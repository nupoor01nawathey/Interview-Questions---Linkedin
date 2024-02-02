-- FAANGM Scenario based Interviews Question for Product companies
-- Problem: find the users with total visit, most visited floor and resources used

create table entries ( 
  name varchar(20),
  address varchar(20),
  email varchar(20),
  floor int,
  resources varchar(10)
);

insert into entries values ('A','Bangalore','A@gmail.com',1,'CPU'),('A','Bangalore','A1@gmail.com',1,'CPU'),('A','Bangalore','A2@gmail.com',2,'DESKTOP')
,('B','Bangalore','B@gmail.com',2,'DESKTOP'),('B','Bangalore','B1@gmail.com',2,'DESKTOP'),('B','Bangalore','B2@gmail.com',1,'MONITOR') ;


select * from entries;

with floor_visits as (
  select 
    name,
    floor,
    count(1) total_visits,
    rank() over(partition by name order by count(1) desc) rn
  from entries
  group by name,floor
), 
resources as (
  select 
    name,
    group_concat(distinct resources) resources_used
  from entries
  group by name
)
select
  f.name,
  total_visits,
  floor as most_visited_floor,
  resources_used
from floor_visits f JOIN resources r
on f.name=r.name
where rn=1 ;


