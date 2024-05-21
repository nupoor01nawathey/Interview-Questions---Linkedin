
create table amazon_monthly_rev (
id int,
created_at date ,
value int , -- nothing but profit 
purchase_id int
);

truncate table amazon_monthly_rev ;

insert into  amazon_monthly_rev(id , created_at , value , purchase_id)
values(1,'2019-01-01',172692,43),
	  (2,'2019-01-05',177194,36),
	  (3,'2019-02-06',116948,56),
	  (4,'2019-02-10',162515,29),
	  (5,'2019-02-14',120741,30),
	  (6,'2019-03-22',151688,34),
	  (7,'2019-03-26',1002327,44);

select * from amazon_monthly_rev ;

with yr_mn_cte as (
	select 
		* ,
		concat ( year(created_at), '-' , month(created_at) ) as yr_mn
	from amazon_monthly_rev 
), curr_mn_cte as (
	select 
		yr_mn,
		sum(value) as curr_mn_value
	from yr_mn_cte
	group by yr_mn
), prev_mn_cte as (
	select 
		*,
		lag(curr_mn_value) over(order by yr_mn asc) as prev_mn_value
	from curr_mn_cte
)
select
	yr_mn as year_month1,
    ROUND(( curr_mn_value - prev_mn_value ) * 100.0 / prev_mn_value, 2 ) as perc_change
from prev_mn_cte 
order by yr_mn
;