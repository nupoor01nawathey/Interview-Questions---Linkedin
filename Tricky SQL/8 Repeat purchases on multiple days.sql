-- Repeat purchases on multiple days

-- Expected output
-- +---------+------------+
-- | user_id | product_id |
-- +---------+------------+
-- |     536 |       3223 |
-- +---------+------------+

-- +-------------+
-- | users_count |
-- +-------------+
-- |           1 |
-- +-------------+

create table purchases(user_id int,product_id int,quantity int,purchase_date datetime);

insert into purchases values(536, 3223, 6, '2022-01-11 12:33:44');
insert into purchases values(827, 3585, 35, '2022-02-20 14:05:26');
insert into purchases values(536, 3223, 5, '2022-03-02 09:33:28');
insert into purchases values(536, 1435, 10, '2022-03-02 08:40:00');
insert into purchases values(827, 2452, 45, '2022-03-02 00:00:00');
insert into purchases values(333, 1122, 9, '2022-02-06 01:00:00');
insert into purchases values(333, 1122, 10, '2022-02-06 02:00:00');

select * from purchases order by user_id;

select count(*) as users_count from (
select 
  user_id,
  product_id
  -- ,count(distinct date(purchase_date)) p_dt_count
from purchases
group by user_id, product_id 
having count(distinct date(purchase_date)) > 1
) a
