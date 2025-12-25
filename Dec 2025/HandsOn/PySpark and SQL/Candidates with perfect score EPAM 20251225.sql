/*
EPAM

Write a SQL query to count the number of candidates got a perfect score in each experience category, 
in which they were requested to solve the task(NULL means the candidate was not requested to solve the 
tasks in that category)

100 -> Perfect score
NULL -> as good as perfect score since candidate was not requested to solve the tasks

Input for dataset 1:
+------+------------+------+------+------------+
| id   | experience | sql_ | algo | bug_fixing |
+------+------------+------+------+------------+
|    1 |          3 |  100 | NULL |         50 |
|    2 |          5 | NULL |  100 |        100 |
|    3 |          1 |  100 |  100 |        100 |
|    4 |          5 |  100 |   50 |       NULL |
|    5 |          5 |  100 |  100 |        100 |
+------+------------+------+------+------------+

Output for datase 1:
+------------+------------------+-----------+
| experience | total_candidates | max_score |
+------------+------------------+-----------+
|          3 |                1 |         0 |
|          5 |                3 |         2 |
|          1 |                1 |         1 |
+------------+------------------+-----------+


Input for dataset 2:
+------+------------+------+------+------------+
| id   | experience | sql_ | algo | bug_fixing |
+------+------------+------+------+------------+
|    1 |          2 | NULL | NULL |       NULL |
|    2 |         20 | NULL | NULL |         20 |
|    3 |          7 |  100 | NULL |        100 |
|    4 |          3 |  100 |   50 |       NULL |
|    5 |          2 |   40 |  100 |        100 |
+------+------------+------+------+------------+
Output for datase 2:
+------------+------------------+-----------+
| experience | total_candidates | max_score |
+------------+------------------+-----------+
|          2 |                2 |         1 |
|         20 |                1 |         0 |
|          7 |                1 |         1 |
|          3 |                1 |         0 |
+------------+------------------+-----------+
*/

create table assessments
(
  id int,
  experience int,
  sql_ int,
  algo int,
  bug_fixing int
) ;

delete from assessments ;
insert into assessments values 
(1,3,100,null,50),
(2,5,null,100,100),
(3,1,100,100,100),
(4,5,100,50,null),
(5,5,100,100,100) ;

delete from assessments ;
insert into assessments values 
(1,2,null,null,null),
(2,20,null,null,20),
(3,7,100,null,100),
(4,3,100,50,null),
(5,2,40,100,100);

select * from assessments ;

select 
  experience, count(*) as total_candidates,
  sum(case when (case when sql_ is null or sql_=100 then 1 else 0 end +
  case when algo is null or algo=100 then 1 else 0 end  + 
  case when bug_fixing is null or bug_fixing=100 then 1 else 0 end)=3 then 1 else 0 end) as max_score
from assessments 
group by experience;
  

