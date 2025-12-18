{%- set source_model = "v_stg_countries" -%}
{%- set src_pk = "HUB_COUNTRY_PK" -%}
{%- set src_nk = "country" -%}
{%- set src_ldts = "LOAD_DATETIME" -%}
{%- set src_source = "RECORD_SOURCE" -%}

{{ automate_dv.hub(src_pk=src_pk, src_nk=src_nk, src_ldts=src_ldts,
                   src_source=src_source, source_model=source_model) }}