-- Paypal SQL Interview Question asked in Data Engineer Interview for Thursday workout 💪

-- Table1:-employee_checkin_details
-- employeeid ,entry_details,timestamp_details 
-- 1000 , login , 2023-06-16 01:00:15.34
-- 1000 , login , 2023-06-16 02:00:15.34
-- 1000 , login , 2023-06-16 03:00:15.34
-- 1000 , logout , 2023-06-16 12:00:15.34
-- 1001 , login , 2023-06-16 01:00:15.34
-- 1001 , login , 2023-06-16 02:00:15.34
-- 1001 , login , 2023-06-16 03:00:15.34
-- 1001 , logout , 2023-06-16 12:00:15.34

-- Table2:-employee_details
-- employeeid , phone_number , isdefault
-- 1001 ,9999 , false
-- 1001 ,1111 , false
-- 1001 ,2222 , true
-- 1003 ,3333 , false

-- Write an SQL to find the output table as below 
-- employeeid,employee_default_phone_number,totalentry,totallogin,totallogout,latestlogin,latestlogout
-- Expected output
-- +------------+--------------+------------+------------+-------------+---------------------+---------------------+
-- | employeeid | phone_number | totalentry | totallogin | totallogout | latestlogin         | latestlogout        |
-- +------------+--------------+------------+------------+-------------+---------------------+---------------------+
-- |       1000 |         NULL |          4 |          3 |           1 | 2023-06-16 03:00:15 | 2023-06-16 12:00:15 |
-- |       1001 |         2222 |          4 |          3 |           1 | 2023-06-16 03:00:15 | 2023-06-16 12:00:15 |
-- +------------+--------------+------------+------------+-------------+---------------------+---------------------+


create table employee_checkin_details(employeeid int,entry_details varchar(50),timestamp_details timestamp) ;

insert into employee_checkin_details values(1000,"login","2023-06-16 01:00:15.34");
insert into employee_checkin_details values(1000,"login","2023-06-16 02:00:15.34");
insert into employee_checkin_details values(1000,"login","2023-06-16 03:00:15.34");
insert into employee_checkin_details values(1000,"logout","2023-06-16 12:00:15.34");
insert into employee_checkin_details values(1001,"login","2023-06-16 01:00:15.34");
insert into employee_checkin_details values(1001,"login","2023-06-16 02:00:15.34");
insert into employee_checkin_details values(1001,"login","2023-06-16 03:00:15.34");
insert into employee_checkin_details values(1001,"logout","2023-06-16 12:00:15.34");

create table employee_details(employeeid int, phone_number int, isdefault char(10)) ; 

insert into employee_details values(1001,9999,"false");
insert into employee_details values(1001,1111,"false");
insert into employee_details values(1001,2222,"true");
insert into employee_details values(1003,3333,"false");

select * from employee_checkin_details ;
select * from employee_details ;


select
  a.employeeid,
  c.phone_number,
  count(*) as totalentry,
  count(case when entry_details='login' then timestamp_details else null end) as totallogin,
  count(case when entry_details='logout' then timestamp_details else null end) as totallogout,
  max(case when entry_details='login' then timestamp_details else null end) as latestlogin,
  max(case when entry_details='logout' then timestamp_details else null end) as latestlogout
from employee_checkin_details a
left join employee_details c
on a.employeeid=c.employeeid and c.isdefault='true'
group by a.employeeid,c.phone_number


