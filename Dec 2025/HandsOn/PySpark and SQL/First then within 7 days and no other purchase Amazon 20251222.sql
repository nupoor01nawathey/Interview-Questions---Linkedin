
/*
Find the users who made their first purchase, then exactly one purchase within 7 days, but
never made another purchase after that.

+----------+------------+---------+
| order_id | order_date | user_id |
+----------+------------+---------+
|      101 | 2024-01-01 |       1 |
|      102 | 2024-01-05 |       1 |
|      103 | 2024-01-01 |       2 |
|      104 | 2024-01-20 |       2 |
|      105 | 2024-02-01 |       3 |
|      106 | 2024-02-03 |       3 |
|      107 | 2024-02-10 |       3 |
|      108 | 2024-03-01 |       4 |
|      109 | 2024-03-08 |       4 |
|      110 | 2024-04-01 |       5 |
|      111 | 2024-05-10 |       6 |
|      112 | 2024-05-10 |       6 |
+----------+------------+---------+

+---------+-------------+--------------+
| user_id | first_order | second_order |
+---------+-------------+--------------+
|       1 | 2024-01-01  | 2024-01-05   |
|       4 | 2024-03-01  | 2024-03-08   |
|       6 | 2024-05-10  | 2024-05-10   | 
+---------+-------------+--------------+

*/

CREATE TABLE orders (
  order_id INT,
  order_date DATE,
  user_id INT
);

INSERT INTO orders VALUES
(101, '2024-01-01', 1),
(102, '2024-01-05', 1),
(103, '2024-01-01', 2),
(104, '2024-01-20', 2),
(105, '2024-02-01', 3),
(106, '2024-02-03', 3),
(107, '2024-02-10', 3),
(108, '2024-03-01', 4),
(109, '2024-03-08', 4),
(110, '2024-04-01', 5),
(111, '2024-05-10', 6),
(112, '2024-05-10', 6);

select * from orders ;

with cte as (
select 
  user_id, min(order_date) as first_order, max(order_date) as second_order
from orders
group by user_id
having count(*) = 2
)
select user_id, first_order, second_order
from cte
where datediff(second_order, first_order)  <= 7