
Create table If Not Exists Enrollments 
(student_id int, 
course_id int, 
grade int
);

insert into Enrollments (student_id, course_id, grade) values ('2', '2', '95') ,
('2', '3', '95'),
('1', '1', '90'),
('1', '2', '99'),
('3', '1', '80'),
('3', '2', '75'),
('3', '3', '82');

select * from enrollments;

with cte as (
	select
		*,
		dense_rank() over(partition by student_id order by grade desc, course_id asc) dr
	from enrollments 
)
select 
	student_id,
    course_id,
    grade
from cte where dr=1;



