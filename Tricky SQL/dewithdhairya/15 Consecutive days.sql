
CREATE TABLE pwc_attandance_log (
    emp_id  INT,
    log_date DATE,
    flag CHAR
);

truncate table pwc_attandance_log; 
insert into pwc_attandance_log(emp_id,log_date,flag) values
(101,'2024-01-02','N'),
(101,'2024-01-03','Y'),
(101,'2024-01-04','N'),
(101,'2024-01-07','Y'),
(102,'2024-01-01','N'),
(102,'2024-01-02','Y'),
(102,'2024-01-03','Y'),
(102,'2024-01-04','N'),
(102,'2024-01-05','Y'),
(102,'2024-01-06','Y'),
(102,'2024-01-07','Y'),
(103,'2024-01-01','N'),
(103,'2024-01-04','N'),
(103,'2024-01-05','Y'),
(103,'2024-01-06','Y'),
(103,'2024-01-07','N');


-- below solution is working
with c1 as (
  select
    *,
    extract(day from log_date) log_day ,
    row_number() over(partition by emp_id order by log_date asc) rn
  from pwc_attandance_log
  where flag='Y'
), c2 as (
  select 
    *,
    log_day - rn as diff
  from c1
), c3 as (
  select
    emp_id,
    min(log_date) as start_date,
    max(log_date) as end_date,
    count(1) as consecutive_days
  from c2
  group by emp_id, diff
)
select * from c3 where consecutive_days >= 2

	/*
		+--------+------------+------------+------------------+
		| emp_id | start_date | end_date   | consecutive_days |
		+--------+------------+------------+------------------+
		|    102 | 2024-01-02 | 2024-01-03 |                2 |
		|    102 | 2024-01-05 | 2024-01-07 |                3 |
		|    103 | 2024-01-05 | 2024-01-06 |                2 |
		+--------+------------+------------+------------------+
	*/

-- OR (below is not working, getting some bigint error)
with cte1 as (
	select
		*,
		extract(day from log_date) log_day,
		row_number() over(order by log_date) rn
	from pwc_attandance_log where flag='Y'
), cte2 as (
	select 
		*,
		CAST(log_day as UNSIGNED) - cast(rn as UNSIGNED) as group_
	from cte1
), cte3 as (
	select
		emp_id,
		min(log_date) as start_date,
		max(log_date) as end_date,
		count(1) as consecutive_days
	from cte2
	group by emp_id, group_ 
)
select * from cte3 where consecutive_days >= 2;
