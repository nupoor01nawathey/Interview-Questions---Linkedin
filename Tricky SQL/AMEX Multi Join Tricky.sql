-- AMEX TRICKY
-- GET list of unique users whose frinds's liked pages alone and not liked by users themselves

-- user_id in likes could be user_id or friend_id from friends table 

-- friends:
-- +---------+-----------+
-- | user_id | friend_id |
-- +---------+-----------+
-- |       1 |         2 |
-- |       1 |         3 |
-- |       1 |         4 |
-- |       2 |         1 |
-- |       3 |         1 |
-- |       3 |         4 |
-- |       4 |         1 |
-- |       4 |         3 |
-- +---------+-----------+

-- likes:
-- +---------+---------+
-- | user_id | page_id |
-- +---------+---------+
-- |       1 | A       |
-- |       1 | B       |
-- |       1 | C       |
-- |       2 | A       |
-- |       3 | B       |
-- |       3 | C       |
-- |       4 | B       |
-- +---------+---------+

-- output
-- +---------+---------+
-- | user_id | page_id |
-- +---------+---------+
-- |       2 | C       |
-- |       2 | B       |
-- |       3 | A       |
-- |       4 | C       |
-- |       4 | A       |
-- +---------+---------+


CREATE TABLE friends (
    user_id INT,
    friend_id INT
);

-- Insert data into friends table
INSERT INTO friends VALUES
(1, 2),
(1, 3),
(1, 4),
(2, 1),
(3, 1),
(3, 4),
(4, 1),
(4, 3);

-- Create likes table
CREATE TABLE likes (
    user_id INT,
    page_id CHAR(1)
);

-- Insert data into likes table
INSERT INTO likes VALUES
(1, 'A'),
(1, 'B'),
(1, 'C'),
(2, 'A'),
(3, 'B'),
(3, 'C'),
(4, 'B');


select * from friends;
select * from likes ; 



with user_pages as (
  select 
    distinct f.user_id,
    l.page_id
  from friends f
  inner join likes l 
  on f.user_id=l.user_id
),
friends_pages as (
  select
    distinct f.user_id,
    f.friend_id,
    l.page_id
  from friends f 
  inner join likes l
  on f.friend_id=l.user_id
)
select 
  distinct fp.user_id,
  fp.page_id
from friends_pages fp
left join user_pages up
on up.user_id=fp.user_id and up.page_id=fp.page_id 
where up.user_id is null;


-- COMPACT SOLUTION
select
  distinct f.user_id, fp.page_id
from friends f 
inner join likes fp
on f.friend_id=fp.user_id
left join likes up on
up.user_id = f.user_id and up.page_id=fp.page_id
where up.user_id is null ; 





