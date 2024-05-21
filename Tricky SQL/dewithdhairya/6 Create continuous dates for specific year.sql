
Create table If Not Exists Failed 
(
 fail_date date
);

Create table If Not Exists Succeeded 
(
 success_date date
);

insert into Failed (fail_date) 
values ('2018-12-28'),('2018-12-29'),('2019-01-04'),('2019-01-05');

insert into Succeeded (success_date) values ('2018-12-30'),('2018-12-31'),('2019-01-01'),('2019-01-02'),('2019-01-03'),('2019-01-06');

select * from failed ;
select * from succeeded ;

with cte as (
	select 
		'failed' status, 
        fail_date as event_date, 
        extract(day from fail_date) - row_number() over() as diff 
	from failed 
    where fail_date >='2019-01-01'
	union
	select 
        'success' status, 
        success_date as event_date, 
        extract(day from success_date)  - row_number() over() as diff 
	from succeeded 
    where success_date >= '2019-01-01'
), cte2 as (
	select 
		diff,
		status as event_status,
		min(event_date) as start_date,
		max(event_date) as end_date
	from cte 
	group by status, diff
	order by start_date 
)
select event_status, start_date, end_date from cte2 ;

