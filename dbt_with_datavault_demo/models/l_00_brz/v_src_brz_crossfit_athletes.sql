with
    s as (SELECT *
    FROM {{ source('source_seed_db', 'CrossFit_Games_Athletes_Men_2019') }} as m
    where competitorid is not null
    union all
    SELECT *
    FROM {{ source('source_seed_db', 'CrossFit_Games_Athletes_Women_2019') }} as w
    where competitorid is not null)
select
    competitorid as competitor_id,
    firstname as first_name,
    lastname as last_name,
    gender,
    age,
    countryoforigincode as country_origin_code,
    height,
    weight,
    overallrank as overall_rank,
    overallscore as overall_score,
    division,
    status,
    bibid,
    'https://profilepicsbucket.crossfit.com/' || profilepics3key as athlete_picture_id,
    affiliateid as affiliate_id,
    affiliatename as affiliate_name,
    countryoforiginname as affiliate_country_origin_name
from s