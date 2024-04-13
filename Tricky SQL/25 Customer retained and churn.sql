-- Customer retention and customer churn metrics
-- Customer retention = repeat buyers using some reward program

create table transactions(
  order_id int,
  cust_id int,
  order_date date,
  amount int
);

insert into transactions values 
(1,1,'2020-01-15',150)
,(2,1,'2020-02-10',150)
,(3,2,'2020-01-16',150)
,(4,2,'2020-02-25',150)
,(5,3,'2020-01-10',150)
,(6,3,'2020-02-20',150)
,(7,4,'2020-01-20',150)
,(8,5,'2020-02-20',150)
;

select * from transactions ;

-- Even if there's are no customer retained for a month we still have to account
-- for such rows, that's why left join
with base_data as (
  select 
    EXTRACT(YEAR_MONTH from this_month.order_date) yr_mo,
    count(distinct last_moth.cust_id) total_users
  from transactions this_month left join transactions last_moth 
  on this_month.cust_id=last_moth.cust_id
  and PERIOD_DIFF(EXTRACT(YEAR_MONTH FROM this_month.order_date), 
  extract(YEAR_MONTH from last_moth.order_date))=1
  group by EXTRACT(YEAR_MONTH from this_month.order_date) 
)
select 
  *,
  case when total_users=0 then 'Customer Churn' else 'Customer retained' end as customer_status
from base_data ;
  
  