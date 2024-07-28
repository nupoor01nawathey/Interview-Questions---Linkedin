-- Project Title: User Activity Analysis Using SQL 

-- Project Overview:
-- This project focuses on analyzing user activity data from two tables, `users_id` and `logins`. The goal is to provide valuable insights into user engagement, activity patterns, and overall usage trends over time. 
-- Users
-- +---------+-----------+-------------+
-- | USER_ID | USER_NAME | USER_STATUS |
-- +---------+-----------+-------------+
-- |       1 | Alice     | Active      |
-- |       2 | Bob       | Inactive    |
-- |       3 | Charlie   | Active      |
-- |       4 | David     | Active      |
-- |       5 | Eve       | Inactive    |
-- |       6 | Frank     | Active      |
-- |       7 | Grace     | Inactive    |
-- |       8 | Heidi     | Active      |
-- |       9 | Ivan      | Inactive    |
-- |      10 | Judy      | Active      |
-- +---------+-----------+-------------+

-- Logins
-- +---------+---------------------+------------+---------------+
-- | USER_ID | LOGIN_TIMESTAMP     | SESSION_ID | SESSION_SCORE |
-- +---------+---------------------+------------+---------------+
-- |       1 | 2023-07-15 09:30:00 |       1001 |            85 |
-- |       2 | 2023-07-22 10:00:00 |       1002 |            90 |
-- |       3 | 2023-08-10 11:15:00 |       1003 |            75 |
-- |       4 | 2023-08-20 14:00:00 |       1004 |            88 |
-- |       5 | 2023-09-05 16:45:00 |       1005 |            82 |
-- |       6 | 2023-10-12 08:30:00 |       1006 |            77 |
-- |       7 | 2023-11-18 09:00:00 |       1007 |            81 |
-- |       8 | 2023-12-01 10:30:00 |       1008 |            84 |
-- |       9 | 2023-12-15 13:15:00 |       1009 |            79 |
-- |      10 | 2024-06-25 15:00:00 |       1010 |            92 |
-- |       1 | 2024-01-10 07:45:00 |       1011 |            86 |
-- |       2 | 2024-01-25 09:30:00 |       1012 |            89 |
-- |       3 | 2024-02-05 11:00:00 |       1013 |            78 |
-- |       4 | 2024-03-01 14:30:00 |       1014 |            91 |
-- |       5 | 2024-03-15 16:00:00 |       1015 |            83 |
-- |       6 | 2024-04-12 08:00:00 |       1016 |            80 |
-- |       7 | 2024-05-18 09:15:00 |       1017 |            82 |
-- |       8 | 2024-05-28 10:45:00 |       1018 |            87 |
-- |       9 | 2024-06-15 13:30:00 |       1019 |            76 |
-- |      10 | 2024-06-26 15:45:00 |       1020 |            93 |
-- |      10 | 2024-06-27 15:00:00 |       1021 |            92 |
-- |      10 | 2024-06-28 15:45:00 |       1022 |            93 |
-- |       1 | 2024-01-10 07:45:00 |       1101 |            86 |
-- |       3 | 2024-01-25 09:30:00 |       1102 |            89 |
-- |       5 | 2024-01-15 11:00:00 |       1103 |            78 |
-- |       2 | 2023-11-10 07:45:00 |       1201 |            82 |
-- |       4 | 2023-11-25 09:30:00 |       1202 |            84 |
-- |       6 | 2023-11-15 11:00:00 |       1203 |            80 |
-- +---------+---------------------+------------+---------------+



-- script:
CREATE TABLE users (
    USER_ID INT PRIMARY KEY,
    USER_NAME VARCHAR(20) NOT NULL,
    USER_STATUS VARCHAR(20) NOT NULL
);

CREATE TABLE logins (
    USER_ID INT,
    LOGIN_TIMESTAMP DATETIME NOT NULL,
    SESSION_ID INT PRIMARY KEY,
    SESSION_SCORE INT,
    FOREIGN KEY (USER_ID) REFERENCES USERS(USER_ID)
);

-- Users Table
INSERT INTO USERS VALUES (1, 'Alice', 'Active');
INSERT INTO USERS VALUES (2, 'Bob', 'Inactive');
INSERT INTO USERS VALUES (3, 'Charlie', 'Active');
INSERT INTO USERS  VALUES (4, 'David', 'Active');
INSERT INTO USERS  VALUES (5, 'Eve', 'Inactive');
INSERT INTO USERS  VALUES (6, 'Frank', 'Active');
INSERT INTO USERS  VALUES (7, 'Grace', 'Inactive');
INSERT INTO USERS  VALUES (8, 'Heidi', 'Active');
INSERT INTO USERS VALUES (9, 'Ivan', 'Inactive');
INSERT INTO USERS VALUES (10, 'Judy', 'Active');

-- Logins Table 

INSERT INTO LOGINS  VALUES (1, '2023-07-15 09:30:00', 1001, 85);
INSERT INTO LOGINS VALUES (2, '2023-07-22 10:00:00', 1002, 90);
INSERT INTO LOGINS VALUES (3, '2023-08-10 11:15:00', 1003, 75);
INSERT INTO LOGINS VALUES (4, '2023-08-20 14:00:00', 1004, 88);
INSERT INTO LOGINS  VALUES (5, '2023-09-05 16:45:00', 1005, 82);

