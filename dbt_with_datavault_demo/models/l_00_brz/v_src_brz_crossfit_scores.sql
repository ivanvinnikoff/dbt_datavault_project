SELECT
    competitorid as competitor_id,
    ordinal,
	breakdown,
	lane,
	rank,
	heat,
	points,
	scoredisplay as score_display,
	time,
	workoutrank as workout_rank
FROM {{ source('source_seed_db', 'CrossFit_Games_Scores_2019') }} as m
