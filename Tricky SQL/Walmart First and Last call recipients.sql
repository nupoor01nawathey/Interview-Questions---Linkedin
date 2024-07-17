-- Walmart
-- From a phone log history we need to find if the caller had done first and last call for the day to the same person.  

-- Output
-- +----------+------------+-------+
-- | Callerid | dt         | first |
-- +----------+------------+-------+
-- |        2 | 2019-07-05 |     5 |
-- |        2 | 2019-08-02 |     4 |
-- +----------+------------+-------+

create table phonelog(
  Callerid int, 
  Recipientid int,
  Datecalled datetime
);

insert into phonelog(Callerid, Recipientid, Datecalled)
values(1, 2, '2019-01-01 09:00:00.000'),
(1, 3, '2019-01-01 17:00:00.000'),
(1, 4, '2019-01-01 23:00:00.000'),
(2, 5, '2019-07-05 09:00:00.000'),
(2, 3, '2019-07-05 17:00:00.000'),
(2, 3, '2019-07-05 17:20:00.000'),
(2, 5, '2019-07-05 23:00:00.000'),
(2, 3, '2019-08-01 09:00:00.000'),
(2, 3, '2019-08-01 17:00:00.000'),
(2, 5, '2019-08-01 19:30:00.000'),
(2, 4, '2019-08-02 09:00:00.000'),
(2, 5, '2019-08-02 10:00:00.000'),
(2, 5, '2019-08-02 10:45:00.000'),
(2, 4, '2019-08-02 11:00:00.000');

select * from phonelog ; 

with call_details as (
select
  *,
  date_format(Datecalled, '%Y-%m-%d') dt,
  first_value(Recipientid) over(partition by Callerid, date_format(Datecalled, '%Y-%m-%d') order by Datecalled) first,
  last_value(Recipientid) over(partition by Callerid, date_format(Datecalled, '%Y-%m-%d') order by Datecalled range between unbounded preceding and unbounded following) last
from phonelog  
)
select
  distinct Callerid,
  dt,
  first
from call_details
where first = last ;
