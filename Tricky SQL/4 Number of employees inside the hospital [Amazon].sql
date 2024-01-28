-- Amazon , Write a query to return total number of patients inside the hospital

create table hospital ( emp_id int
, action varchar(10)
, time datetime);

insert into hospital values ('1', 'in', '2019-12-22 09:00:00');
insert into hospital values ('1', 'out', '2019-12-22 09:15:00');
insert into hospital values ('2', 'in', '2019-12-22 09:00:00');
insert into hospital values ('2', 'out', '2019-12-22 09:15:00');
insert into hospital values ('2', 'in', '2019-12-22 09:30:00');
insert into hospital values ('3', 'out', '2019-12-22 09:00:00');
insert into hospital values ('3', 'in', '2019-12-22 09:15:00');
insert into hospital values ('3', 'out', '2019-12-22 09:30:00');
insert into hospital values ('3', 'in', '2019-12-22 09:45:00');
insert into hospital values ('4', 'in', '2019-12-22 09:45:00');
insert into hospital values ('5', 'out', '2019-12-22 09:40:00');

select * from hospital ;

-- we are interested only patients where action=in so if max(time)==maxt(time) where action=in that will give desired output
with latest_time as (
  select 
    emp_id,
    max(time) as max_latest_time 
  from hospital 
  group by emp_id
), max_in_time as (
  select 
    emp_id,
    max(time) as max_in_time 
  from hospital
  where action='in'
  group by emp_id
)
select 
  *
from latest_time lt 
inner join max_in_time mit 
on lt.emp_id=mit.emp_id 
and max_in_time=max_latest_time ;


-- using window functions
with cte as (
  select 
    *,
    dense_rank() over(partition by emp_id order by time desc) dr
  from hospital
)
select 
  emp_id,
  action,
  time
from cte
where dr=1 and action='in'

