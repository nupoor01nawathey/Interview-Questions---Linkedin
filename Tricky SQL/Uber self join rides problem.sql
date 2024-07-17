-- Uber
-- Write a sql to print total rides and profit rides from each driver
-- Profit ride is when end location of current ride is same as start location of next ride
-- WITHOUT WINDOW FUNCTION

create table drivers(id varchar(10), start_time time, end_time time, start_loc varchar(10), end_loc varchar(10));

insert into drivers values('dri_1', '09:00', '09:30', 'a','b'),('dri_1', '09:30', '10:30', 'b','c'),('dri_1','11:00','11:30', 'd','e');
insert into drivers values('dri_1', '12:00', '12:30', 'f','g'),('dri_1', '13:30', '14:30', 'c','h');
insert into drivers values('dri_2', '12:15', '12:30', 'f','g'),('dri_2', '13:30', '14:30', 'c','h');

select * from drivers ;



select 
  a.id, 
  count(a.end_loc) as a_end,
  count(b.start_loc) as b_start 
from drivers a left join drivers b 
on a.end_loc = b.start_loc and a.end_time = b.start_time
group by a.id ;


with ride_details as (
  select 
    *,
    lead(start_loc) over(partition by id order by end_time) next_loc
  from drivers 
)
select 
  id,
  count(*) total_rides,
  sum(case when end_loc=next_loc then 1 else 0 end) profit_ride
from ride_details 
group by id;



