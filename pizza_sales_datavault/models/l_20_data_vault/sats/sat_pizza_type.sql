{%- set source_model = "v_stg_pizza_types" -%}
{%- set src_pk = "HUB_PIZZA_TYPE_PK" -%}
{%- set src_hashdiff = "PIZZA_TYPE_HASHDIFF" -%}
{%- set src_payload = ["name", "category", "ingredients"] -%}
{%- set src_ldts = "LOAD_DATETIME" -%}
{%- set src_source = "RECORD_SOURCE" -%}
{%- set src_eff = none -%}

{{ automate_dv.sat(src_pk=src_pk,
                   src_hashdiff=src_hashdiff,
                   src_payload=src_payload,
                   src_eff=src_eff,
                   src_ldts=src_ldts,
                   src_source=src_source,
                   source_model=source_model) }}
