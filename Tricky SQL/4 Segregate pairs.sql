-- Q4 Segregate data

-- INPUT
-- +------+-------+----------+
-- | id   | name  | location |
-- +------+-------+----------+
-- |    1 | NULL  | NULL     |
-- |    2 | David | NULL     |
-- |    3 | NULL  | London   |
-- |    4 | NULL  | NULL     |
-- |    5 | David | NULL     |
-- +------+-------+----------+

-- OUTPUT
-- +------+-------+----------+
-- | id   | name  | location |
-- +------+-------+----------+
-- |    1 | David | London   |
-- |    5 | David | London   |
-- +------+-------+----------+

drop table if exists Q4_data;
create table Q4_data
(
	id			int,
	name		varchar(20),
	location	varchar(20)
);
insert into Q4_data values(1,null,null);
insert into Q4_data values(2,'David',null);
insert into Q4_data values(3,null,'London');
insert into Q4_data values(4,null,null);
insert into Q4_data values(5,'David',null);

select * from Q4_data;


select 
  min(id) as id, min(name) name, min(location) location 
from Q4_data 
union
select
  max(id) as id, max(name) name, max(location) location 
from Q4_data
  
;