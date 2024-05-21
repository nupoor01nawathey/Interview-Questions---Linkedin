
create table salary
(
 emp_id  int,
 emp_name varchar(30),
 base_salary int
);

insert into salary values(1, 'Rohan', 5000);
insert into salary values(2, 'Alex', 6000);
insert into salary values(3, 'Maryam', 7000);



create table income
(
 id   int,
 income  varchar(20),
 percentage int
);
insert into income values(1,'Basic', 100);
insert into income values(2,'Allowance', 4);
insert into income values(3,'Others', 6);



create table deduction
(
 id   int,
 deduction varchar(20),
 percentage int
);
insert into deduction values(1,'Insurance', 5);
insert into deduction values(2,'Health', 6);
insert into deduction values(3,'House', 4);


select * from salary;
select * from income;
select * from deduction;

with combined as(
select s.*,i.* from salary s inner join income i on 1=1 
union
select s.*,d.* from salary s inner join deduction d on 1=1
),amount as (
	select *, base_salary*percentage/100.0 as amount from combined 
),
salary_report as (
select 
	emp_name,
	sum(case when income='Basic' then amount end) as 'Basic' ,
	sum(case when income='Allowance' then amount end) as 'Allowance' ,
	sum(case when income='Others' then amount end) as 'Others' ,
	sum(case when income='Insurance' then amount end) as 'Insurance' ,
	sum(case when income='Health' then amount end) as 'Health' ,
	sum(case when income='House' then amount end) as 'House'
 from amount 
 group by emp_name
)
select 
	*,
	basic + allowance + others as Gross,
    insurance + health + house as total_deductions 
from salary_report 
order by emp_name ;

 