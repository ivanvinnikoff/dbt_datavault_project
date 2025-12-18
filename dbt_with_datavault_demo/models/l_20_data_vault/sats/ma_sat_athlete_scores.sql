{{ config(materialized='table') }}

{%- set yaml_metadata -%}
source_model: "v_stg_athlete_scores"
src_pk: "HUB_ATHLETE_PK"
src_cdk:
  - "ordinal"
src_payload:
  - "breakdown"
  - "lane"
  - "rank"
  - "heat"
  - "points"
  - "score_display"
  - "time"
  - "workout_rank"

src_hashdiff: "ATHLETE_SCORE_HASHDIFF"
src_ldts: "LOAD_DATETIME"
src_source: "RECORD_SOURCE"
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{{ automate_dv.ma_sat(src_pk=metadata_dict['src_pk'],
                      src_cdk=metadata_dict['src_cdk'],
                      src_payload=metadata_dict['src_payload'],
                      src_hashdiff=metadata_dict['src_hashdiff'],
                      src_eff=metadata_dict['src_eff'],
                      src_ldts=metadata_dict['src_ldts'],
                      src_source=metadata_dict['src_source'],
                      source_model=metadata_dict['source_model']) }}

