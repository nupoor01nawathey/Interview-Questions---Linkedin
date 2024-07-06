-- Tredence 

-- Input
-- +---------+------+
-- | seat_id | free |
-- +---------+------+
-- |       1 |    1 |
-- |       2 |    0 |
-- |       3 |    1 |
-- |       4 |    1 |
-- |       5 |    1 |
-- |       6 |    0 |
-- |       7 |    1 |
-- |       8 |    1 |
-- |       9 |    0 |
-- |      10 |    1 |
-- |      11 |    0 |
-- |      12 |    1 |
-- |      13 |    0 |
-- |      14 |    1 |
-- |      15 |    1 |
-- |      16 |    0 |
-- |      17 |    1 |
-- |      18 |    1 |
-- |      19 |    1 |
-- |      20 |    1 |
-- +---------+------+

-- Output
-- Total 11 seats
-- 3,4,5
-- 7,8
-- 14,15
-- 17,18,19,20


CREATE TABLE cinema (
  seat_id INT PRIMARY KEY,
  free int
);

delete from cinema;
INSERT INTO cinema (seat_id, free) VALUES (1, 1);
INSERT INTO cinema (seat_id, free) VALUES (2, 0);
INSERT INTO cinema (seat_id, free) VALUES (3, 1);
INSERT INTO cinema (seat_id, free) VALUES (4, 1);
INSERT INTO cinema (seat_id, free) VALUES (5, 1);
INSERT INTO cinema (seat_id, free) VALUES (6, 0);
INSERT INTO cinema (seat_id, free) VALUES (7, 1);
INSERT INTO cinema (seat_id, free) VALUES (8, 1);
INSERT INTO cinema (seat_id, free) VALUES (9, 0);
INSERT INTO cinema (seat_id, free) VALUES (10, 1);
INSERT INTO cinema (seat_id, free) VALUES (11, 0);
INSERT INTO cinema (seat_id, free) VALUES (12, 1);
INSERT INTO cinema (seat_id, free) VALUES (13, 0);
INSERT INTO cinema (seat_id, free) VALUES (14, 1);
INSERT INTO cinema (seat_id, free) VALUES (15, 1);
INSERT INTO cinema (seat_id, free) VALUES (16, 0);
INSERT INTO cinema (seat_id, free) VALUES (17, 1);
INSERT INTO cinema (seat_id, free) VALUES (18, 1);
INSERT INTO cinema (seat_id, free) VALUES (19, 1);
INSERT INTO cinema (seat_id, free) VALUES (20, 1);


select * from cinema ;

with seats as (
select
  *,
  seat_id - row_number() over(order by seat_id) differ
from cinema
where free=1 
), grps_ as (
  select 
    *,
    count(*) over(partition by differ) cnt
  from seats 
)
select 
  seat_id 
from grps_ 
where cnt > 1;

