-- Leetcode Students Reports By Geography |

-- Input
-- +--------+-----------+
-- | name   | city      |
-- +--------+-----------+
-- | Sachin | Mumbai    |
-- | Virat  | Delhi     |
-- | Rahul  | Bangalore |
-- | Rohit  | Mumbai    |
-- | Mayank | Bangalore |
-- +--------+-----------+

-- Output
-- +-----------+--------+-------+
-- | Bangalore | Mumbai | Delhi |
-- +-----------+--------+-------+
-- | Mayank    | Rohit  | Virat |
-- | Rahul     | Sachin | NULL  |
-- +-----------+--------+-------+

create table players_location
(
  name varchar(20),
  city varchar(20)
);
insert into players_location
values ('Sachin','Mumbai'),('Virat','Delhi') , ('Rahul','Bangalore'),('Rohit','Mumbai'),('Mayank','Bangalore');

select * from players_location; 


select
  max(case when city='Bangalore' then name end) as Bangalore,
  max(case when city='Mumbai' then name end) as Mumbai,
  max(case when city='Delhi' then name end) as Delhi
from 
(
  select
    *,
    row_number() over(partition by city order by name asc) player_group
  from players_location
) tmp
group by player_group ;

