
-- 📊 Question: The table logs the spending's history of users that make purchases from an online shopping website which has a desktop and a mobile application.

-- (user_id, spend_date, platform) is the primary key of this table.

-- 👉 Write a SQL query to find the total number of users and the total amount spent using mobile only, desktop only and both mobile and desktop together for each date.

-- The query result format is in the following example:

-- Spending table:
-- +---------+------------+----------+--------+
-- | user_id | spend_date | platform | amount |
-- +---------+------------+----------+--------+
-- | 1       | 2019-07-01 | mobile   | 100    |
-- | 1       | 2019-07-01 | desktop  | 100    |
-- | 2       | 2019-07-01 | mobile   | 100    |
-- | 2       | 2019-07-02 | mobile   | 100    |
-- | 3       | 2019-07-01 | desktop  | 100    |
-- | 3       | 2019-07-02 | desktop  | 100    |
-- +---------+------------+----------+--------+

-- Result table:
-- +----------+--------+------------+-----------+
-- |spend_date|platform|total_amount|total_users|
-- +----------+--------+------------+-----------+
-- |2019-07-01| mobile |     100    |     1     |
-- |2019-07-01| desktop|     100    |     1     |
-- |2019-07-01|  both  |     200    |     1     |
-- |2019-07-02| mobile |     100    |     1     |
-- |2019-07-02| desktop|     100    |     1     |
-- |2019-07-02|  both  |      0     |     0     |
-- +----------+--------+------------+-----------+
-- On 2019-07-01, user 1 purchased using both desktop and mobile, user 2 purchased using mobile only and user 3 purchased using desktop only.

-- On 2019-07-02, user 2 purchased using mobile only, user 3 purchased using desktop only and no one purchased using both platforms.

-- ✅ 𝗘𝘅𝗽𝗹𝗮𝗻𝗮𝘁𝗶𝗼𝗻:
-- 1️⃣ Count distinct platform and derive required platform column.
-- 2️⃣ Create platform data with all possible values and join to get spend_date wise platform.
-- 3️⃣ Join the above two results for required result.

create table spending(user_id int, spend_date date, platform varchar(15), amount int);

insert into spending values(1,'2019-07-01','mobile',100);
insert into spending values(1,'2019-07-01','desktop',100);
insert into spending values(2,'2019-07-01','mobile',100);
insert into spending values(2,'2019-07-02','mobile',100);
insert into spending values(3,'2019-07-01','desktop',100);
insert into spending values(3,'2019-07-02','desktop',100);

select * from spending;

with cte1 as (
  select 
    user_id,spend_date,
    count(distinct platform) platform_count
  from spending
  group by user_id,spend_date
)
-- select * from cte1 ;
-- +---------+------------+----------------+
-- | user_id | spend_date | platform_count |
-- +---------+------------+----------------+
-- |       1 | 2019-07-01 |              2 |
-- |       2 | 2019-07-01 |              1 |
-- |       2 | 2019-07-02 |              1 |
-- |       3 | 2019-07-01 |              1 |
-- |       3 | 2019-07-02 |              1 |
-- +---------+------------+----------------+
,cte2 as (
  select
    s.user_id,
    s.spend_date,
    s.amount,
    if(c1.platform_count>1, 'both', s.platform) as platform
  from spending s join cte1 c1
  on s.user_id=c1.user_id
  and s.spend_date=c1.spend_date
)
-- select * from cte2 ;
-- +---------+------------+--------+----------+
-- | user_id | spend_date | amount | platform |
-- +---------+------------+--------+----------+
-- |       1 | 2019-07-01 |    100 | both     |
-- |       1 | 2019-07-01 |    100 | both     |
-- |       2 | 2019-07-01 |    100 | mobile   |
-- |       2 | 2019-07-02 |    100 | mobile   |
-- |       3 | 2019-07-01 |    100 | desktop  |
-- |       3 | 2019-07-02 |    100 | desktop  |
-- +---------+------------+--------+----------+
-- select
--   spend_date,
--   platform,
--   sum(amount) as total_amount,
--   count(distinct user_id) total_users
-- from cte2
-- group by
-- spend_date,platform
-- above select will skip both platform record for 2019-07-02
-- +------------+----------+--------------+-------------+
-- | spend_date | platform | total_amount | total_users |
-- +------------+----------+--------------+-------------+
-- | 2019-07-01 | both     |          200 |           1 |
-- | 2019-07-01 | desktop  |          100 |           1 |
-- | 2019-07-01 | mobile   |          100 |           1 |
-- | 2019-07-02 | desktop  |          100 |           1 |
-- | 2019-07-02 | mobile   |          100 |           1 |
-- +------------+----------+--------------+-------------+
,
cte3 as (
  select distinct spend_date, a.platform
  from spending join
    (
      select 'desktop' as platform
      UNION
      select 'mobile' as platform
      UNION
      select 'both' as platform
    ) a
)
-- select * from cte3 ;
-- +------------+----------+
-- | spend_date | platform |
-- +------------+----------+
-- | 2019-07-01 | both     |
-- | 2019-07-01 | mobile   |
-- | 2019-07-01 | desktop  |
-- | 2019-07-02 | both     |
-- | 2019-07-02 | mobile   |
-- | 2019-07-02 | desktop  |
-- +------------+----------+

select 
  A.spend_date, A.platform,
  coalesce(sum(amount), 0) as total_amount,
  coalesce(count(distinct user_id), 0) as total_users
from cte3 A left join cte2 B
on A.platform = B.platform 
and A.spend_date = B.spend_date
group by A.spend_date, A.platform
order by A.spend_date, A.platform desc;

