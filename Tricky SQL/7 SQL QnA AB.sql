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

SELECT * FROM users;
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

SELECT * FROM logins;
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


-- 1. Get users which didn't login in last 5 months
SELECT DISTINCT USER_ID
FROM logins WHERE USER_ID NOT IN (
  SELECT 
    USER_ID
  FROM logins 
  -- Below will give all users who logged in AFTER 5 MONTHS TS
  WHERE LOGIN_TIMESTAMP > DATE_SUB(now(), INTERVAL 5 MONTH) 
  order by USER_ID
) ;



-- 2. For the BU quarterly analysis calculate how many users and how many sessions were at each 
-- quarter order by quarter from newest or oldest.
-- ***** Return first day of each quarter, user_cnt, session_cnt ***** 
select
  quarter(LOGIN_TIMESTAMP) as quarter_num,
  count(1) as session_cnt,
  count(distinct USER_ID) as user_cnt,
  MIN(DATE_FORMAT(LOGIN_TIMESTAMP, '%Y-%m-01')) as quarter_first_date
from logins
group by quarter(LOGIN_TIMESTAMP) ;



-- 3. Find out list of users who logged in in Jan-24 but not in Nov-23
SELECT
  DISTINCT USER_ID,
  LOGIN_TIMESTAMP
FROM logins 
WHERE LOGIN_TIMESTAMP BETWEEN '2024-01-01' AND '2024-01-31'
AND USER_ID NOT IN (
  SELECT 
    USER_ID
  FROM logins
  WHERE LOGIN_TIMESTAMP BETWEEN '2023-11-01' AND '2023-11-30'
) ;



-- 4. Extend 2nd Q and find % change in session from last quarter
-- **** Return first day of quarter, session_cnt, prev_session_cnt, session_perc_change
with quarter_data as (
  select
    quarter(LOGIN_TIMESTAMP) as quarter_number,
    count(1) as session_cnt,
    MIN(DATE_FORMAT(LOGIN_TIMESTAMP, '%Y-%m-01')) as first_day_of_quarter
  from logins
  group by quarter(LOGIN_TIMESTAMP)
)
select 
  *,
  LAG(session_cnt,1) over(order by first_day_of_quarter) prev_session_cnt,
  (session_cnt - (LAG(session_cnt,1) over(order by first_day_of_quarter))) * 100.0 / (LAG(session_cnt,1) over(order by first_day_of_quarter)) as session_perc_change
from quarter_data ;



-- 5. Display the user who had the highest session score for each day
SELECT
  USER_ID,
  DATE_FORMAT(LOGIN_TIMESTAMP, '%Y-%m-%d') as dt,
  SUM(SESSION_SCORE) as total_session_score
FROM logins 
GROUP BY USER_ID, DATE_FORMAT(LOGIN_TIMESTAMP, '%Y-%m-%d')
ORDER BY dt, total_session_score ;




-- --*** TRICKY  6. Identify best users meaning return users who had logged in session on each day since their first login
-- Return USER_ID
with login_data as (
  select 
    user_id,
    min(DATE_FORMAT(LOGIN_TIMESTAMP, '%Y-%m-%d')) first_login,
    COUNT(distinct DATE_FORMAT(LOGIN_TIMESTAMP, '%Y-%m-%d')) no_of_actual_login_days,
    DATEDIFF(DATE_FORMAT(now(), '%Y-%m-%d'), min(DATE_FORMAT(LOGIN_TIMESTAMP, '%Y-%m-%d'))) no_of_expected_login_days
  from logins
  group by USER_ID
  order by user_id
)
select 
  *
from login_data
where no_of_actual_login_days=no_of_expected_login_days
;



-- -- *** TRICKY 7. On what days there was no login at all
-- Return login_dates

-- HINT
-- We need to find days between 2023-07-15 AND 2024-06-28 and extract dates which are not in logins table

WITH recursive dates as (
  SELECT
    MIN(DATE_FORMAT(LOGIN_TIMESTAMP, '%Y-%m-%d')) as start_date,
    MAX(DATE_FORMAT(LOGIN_TIMESTAMP, '%Y-%m-%d')) as end_date
  FROM logins 
  UNION ALL
  SELECT DATE_ADD(start_date, INTERVAL 1 DAY), end_date from dates
  WHERE start_date < end_date
)
SELECT 
  *
from dates  
WHERE start_date not in (select DATE_FORMAT(LOGIN_TIMESTAMP, '%Y-%m%d') from logins) ;












