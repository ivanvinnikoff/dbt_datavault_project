{%- set source_model = "v_stg_athletes" -%}
{%- set src_pk = "HUB_AFFILIATE_PK" -%}
{%- set src_hashdiff = "AFFILIATE_HASHDIFF" -%}
{%- set src_payload = ["affiliate_name"] -%}
{%- set src_ldts = "LOAD_DATETIME" -%}
{%- set src_source = "RECORD_SOURCE" -%}


{{ automate_dv.sat(src_pk=src_pk,src_payload=src_payload,
                   src_hashdiff=src_hashdiff,
                   src_eff=src_eff,
                   src_ldts=src_ldts, src_source=src_source,
                   source_model=source_model) }}
