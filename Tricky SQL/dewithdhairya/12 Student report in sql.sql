
create table student (
student_id int , 
name varchar(40)
);
insert into student(student_id , name) 
values(1,'Steve'),(2,'David'),(3,'Aryan');

create table marks (
student_id int ,
subject_name varchar(50) ,
marks int 
);

insert into marks(student_id , subject_name, marks) values(1,'pyspark',90),(1,'sql',100),
(2,'sql',70),(2,'pyspark',60),(3,'sql',60),(3,'pyspark',55);


select * from student;
select * from marks;

with cte1 as (
	select
		student_id,
		round(sum(marks)* 100 / (count(1) * 100), 2) as perc
	from marks 
	group by student_id
)
select 
	c1.student_id,
    perc,
    s.name,
	case when perc >= 70 then 'Distinction' 
         when perc between 60 and 69 then 'First Class'
         when perc between 50 and 50 then 'Second Class'
         when perc between 40 and 49 then 'Third Class'
		 else 'Fail'
	end as Result
from cte1 c1 inner join student s
on c1.student_id = s.student_id ;


