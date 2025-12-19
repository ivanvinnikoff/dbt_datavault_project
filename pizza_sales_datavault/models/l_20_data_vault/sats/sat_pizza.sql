{%- set source_model = "v_stg_pizzas" -%}
{%- set src_pk = "HUB_PIZZA_PK" -%}
{%- set src_hashdiff = "PIZZA_HASHDIFF" -%}
{%- set src_payload = ["size", "price"] -%}
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
