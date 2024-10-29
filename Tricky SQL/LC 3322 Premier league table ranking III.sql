-- LC 3322 Premier league table ranking III
-- NOTE: The actual table and data / output may vary, this is copied and pasted from internet just to understand the question

-- +------------------+---------+
-- | Column Name      | Type    |
-- +------------------+---------+
-- | team_id          | int     |
-- | team_name        | varchar |
-- | matches_played   | int     |
-- | wins             | int     |
-- | draws            | int     |
-- | losses           | int     |
-- +------------------+---------+
-- team_id is the unique key for this table.
-- This table contains team id, team name, matches_played, wins, draws, and losses.
-- Write a solution to calculate the points and rank for each team in the league. Points are calculated as follows:

-- 3 points for a win
-- 1 point for a draw
-- 0 points for a loss
-- Note: Teams with the same points must be assigned the same rank.

-- Return the result table ordered by points in descending, and then by team_name in ascending order.
-- The query result format is in the following example.

-- Example:
-- Input:
-- TeamStats table:
-- +---------+-----------------+----------------+------+-------+--------+
-- | team_id | team_name       | matches_played | wins | draws | losses |
-- +---------+-----------------+----------------+------+-------+--------+
-- | 1       | Manchester City | 10             | 6    | 2     | 2      |
-- | 2       | Liverpool       | 10             | 6    | 2     | 2      |
-- | 3       | Chelsea         | 10             | 5    | 3     | 2      |
-- | 4       | Arsenal         | 10             | 4    | 4     | 2      |
-- | 5       | Tottenham       | 10             | 3    | 5     | 2      |
-- +---------+-----------------+----------------+------+-------+--------+

-- Output:
-- +---------+-----------------+--------+----------+
-- | team_id | team_name       | points | position |
-- +---------+-----------------+--------+----------+
-- | 2       | Liverpool       | 20     | 1        |
-- | 1       | Manchester City | 20     | 1        |
-- | 3       | Chelsea         | 18     | 3        |
-- | 4       | Arsenal         | 16     | 4        |
-- | 5       | Tottenham       | 14     | 5        |
-- +---------+-----------------+--------+----------+
-- Explanation:

-- Manchester City and Liverpool both have 20 points (6 wins * 3 points + 2 draws * 1 point), so they share position 1.
-- Chelsea has 18 points (5 wins * 3 points + 3 draws * 1 point) and is position 3rd.
-- Arsenal has 16 points (4 wins * 3 points + 4 draws * 1 point) and is position 4th.
-- Tottenham has 14 points (3 wins * 3 points + 5 draws * 1 point) and is position 5th.
-- The output table is ordered by points in descending order, then by team_name in ascending order.


CREATE TABLE SeasonStats (
  season_id INT,
  team_id INT,
  team_name VARCHAR(255),
  matches_played INT,
  wins INT,
  draws INT,
  losses INT,
  goals_for INT,
  goals_against INT
);

insert into SeasonStats (season_id, team_id, team_name, matches_played, wins, draws, losses, goals_for, goals_against) values ('2021', '1', 'Manchester City', '38', '29', '6', '3', '99', '26') ;
insert into SeasonStats (season_id, team_id, team_name, matches_played, wins, draws, losses, goals_for, goals_against) values ('2021', '2', 'Liverpool', '38', '28', '8', '2', '94', '26') ;
insert into SeasonStats (season_id, team_id, team_name, matches_played, wins, draws, losses, goals_for, goals_against) values ('2021', '3', 'Chelsea', '38', '21', '11', '6', '76', '33') ;
insert into SeasonStats (season_id, team_id, team_name, matches_played, wins, draws, losses, goals_for, goals_against) values ('2021', '4', 'Tottenham', '38', '22', '5', '11', '69', '40') ;
insert into SeasonStats (season_id, team_id, team_name, matches_played, wins, draws, losses, goals_for, goals_against) values ('2021', '5', 'Arsenal', '38', '22', '3', '13', '61', '48') ;
insert into SeasonStats (season_id, team_id, team_name, matches_played, wins, draws, losses, goals_for, goals_against) values ('2022', '1', 'Manchester City', '38', '28', '5', '5', '94', '33') ;
insert into SeasonStats (season_id, team_id, team_name, matches_played, wins, draws, losses, goals_for, goals_against) values ('2022', '2', 'Arsenal', '38', '26', '6', '6', '88', '43') ;
insert into SeasonStats (season_id, team_id, team_name, matches_played, wins, draws, losses, goals_for, goals_against) values ('2022', '3', 'Manchester United', '38', '23', '6', '9', '58', '43') ;
insert into SeasonStats (season_id, team_id, team_name, matches_played, wins, draws, losses, goals_for, goals_against) values ('2022', '4', 'Newcastle', '38', '19', '14', '5', '68', '33') ;
insert into SeasonStats (season_id, team_id, team_name, matches_played, wins, draws, losses, goals_for, goals_against) values ('2022', '5', 'Liverpool', '38', '19', '10', '9', '75', '47') ;

select * from SeasonStats ; 


WITH scoreboard AS (
  SELECT
    season_id,
    team_id,
    team_name,
    (wins * 3 + draws * 1 + losses * 0) AS points,
    goals_for - goals_against AS goal_difference
  FROM SeasonStats 
)
SELECT
  *,
  row_number() over(partition by season_id order by points desc, goal_difference desc, team_name) AS position
FROM scoreboard
ORDER BY season_id , position, team_name
;
