-- IBM SQL Interview Question:

-- LeetCode Premium Problem 1355:

-- Write a SQL query to find the names of all the activities with neither maximum, 
-- nor minimum number of participants.

-- Answer: Singer and Horse Riding
--  Eating activity has max participants 3 and dancing has 0 participants so get the result without these two in the ouput


CREATE TABLE friends (
 id INT,
 name VARCHAR(255),
 activity VARCHAR(255)
);

CREATE TABLE activities (
 id INT,
 name VARCHAR(255)
);

INSERT INTO friends (id, name, activity) VALUES (1, 'Jonathan D.', 'Eating');
INSERT INTO friends (id, name, activity) VALUES (2, 'Jade W.', 'Singing');
INSERT INTO friends (id, name, activity) VALUES (3, 'Victor J.', 'Singing');
INSERT INTO friends (id, name, activity) VALUES (4, 'Elvis Q.', 'Eating');
INSERT INTO friends (id, name, activity) VALUES (5, 'Daniel A.', 'Eating');
INSERT INTO friends (id, name, activity) VALUES (6, 'Bob B.', 'Horse Riding');


INSERT INTO activities (id, name) VALUES (1, 'Eating');
INSERT INTO activities (id, name) VALUES (2, 'Singing');
INSERT INTO activities (id, name) VALUES (3, 'Horse Riding');
INSERT INTO activities (id, name) VALUES (4, 'Dancing');

select * from friends ;
select * from activities ;

with activity_count as (
  select 
    a.name as activity_name ,
    count(f.id) participant_count
  from activities a
  left join friends f
  on f.activity=a.name
  group by a.name
)

select 
  activity_name
from activity_count 
where participant_count not in (select max(participant_count) from activity_count)
and participant_count not in (select min(participant_count) from activity_count)
;







