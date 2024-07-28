-- MS SQL DDL 
-- Mesho
-- If multiple year data is available then need to consider year also in grouping

CREATE TABLE covid_cases (
  record_date DATE PRIMARY KEY,
  cases_count INT
);

DECLARE @end_date date;
DECLARE @loop_date date;
DECLARE @num INT;
set @end_date = '2021-12-31'
set @loop_date = '2021-01-01'

WHILE @loop_date <= @end_date
BEGIN
	select @num = floor(RAND()*(1000-500)+500);
    insert into covid_cases(record_date, cases_count) values(@loop_date, @num);
    select @loop_date = dateadd(day, 1, cast(@loop_date as date));
END ;

-- select * from covid_cases ; 

with monthly_cases as (
  select 
    month(record_date) mnth ,
    sum(cases_count) cases_count
  from covid_cases 
  group by month(record_date)
), cum_cases_c as (
select
  *,
  sum(cases_count) over(order by mnth rows between unbounded preceding and 1 preceding) cum_sum
from monthly_cases
)
select
  *,
  case when cases_count is null then 0 else
  ROUND((1.0 * cases_count / cum_sum ) * 100, 2) end as cum_perc
from cum_cases_c ;


