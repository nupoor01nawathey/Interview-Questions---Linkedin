-- Write a solution to swap the seat id of every two consecutive students. 
-- If the number of students is odd, the id of the last student is not swapped.

-- Return the result table ordered by id in ascending order.
-- The result format is in the following example.

-- Example 1:

-- Input: 
-- Seat table:
-- +----+---------+
-- | id | student |
-- +----+---------+
-- | 1  | Abbot   |
-- | 2  | Doris   |
-- | 3  | Emerson |
-- | 4  | Green   |
-- | 5  | Jeames  |
-- +----+---------+

-- Explanation: 
-- Note that if the number of students is odd, there is no need to change the last one's seat.

create table students(
	id int,
    student varchar(20)
);

insert into students values
( 1,"Abbot"),
( 2,"Doris"),
( 3,"Emerson"),
( 4,"Green"),
( 5,"Jeames") ;

select * from students;

with cte as (
	select
		id,
		student,
		lead(student) over(order by id) as next_student,
        lag(student) over(order by id) as prev_student
	from students
)
select 
	id,
    student,
    case when id%2 != 0 then coalesce(next_student, student)
		 else prev_student end as exchange_student
from cte ;
