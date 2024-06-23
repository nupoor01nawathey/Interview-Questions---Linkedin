-- Amazon Create present absence report of employees

drop table if exists emp_attendance;

create table emp_attendance
(
	employee 	varchar(10),
	dates 		date,
	status 		varchar(20)
);
insert into emp_attendance values('A1', '2024-01-01', 'PRESENT');
insert into emp_attendance values('A1', '2024-01-02', 'PRESENT');
insert into emp_attendance values('A1', '2024-01-03', 'PRESENT');
insert into emp_attendance values('A1', '2024-01-04', 'ABSENT');
insert into emp_attendance values('A1', '2024-01-05', 'PRESENT');
insert into emp_attendance values('A1', '2024-01-06', 'PRESENT');
insert into emp_attendance values('A1', '2024-01-07', 'ABSENT');
insert into emp_attendance values('A1', '2024-01-08', 'ABSENT');
insert into emp_attendance values('A1', '2024-01-09', 'ABSENT');
insert into emp_attendance values('A1', '2024-01-010', 'PRESENT');
insert into emp_attendance values('A2', '2024-01-06', 'PRESENT');
insert into emp_attendance values('A2', '2024-01-07', 'PRESENT');
insert into emp_attendance values('A2', '2024-01-08', 'ABSENT');
insert into emp_attendance values('A2', '2024-01-09', 'PRESENT');
insert into emp_attendance values('A2', '2024-01-010', 'ABSENT');

SELECT * from emp_attendance;

with cte as (
  select 
    *,
    row_number() over(partition by employee,status order by dates, status) emp_status_grp,
    row_number() over(partition by employee order by dates, status) emp_grp
  from emp_attendance
), cte_2 as (
  select 
    *,
     cast(emp_status_grp as signed) - cast(emp_grp as signed) as grp
  from cte
)
select 
  employee,
  min(dates) min_dt,
  max(dates) max_dt,
  status
from cte_2
group by employee, status, grp ; 


