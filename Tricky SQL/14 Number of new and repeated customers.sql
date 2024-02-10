

create table customer_orders (
order_id int,
customer_id int,
order_date date,
order_amount int
);

insert into customer_orders values(1,100,cast('2022-01-01' as date),2000),(2,200,cast('2022-01-01' as date),2500),(3,300,cast('2022-01-01' as date),2100)
,(4,100,cast('2022-01-02' as date),2000),(5,400,cast('2022-01-02' as date),2200),(6,500,cast('2022-01-02' as date),2700)
,(7,100,cast('2022-01-03' as date),3000),(8,400,cast('2022-01-03' as date),1000),(9,600,cast('2022-01-03' as date),3000)
;

select * from customer_orders ; 

with cte as (
  select
    customer_id,
    min(order_date) first_ordered_date
  from customer_orders
  group by customer_id
),
cte2 as (
  select 
    co.*,
    c.first_ordered_date
  from customer_orders co join cte c
  on co.customer_id=c.customer_id
)
select
  order_date,
  sum(case when order_date=first_ordered_date then 1 else 0 end) as no_of_first_time_visitors,
  sum(case when order_date!=first_ordered_date then 1 else 0 end) as no_of_repeated_customers
from cte2 
group by order_date
;


-- +------------+---------------------------+--------------------------+
-- | order_date | no_of_first_time_visitors | no_of_repeated_customers |
-- +------------+---------------------------+--------------------------+
-- | 2022-01-01 |                         3 |                        0 |
-- | 2022-01-02 |                         2 |                        1 |
-- | 2022-01-03 |                         1 |                        2 |
-- +------------+---------------------------+--------------------------+
