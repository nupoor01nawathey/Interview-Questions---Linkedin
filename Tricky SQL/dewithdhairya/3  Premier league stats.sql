

Create table If Not Exists Teams 
(
 team_id int, 
 team_name varchar(20)
);
truncate table teams;
Create table If Not Exists Matches 
(
 home_team_id int, 
 away_team_id int, 
 home_team_goals int, 
 away_team_goals int
);

insert into Teams (team_id, team_name) values 
('1', 'CSK'),
('4', 'RCB'),
('6', 'KKR');

insert into Matches (home_team_id, away_team_id, home_team_goals, away_team_goals) values 
('1', '4', '0', '1'),
('1', '6', '3', '3'),
('4', '1', '5', '2'),
('6', '1', '0', '0');

select * from teams;
select * from matches;

with cte as (
	select 
		home_team_id as team_id, 
		home_team_goals as goals_for,
		away_team_goals as goals_against,
		case when home_team_goals > away_team_goals then 3 
			 when away_team_goals > home_team_goals then 0
			 else 1
		end as points
	from matches 
	UNION
	select
		away_team_id as team_id,
		away_team_goals as goals_for,
		home_team_goals as goals_against,
		case when away_team_goals > home_team_goals then 3 
			 when home_team_goals > away_team_goals then 0
			 else 1
		end as points
	from matches 
), cte2 as (
select c.team_id, team_name, count(1) matches_player,
	sum(points) as points,
    sum(goals_for) as goals_for,
    sum(goals_against) as goal_against
from cte c inner join teams t
on c.team_id = t.team_id
group by c.team_id, team_name 
)
select 
	* ,
    goals_for - goal_against as goal_diff
from cte2 
order by points desc, goal_diff desc, team_name ;
