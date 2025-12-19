select
  cast(order_id as integer) as order_id,
  cast(date as date) as order_date,
  cast(time as time) as order_time
from {{ source('pizza_seed', 'orders') }}
