select
  pizza_id,
  pizza_type_id,
  size,
  cast(price as numeric(10, 2)) as price
from {{ source('pizza_seed', 'pizzas') }}
