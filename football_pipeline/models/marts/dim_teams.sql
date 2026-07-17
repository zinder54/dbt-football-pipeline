{{ config(materialized='table') }}

SELECT
home_team_id as team_id,
home_team AS team_name,
hometeam_shortname AS team_shortname,
    hometeam_tla AS team_tla,
    hometeam_crest AS team_crest
FROM {{ ref('stg_matches') }}
UNION
SELECT
away_team_id as team_id,
away_team AS team_name,
awayteam_shortname AS team_shortname,
    awayteam_tla AS team_tla,
    awayteam_crest AS team_crest
FROM {{ ref('stg_matches') }}
