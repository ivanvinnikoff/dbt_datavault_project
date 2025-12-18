{{
  config(
    materialized = "view"
  )
}}
with
athlete as (
	select
		ha.hub_athlete_pk, ha.competitor_id,
		sa.first_name , sa.last_name, sa.gender, sa.age, sa.country_origin_code, sa.athlete_picture_id,
		sam.height, sam.weight ,sam.overall_rank, sam.overall_score, sam.division, sam.status,
		greatest (ha.load_datetime, sam.load_datetime) load_datetime
	from {{ ref('hub_athlete') }} ha, {{ ref('sat_athlete') }} sa , {{ ref('sat_athlete_metrics') }} sam
	where ha.hub_athlete_pk  = sa.hub_athlete_pk  and ha.hub_athlete_pk  = sam.hub_athlete_pk
)
,affiliate as(
	select
		haf.hub_affiliate_pk, haf.affiliate_id,
		saf.affiliate_name,
		greatest (haf.load_datetime, saf.load_datetime) load_datetime
	from {{ ref('hub_affiliate') }} haf, {{ ref('sat_affiliate') }} saf
	where haf.hub_affiliate_pk = saf.hub_affiliate_pk
)
, country as (
	select
		hc.hub_country_pk, hc.country,
		sc.population , sc."source",
		greatest(hc.load_datetime, sc.load_datetime) load_datetime
	from {{ ref('hub_country') }} hc, {{ ref('sat_country') }} sc
	where hc.hub_country_pk  = sc.hub_country_pk
)

select
	competitor_id, first_name , last_name, gender, age, country_origin_code, athlete_picture_id,
	height, weight, overall_rank, overall_score, division, status,
	affiliate_id, affiliate_name,
	country, population, "source"
	,greatest (ha.load_datetime, ha2.load_datetime, hc.load_datetime) load_datetime
from
	athlete ha
	left join {{ ref('lnk_affiliate_athlete') }} laa
		on ha.hub_athlete_pk = laa.hub_athlete_pk
	left join affiliate ha2
		on laa.hub_affiliate_pk = ha2.hub_affiliate_pk
	left join {{ ref('lnk_affiliate_country') }} lac
		on ha2.hub_affiliate_pk = lac.hub_affiliate_pk
	left join country hc
		on lac.hub_country_pk = hc.hub_country_pk
    
