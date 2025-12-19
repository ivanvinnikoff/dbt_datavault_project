{%- set yaml_metadata -%}
source_model: 'v_brz_orders'
derived_columns:
  RECORD_SOURCE: '!PIZZA_SEED'
  LOAD_DATETIME: 'CURRENT_TIMESTAMP(6)'

hashed_columns:
  HUB_ORDER_PK: order_id

  ORDER_HASHDIFF:
    is_hashdiff: true
    columns:
      - order_date
      - order_time
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
