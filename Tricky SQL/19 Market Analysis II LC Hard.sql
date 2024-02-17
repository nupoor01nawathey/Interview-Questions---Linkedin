-- Leetcode Hard Problem  | Market Analysis 2 
-- Write an SQL query to find for each user, whether the brand of the second item (by date) they sold is their favorite brand. If a user sold less than two items, report the answer for that user as no.

-- It is guaranteed that no seller sold more than one item on a day.

-- Result table:
-- +-----------+--------------------+
-- | seller_id | 2nd_item_fav_brand |
-- +-----------+--------------------+
-- | 1         | no                 |
-- | 2         | yes                |
-- | 3         | yes                |
-- | 4         | no                 |
-- +-----------+--------------------+

-- The answer for the user with id 1 is no because they sold nothing.
-- The answer for the users with id 2 and 3 is yes because the brands of their second sold items are their favorite brands.
-- The answer for the user with id 4 is no because the brand of their second sold item is not their favorite brand.


create table users (
 user_id         int     ,
 join_date       date    ,
 favorite_brand  varchar(50));

 create table orders (
 order_id       int     ,
 order_date     date    ,
 item_id        int     ,
 buyer_id       int     ,
 seller_id      int 
 );

 create table items
 (
 item_id        int     ,
 item_brand     varchar(50)
 );


insert into users values (1,'2019-01-01','Lenovo'),(2,'2019-02-09','Samsung'),(3,'2019-01-19','LG'),(4,'2019-05-21','HP');

insert into items values (1,'Samsung'),(2,'Lenovo'),(3,'LG'),(4,'HP');

insert into orders values (1,'2019-08-01',4,1,2),(2,'2019-08-02',2,1,3),(3,'2019-08-03',3,2,3),(4,'2019-08-04',1,4,2)
,(5,'2019-08-04',1,3,4),(6,'2019-08-05',2,2,4);


select * from orders;
select * from users;
select * from items;

with ranked_orders as (
  select *, rank() over(partition by seller_id order by order_date asc) rnk
  from orders
)
select 
  u.user_id as user_id,
  case when i.item_brand=u.favorite_brand then 'Yes' else 'No' end as second_item_fav_brand
from users u -- Because if user sold < 2 items that record is also expected in the output
left join ranked_orders ro 
on u.user_id=ro.seller_id and rnk=2 -- since filter on rnk=2 will happen first and then join will happen user_id=1 will be available in the output
left join items i
on ro.item_id=i.item_id

--  ;



