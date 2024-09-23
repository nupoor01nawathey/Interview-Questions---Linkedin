-- Zepto/Blinkit Product Analyst

-- Input
-- +------+
-- | n    |
-- +------+
-- |    1 |
-- |    2 |
-- |    3 |
-- |    4 |
-- |    5 |
-- |    9 |
-- +------+

-- Output
-- +------+-------------+
-- | n    | num_counter |
-- +------+-------------+
-- |    1 |           1 |
-- |    2 |           1 |
-- |    2 |           2 |
-- |    3 |           1 |
-- |    3 |           2 |
-- |    3 |           3 |
-- |    4 |           1 |
-- |    4 |           2 |
-- |    4 |           3 |
-- |    4 |           4 |
-- |    5 |           1 |
-- |    5 |           2 |
-- |    5 |           3 |
-- |    5 |           4 |
-- |    5 |           5 |
-- |    9 |           1 |
-- |    9 |           2 |
-- |    9 |           3 |
-- |    9 |           4 |
-- |    9 |           5 |
-- |    9 |           6 |
-- |    9 |           7 |
-- |    9 |           8 |
-- |    9 |           9 |
-- +------+-------------+

create table numbers (n int);

insert into numbers values (1),(2),(3),(4),(5) ; 
insert into numbers values (9) ;


select * from numbers ;


WITH recursive CTE AS (
  SELECT n, 1 AS num_counter FROM numbers
  UNION ALL
  SELECT n, num_counter+1 FROM CTE WHERE num_counter+1 <= n
)
SELECT * FROM CTE ORDER BY n, num_counter ;


-- RECURSIVE CTE + CROSS JOIN
WITH recursive CTE1 AS (
  SELECT max(n) AS n FROM numbers
  UNION ALL
  SELECT n-1 FROM CTE1
  WHERE n-1 >= 1
)
SELECT 
  t1.n num, 
  t2.n num_counter
FROM CTE1 t1
JOIN CTE1 t2 on t1.n >= t2.n
ORDER BY 1, 2 ;


