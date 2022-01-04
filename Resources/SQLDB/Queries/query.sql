-- Query post DB creation, schema and seeding - country table
SELECT *
FROM country
LIMIT 100

-- Query post DB creation, schema and seeding - league table 
SELECT *
FROM league
LIMIT 100


-- Query post DB creation, schema and seeding - team table
SELECT *
FROM team
LIMIT 100

-- Query post DB creation, schema and seeding - player table
SELECT *
FROM player
LIMIT 100;

-- Query post DB creation, schema and seeding - team_attributes table
SELECT *
FROM team_attributes
LIMIT 100

-- Query post DB creation, schema and seeding - player_attributes table
SELECT *
FROM player_attributes
LIMIT 100

-- Query post DB creation, schema and seeding - match table
SELECT *
FROM match
LIMIT 1000;

--------------------------------------------------------------------------
-- In which year are the most goals scored 
--Compare Average Goals scored in all leagues per season
SELECT season, (ROUND(AVG(home_team_goal),2) + ROUND(AVG(away_team_goal),2)) AS total_goals
FROM match
GROUP BY season
ORDER BY season; 

-- Does the home team have an advantage ?
--Compare Average Home Goals vs Away Goals scored in all leagues over all seasons
SELECT ROUND(AVG(home_team_goal),2) AS home_team_goals, ROUND(AVG(away_team_goal),2) AS away_team_goals
FROM match;

--Compare Average Home Goals vs Away Goals scored in all leagues per season
SELECT season, ROUND(AVG(home_team_goal),2) AS home_team_goals, ROUND(AVG(away_team_goal),2) AS away_team_goals
FROM match
GROUP BY season
ORDER BY season;

-- Does the home team have an advantage change for different leagues ?
--Compare Average Home Goals vs Away Goals scored for each league per season
SELECT match.season, league.name, ROUND(AVG(match.home_team_goal),2) AS home_team_goals, ROUND(AVG(match.away_team_goal),2) AS away_team_goals
FROM match
JOIN league ON match.country_id = league.country_id
GROUP BY match.season, league.name
ORDER BY season;

-- Which League has the most matches ?
--Group matches by leauge and count for all years
SELECT league.name, COUNT(match.match_api_id) AS total_league_games
FROM match
JOIN league ON match.league_id = league.id
GROUP BY league.name
ORDER BY total_league_games;

--Group matches by leauge and count for each year
SELECT league.name, COUNT(match.match_api_id) AS total_league_games
FROM match
JOIN league ON match.league_id = league.id
GROUP BY match.season, league.name
ORDER BY league.name;

-- Which Look at home team winner percentage
--Get match scores and betting odds
SELECT team.team_long_name AS home_team, match.home_team_goal, match.away_team_goal, match.b365h, match.b365d, match.b365a
FROM match
JOIN team ON match.home_team_api_id = team.team_api_id
LIMIT 100;

