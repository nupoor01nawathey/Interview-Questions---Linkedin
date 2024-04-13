-- Amazon
-- Find total number of messages exchanged between each person per day

-- Input
-- +------------+---------+----------+--------+
-- | sms_date   | sender  | receiver | sms_no |
-- +------------+---------+----------+--------+
-- | 2020-04-01 | Avinash | Vibhor   |     10 |
-- | 2020-04-01 | Vibhor  | Avinash  |     20 |
-- | 2020-04-01 | Avinash | Pawan    |     30 |
-- | 2020-04-01 | Pawan   | Avinash  |     20 |
-- | 2020-04-01 | Vibhor  | Pawan    |      5 |
-- | 2020-04-01 | Pawan   | Vibhor   |      8 |
-- | 2020-04-01 | Vibhor  | Deepak   |     50 |
-- +------------+---------+----------+--------+

-- Output
-- +------------+---------+--------+-----------+
-- | sms_date   | p1      | p2     | total_sms |
-- +------------+---------+--------+-----------+
-- | 2020-04-01 | Avinash | Vibhor |        30 |
-- | 2020-04-01 | Avinash | Pawan  |        50 |
-- | 2020-04-01 | Pawan   | Vibhor |        13 |
-- | 2020-04-01 | Deepak  | Vibhor |        50 |
-- +------------+---------+--------+-----------+

CREATE TABLE subscriber (
 sms_date date ,
 sender varchar(20) ,
 receiver varchar(20) ,
 sms_no int
);

INSERT INTO subscriber VALUES ('2020-04-01', 'Avinash', 'Vibhor',10);
INSERT INTO subscriber VALUES ('2020-04-01', 'Vibhor', 'Avinash',20);
INSERT INTO subscriber VALUES ('2020-04-01', 'Avinash', 'Pawan',30);
INSERT INTO subscriber VALUES ('2020-04-01', 'Pawan', 'Avinash',20);
INSERT INTO subscriber VALUES ('2020-04-01', 'Vibhor', 'Pawan',5);
INSERT INTO subscriber VALUES ('2020-04-01', 'Pawan', 'Vibhor',8);
INSERT INTO subscriber VALUES ('2020-04-01', 'Vibhor', 'Deepak',50);

select * from subscriber ; 

select 
  sms_date, p1, p2, sum(sms_no) total_sms
from (
  select
    sms_date,
    case when sender<receiver then sender else receiver end as p1,
    case when sender>receiver then sender else receiver end as p2,
    sms_no
  from subscriber 
) tmp
group by sms_date, p1, p2
