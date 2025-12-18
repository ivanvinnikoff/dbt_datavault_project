{%- set yaml_metadata -%}
source_model: 'v_src_brz_crossfit_scores'
derived_columns:
  RECORD_SOURCE: '!SEEDS_DB'
  LOAD_DATETIME: 'CURRENT_TIMESTAMP(4)'

hashed_columns:
  HUB_ATHLETE_PK: "competitor_id"

  ATHLETE_SCORE_HASHDIFF:
    is_hashdiff: true
    columns:
      - "ordinal"
      - "breakdown"
      - "lane"
      - "rank"
      - "heat"
      - "points"
      - "score_display"
      - "time"
      - "workout_rank"

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
