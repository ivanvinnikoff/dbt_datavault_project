{%- set source_model = "v_stg_countries" -%}
{%- set src_pk = "HUB_COUNTRY_PK" -%}
{%- set src_hashdiff = "ATHLETE_HASHDIFF" -%}
{%- set src_payload = ["population", "source"] -%}
{%- set src_ldts = "LOAD_DATETIME" -%}
{%- set src_source = "RECORD_SOURCE" -%}


{{ automate_dv.sat(src_pk=src_pk,src_payload=src_payload,
                   src_hashdiff=src_hashdiff,
                   src_eff=src_eff,
                   src_ldts=src_ldts, src_source=src_source,
                   source_model=source_model) }}
