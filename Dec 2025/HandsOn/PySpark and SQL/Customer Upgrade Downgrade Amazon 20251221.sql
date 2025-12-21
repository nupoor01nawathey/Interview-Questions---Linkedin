CREATE TABLE subscribers (
  customer_id INT,
  subscription_date DATE,
  plan_value INT
);

INSERT INTO subscribers VALUES
(1, '2023-03-02', 799),
(1, '2023-04-01', 599),
(1, '2023-05-01', 499),
(2, '2023-04-02', 799),
(2, '2023-07-01', 599),
(2, '2023-09-01', 499),
(3, '2023-01-01', 499),
(3, '2023-04-01', 599),
(3, '2023-07-02', 799),
(4, '2023-04-01', 499),
(4, '2023-09-01', 599),
(4, '2023-10-02', 499),
(4, '2023-11-02', 799),
(5, '2023-10-02', 799),
(5, '2023-11-02', 799),
(6, '2023-03-01', 499);


select * from subscribers ;

-- 1.
select count(distinct customer_id) as unique_customers from subscribers ;


-- 2.
select 
  customer_id, 
  min(plan_value) as min_spend, 
  max(plan_value) as max_spend 
from subscribers group by customer_id ;


-- 3.
with cte as (
    select 
      *, 
      lag(plan_value,1,plan_value) over(partition by customer_id order by subscription_date) as previous_plan_value
    from subscribers
), cte2 as (
select 
  customer_id,
  max(case when plan_value > previous_plan_value then 1 else 0 end) as has_upgraded,
  max(case when plan_value < previous_plan_value then 1 else 0 end) as has_downgraded
from cte
group by customer_id
)
select
  customer_id,
  case when has_upgraded=1 then 'Yes' else 'No' end as has_upgraded,
  case when has_downgraded=1 then 'Yes' else 'No' end as has_downgraded
from cte2 ;
