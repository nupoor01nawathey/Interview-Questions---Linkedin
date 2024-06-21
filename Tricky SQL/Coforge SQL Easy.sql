-- Coforge
-- Write a SQL code to filter customer transactions greater than $10,000, transform
-- customer names to have the first letter capitalized and the rest in lowercase
-- *** CONCAT(UCASE(LEFT(customer_name,1)) , LCASE(SUBSTRING(customer_name, 2))) ***
-- and compute the average transaction amount for each product category.

CREATE TABLE customer_transactions (
 customer_id INT,
 customer_name VARCHAR(50),
 transaction DECIMAL(10, 2),
 product_category VARCHAR(50)
);

INSERT INTO customer_transactions (customer_id, customer_name, transaction, product_category)
VALUES
 (1, 'ALICE', 12000.00, 'Electronics'),
 (2, 'BOB', 9000.00, 'Home Appliances'),
 (3, 'CHARLIE', 15000.00, 'Fashion'),
 (4, 'DANIEL', 8000.00, 'Electronics'),
 (5, 'EMMA', 11000.00, 'Fashion'),
 (6, 'FRANK', 13000.00, 'Home Appliances'),
 (7, 'GINA', 10000.00, 'Electronics'),
 (8, 'HENRY', 14000.00, 'Fashion'),
 (9, 'ISABELLA', 9500.00, 'Home Appliances'),
 (10, 'JACK', 10500.00, 'Electronics');
 
 select * from customer_transactions ;
 
 select 
  *,
  CONCAT(UCASE(LEFT(customer_name,1)) , LCASE(SUBSTRING(customer_name, 2))) camel_cased_name,
  avg(transaction) over (partition by product_category) avg_transaction_per_product_category
from customer_transactions
where transaction > 10000 ;



 
 