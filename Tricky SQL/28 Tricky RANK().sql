-- Find cities where the covid cases are increasing continuously

create table covid(city varchar(50),days date,cases int);

insert into covid values('DELHI','2022-01-01',100);
insert into covid values('DELHI','2022-01-02',200);
insert into covid values('DELHI','2022-01-03',300);
insert into covid values('MUMBAI','2022-01-01',100);
insert into covid values('MUMBAI','2022-01-02',100);
insert into covid values('MUMBAI','2022-01-03',300);
insert into covid values('CHENNAI','2022-01-01',100);
insert into covid values('CHENNAI','2022-01-02',200);
insert into covid values('CHENNAI','2022-01-03',150);
insert into covid values('BANGALORE','2022-01-01',100);
insert into covid values('BANGALORE','2022-01-02',300);
insert into covid values('BANGALORE','2022-01-03',200);
insert into covid values('BANGALORE','2022-01-04',400);

select * from covid;

with cte as (
select 
  *,
  cast(RANK() over(partition by city order by days asc) as signed) - cast(RANK() over(partition by city order by cases asc) as signed) diff
from covid
)
select
  city
from cte 
group by city
having max(diff)=0 and count(distinct diff)=1 ;

