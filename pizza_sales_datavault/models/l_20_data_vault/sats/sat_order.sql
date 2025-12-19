{%- set source_model = "v_stg_orders" -%}
{%- set src_pk = "HUB_ORDER_PK" -%}
{%- set src_hashdiff = "ORDER_HASHDIFF" -%}
{%- set src_payload = ["order_date", "order_time"] -%}
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
