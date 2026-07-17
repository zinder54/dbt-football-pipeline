{{ config(materialized='table') }}

WITH all_team_matches AS (
    SELECT home_team_id AS team_id, home_goals AS goals_for,
           away_goals AS goals_against
    FROM {{ ref('fct_matches') }}
    UNION ALL
    SELECT away_team_id AS team_id, away_goals AS goals_for,
           home_goals AS goals_against
    FROM {{ ref('fct_matches') }}
)

SELECT
    team_id,
    COUNT(*) AS total_matches,
    SUM(goals_for) AS total_goals_for,
    SUM(goals_against) AS total_goals_against,
    SUM(CASE WHEN goals_for > goals_against THEN 1 ELSE 0 END) AS wins,
    SUM(CASE WHEN goals_for < goals_against THEN 1 ELSE 0 END) AS losses,
    SUM(CASE WHEN goals_for = goals_against THEN 1 ELSE 0 END) AS draws,
    SUM(CASE WHEN goals_for > goals_against THEN 3
             WHEN goals_for = goals_against THEN 1
             ELSE 0 END) AS total_points,
    SUM(goals_for) - SUM(goals_against) AS goal_difference
FROM all_team_matches
GROUP BY team_id