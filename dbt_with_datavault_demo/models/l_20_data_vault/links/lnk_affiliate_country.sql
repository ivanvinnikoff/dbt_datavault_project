{%- set source_model = "v_stg_athletes" -%}
{%- set src_pk = "LNK_AFFILIATE_COUNTRY_PK" -%}
{%- set src_fk = ["HUB_AFFILIATE_PK", "HUB_COUNTRY_PK"] -%}
{%- set src_ldts = "LOAD_DATETIME" -%}
{%- set src_source = "RECORD_SOURCE" -%}

{{ automate_dv.link(src_pk=src_pk, src_fk=src_fk, src_ldts=src_ldts,
                    src_source=src_source, source_model=source_model) }}
