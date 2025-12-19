select
  pizza_type_id,
  name,
  category,
  ingredients
from {{ source('pizza_seed', 'pizza_types') }}
