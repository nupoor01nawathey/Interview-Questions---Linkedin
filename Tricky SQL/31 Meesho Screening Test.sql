-- In case of clash choose less costly product

-- Input
-- +------------+------+
-- | product_id | cost |
-- +------------+------+
-- | P1         |  200 |
-- | P2         |  300 |
-- | P3         |  500 |
-- | P4         |  800 |
-- +------------+------+
-- +-------------+--------+
-- | customer_id | budget |
-- +-------------+--------+
-- |         100 |    400 |
-- |         200 |    800 |
-- |         300 |   1500 |
-- +-------------+--------+

-- Output
-- +-------------+--------+----------------+--------------------------+
-- | customer_id | budget | no_of_products | group_concat(product_id) |
-- +-------------+--------+----------------+--------------------------+
-- |         100 |    400 |              1 | P1                       |
-- |         200 |    800 |              2 | P1,P2                    |
-- |         300 |   1500 |              3 | P1,P2,P3                 |
-- +-------------+--------+----------------+--------------------------+

create table products
(
product_id varchar(20) ,
cost int
);
insert into products values ('P1',200),('P2',300),('P3',500),('P4',800);

create table customer_budget
(
customer_id int,
budget int
);

insert into customer_budget values (100,400),(200,800),(300,1500);

select * from products;

select * from customer_budget;


with running_cost as (
select
  *,
  sum(cost) over(order by cost asc) running_sum
from products
),
cte1 as (
  select
    *
  from running_cost rc 
  left join customer_budget cb
  on rc.running_sum < cb.budget 
  where customer_id is not null
)
select 
  customer_id,
  budget,
  count(1) no_of_products,
  group_concat(product_id)
from cte1
group by customer_id,budget
;

