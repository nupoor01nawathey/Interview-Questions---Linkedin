
create table emp_data(
name varchar(30),
age int
);

insert into emp_data(name, age) values('Alice', 28),
 ('Bob', 35),
 ('Charlie', 42),
 ('David', 25),
 ('Eva', 31),
 ('Frank', 38),
 ('Grace', 45),
 ('Henry', 29);

select * from emp_data;

with CTE as (
	select
		*,
		ntile(4) over() as nth_part
	from emp_data
)
select * from CTE where nth_part=3 ;
