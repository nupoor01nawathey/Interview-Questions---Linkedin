-- Leetcode Hard problem | Tournament Winners 
-- Expected output
-- +-----------+----------+-------+-----+
-- | player_id | group_id | score | rnk |
-- +-----------+----------+-------+-----+
-- |        15 |        1 |     3 |   1 |
-- |        35 |        2 |     1 |   1 |
-- |        40 |        3 |     5 |   1 |
-- +-----------+----------+-------+-----+

create table players
(player_id int,
group_id int);

insert into players values (15,1);
insert into players values (25,1);
insert into players values (30,1);
insert into players values (45,1);
insert into players values (10,2);
insert into players values (35,2);
insert into players values (50,2);
insert into players values (20,3);
insert into players values (40,3);

create table matches
(
match_id int,
first_player int,
second_player int,
first_score int,
second_score int);

insert into matches values (1,15,45,3,0);
insert into matches values (2,30,25,1,2);
insert into matches values (3,30,15,2,0);
insert into matches values (4,40,20,5,2);
insert into matches values (5,35,50,1,1);

select * from players;
select * from matches;

with scores as (
  select first_player player_id, first_score score from matches
  UNION ALL
  select second_player player_id, second_score score from matches 
),
final_scores as (
  select s.player_id, p.group_id, sum(s.score) score
  from scores s inner join players p
  on s.player_id=p.player_id
  group by s.player_id, p.group_id 
),
final_ranking as (
select
  *,
  rank() over(partition by group_id order by score desc, player_id) rnk
from final_scores
)
select * from final_ranking where rnk=1 ;


