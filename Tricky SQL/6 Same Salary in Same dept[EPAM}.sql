-- EPAM, Write a sql query to return all employees whose salary is same in the same department

-- Expected output
-- +--------+--------+--------+---------+
-- | emp_id | name   | salary | dept_id |
-- +--------+--------+--------+---------+
-- |    101 | sohan  | 3000   |      11 |
-- |    104 | cat    | 3000   |      11 |
-- |    102 | rohan  | 4000   |      12 |
-- |    105 | suresh | 4000   |      12 |
-- +--------+--------+--------+---------+

CREATE TABLE emp_salary (
  emp_id INTEGER  NOT NULL,
  name NVARCHAR(20)  NOT NULL,
  salary NVARCHAR(30),
  dept_id INTEGER
);

INSERT INTO emp_salary
(emp_id, name, salary, dept_id)
VALUES(101, 'sohan', '3000', '11'),
(102, 'rohan', '4000', '12'),
(103, 'mohan', '5000', '13'),
(104, 'cat', '3000', '11'),
(105, 'suresh', '4000', '12'),
(109, 'mahesh', '7000', '12'),
(108, 'kamal', '8000', '11');

select * from emp_salary;

with same_sal_cte as (
  select
    salary, dept_id
  from emp_salary
  group by dept_id, salary
  having count(1) > 1 
)
select
  es.*
from emp_salary es
inner join same_sal_cte ssc
on es.dept_id=ssc.dept_id
and es.salary=ssc.salary ;


-- easiest solution using window
with cte as (
  select 
    *,
    count(*) over(partition by dept_id,salary) same_salary
  from emp_salary
)
select
  emp_id, name, salary, dept_id
from cte
where same_salary > 1 ;

