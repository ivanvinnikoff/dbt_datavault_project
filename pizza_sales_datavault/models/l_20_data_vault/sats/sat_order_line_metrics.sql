{%- set source_model = "v_stg_order_details" -%}
{%- set src_pk = "LNK_ORDER_PIZZA_PK" -%}
{%- set src_hashdiff = "ORDER_LINE_HASHDIFF" -%}
{%- set src_payload = ["order_details_id", "quantity"] -%}
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
