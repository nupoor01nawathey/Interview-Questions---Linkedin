-- Write a query to find difference between 2 dates excluding weekends and public holidays. 
-- Basically we need to find business days between 2 given dates using SQL. 

-- Expected output
-- +-----------+-------------+---------------+--------------------+---------------+
-- | ticket_id | create_date | resolved_date | number_of_holidays | business_days |
-- +-----------+-------------+---------------+--------------------+---------------+
-- | 1         | 2022-08-01  | 2022-08-03    |                  0 |             2 |
-- | 2         | 2022-08-01  | 2022-08-12    |                  1 |             8 |
-- | 3         | 2022-08-01  | 2022-08-16    |                  2 |             9 |
-- +-----------+-------------+---------------+--------------------+---------------+

create table tickets(
  ticket_id varchar(10),
  create_date date,
  resolved_date date
);
insert into tickets values (1,'2022-08-01','2022-08-03'),(2,'2022-08-01','2022-08-12'),(3,'2022-08-01','2022-08-16');

create table holidays (
  holiday_date date
,reason varchar(100)
);

insert into holidays values ('2022-08-11','Rakhi'),('2022-08-15','Independence day');

select * from tickets;
select * from holidays;


-- Explaination
-- Get the days difference between ticket create_date and resolved_date in number
-- Get week difference between create_date and resolved_date
-- 1 Week has 2 weekends so multiply week_differ * 2 and subtract this from days difference
-- since we have to consider holidays also need to join using between and group by
-- this solution does not consider if a holiday falls on the weekend, need to add below to query
  -- dayname(holiday_date) <> 'Saturday' and dayname(holiday_date) <> 'Sunday')

select 
  *,
  datediff(resolved_date, create_date) 
  - 2 * (week(resolved_date) - week(create_date))
  - number_of_holidays as business_days
  from (
    select 
      ticket_id,
      create_date,
      resolved_date,
      count(holiday_date) number_of_holidays
      -- datediff(resolved_date, create_date) as actual_days,
      -- week(create_date) week_create_date,      -- return week number 
      -- week(resolved_date) week_resolved_date,  -- return week number 
      -- week(resolved_date) - week(create_date) week_differ,
        from tickets
    left join holidays 
    on holiday_date between create_date and resolved_date
    group by ticket_id, create_date, resolved_date
  ) A





