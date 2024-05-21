
-- A company's executives are interested in seeing who earns the most money in each of the company's departments. 
-- A high earner in a department is an employee who has a salary in the top three unique salaries for that department.
-- Write a solution to find the employees who are high earners in each of the departments.
-- Return the result table in any order.

-- Input: 
-- Employee table:
-- +----+-------+--------+--------------+
-- | id | name  | salary | departmentId |
-- +----+-------+--------+--------------+
-- | 1  | Joe   | 85000  | 1            |
-- | 2  | Henry | 80000  | 2            |
-- | 3  | Sam   | 60000  | 2            |
-- | 4  | Max   | 90000  | 1            |
-- | 5  | Janet | 69000  | 1            |
-- | 6  | Randy | 85000  | 1            |
-- | 7  | Will  | 70000  | 1            |
-- +----+-------+--------+--------------+
-- Department table:
-- +----+-------+
-- | id | name  |
-- +----+-------+
-- | 1  | IT    |
-- | 2  | Sales |
-- +----+-------+
-- Output: 
-- +------------+----------+--------+
-- | Department | Employee | Salary |
-- +------------+----------+--------+
-- | IT         | Max      | 90000  |
-- | IT         | Joe      | 85000  |
-- | IT         | Randy    | 85000  |
-- | IT         | Will     | 70000  |
-- | Sales      | Henry    | 80000  |
-- | Sales      | Sam      | 60000  |
-- +------------+----------+--------+
-- Explanation: 
-- In the IT department:
-- - Max earns the highest unique salary
-- - Both Randy and Joe earn the second-highest unique salary
-- - Will earns the third-highest unique salary

-- In the Sales department:
-- - Henry earns the highest salary
-- - Sam earns the second-highest salary
-- - There is no third-highest salary as there are only two employees

create table Employee3(id int, name varchar(20), salary int, departmentId int);

truncate table employee3 ;

insert into employee3 values(1,"Joe",85000,1),
(2,"Henry",80000,2),
(3,"Sam",60000,2),
(4,"Max",90000,1),
(5,"Janet",69000,1),
(6,"Randy",85000,1),
(7,"Will",70000,1) ;

create table Department(id int, name varchar(20));

insert into Department values(1,"IT"), (2,"Sales");


select * from Employee3;
select * from Department;


select department_name,emp_name,salary from (
	select
		d.name as department_name,
		e.name as emp_name,
		e.salary,
		dense_rank() over(partition by e.departmentId order by salary desc) dr
	from Employee3 e inner join Department d
	on e.departmentId=d.id
) A
where A.dr < 4