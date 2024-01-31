-- Amazon, There are 2 tables first table has 5 records and 2nd table has 10 records
-- you can assume any value in each of these tables. How many max and min records possible in case of 
-- inner join, left join, right join and full outer join ?

create table T1( id_1 int);
INSERT INTO T1 (id_1) VALUES (1);
INSERT INTO T1 (id_1) VALUES (1);
INSERT INTO T1 (id_1) VALUES (1);
INSERT INTO T1 (id_1) VALUES (1);
INSERT INTO T1 (id_1) VALUES (1);

create table T2( id_2 int);
INSERT INTO T2(id_2) VALUES (1);
INSERT INTO T2 (id_2) VALUES (1);
INSERT INTO T2 (id_2) VALUES (1);
INSERT INTO T2 (id_2) VALUES (1);
INSERT INTO T2 (id_2) VALUES (1);
INSERT INTO T2(id_2) VALUES (1);
INSERT INTO T2 (id_2) VALUES (1);
INSERT INTO T2 (id_2) VALUES (1);
INSERT INTO T2 (id_2) VALUES (1);
INSERT INTO T2 (id_2) VALUES (1);

select * from T1;
select * from T2;


select 
  count(t1.id_1) as inner_join_count
from T1 t1 inner join T2 t2
on t1.id_1=t2.id_2 ;

select 
  count(t1.id_1) as left_join_count
from T1 t1 left join T2 t2
on t1.id_1=t2.id_2 ;

select 
  count(t1.id_1) as right_join_count
from T1 t1 left join T2 t2
on t1.id_1=t2.id_2 ;

-- full outer syntax not available in MySQL
select 
  count(t1.id_1) as full_join_count
from T1 t1 left join T2 t2
on t1.id_1=t2.id_2
UNION
select 
  count(t1.id_1) as full_join_count
from T1 t1 left join T2 t2
on t1.id_1=t2.id_2 ;