INSERT INTO LOGINS  VALUES (6, '2023-10-12 08:30:00', 1006, 77);
INSERT INTO LOGINS  VALUES (7, '2023-11-18 09:00:00', 1007, 81);
INSERT INTO LOGINS VALUES (8, '2023-12-01 10:30:00', 1008, 84);
INSERT INTO LOGINS  VALUES (9, '2023-12-15 13:15:00', 1009, 79);


-- 2024 Q1
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (1, '2024-01-10 07:45:00', 1011, 86);
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (2, '2024-01-25 09:30:00', 1012, 89);
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (3, '2024-02-05 11:00:00', 1013, 78);
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (4, '2024-03-01 14:30:00', 1014, 91);
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (5, '2024-03-15 16:00:00', 1015, 83);

INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (6, '2024-04-12 08:00:00', 1016, 80);
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (7, '2024-05-18 09:15:00', 1017, 82);
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (8, '2024-05-28 10:45:00', 1018, 87);
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (9, '2024-06-15 13:30:00', 1019, 76);
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (10, '2024-06-25 15:00:00', 1010, 92);
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (10, '2024-06-26 15:45:00', 1020, 93);
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (10, '2024-06-27 15:00:00', 1021, 92);
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (10, '2024-06-28 15:45:00', 1022, 93);
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (1, '2024-01-10 07:45:00', 1101, 86);
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (3, '2024-01-25 09:30:00', 1102, 89);
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (5, '2024-01-15 11:00:00', 1103, 78);
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (2, '2023-11-10 07:45:00', 1201, 82);
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (4, '2023-11-25 09:30:00', 1202, 84);
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (6, '2023-11-15 11:00:00', 1203, 80);


select * from users ;
select * from logins ;

-- 1. Which users did not log in during the past 5 months?
select distinct user_id from logins where user_id not in (
  select 
    user_id
  from logins
  where LOGIN_TIMESTAMP > date_add(current_timestamp() , INTERVAL -5 MONTH)
) ;


-- 2. How many users and sessions were there in each quarter, ordered from newest to oldest?
select
  date_sub(min(LOGIN_TIMESTAMP), interval dayofmonth(min(LOGIN_TIMESTAMP)) -1 day) quarters_first_date,
  count(*) session_cnt,
  count(distinct user_id) user_cnt
from logins 
group by(quarter(LOGIN_TIMESTAMP)) ;


-- 3. Which users logged in during January 2024 but did not log in during November 2023?
select 
  distinct user_id
from logins
where LOGIN_TIMESTAMP between '2024-01-01' and '2024-01-31'
and user_id not in (
  select 
    user_id 
  from logins 
  where LOGIN_TIMESTAMP between '2023-11-01' and '2023-11-30'
) ;


-- 4. What is the percentage change in sessions from the last quarter?
with cte as (
  select
    date_sub(min(LOGIN_TIMESTAMP), interval dayofmonth(min(LOGIN_TIMESTAMP)) -1 day) quarters_first_date,
    count(*) session_cnt,
    count(distinct user_id) user_cnt
  from logins 
  group by (quarter(LOGIN_TIMESTAMP)) 
)
select
  *,
  (session_cnt - lag(session_cnt,1) over(order by quarters_first_date)) * 100.0/
  lag(session_cnt,1) over(order by quarters_first_date) perc_change
from cte ;


-- 5. Which user had the highest session score each day?
with cte1 as (
  select
    USER_ID,
    date_format(LOGIN_TIMESTAMP, '%y-%m-%d') login_date,
    sum(SESSION_SCORE) total_session_score
  from logins
  group by USER_ID, date_format(LOGIN_TIMESTAMP, '%y-%m-%d')
)
select * from (
  select
    *,
    row_number() over(partition by login_date order by total_session_score desc) max_session_cnt_per_user
  from cte1 
) T
where max_session_cnt_per_user=1 ;


-- 6. Which users have had a session every single day since their first login?
-- Assumption current_date as 2024-06-28
select
  USER_ID,
  min(date_format(LOGIN_TIMESTAMP, '%y-%m-%d')) first_login,
  datediff('2024-06-28', min(date_format(LOGIN_TIMESTAMP, '%y-%m-%d'))) + 1 login_days_between_this_range,
  count(distinct date_format(LOGIN_TIMESTAMP, '%y-%m-%d')) login_days_cnt
from logins
group by USER_ID 
having login_days_between_this_range = login_days_cnt
order by USER_ID;


-- 7. On what dates were there no logins at all?
-- Assumption current_date as 2024-06-28

with recursive cte2 as (
select
  min(date_format(LOGIN_TIMESTAMP, '%Y-%m-%d')) as first_login,
  date_format('2024-06-28', '%Y-%m-%d') as last_login
from logins
UNION ALL
select
  date_add(first_login, interval 1 day) as first_login,
  last_login
from cte2
where first_login < last_login
)
select * from cte2 
where first_login not in (
  select distinct date_format(LOGIN_TIMESTAMP, '%Y-%m-%d') from logins
);








