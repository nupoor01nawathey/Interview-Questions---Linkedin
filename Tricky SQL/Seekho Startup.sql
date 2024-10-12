-- Seekho Startup for DA

-- Identify users sessions. A session is defined as a sequence of activities by a user where the time difference
-- between consecutive events is less than or equal to 30 minutes. If it exceeds 30 minutes then it is considered 
-- as a start of a new session.

-- INPUT
-- +--------+------------+---------------------+
-- | userid | event_type | event_time          |
-- +--------+------------+---------------------+
-- |      1 | click      | 2023-09-10 09:00:00 |
-- |      1 | click      | 2023-09-10 10:00:00 |
-- |      1 | scroll     | 2023-09-10 10:20:00 |
-- |      1 | click      | 2023-09-10 10:50:00 |
-- |      1 | scroll     | 2023-09-10 11:40:00 |
-- |      1 | click      | 2023-09-10 12:40:00 |
-- |      1 | scroll     | 2023-09-10 12:50:00 |
-- |      2 | click      | 2023-09-10 09:00:00 |
-- |      2 | scroll     | 2023-09-10 09:20:00 |
-- |      2 | click      | 2023-09-10 10:30:00 |
-- +--------+------------+---------------------+

-- OUTPUT
-- +--------+------------+---------------------+---------------------+--------------+------------------+
-- | userid | session_id | start_time          | end_time            | events_count | session_duration |
-- +--------+------------+---------------------+---------------------+--------------+------------------+
-- |      1 |          2 | 2023-09-10 09:00:00 | 2023-09-10 09:00:00 |            1 |                0 |
-- |      1 |          3 | 2023-09-10 10:00:00 | 2023-09-10 10:50:00 |            3 |               50 |
-- |      1 |          4 | 2023-09-10 11:40:00 | 2023-09-10 11:40:00 |            1 |                0 |
-- |      1 |          5 | 2023-09-10 12:40:00 | 2023-09-10 12:50:00 |            2 |               10 |
-- |      2 |          2 | 2023-09-10 09:00:00 | 2023-09-10 09:20:00 |            2 |               20 |
-- |      2 |          3 | 2023-09-10 10:30:00 | 2023-09-10 10:30:00 |            1 |                0 |
-- +--------+------------+---------------------+---------------------+--------------+------------------+

create table events 
(userid int , 
event_type varchar(20),
event_time datetime);

insert into events VALUES (1, 'click', '2023-09-10 09:00:00');
insert into events VALUES (1, 'click', '2023-09-10 10:00:00');
insert into events VALUES (1, 'scroll', '2023-09-10 10:20:00');
insert into events VALUES (1, 'click', '2023-09-10 10:50:00');
insert into events VALUES (1, 'scroll', '2023-09-10 11:40:00');
insert into events VALUES (1, 'click', '2023-09-10 12:40:00');
insert into events VALUES (1, 'scroll', '2023-09-10 12:50:00');
insert into events VALUES (2, 'click', '2023-09-10 09:00:00');
insert into events VALUES (2, 'scroll', '2023-09-10 09:20:00');
insert into events VALUES (2, 'click', '2023-09-10 10:30:00');

select * from events ; 

WITH time_diff AS (
  SELECT
    *,
    TIMESTAMPDIFF(MINUTE, LAG(event_time, 1) OVER(PARTITION BY userid ORDER BY event_time), event_time) event_time_diff
  FROM events 
), sessions AS (
SELECT
  *,
  CASE WHEN event_time_diff <= 30 THEN 0 ELSE 1 END AS session_flag,
  SUM(CASE WHEN event_time_diff <= 30 THEN 0 ELSE 1 END) OVER(PARTITION BY userid ORDER BY event_time) session_grp
FROM time_diff
)
SELECT
  userid,
  session_grp + 1 session_id,
  MIN(event_time) start_time,
  MAX(event_time) end_time,
  COUNT(1) events_count,
  TIMESTAMPDIFF(MINUTE, MIN(event_time), MAX(event_time)) session_duration
FROM sessions
GROUP BY 1, 2 
ORDER BY 1, 2 ;

