
/*
Find out travel start and end location where stops are not in sorted order

INPUT
+----------+-----------+-----------+
| customer | start_loc | end_loc   |
+----------+-----------+-----------+
| c1       | New York  | Lima      |
| c1       | London    | New York  |
| c1       | Lima      | Sao Paulo |
| c1       | Sao Paulo | New Delhi |
| c2       | Mumbai    | Hyderabad |
| c2       | Surat     | Pune      |
| c2       | Hyderabad | Surat     |
| c3       | Kochi     | Kurnool   |
| c3       | Lucknow   | Agra      |
| c3       | Agra      | Jaipur    |
| c3       | Jaipur    | Kochi     |
+----------+-----------+-----------+


OUTPUT
+----------+-----------+-----------+
| customer | start_loc | end_loc   |
+----------+-----------+-----------+
| c1       | London    | New Delhi |
| c2       | Mumbai    | Pune      |
| c3       | Lucknow   | Kurnool   |
+----------+-----------+-----------+
*/

CREATE TABLE travel_data (
  customer VARCHAR(10),
  start_loc VARCHAR(50),
  end_loc VARCHAR(50)
);

INSERT INTO travel_data (customer, start_loc, end_loc) VALUES
  ('c1', 'New York', 'Lima'),
  ('c1', 'London', 'New York'),
  ('c1', 'Lima', 'Sao Paulo'),
  ('c1', 'Sao Paulo', 'New Delhi'),
  ('c2', 'Mumbai', 'Hyderabad'),
  ('c2', 'Surat', 'Pune'),
  ('c2', 'Hyderabad', 'Surat'),
  ('c3', 'Kochi', 'Kurnool'),
  ('c3', 'Lucknow', 'Agra'),
  ('c3', 'Agra', 'Jaipur'),
  ('c3', 'Jaipur', 'Kochi');
  

select * from travel_data ;

with iter as (
  select customer, start_loc as loc, 'start_loc' as column_name from travel_data
  union all
  select customer, end_loc as loc, 'end_loc' as column_name from travel_data
), cte2 as (
select 
  *,
  count(*) over (partition by customer, loc) as cnt
from iter 
order by customer, loc 
)
select 
  customer,
  max(case when column_name='start_loc' then loc end) as start_loc,
  max(case when column_name='end_loc' then loc end) as end_loc
from cte2 
where cnt = 1
group by customer 

