-- You are given a table named "Attendance" with columns:
-- StudentID, ClassDate, IsPresent (a boolean where 1 indicates presence and 0 indicates absence).

-- Write a SQL query to identify students who have missed at least 3 consecutive classes (DO NOT use LAG / LEAD).
-- Also include students who missed class for a single day

-- OUTPUT-
-- StudentID, MissingFrom, NumberOfMissedDays
-- 2, 2023-10-02,  3
-- 2, 2023-10-06,  4
-- 3, 2023-10-01,  3

create table attendance (
  StudentID int, 
  ClassDate date, 
  IsPresent boolean
);

insert into attendance values(1,"2023-10-01", 1);
insert into attendance values(2,"2023-10-01", 1);
insert into attendance values(3,"2023-10-01", 0);
insert into attendance values(1,"2023-10-02", 1);
insert into attendance values(2,"2023-10-02", 0);
insert into attendance values(3,"2023-10-02", 1);
insert into attendance values(1,"2023-10-03", 1);
insert into attendance values(2,"2023-10-03", 0);
insert into attendance values(3,"2023-10-03", 1);
insert into attendance values(1,"2023-10-04", 1);
insert into attendance values(2,"2023-10-04", 0);
insert into attendance values(3,"2023-10-04", 1);
insert into attendance values(1,"2023-10-05", 1);
insert into attendance values(2,"2023-10-05", 1);
insert into attendance values(3,"2023-10-05", 1);
insert into attendance values(1,"2023-10-06", 1);
insert into attendance values(2,"2023-10-06", 0);
insert into attendance values(3,"2023-10-06", 1);
insert into attendance values(1,"2023-10-07", 1);
insert into attendance values(2,"2023-10-07", 0);
insert into attendance values(3,"2023-10-07", 1);
insert into attendance values(1,"2023-10-08", 1);
insert into attendance values(2,"2023-10-08", 0);
insert into attendance values(3,"2023-10-08", 1);
insert into attendance values(1,"2023-10-09", 1);
insert into attendance values(2,"2023-10-09", 0);
insert into attendance values(3,"2023-10-09", 1);

select * from attendance order by StudentID;

with cte as (
  select
    *,
    row_number() over(partition by StudentID order by ClassDate) rn_dates,
    row_number() over(partition by StudentID, IsPresent order by ClassDate) rn_attendance
  from attendance
 )
select 
  StudentID,
  min(ClassDate) as missing_from_date,
  count(rn_dates - rn_attendance) as no_of_missing_days
from cte 
where IsPresent=0
group by StudentID, rn_dates - rn_attendance;

-- +-----------+------------+-----------+---------+---------------------------+-----------------
-- | StudentID | ClassDate  | IsPresent |rn_dates |rn_attendance              |no_of_missing_days
-- +-----------+------------+-----------+---------+---------------------------+-----------------
-- |         2 | 2023-10-01 |         1 | 1       | 1    -> IsPresent=1 ignore|

-- |         2 | 2023-10-02 |         0 | 2       | 1                         |1
-- |         2 | 2023-10-03 |         0 | 3       | 2                         |1
-- |         2 | 2023-10-04 |         0 | 4       | 3                         |1

-- |         2 | 2023-10-05 |         1 | 5       | 2    -> IsPresent=1 ignore|

-- |         2 | 2023-10-06 |         0 | 6       | 4                         |2
-- |         2 | 2023-10-07 |         0 | 7       | 5                         |2
-- |         2 | 2023-10-08 |         0 | 8       | 6                         |2
-- |         2 | 2023-10-09 |         0 | 9       | 7                         |2 

