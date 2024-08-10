CREATE TABLE tickets (
  airline_number VARCHAR(10),
  origin VARCHAR(3),
  destination VARCHAR(3),
  oneway_round CHAR(1),
  ticket_count INT
);


INSERT INTO tickets (airline_number, origin, destination, oneway_round, ticket_count)
VALUES
  ('DEF456', 'BOM', 'DEL', 'O', 150),
  ('GHI789', 'DEL', 'BOM', 'R', 50),
  ('JKL012', 'BOM', 'DEL', 'R', 75),
  ('MNO345', 'DEL', 'NYC', 'O', 200),
  ('PQR678', 'NYC', 'DEL', 'O', 180),
  ('STU901', 'NYC', 'DEL', 'R', 60),
  ('ABC123', 'DEL', 'BOM', 'O', 100),
  ('VWX234', 'DEL', 'NYC', 'R', 90);
  
    
select * from tickets ;

-- Note: in case of oneway_round=R rows, it actually represents two rows
-- origin to destination as one row and destination back to origin as 2nd row 

select origin, destination, sum(ticket_count) tc
from (
  select 
    origin, destination, ticket_count
  from tickets
  union all
  select
    destination, origin, ticket_count
  from tickets where oneway_round
) A
group by 1, 2
order by tc desc

