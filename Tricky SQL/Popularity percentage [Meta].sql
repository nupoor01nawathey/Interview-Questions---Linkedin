-- Input: 
-- Friends table:
-- +-------+-------+
-- | user1 | user2 | 
-- +-------+-------+
-- | 2     | 1     | 
-- | 1     | 3     | 
-- | 4     | 1     | 
-- | 1     | 5     | 
-- | 1     | 6     |
-- | 2     | 6     | 
-- | 7     | 2     | 
-- | 8     | 3     | 
-- | 3     | 9     |  
-- +-------+-------+

-- Output: 
-- +-------+-----------------------+
-- | user1 | percentage_popularity |
-- +-------+-----------------------+
-- | 1     | 55.56                 |
-- | 2     | 33.33                 |
-- | 3     | 33.33                 |
-- | 4     | 11.11                 |
-- | 5     | 11.11                 |
-- | 6     | 22.22                 |
-- | 7     | 11.11                 |
-- | 8     | 11.11                 |
-- | 9     | 11.11                 |
-- +-------+-----------------------+
-- Explanation: 
-- There are total 9 users on the platform.
-- - User "1" has friendships with 2, 3, 4, 5 and 6. Therefore, the percentage popularity for user 1 would be calculated as (5/9) * 100 = 55.56.
-- - User "2" has friendships with 1, 6 and 7. Therefore, the percentage popularity for user 2 would be calculated as (3/9) * 100 = 33.33.
-- - User "3" has friendships with 1, 8 and 9. Therefore, the percentage popularity for user 3 would be calculated as (3/9) * 100 = 33.33.
-- - User "4" has friendships with 1. Therefore, the percentage popularity for user 4 would be calculated as (1/9) * 100 = 11.11.
-- - User "5" has friendships with 1. Therefore, the percentage popularity for user 5 would be calculated as (1/9) * 100 = 11.11.
-- - User "6" has friendships with 1 and 2. Therefore, the percentage popularity for user 6 would be calculated as (2/9) * 100 = 22.22.
-- - User "7" has friendships with 2. Therefore, the percentage popularity for user 7 would be calculated as (1/9) * 100 = 11.11.
-- - User "8" has friendships with 3. Therefore, the percentage popularity for user 8 would be calculated as (1/9) * 100 = 11.11.
-- - User "9" has friendships with 3. Therefore, the percentage popularity for user 9 would be calculated as (1/9) * 100 = 11.11.
-- user1 is sorted in ascending order.


create table friends (user1 int, user2 int);

insert into friends values(2, 1); 
insert into friends values(1, 3); 
insert into friends values(4, 1); 
insert into friends values(1, 5); 
insert into friends values(1, 6);
insert into friends values(2, 6); 
insert into friends values(7, 2); 
insert into friends values(8, 3); 
insert into friends values(3, 9);  


select * from friends ;


with users as (
  select 
    user1, user2
  from friends 
  union
  select 
    user2 as user1, user1 as user2
  from friends 
)
select 
  user1, count(1) * 100.0 / (select count(distinct user1) from friends) as popularity 
from users 
group by user1
order by user1 ; 

















