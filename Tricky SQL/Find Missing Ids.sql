/*
SQL EQUIVALENT - USING RECURSIVE CTE
*/

create table ids (id int);

insert into ids values(1);
insert into ids values(2);
insert into ids values(3);
insert into ids values(5);
insert into ids values(6);
insert into ids values(7);
insert into ids values(9);

select * from ids ;

with recursive all_ids as (
  select min(id) as id from ids 
  union
  select id+1 as id from all_ids where id < (select max(id) from ids)
)
-- select * from all_ids ;
select 
  t2.id from all_ids t2 
left join ids t1
on t2.id=t1.id
where t1.id is null ;

