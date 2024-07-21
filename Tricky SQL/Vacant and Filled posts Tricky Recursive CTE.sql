-- Create vacant and filled positions data TRICKY

-- Input
-- +------+--------------------+-------------+
-- | id   | name               | position_id |
-- +------+--------------------+-------------+
-- |    1 | John Smith         |           1 |
-- |    2 | Jane Doe           |           2 |
-- |    3 | Michael Brown      |           2 |
-- |    4 | Emily Johnson      |           2 |
-- |    5 | William Lee        |           3 |
-- |    6 | Jessica Clark      |           3 |
-- |    7 | Christopher Harris |           3 |
-- |    8 | Olivia Wilson      |           3 |
-- |    9 | Daniel Martinez    |           3 |
-- |   10 | Sophia Miller      |           3 |
-- +------+--------------------+-------------+
-- +------+-----------------+---------+--------+----------+-----------+
-- | id   | title           | groups_ | levels | payscale | totalpost |
-- +------+-----------------+---------+--------+----------+-----------+
-- |    1 | General manager | A       | l-15   |    10000 |         1 |
-- |    2 | Manager         | B       | l-14   |     9000 |         5 |
-- |    3 | Asst. Manager   | C       | l-13   |     8000 |        10 |
-- +------+-----------------+---------+--------+----------+-----------+


-- Output:
-- +------+-----------------+---------+--------+-----------+--------------------+
-- | id   | title           | groups_ | levels | totalpost | name               |
-- +------+-----------------+---------+--------+-----------+--------------------+
-- |    1 | General manager | A       | l-15   |         1 | John Smith         |
-- |    2 | Manager         | B       | l-14   |         5 | Jane Doe           |
-- |    2 | Manager         | B       | l-14   |         5 | Michael Brown      |
-- |    2 | Manager         | B       | l-14   |         5 | Emily Johnson      |
-- |    2 | Manager         | B       | l-14   |         5 | vacant             |
-- |    2 | Manager         | B       | l-14   |         5 | vacant             |
-- |    3 | Asst. Manager   | C       | l-13   |        10 | William Lee        |
-- |    3 | Asst. Manager   | C       | l-13   |        10 | Jessica Clark      |
-- |    3 | Asst. Manager   | C       | l-13   |        10 | Christopher Harris |
-- |    3 | Asst. Manager   | C       | l-13   |        10 | Olivia Wilson      |
-- |    3 | Asst. Manager   | C       | l-13   |        10 | Daniel Martinez    |
-- |    3 | Asst. Manager   | C       | l-13   |        10 | Sophia Miller      |
-- |    3 | Asst. Manager   | C       | l-13   |        10 | vacant             |
-- |    3 | Asst. Manager   | C       | l-13   |        10 | vacant             |
-- |    3 | Asst. Manager   | C       | l-13   |        10 | vacant             |
-- |    3 | Asst. Manager   | C       | l-13   |        10 | vacant             |
-- +------+-----------------+---------+--------+-----------+--------------------+


create table job_positions (
  id  int,
  title char(200),
  groups_ char(20),
  levels char(20),     
  payscale int, 
  totalpost int
);

insert into job_positions values (1, 'General manager', 'A', 'l-15', 10000, 1); 
insert into job_positions values (2, 'Manager', 'B', 'l-14', 9000, 5); 
insert into job_positions values (3, 'Asst. Manager', 'C', 'l-13', 8000, 10);  

create table job_employees ( 
  id  int, 
  name   varchar(100),     
  position_id  int 
);  
insert into job_employees values (1, 'John Smith', 1); 
insert into job_employees values (2, 'Jane Doe', 2);
insert into job_employees values (3, 'Michael Brown', 2);
insert into job_employees values (4, 'Emily Johnson', 2); 
insert into job_employees values (5, 'William Lee', 3); 
insert into job_employees values (6, 'Jessica Clark', 3); 
insert into job_employees values (7, 'Christopher Harris', 3);
insert into job_employees values (8, 'Olivia Wilson', 3);
insert into job_employees values (9, 'Daniel Martinez', 3);
insert into job_employees values (10, 'Sophia Miller', 3);

select * from job_employees ; 
select * from job_positions ;


with RECURSIVE cte1 as (
  select id, title, groups_, levels, payscale, totalpost, 1 as rn from job_positions
  union all
  select id, title, groups_, levels, payscale, totalpost, rn + 1 from cte1 
  where rn + 1 <= totalpost 
),
emp as (
  select
    *,
    row_number() over(partition by position_id order by id) rn_e
  from job_employees
)
select 
  c.id,
  c.title,
  c.groups_,
  c.levels,
  c.totalpost,
  coalesce(e.name, 'vacant') name
from cte1 c left join emp e
on c.id = e.position_id
and c.rn = e.rn_e
order by id
;




