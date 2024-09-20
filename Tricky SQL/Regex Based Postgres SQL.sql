-- Find all phone numbers containing unique digits 
-- USES Postgres REGEXP functions : position, split_part and REGEXP_SPLIT_TO_TABLE

/*
      num       
----------------
 1234567780
 2234578996
 +1-12244567780
 +32-2233567889
 +2-23456987312
 +91-9087654123
 +23-9085761324
 +11-8091013345

  num       | formatted_num | no_of_digits | distinct_digits 
----------------+---------------+--------------+-----------------
 +23-9085761324 | 9085761324    |           10 |              10
 +91-9087654123 | 9087654123    |           10 |              10
*/


create table phone_numbers (num varchar(20));
insert into phone_numbers values
('1234567780'),
('2234578996'),
('+1-12244567780'),
('+32-2233567889'),
('+2-23456987312'),
('+91-9087654123'),
('+23-9085761324'),
('+11-8091013345');

select * from phone_numbers ;

WITH CTE AS (
  SELECT
    *,
    position('-' in num),
    split_part(num, '-', 2)
  FROM phone_numbers
), CTE1 AS (
  SELECT
    *,
    CASE WHEN position = 0 THEN num
         ELSE split_part
    END AS formatted_num
  FROM CTE
)
SELECT 
  num,
  formatted_num,
  COUNT(*) AS no_of_digits,
  COUNT(DISTINCT digits) AS distinct_digits
FROM (
  SELECT
    *,
    REGEXP_SPLIT_TO_TABLE(formatted_num, '') AS digits
  FROM CTE1 
) T
GROUP BY 1, 2 
HAVING COUNT(*) = COUNT(DISTINCT digits) 


