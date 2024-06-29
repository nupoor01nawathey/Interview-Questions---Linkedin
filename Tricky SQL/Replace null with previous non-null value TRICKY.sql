-- Replace NULL with previous valid value DELOITTE / CTS

-- Input
-- +------------+------------+
-- | category   | brand_name |
-- +------------+------------+
-- | chocolates | 5-star     |
-- | NULL       | dairy milk |
-- | NULL       | perk       |
-- | NULL       | eclair     |
-- | Biscuits   | britannia  |
-- | NULL       | good day   |
-- | NULL       | boost      |
-- +------------+------------+

-- Output
-- +------------+------------+
-- | brand_name | category   |
-- +------------+------------+
-- | 5-star     | chocolates |
-- | dairy milk | chocolates |
-- | perk       | chocolates |
-- | eclair     | chocolates |
-- | britannia  | Biscuits   |
-- | good day   | Biscuits   |
-- | boost      | Biscuits   |
-- +------------+------------+


create table brands (
  category varchar(20),
  brand_name varchar(20)
);

insert into brands values
('chocolates','5-star')
,(null,'dairy milk')
,(null,'perk')
,(null,'eclair')
,('Biscuits','britannia')
,(null,'good day')
,(null,'boost');

select * from brands ; 


with start_rn_c as (
select
  *,
  row_number() over(order by (select 1)) start_rn, -- select null will also work
  case when category is NULL then 0 else 1 end as grp_
from brands 
), grouping_c as (
select 
  *,
  sum(grp_) over(order by start_rn) rolling_sum
  from start_rn_c 
)
select 
  brand_name,
  max(category) over(partition by rolling_sum) as category
from grouping_c
;


-- select * from grouping_c ;
-- +------------+------------+----------+------+-------------+
-- | category   | brand_name | start_rn | grp_ | rolling_sum |
-- +------------+------------+----------+------+-------------+
-- | chocolates | 5-star     |        1 |    1 |           1 |
-- | NULL       | dairy milk |        2 |    0 |           1 |
-- | NULL       | perk       |        3 |    0 |           1 |
-- | NULL       | eclair     |        4 |    0 |           1 |
-- | Biscuits   | britannia  |        5 |    1 |           2 |
-- | NULL       | good day   |        6 |    0 |           2 |
-- | NULL       | boost      |        7 |    0 |           2 |
-- +------------+------------+----------+------+-------------+
  