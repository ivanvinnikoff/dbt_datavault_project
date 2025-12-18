SELECT *
FROM {{ source('source_seed_db', 'Country_Metadata') }} as m