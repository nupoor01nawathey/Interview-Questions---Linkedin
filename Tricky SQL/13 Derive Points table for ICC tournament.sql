

create table icc_world_cup (
Team_1 Varchar(20),
Team_2 Varchar(20),
Winner Varchar(20)
);

INSERT INTO icc_world_cup values('India','SL','India');
INSERT INTO icc_world_cup values('SL','Aus','Aus');
INSERT INTO icc_world_cup values('SA','Eng','Eng');
INSERT INTO icc_world_cup values('Eng','NZ','NZ');
INSERT INTO icc_world_cup values('Aus','India','India');

select * from icc_world_cup;


with cte as (
  select
    Team_1,
    case when Team_1=Winner then 1 else 0 end as win_flag
  from icc_world_cup
  UNION ALL
  select
    Team_2,
    case when Team_2=Winner then 1 else 0 end as win_flag
  from icc_world_cup
)
select 
  Team_1 as team_name,
  count(1) matches_played,
  sum(win_flag) no_of_matches_won,
  count(1) - sum(win_flag) no_of_losses
from cte
group by team_name 
order by ;

