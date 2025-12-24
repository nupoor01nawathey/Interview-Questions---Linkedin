/*
A tours and travel company has 2 tables that relate to customers: FAMILIES and COUNTRIES . Each tour offers
a discount if a minimum number of people book at the same time.

Write a SQL query to print the maximum number of discounted tours any 1 family in the families table 
can choose from.

+----------------------------------+----------------+-------------+
| ID                               | NAME           | FAMILY_SIZE |
+----------------------------------+----------------+-------------+
| c00dac11bde74750b4d207b9c182a85f | Alex Thomas    |           9 |
| eb6f2d3426694667ae3e79d6274114a4 | Chris Gray     |           2 |
| 3f7b5b8e835d4e1c8b3e12e964a741f3 | Emily Johnson  |           4 |
| 9a345b079d9f4d3cafb2d4c11d20f8ce | Michael Brown  |           6 |
| e0a5f57516024de2a231d09de2cbe9d1 | Jessica Wilson |           3 |
+----------------------------------+----------------+-------------+
+----------------------------------+--------------+----------+----------+
| ID                               | NAME         | MIN_SIZE | MAX_SIZE |
+----------------------------------+--------------+----------+----------+
| 023fd23615bd4ff4b2ae0a13ed7efec9 | Bolivia      |        2 |        4 |
| be247f73de0f4b2d810367cb26941fb9 | Cook Islands |        4 |        8 |
| 3e85ab80a6f84ef3b9068b21dbcc54b3 | Brazil       |        4 |        7 |
| e571e164152c4f7c8413e2734f67b146 | Australia    |        5 |        9 |
| f35a7bb7d44342f7a8a42a53115294a8 | Canada       |        3 |        5 |
| a1b5a4b5fc5f46f891d9040566a78f27 | Japan        |       10 |       12 |
+----------------------------------+--------------+----------+----------+

Output: When max_size col is not there, this problem is tweaked a little from the original question.
+----------------------------------+--------------+----------+----------+
| ID                               | NAME         | MIN_SIZE | MAX_SIZE |
+----------------------------------+--------------+----------+----------+
| 023fd23615bd4ff4b2ae0a13ed7efec9 | Bolivia      |        2 |        4 |
| be247f73de0f4b2d810367cb26941fb9 | Cook Islands |        4 |        8 |
| 3e85ab80a6f84ef3b9068b21dbcc54b3 | Brazil       |        4 |        7 |
| e571e164152c4f7c8413e2734f67b146 | Australia    |        5 |        9 |
| f35a7bb7d44342f7a8a42a53115294a8 | Canada       |        3 |        5 |
+----------------------------------+--------------+----------+----------+


Expected Output
+----------------------+
| max_discounted_tours |
+----------------------+
|                    4 |
+----------------------+
*/
CREATE TABLE FAMILIES (
    ID VARCHAR(50),
    NAME VARCHAR(50),
    FAMILY_SIZE INT
);

INSERT INTO FAMILIES (ID, NAME, FAMILY_SIZE) VALUES 
('c00dac11bde74750b4d207b9c182a85f', 'Alex Thomas', 9),
('eb6f2d3426694667ae3e79d6274114a4', 'Chris Gray', 2),
('3f7b5b8e835d4e1c8b3e12e964a741f3', 'Emily Johnson', 4),
('9a345b079d9f4d3cafb2d4c11d20f8ce', 'Michael Brown', 6),
('e0a5f57516024de2a231d09de2cbe9d1', 'Jessica Wilson', 3);


CREATE TABLE COUNTRIES (
    ID VARCHAR(50),
    NAME VARCHAR(50),
    MIN_SIZE INT,
 MAX_SIZE INT
);

INSERT INTO COUNTRIES (ID, NAME, MIN_SIZE,MAX_SIZE) VALUES 
('023fd23615bd4ff4b2ae0a13ed7efec9', 'Bolivia', 2 , 4),
('be247f73de0f4b2d810367cb26941fb9', 'Cook Islands', 4,8),
('3e85ab80a6f84ef3b9068b21dbcc54b3', 'Brazil', 4,7),
('e571e164152c4f7c8413e2734f67b146', 'Australia', 5,9),
('f35a7bb7d44342f7a8a42a53115294a8', 'Canada', 3,5),
('a1b5a4b5fc5f46f891d9040566a78f27', 'Japan', 10,12);
  
  
select * from FAMILIES ;
select * from COUNTRIES ;

select * from countries where min_size < (select max(FAMILY_SIZE) from families) ;

/*
Output just for vizualization purpose, how data looks like for below query 

select * from FAMILIES f inner join COUNTRIES c
on f.FAMILY_SIZE between c.min_size and c.max_size ;
+----------------------------------+----------------+-------------+----------------------------------+--------------+----------+----------+
| ID                               | NAME           | FAMILY_SIZE | ID                               | NAME         | MIN_SIZE | MAX_SIZE |
+----------------------------------+----------------+-------------+----------------------------------+--------------+----------+----------+
| e0a5f57516024de2a231d09de2cbe9d1 | Jessica Wilson |           3 | 023fd23615bd4ff4b2ae0a13ed7efec9 | Bolivia      |        2 |        4 |
| 3f7b5b8e835d4e1c8b3e12e964a741f3 | Emily Johnson  |           4 | 023fd23615bd4ff4b2ae0a13ed7efec9 | Bolivia      |        2 |        4 |
| eb6f2d3426694667ae3e79d6274114a4 | Chris Gray     |           2 | 023fd23615bd4ff4b2ae0a13ed7efec9 | Bolivia      |        2 |        4 |
| 9a345b079d9f4d3cafb2d4c11d20f8ce | Michael Brown  |           6 | be247f73de0f4b2d810367cb26941fb9 | Cook Islands |        4 |        8 |
| 3f7b5b8e835d4e1c8b3e12e964a741f3 | Emily Johnson  |           4 | be247f73de0f4b2d810367cb26941fb9 | Cook Islands |        4 |        8 |
| 9a345b079d9f4d3cafb2d4c11d20f8ce | Michael Brown  |           6 | 3e85ab80a6f84ef3b9068b21dbcc54b3 | Brazil       |        4 |        7 |
| 3f7b5b8e835d4e1c8b3e12e964a741f3 | Emily Johnson  |           4 | 3e85ab80a6f84ef3b9068b21dbcc54b3 | Brazil       |        4 |        7 |
| 9a345b079d9f4d3cafb2d4c11d20f8ce | Michael Brown  |           6 | e571e164152c4f7c8413e2734f67b146 | Australia    |        5 |        9 |
| c00dac11bde74750b4d207b9c182a85f | Alex Thomas    |           9 | e571e164152c4f7c8413e2734f67b146 | Australia    |        5 |        9 |
| e0a5f57516024de2a231d09de2cbe9d1 | Jessica Wilson |           3 | f35a7bb7d44342f7a8a42a53115294a8 | Canada       |        3 |        5 |
| 3f7b5b8e835d4e1c8b3e12e964a741f3 | Emily Johnson  |           4 | f35a7bb7d44342f7a8a42a53115294a8 | Canada       |        3 |        5 |
+----------------------------------+----------------+-------------+----------------------------------+--------------+----------+----------+
*/

select max(cnt) as max_discounted_tours from (
  select 
    f.name, count(*) as cnt
  from FAMILIES f inner join COUNTRIES c
  on f.FAMILY_SIZE between c.min_size and c.max_size 
  group by f.name
) T
;


