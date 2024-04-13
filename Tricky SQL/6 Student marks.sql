-- Q6 Students test

-- INPUT 
-- +---------+-------+
-- | test_id | marks |
-- +---------+-------+
-- |     100 |    55 |
-- |     101 |    55 |
-- |     102 |    60 |
-- |     103 |    58 |
-- |     104 |    40 |
-- |     105 |    50 |
-- +---------+-------+

-- OUTPUT 1
-- +---------+-------+
-- | test_id | marks |
-- +---------+-------+
-- |     100 |    55 |
-- |     102 |    60 |
-- |     105 |    50 |
-- +---------+-------+

-- OUTPUT 2
-- +---------+-------+
-- | test_id | marks |
-- +---------+-------+
-- |     102 |    60 |
-- |     105 |    50 |
-- +---------+-------+


drop table if exists  student_tests;
create table student_tests
(
	test_id		int,
	marks		int
);
insert into student_tests values(100, 55);
insert into student_tests values(101, 55);
insert into student_tests values(102, 60);
insert into student_tests values(103, 58);
insert into student_tests values(104, 40);
insert into student_tests values(105, 50);

select * from student_tests;

with cte as (
  select
    *,
    lag(marks,1,0) over(order by test_id) as prev_marks
  from student_tests
)
select test_id,marks from cte where marks > prev_marks ;


with cte as (
  select
    *,
    lag(marks,1,marks) over(order by test_id) as prev_marks
  from student_tests
)
select test_id,marks from cte where marks > prev_marks ;



