-- 🔶 Problem Statement:

-- Write a SQL query that prints the names of a child along with the names of their father and mother in individual columns, ordered by the name of the child in ascending order.

-- ✴Table Creation:
-- You are given two tables: people and relations. The people table contains details of each individual, and the relations table contains parent-child relationships between individuals.

-- Output
-- +-----------+-----------+---------+
-- | child     | father    | mother  |
-- +-----------+-----------+---------+
-- | dimartino | beane     | hansard |
-- | hawbaker  | blackston | days    |
-- | keffer    | canty     | hensel  |
-- | mozingo   | nolf      | criss   |
-- | waugh     | tong      | chatmon |
-- +-----------+-----------+---------+


CREATE TABLE people (
 id INTEGER PRIMARY KEY,
 name VARCHAR(255),
 gender CHAR(1)
);

CREATE TABLE relations (
 c_id INTEGER,
 p_id INTEGER
);


INSERT INTO people (id, name, gender) VALUES
(107, 'days', 'F'),
(145, 'hawbaker', 'M'),
(201, 'blackston', 'M'),
(202, 'beane', 'M'),
(203, 'hansard', 'F'),
(204, 'canty', 'M'),
(205, 'hensel', 'F'),
(206, 'nolf', 'M'),
(207, 'criss', 'F'),
(208, 'tong', 'M'),
(209, 'chatmon', 'F'),
(210, 'dimartino', 'M'),
(211, 'keffer', 'M'),
(212, 'mozingo', 'M'),
(213, 'waugh', 'M');

INSERT INTO relations (c_id, p_id) VALUES
(145, 201),
(145, 107),
(210, 202),
(210, 203),
(211, 204),
(211, 205),
(212, 206),
(212, 207),
(213, 208),
(213, 209);

select * from people ;
select * from relations ;


with family_data as (
  select 
    c.name as child,
    min(case when p.gender='M' then p.name end) as father,
    min(case when p.gender='F' then p.name end) as mother
  from people c
  left join relations r 
  on c.id = r.c_id
  left join people p
  on p.id = r.p_id 
  group by c.name
)
select 
  *
from family_data
where father is not null
and mother is not null
order by child  ;




