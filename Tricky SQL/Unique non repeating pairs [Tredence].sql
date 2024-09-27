-- Generate unique non-repeating pairs like 'A-B' from a given table using SQL


-- Input
-- +----------+
-- | a_letter |
-- +----------+
-- | A        |
-- | B        |
-- | C        |
-- | D        |
-- +----------+

-- Output
-- +--------------+---------------+--------------+
-- | first_letter | second_letter | combinations |
-- +--------------+---------------+--------------+
-- | A            | B             | A-B          |
-- | B            | C             | B-C          |
-- | A            | C             | A-C          |
-- | C            | D             | C-D          |
-- | B            | D             | B-D          |
-- | A            | D             | A-D          |
-- +--------------+---------------+--------------+


create table letters (
  a_letter char(1)
);

insert into letters values('A') ;
insert into letters values('B') ;
insert into letters values('C') ;
insert into letters values('D') ;

select * from letters ;

SELECT
  l1.a_letter AS first_letter,
  l2.a_letter AS second_letter,
  CONCAT(l1.a_letter, "-", l2.a_letter) AS combinations
FROM letters l1 INNER JOIN letters l2
ON l1.a_letter < l2.a_letter ;
