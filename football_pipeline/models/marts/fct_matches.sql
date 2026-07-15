{{ config(materialized='table') }}
SELECT
    match_id,
    match_date,
    matchday,
    competition_id,
    home_team_id,
    away_team_id,
    home_team,
    away_team,
    home_goals,
    away_goals,
    home_goals_ht,
    away_goals_ht,
    home_goals - away_goals AS goal_difference,
    home_goals_ht - away_goals_ht AS goal_difference_ht,
    home_goals + away_goals AS total_goals,
    home_goals - home_goals_ht AS home_goals_2nd_half,
    away_goals - away_goals_ht AS away_goals_2nd_half,
    CASE
        WHEN home_goals > away_goals THEN home_team
        WHEN away_goals > home_goals THEN away_team
        ELSE 'Draw'
    END AS winner
FROM {{ ref('stg_matches') }}