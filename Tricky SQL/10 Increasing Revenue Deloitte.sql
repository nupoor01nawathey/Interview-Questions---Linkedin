-- Deloitte , 
-- Write a sql query to find the products whose total sales revenue has increased every year. 
-- Include the product_id , product_name and category in the result.


CREATE TABLE products (
 product_id INT PRIMARY KEY,
 product_name VARCHAR(50),
 category VARCHAR(50)
);

INSERT INTO products (product_id, product_name, category) VALUES
 (1, 'Laptops', 'Electronics'),
 (2, 'Jeans', 'Clothing'),
 (3, 'Chairs', 'Home Appliances');


CREATE TABLE sales (
 product_id INT,
 year INT,
 total_sales_revenue DECIMAL(10, 2),
 PRIMARY KEY (product_id, year),
 FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO sales (product_id, year, total_sales_revenue) VALUES
 (1, 2019, 1000.00),
 (1, 2020, 1200.00),
 (1, 2021, 1100.00),
 (2, 2019, 500.00),
 (2, 2020, 600.00),
 (2, 2021, 900.00),
 (3, 2019, 300.00),
 (3, 2020, 450.00),
 (3, 2021, 400.00);


select * from products;

select * from sales;

with cte as (
    select 
        *,
        lag(total_sales_revenue, 1, total_sales_revenue) over(partition by product_id order by year asc) prev_year_sales_revenue
    from sales
), cte1 as (
    select 
        *,
        total_sales_revenue-prev_year_sales_revenue as diff
    from cte
), cte2 as (
select
    product_id,
    min(diff)
from cte1
group by product_id
having min(diff) > 0
)
select
    p.*
from cte2 c2 join products p 
ON c2.product_id=p.product_id






