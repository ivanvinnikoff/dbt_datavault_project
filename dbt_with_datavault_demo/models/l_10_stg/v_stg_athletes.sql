{%- set yaml_metadata -%}
source_model: 'v_src_brz_crossfit_athletes'
derived_columns:
  RECORD_SOURCE: '!SEEDS_DB'
  LOAD_DATETIME: 'CURRENT_TIMESTAMP(4)'

hashed_columns:
  HUB_ATHLETE_PK: "competitor_id"

  ATHLETE_HASHDIFF:
    is_hashdiff: true
    columns:
      - "first_name"
      - "last_name"
      - "gender"
      - "gender"
      - "age"
      - "country_origin_code"
      - "athlete_picture_id"

  ATHLETE_METRICS_HASHDIFF:
    is_hashdiff: true
    columns:
        - "height"
        - "weight"
        - "overall_rank"
        - "overall_score"
        - "division"
        - "status"
        - "bibid"

  HUB_AFFILIATE_PK: "affiliate_id"

  AFFILIATE_HASHDIFF:
    is_hashdiff: true
    columns:
      - "affiliate_name"


  LNK_AFFILIATE_ATHLETE_PK:
    - 'affiliate_id'
    - 'competitor_id'

  LNK_AFFILIATE_COUNTRY_PK:
    - 'affiliate_id'
    - 'affiliate_country_origin_name'

  HUB_COUNTRY_PK: "affiliate_country_origin_name"


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
