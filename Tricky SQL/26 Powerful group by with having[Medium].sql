create table exams (student_id int, subject varchar(20), marks int);

insert into exams values (1,'Chemistry',91),(1,'Physics',91)
,(2,'Chemistry',80),(2,'Physics',90)
,(3,'Chemistry',80)
,(4,'Chemistry',71),(4,'Physics',54);

select * from exams;


select
  student_id  
from exams
where subject in ('Physics', 'Chemistry')
group by student_id
having count(distinct subject)=2 and count(distinct marks)=1
;

select
  student_id  
from exams
where subject in ('Physics', 'Chemistry')
group by student_id
having count(distinct subject)=2 and max(marks)=avg(marks);
;