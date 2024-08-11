-- Table: Toppings
-- +--------------+---------+ 
-- | Column Name  | Type    | 
-- +--------------+---------+ 
-- | topping_name | varchar | 
-- | cost         | decimal |
-- +--------------+---------+
-- topping_name is the primary key for this table.
-- Each row of this table contains topping name and the cost of the topping. 
-- Write a solution to calculate the total cost of all possible 3-topping pizza combinations from a given list of toppings. The total cost of toppings must be rounded to 2 decimal places.

-- Note:
-- Do not include the pizzas where a topping is repeated. For example, ‘Pepperoni, Pepperoni, Onion Pizza’.
-- Toppings must be listed in alphabetical order. For example, 'Chicken, Onions, Sausage'. 'Onion, Sausage, Chicken' is not acceptable.
-- Return the result table ordered by total cost in descending order and combination of toppings in ascending order.
-- The result format is in the following example.
 

-- Example 1:
-- Input: 
-- Toppings table:
-- +--------------+------+
-- | topping_name | cost |
-- +--------------+------+
-- | Pepperoni    | 0.50 |
-- | Sausage      | 0.70 |
-- | Chicken      | 0.55 |
-- | Extra Cheese | 0.40 |
-- +--------------+------+

-- Output: 
-- +--------------------------------+------------+
-- | pizza                          | total_cost | 
-- +--------------------------------+------------+
-- | Chicken,Pepperoni,Sausage      | 1.75       |  
-- | Chicken,Extra Cheese,Sausage   | 1.65       |
-- | Extra Cheese,Pepperoni,Sausage | 1.60       |
-- | Chicken,Extra Cheese,Pepperoni | 1.45       | 
-- +--------------------------------+------------+
-- Explanation: 
-- There are only four different combinations possible with the three topings:
-- - Chicken, Pepperoni, Sausage: Total cost is $1.75 (Chicken $0.55, Pepperoni $0.50, Sausage $0.70).
-- - Chicken, Extra Cheese, Sausage: Total cost is $1.65 (Chicken $0.55, Extra Cheese $0.40, Sausage $0.70).
-- - Extra Cheese, Pepperoni, Sausage: Total cost is $1.60 (Extra Cheese $0.40, Pepperoni $0.50, Sausage $0.70).
-- - Chicken, Extra Cheese, Pepperoni: Total cost is $1.45 (Chicken $0.55, Extra Cheese $0.40, Pepperoni $0.50).
-- Output table is ordered by the total cost in descending order.


CREATE TABLE toppings (
  topping_name VARCHAR(50) PRIMARY KEY,
  cost DECIMAL(5, 2) NOT NULL
);

INSERT INTO toppings (topping_name, cost) VALUES ('Pepperoni', 0.50);
INSERT INTO toppings (topping_name, cost) VALUES ('Sausage', 0.70);
INSERT INTO toppings (topping_name, cost) VALUES ('Chicken', 0.55);
INSERT INTO toppings (topping_name, cost) VALUES ('Extra Cheese', 0.40);


select * from toppings ;


WITH T1 AS (
  SELECT 
    *
  FROM toppings
  ORDER BY topping_name
), T2 AS (
  SELECT
    t1.topping_name AS topping_name_1,
    t2.topping_name AS topping_name_2,
    t3.topping_name AS topping_name_3,
    t1.cost AS cost_1,
    t2.cost AS cost_2,
    t3.cost AS cost_3
  FROM T1 as t1
  INNER JOIN toppings t2
  ON t1.topping_name < t2.topping_name
  INNER JOIN toppings t3
  ON t2.topping_name < t3.topping_name 
)
SELECT 
  CONCAT(topping_name_1, ',', topping_name_2, ',', topping_name_3) AS topping_name ,
  cost_1 + cost_2 + cost_3 AS total_cost
FROM T2
;
  