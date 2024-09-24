-- There could be multiple busses for same origin, destination. 
-- Passenger will board the earliest bus as per their schedule.

-- Write a query that returns the number of passenger boarding for each bus.
-- Input
-- bus
-- +------+--------+-------------+------+
-- | id   | origin | destination | time |
-- +------+--------+-------------+------+
-- |    1 | Delhi  | Mumbai      |    7 |
-- |    2 | Delhi  | Jaipur      |    8 |
-- |    3 | Jaipur | Mumbai      |    7 |
-- |    4 | Mumbai | Pune        |    8 |
-- |    5 | Delhi  | Mumbai      |    9 |
-- |    6 | Delhi  | Jaipur      |    9 |
-- |    7 | Delhi  | Jaipur      |  7.3 |
-- +------+--------+-------------+------+

-- passenger
-- +------+--------+-------------+------+
-- | id   | origin | destination | time |
-- +------+--------+-------------+------+
-- |    1 | Delhi  | Mumbai      |    8 |
-- |    2 | Delhi  | Jaipur      | 8.15 |
-- |    3 | Jaipur | Mumbai      |    7 |
-- |    4 | Mumbai | Pune        |    7 |
-- |    5 | Delhi  | Mumbai      |    8 |
-- |    6 | Delhi  | Jaipur      |  8.3 |
-- |    7 | Delhi  | Jaipur      | 7.45 |
-- +------+--------+-------------+------+

-- Output
-- +--------+------------------+
-- | bus_id | num_of_passenger |
-- +--------+------------------+
-- |   NULL |                0 |
-- |   NULL |                0 |
-- |      2 |                1 |
-- |      3 |                1 |
-- |      4 |                1 |
-- |      5 |                2 |
-- |      6 |                2 |
-- +--------+------------------+
-- +------+---------------+
-- | id   | num_passanger |
-- +------+---------------+
-- |    1 |             0 |
-- |    2 |             1 |
-- |    3 |             1 |
-- |    4 |             1 |
-- |    5 |             2 |
-- |    6 |             2 |
-- |    7 |             0 |
-- +------+---------------+


create table bus_data (
  id int,
  origin char(20),
  destination char(20),
  time float
);


create table passenger_data (
  id int,
  origin char(20),
  destination char(20),
  time float
);


insert into bus_data values (1, 'Delhi', 'Mumbai', 7.0);
insert into bus_data values (2, 'Delhi', 'Jaipur', 8.0);
insert into bus_data values (3, 'Jaipur', 'Mumbai', 7.0);
insert into bus_data values (4, 'Mumbai', 'Pune', 8.0);
insert into bus_data values (5, 'Delhi', 'Mumbai', 9.0);
insert into bus_data values (6, 'Delhi', 'Jaipur', 9.0);
insert into bus_data values (7, 'Delhi', 'Jaipur', 7.3);

insert into passenger_data values (1, 'Delhi', 'Mumbai', 8.0);
insert into passenger_data values (2, 'Delhi', 'Jaipur', 8.15);
insert into passenger_data values (3, 'Jaipur', 'Mumbai', 7.0);
insert into passenger_data values (4, 'Mumbai', 'Pune', 7.0);
insert into passenger_data values (5, 'Delhi', 'Mumbai', 8.0);
insert into passenger_data values (6, 'Delhi', 'Jaipur', 8.30);
insert into passenger_data values (7, 'Delhi', 'Jaipur', 7.45);

select * from bus_data ;
select * from passenger_data ;


WITH cte AS (
  SELECT
    b.id AS bus_id,
    p.id AS passenger_id,
    p.time AS passenger_time,
    ROW_NUMBER() OVER(PARTITION BY p.id ORDER BY b.time) AS rn
  FROM bus_data b INNER JOIN passenger_data p
  ON b.origin = p.origin 
  AND b.destination = p.destination
  AND b.time >= p.time
)
SELECT 
  bus_id,
  COUNT(passenger_id) AS num_of_passenger
FROM bus_data b LEFT JOIN cte c
ON b.id=c.bus_id
AND rn=1
GROUP BY b.id
ORDER BY 1, 2;
