-- [PBC]
-- Group based on status check input and expected output, there's a catch in state.
-- State could be repeated, so grouping logic is important to understand

-- Instead of state success/failure there could online/offline 

-- Expected output
-- +------------+------------+---------+
-- | start_date | end_date   | state   |
-- +------------+------------+---------+
-- | 2019-01-01 | 2019-01-03 | success |
-- | 2019-01-04 | 2019-01-05 | fail    |
-- | 2019-01-06 | 2019-01-06 | success |
-- +------------+------------+---------+



create table tasks (
  date_value date,
  state varchar(10)
);

insert into tasks  values ('2019-01-01','success'),('2019-01-02','success'),('2019-01-03','success'),('2019-01-04','fail')
,('2019-01-05','fail'),('2019-01-06','success') ;

select * from tasks;

with base as (
  select
    *,
    day(date_value) day_value,
    row_number() over (partition by state order by date_value) as group_value
  from tasks order by date_value 
),
dates as (
  select 
    date_value,
    state,
    day_value - group_value as group_condition
  from base
)
select 
  min(date_value) start_date,
  max(date_value) end_date,
  state
from dates
group by state, group_condition ;

-- select * from base ;
-- +------------+---------+-----------+-------------+
-- | date_value | state   | day_value | group_value |
-- +------------+---------+-----------+-------------+
-- | 2019-01-01 | success |         1 |           1 |
-- | 2019-01-02 | success |         2 |           2 |
-- | 2019-01-03 | success |         3 |           3 |
-- | 2019-01-04 | fail    |         4 |           1 |
-- | 2019-01-05 | fail    |         5 |           2 |
-- | 2019-01-06 | success |         6 |           4 |
-- +------------+---------+-----------+-------------+

-- select * from dates;
-- +------------+---------+-----------------+
-- | date_value | state   | group_condition |
-- +------------+---------+-----------------+
-- | 2019-01-01 | success |               0 |
-- | 2019-01-02 | success |               0 |
-- | 2019-01-03 | success |               0 |
-- | 2019-01-04 | fail    |               3 |
-- | 2019-01-05 | fail    |               3 |
-- | 2019-01-06 | success |               2 |
-- +------------+---------+-----------------+

