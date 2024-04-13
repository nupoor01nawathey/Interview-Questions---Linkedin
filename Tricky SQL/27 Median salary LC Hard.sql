-- LeetCode hard problem to find median salary of employees for each company. 

create table employee 
(
  emp_id int,
  company varchar(10),
  salary int
);

insert into employee values (1,'A',2341);
insert into employee values (2,'A',341);
insert into employee values (3,'A',15);
insert into employee values (4,'A',15314);
insert into employee values (5,'A',451);
insert into employee values (6,'A',513);
insert into employee values (7,'B',15);
insert into employee values (8,'B',13);
insert into employee values (9,'B',1154);
insert into employee values (10,'B',1345);
insert into employee values (11,'B',1221);
insert into employee values (12,'B',234);
insert into employee values (13,'C',2345);
insert into employee values (14,'C',2645);
insert into employee values (15,'C',2645);
insert into employee values (16,'C',2652);
insert into employee values (17,'C',65);


select * from employee;

select 
  company, 
  avg(salary) median_per_company
from (
  select 
    *,
    row_number() over(partition by company order by salary asc) rn,
    count(1) over(partition by company) cnt 
  from employee
) a
where rn between cnt*1.0/2  and cnt*1.0/2+1 
group by company ;


-- +--------+---------+--------+----+-----+-----------+-------------+
-- | emp_id | company | salary | rn | cnt | cnt*1.0/2 | cnt*1.0/2+1 |
-- +--------+---------+--------+----+-----+-----------+-------------+
-- |      2 | A       |    341 |  2 |   6 |   3.00000 |     4.00000 |
-- |      5 | A       |    451 |  3 |   6 |   3.00000 |     4.00000 |
-- |      6 | A       |    513 |  4 |   6 |   3.00000 |     4.00000 |
-- |      1 | A       |   2341 |  5 |   6 |   3.00000 |     4.00000 |
-- |      4 | A       |  15314 |  6 |   6 |   3.00000 |     4.00000 |
-- |      3 | A       |     15 |  1 |   6 |   3.00000 |     4.00000 |
-- |     12 | B       |    234 |  3 |   6 |   3.00000 |     4.00000 |
-- |     10 | B       |   1345 |  6 |   6 |   3.00000 |     4.00000 |
-- |     11 | B       |   1221 |  5 |   6 |   3.00000 |     4.00000 |
-- |      9 | B       |   1154 |  4 |   6 |   3.00000 |     4.00000 |
-- |      7 | B       |     15 |  2 |   6 |   3.00000 |     4.00000 |
-- |      8 | B       |     13 |  1 |   6 |   3.00000 |     4.00000 |
-- |     17 | C       |     65 |  1 |   5 |   2.50000 |     3.50000 |
-- |     13 | C       |   2345 |  2 |   5 |   2.50000 |     3.50000 |
-- |     14 | C       |   2645 |  3 |   5 |   2.50000 |     3.50000 |
-- |     15 | C       |   2645 |  4 |   5 |   2.50000 |     3.50000 |
-- |     16 | C       |   2652 |  5 |   5 |   2.50000 |     3.50000 |
-- +--------+---------+--------+----+-----+-----------+-------------+



