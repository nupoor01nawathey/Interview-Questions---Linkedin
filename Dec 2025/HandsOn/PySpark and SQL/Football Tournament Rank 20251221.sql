/*
• Understanding the Problem
Let's break down the problem statement:
• Data Input: We have a dataset containing records of football matches. Each record includes the names of two teams, the match result (win or loss), and the number of goals scored by each team.
• Ranking Rules:
1. Teams are ranked based on their total points, calculated by summing the points earned from wins and subtracting the points lost from losses.
2. In case of a tie in total points, the team with a higher number of winning goals gets ranked higher.
*/

CREATE TABLE matches (
  match_id INT PRIMARY KEY,
  winning_team_id INT,
  losing_team_id INT,
  goals_won INT
);

INSERT INTO matches (match_id, winning_team_id, losing_team_id, goals_won) VALUES
(1, 1001, 1007, 1),
(2, 1007, 1001, 2),
(3, 1006, 1003, 3),
(4, 1001, 1003, 1),
(5, 1007, 1001, 1),
(6, 1006, 1003, 2),
(7, 1006, 1001, 3),
(8, 1007, 1003, 5),
(9, 1001, 1003, 1),
(10, 1007, 1006, 2),
(11, 1006, 1003, 3),
(12, 1001, 1003, 4),
(13, 1001, 1006, 2),
(14, 1007, 1001, 4),
(15, 1006, 1007, 3),
(16, 1001, 1003, 3),
(17, 1001, 1007, 3),
(18, 1006, 1007, 2),
(19, 1003, 1001, 1),
(20, 1001, 1007, 3),
(21, 1001, 1003, 3);

CREATE TABLE teaminfo (
  team_id INT ,
  team_name varchar(25)
);
INSERT INTO teaminfo (team_id, team_name) VALUES
(1001,'Nickmiesters'),
(1003,'sunrisers'),
(1006,'Philipines prates'),
(1007,'Smashers');

select * from teaminfo;
/*
team_name                 team_rnk            
------------------------- --------------------
Nickmiesters                                 1
Philipines prates                            2
Smashers                                     3
sunrisers                                    4
*/


select * from matches ;
/*
match_id    winning_team_id losing_team_id goals_won  
----------- --------------- -------------- -----------
          1            1001           1007           1
          2            1007           1001           2
          3            1006           1003           3
          4            1001           1003           1
          5            1007           1001           1
          6            1006           1003           2
          7            1006           1001           3
          8            1007           1003           5
          9            1001           1003           1
         10            1007           1006           2
         11            1006           1003           3
         12            1001           1003           4
         13            1001           1006           2
         14            1007           1001           4
         15            1006           1007           3
         16            1001           1003           3
         17            1001           1007           3
         18            1006           1007           2
         19            1003           1001           1
         20            1001           1007           3
         21            1001           1003           3
*/

with cte as (
select winning_team_id as team_id, 1 as points, goals_won as goals from matches
union all
select losing_team_id as team_id, -1 as points, 0 as goals from matches
), cte2 as(
select
  team_id, sum(points) as total_points, sum(goals) as total_goals_won
from cte
group by team_id
)
select 
team_name, rank() over(order by c.total_points desc, c.total_goals_won desc) as team_rnk
from cte2 c inner join teaminfo t 
on c.team_id=t.team_id ;





