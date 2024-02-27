-- Given the following two tables, return the fraction of users, rounded to two decimal places,
-- who accessed Amazon music and upgraded to prime membership within the first 30 days of signing up. 

create table users
(
  user_id integer,
  name varchar(20),
  join_date date
);
insert into users
values (1, 'Jon', '2020-02-14'), 
(2, 'Jane', '2020-02-14'), 
(3, 'Jill', '2020-02-15'), 
(4, 'Josh', '2020-02-15'), 
(5, 'Jean', '2020-02-16'), 
(6, 'Justin', '2020-02-17'),
(7, 'Jeremy', '2020-02-18');

create table events
(
  user_id integer,
  type varchar(10),
  access_date date
);

insert into events values
(1, 'Pay', '2020-03-01' ), 
(2, 'Music', '2020-03-02' ), 
(2, 'P', '2020-03-12' ),
(3, 'Music', '2020-03-15'), 
(4, 'Music', '2020-03-15'), 
(1, 'P', '2020-03-16'), 
(3, 'P', '2020-03-22');

select * from users;
select * from events;

with base as (
select 
  count(distinct u.user_id) as total_amazon_users,
  count(case when datediff(e.access_date,u.join_date) <=30 then u.user_id end) total_prime_users 
from users u left join events e
on u.user_id=e.user_id and e.type='P'
where u.user_id in (select user_id from events where type='Music')
)
select ROUND(total_prime_users/total_amazon_users * 100, 2) as purchase_rate from base ;

