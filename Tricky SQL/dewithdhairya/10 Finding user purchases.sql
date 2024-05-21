
create table amazon_interview (
user_id int,
item varchar(50),
created_at date,
revenue bigint
);

insert into amazon_interview(user_id , item , created_at, revenue)
values(100, 'bread', '2020-03-07', 410),(100, 'banana' ,'2020-03-13' ,175),
(100, 'banana','2020-03-29', 599),
(101, 'milk', '2020-03-01', 449),
(101, 'milk', '2020-03-26', 740),
(114, 'banana', '2020-03-10', 200),
(114, 'biscuit', '2020-03-16', 300);

select * from amazon_interview ;

with cte as (
	select 
		*,
		lag(created_at,1) over(partition by user_id order by created_at asc) prev_dt
	from amazon_interview 
)
select
	distinct user_id
from cte
where created_at - prev_dt <= 6 ;

