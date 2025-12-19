{{
  config(materialized='view')
}}

with sat_order_latest as (
  select distinct on (hub_order_pk)
    hub_order_pk,
    order_date,
    order_time,
    load_datetime
  from {{ ref('sat_order') }}
  order by hub_order_pk, load_datetime desc
),
sat_pizza_latest as (
  select distinct on (hub_pizza_pk)
    hub_pizza_pk,
    size,
    price,
    load_datetime
  from {{ ref('sat_pizza') }}
  order by hub_pizza_pk, load_datetime desc
),
sat_pizza_type_latest as (
  select distinct on (hub_pizza_type_pk)
    hub_pizza_type_pk,
    name,
    category,
    ingredients,
    load_datetime
  from {{ ref('sat_pizza_type') }}
  order by hub_pizza_type_pk, load_datetime desc
),
sat_order_line_latest as (
  select distinct on (lnk_order_pizza_pk)
    lnk_order_pizza_pk,
    order_details_id,
    quantity,
    load_datetime
  from {{ ref('sat_order_line_metrics') }}
  order by lnk_order_pizza_pk, load_datetime desc
),
order_data as (
  select
    ho.hub_order_pk,
    ho.order_id,
    so.order_date,
    so.order_time,
    greatest(ho.load_datetime, so.load_datetime) as order_load_datetime
  from {{ ref('hub_order') }} ho
  join sat_order_latest so
    on ho.hub_order_pk = so.hub_order_pk
),
pizza_data as (
  select
    hp.hub_pizza_pk,
    hp.pizza_id,
    sp.size,
    sp.price,
    greatest(hp.load_datetime, sp.load_datetime) as pizza_load_datetime
  from {{ ref('hub_pizza') }} hp
  join sat_pizza_latest sp
    on hp.hub_pizza_pk = sp.hub_pizza_pk
),
pizza_type_data as (
  select
    hpt.hub_pizza_type_pk,
    hpt.pizza_type_id,
    spt.name as pizza_type_name,
    spt.category,
    spt.ingredients,
    greatest(hpt.load_datetime, spt.load_datetime) as pizza_type_load_datetime
  from {{ ref('hub_pizza_type') }} hpt
  join sat_pizza_type_latest spt
    on hpt.hub_pizza_type_pk = spt.hub_pizza_type_pk
),
order_lines as (
  select
    lop.lnk_order_pizza_pk,
    lop.hub_order_pk,
    lop.hub_pizza_pk,
    sol.order_details_id,
    sol.quantity,
    greatest(lop.load_datetime, sol.load_datetime) as line_load_datetime
  from {{ ref('lnk_order_pizza') }} lop
  join sat_order_line_latest sol
    on lop.lnk_order_pizza_pk = sol.lnk_order_pizza_pk
),
pizza_to_type as (
  select
    lppt.hub_pizza_pk,
    lppt.hub_pizza_type_pk,
    lppt.load_datetime as link_load_datetime
  from {{ ref('lnk_pizza_pizza_type') }} lppt
)

select
  ol.order_details_id,
  od.order_id,
  od.order_date,
  od.order_time,
  pd.pizza_id,
  pd.size,
  pd.price,
  ptd.pizza_type_id,
  ptd.pizza_type_name,
  ptd.category,
  ptd.ingredients,
  ol.quantity,
  (ol.quantity * pd.price)::numeric(18, 2) as revenue,
  greatest(
    od.order_load_datetime,
    pd.pizza_load_datetime,
    ol.line_load_datetime,
    coalesce(ptd.pizza_type_load_datetime, ppt.link_load_datetime)
  ) as load_datetime
from order_lines ol
join order_data od
  on ol.hub_order_pk = od.hub_order_pk
join pizza_data pd
  on ol.hub_pizza_pk = pd.hub_pizza_pk
left join pizza_to_type ppt
  on ol.hub_pizza_pk = ppt.hub_pizza_pk
left join pizza_type_data ptd
  on ppt.hub_pizza_type_pk = ptd.hub_pizza_type_pk
