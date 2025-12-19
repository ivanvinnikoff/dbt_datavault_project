{%- set yaml_metadata -%}
source_model: 'v_brz_pizza_types'
derived_columns:
  RECORD_SOURCE: '!PIZZA_SEED'
  LOAD_DATETIME: 'CURRENT_TIMESTAMP(6)'

hashed_columns:
  HUB_PIZZA_TYPE_PK: pizza_type_id

  PIZZA_TYPE_HASHDIFF:
    is_hashdiff: true
    columns:
      - name
      - category
      - ingredients
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
