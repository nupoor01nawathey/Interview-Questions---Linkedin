-- Human Traffic LC Hard

-- +------+------------+--------------+
-- | id   | visit_date | no_of_people |
-- +------+------------+--------------+
-- |    1 | 2017-07-01 |           10 |
-- |    2 | 2017-07-02 |          109 |
-- |    3 | 2017-07-03 |          150 |
-- |    4 | 2017-07-04 |           99 |
-- |    5 | 2017-07-05 |          145 |
-- |    6 | 2017-07-06 |         1455 |
-- |    7 | 2017-07-07 |          199 |
-- |    8 | 2017-07-08 |          188 |
-- +------+------------+--------------+

create table stadium (
  id int,
  visit_date date,
  no_of_people int
);

insert into stadium
values (1,'2017-07-01',10)
,(2,'2017-07-02',109)
,(3,'2017-07-03',150)
,(4,'2017-07-04',99)
,(5,'2017-07-05',145)
,(6,'2017-07-06',1455)
,(7,'2017-07-07',199)
,(8,'2017-07-08',188);


select * from stadium ;

with cte as (
  select 
    *,
    id - row_number() over(order by visit_date) as group_c
  from stadium
  where no_of_people >= 100 
)
select * from cte
where group_c in (
  select 
    group_c
  from cte 
  group by group_c 
  having count(1) >=3 
)




