select
  cast(order_details_id as integer) as order_details_id,
  cast(order_id as integer) as order_id,
  pizza_id,
  cast(quantity as integer) as quantity
from {{ source('pizza_seed', 'order_details') }}
