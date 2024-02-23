-- Total sale by year LC Hard problem

create table sales (
  product_id int,
  period_start date,
  period_end date,
  average_daily_sales int
);

insert into sales values
(1,'2019-01-25','2019-02-28',100),
(2,'2018-12-01','2020-01-01',10),
(3,'2019-12-01','2020-01-31',1);

select * from sales ;

with recursive day_sales as (
  select min(period_start) as dates, max(period_end) as max_end_date from sales
  UNION ALL
  SELECT date_add(dates, INTERVAL 1 DAY) as dates, max_end_date
  from day_sales
  where dates < max_end_date 
)
select 
  product_id,
  year(dates) as report_year,
  sum(average_daily_sales) as total_amount
from day_sales inner join sales
on dates between period_start and period_end
group by product_id,year(dates)
order by product_id
;

