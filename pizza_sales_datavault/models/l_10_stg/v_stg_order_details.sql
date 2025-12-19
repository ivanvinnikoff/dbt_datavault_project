{%- set yaml_metadata -%}
source_model: 'v_brz_order_details'
derived_columns:
  RECORD_SOURCE: '!PIZZA_SEED'
  LOAD_DATETIME: 'CURRENT_TIMESTAMP(6)'

hashed_columns:
  HUB_ORDER_PK: order_id

  HUB_PIZZA_PK: pizza_id

  LNK_ORDER_PIZZA_PK:
    - order_id
    - pizza_id

  ORDER_LINE_HASHDIFF:
    is_hashdiff: true
    columns:
      - quantity
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{% set source_model = metadata_dict['source_model'] %}

{% set derived_columns = metadata_dict['derived_columns'] %}

{% set hashed_columns = metadata_dict['hashed_columns'] %}

{{ automate_dv.stage(include_source_columns=true,
                     source_model=source_model,
                     derived_columns=derived_columns,
                     hashed_columns=hashed_columns,
                     ranked_columns=none) }}
