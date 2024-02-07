-- Impetus, Sum all positive numbers and negative numbers from nums table

CREATE TABLE nums (
  id int
);

INSERT INTO nums VALUES (5);
INSERT INTO nums VALUES (-5);
INSERT INTO nums VALUES (-7);
INSERT INTO nums VALUES (-2);
INSERT INTO nums VALUES (3);
INSERT INTO nums VALUES (10);
INSERT INTO nums VALUES (1);

select * from nums;


select sum(id) id
from nums
where id > 0
union
select sum(id) id
from nums 
where id < 0

-- +------+
-- | id   |
-- +------+
-- |   19 |
-- |  -14 |
-- +------+
