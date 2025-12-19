# Pizza Sales Data Vault (dbt)

End-to-end dbt project modeling the Pizza Place Sales dataset into a Data Vault 2.0 architecture (bronze → staging → hubs/links/sats → OBT).

## Project name & profile
- Project: `pizza_sales_datavault`
- Profile: `pizza_sales_datavault` (see `~/.dbt/profiles.yml`)

## Architecture overview
This repository follows a layered dbt + DV2 pattern:
- **Sources (seeds)**: CSV files loaded by `dbt seed` into `bronze_db`
- **Bronze (`l_00_brz`)**: typed, renamed pass-through views over the sources
- **Staging (`l_10_stg`)**: Data Vault preparation using `automate_dv.stage` (adds `load_datetime`, `record_source`, hash keys, hashdiffs)
- **Data Vault (`l_20_data_vault`)**: hubs, links, and satellites built with `Datavault-UK/automate_dv`
- **Marts (`l_30_data_marts`)**: consumer-ready OBT for analytics use cases

Data Vault naming conventions used in this project:
- `hub_*` = business keys only
- `lnk_*` = relationships between hubs
- `sat_*` = descriptive attributes/metrics, historized via append-only loads and hashdiff change detection

## Running locally (Postgres)
1. Ensure Postgres is running and the `pizza_sales_datavault` database exists with schemas `bronze_db`, `data_vault`, `data_marts`.
2. Install dbt (tested with `dbt-postgres 1.9.1` / `dbt-core 1.10.16`).
3. Install packages: `dbt deps`
4. Build pipeline:
   - `dbt seed --full-refresh`
   - `dbt run`
   - `dbt test`
5. Docs: `dbt docs generate` then `dbt docs serve` (optional).

## Exploring dbt docs
Run `dbt docs generate` and then `dbt docs serve`. In the DAG:
- start at the `pizza_seed` sources
- follow bronze → staging → Data Vault → `v_obt`

## Dataset
Seeds live in `seeds/pizza/` (orders, order_details, pizzas, pizza_types) and are loaded to the `bronze_db` schema.

## Models layout
- `models/l_00_brz`: bronze pass-through views from seeds
- `models/l_10_stg`: staging with hash keys/diffs via `automate_dv.stage`
- `models/l_20_data_vault`: hubs, links, satellites
- `models/l_30_data_marts`: analytics-ready OBT
- `models/sources.yml`, `models/schema.yml`: sources, docs, and tests
