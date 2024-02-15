-- Amazon, print employees earning more than their managers

create table emp (
  emp_id int, 
  emp_name char(10),
  designation char(10),
  manager_id int,
  hire_date date,
  salary int,
  dep_id int
);

insert into emp values(68319,"KAYLING","PRESIDENT",null,"1991-11-18",6000.00,1001);
insert into emp values(66928,"BLAZE","MANAGER",68319,"1991-05-01",2750.00,3001);
insert into emp values(67832,"CLARE","MANAGER",68319,"1991-06-09",2550.00,1001);
insert into emp values(65646,"JONAS","MANAGER",68319,"1991-04-02",2957.00,2001);
insert into emp values(67858,"SCARLET","ANALYST",65646,"1997-04-19",3100.00,2001);
insert into emp values(69062,"FRANK","ANALYST",65646,"1991-12-03",3100.00,2001);
insert into emp values(63679,"SANDRINE","CLERK",69062,"1990-12-18", 900.00,2001);
insert into emp values(64989,"ADELYN","SALESMAN",66928,"1991-02-20",1700.00,3001);
insert into emp values(65271,"WADE","SALESMAN",66928,"1991-02-22",1350.00,3001);
insert into emp values(66564,"MADDEN","SALESMAN",66928,"1991-09-28",1350.00,3001);
insert into emp values(68454,"TUCKER","SALESMAN",66928,"1991-09-08",1600.00,3001);
insert into emp values(68736,"ADNRES","CLERK",67858,"1997-05-23",1200.00,2001);
insert into emp values(69000,"JULIUS","CLERK",66928,"1991-12-03",1050.00,3001);
insert into emp values(69324,"MARKER","CLERK",67832,"1992-01-23",1400.00,1001);

select * from emp ; 


select
  distinct e.emp_id,
  e.emp_name,
  e.designation,
  e.salary,
  m.manager_id
from emp e inner join emp m
on e.emp_id=m.manager_id 
where e.salary > m.salary
;
  
-- +--------+----------+-------------+--------+------------+
-- | emp_id | emp_name | designation | salary | manager_id |
-- +--------+----------+-------------+--------+------------+
-- |  68319 | KAYLING  | PRESIDENT   |   6000 |      68319 |
-- |  69062 | FRANK    | ANALYST     |   3100 |      69062 |
-- |  66928 | BLAZE    | MANAGER     |   2750 |      66928 |
-- |  67858 | SCARLET  | ANALYST     |   3100 |      67858 |
-- |  67832 | CLARE    | MANAGER     |   2550 |      67832 |
-- +--------+----------+-------------+--------+------------+

