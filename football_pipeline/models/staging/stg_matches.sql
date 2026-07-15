SELECT
    id AS match_id,
    CAST(utcdate AS TIMESTAMP) AS match_date,
    competition_id,
    status,
    matchday,
    hometeam_id AS home_team_id,
    awayteam_id AS away_team_id,
    hometeam_name AS home_team,
    awayteam_name AS away_team,
    score_fulltime_home AS home_goals,
    score_fulltime_away AS away_goals,
    score_halftime_home AS home_goals_ht,
    score_halftime_away AS away_goals_ht
FROM {{ source('raw', 'matches') }}