-- Ref links 
-- https://github.com/shahriarShawon/bike_rental_sql
-- https://www.youtube.com/watch?v=qteUUBPy2iE

/*
drop database bike_rental_case_study ;
create database bike_rental_case_study ;
use bike_rental_case_study ;

drop table if exists customer;
create table customer
(
	id		int primary key,
	name	varchar(30),
	email	varchar(50)
);


drop table if exists bike;
create table bike
(
	id					int primary key,
	model				varchar(50),
	category			varchar(50),
	price_per_hour		decimal,
	price_per_day		decimal,
	status				varchar(20)
);


drop table if exists rental;
create table rental
(
	id					int primary key,
	customer_id			int references customer(id),
	bike_id				int references bike(id),
	start_timestamp		timestamp,
	duration			int,
	total_paid			decimal
);


drop table if exists membership_type;
create table membership_type
(
	id				int primary key,
	name			varchar(50),
	description		varchar(500),
	price			decimal
);


drop table if exists membership;
create table membership
(
	id					int primary key,
	membership_type_id	int references membership_type(id),
	customer_id			int references customer(id),
	start_date			date,
	end_date			date,
	total_paid			decimal
);



insert into customer values(1,	'John Doe',			'john.doe@example.com');
insert into customer values(2,	'Alice Smith',		'alice.smith@example.com');
insert into customer values(3,	'Bob Johnson',		'bob.johnson@example.com');
insert into customer values(4,	'Eva Brown',		'eva.brown@example.com');
insert into customer values(5,	'Michael Lee',		'michael.lee@example.com');
insert into customer values(6,	'Sarah White',		'sarah.white@example.com');
insert into customer values(7,	'David Wilson',		'david.wilson@example.com');
insert into customer values(8,	'Emily Davis',		'emily.davis@example.com');
insert into customer values(9,	'Daniel Miller',	'daniel.miller@example.com');
insert into customer values(10,	'Olivia Taylor',	'olivia.taylor@example.com');


insert into bike values(1,	'Mountain Bike 1'	,'mountain bike'	,10.00	,50.00	,'available');
insert into bike values(2,	'Road Bike 1'	,'road bike',12.00	,60.00	,'available');
insert into bike values(3,	'Hybrid Bike 1'	,'hybrid'	,8.00	,40.00	,'rented');
insert into bike values(4,	'Electric Bike 1'	,'electric',15.00	,75.00	,'available');
insert into bike values(5,	'Mountain Bike 2'	,'mountain bike'	,10.00	,50.00	,'out of service');
insert into bike values(6,	'Road Bike 2'	,'road bike',12.00	,60.00	,'available');
insert into bike values(7,	'Hybrid Bike 2'	,'hybrid'	,8.00	,40.00	,'out of service');
insert into bike values(8,	'Electric Bike 2'	,'electric',15.00	,75.00	,'available');
insert into bike values(9,	'Mountain Bike 3'	,'mountain bike'	,10.00	,50.00	,'rented');
insert into bike values(10,	'Road Bike 3'	,'road bike',12.00	,60.00	,'available');


insert into rental values(1,	1,	1,	'2022-11-01 10:00:00',	240,	50.00);
insert into rental values(2,	1,	1,	'2022-11-02 10:00:00',	245,	50.00);
insert into rental values(3,	1,	1,	'2022-11-03 10:00:00',	250,	50.00);
insert into rental values(4,	1,	1,	'2022-11-04 10:00:00',	235,	50.00);
insert into rental values(5,	1,	1,	'2022-12-05 10:00:00',	155,	50.00);
insert into rental values(6,	2,	2,	'2022-12-08 11:00:00',	250,	60.00);
insert into rental values(7,	3,	3,	'2022-12-13 12:00:00',	245,	40.00);
insert into rental values(8,	1,	1,	'2023-01-05 10:00:00',	240,	50.00);
insert into rental values(9,	2,	2,	'2023-01-08 11:00:00',	235,	60.00);
insert into rental values(10,	3,	3,	'2023-02-13 12:00:00',	245,	40.00);
insert into rental values(11,	1,	1,	'2023-03-05 10:00:00',	250,	50.00);
insert into rental values(12,	2,	2,	'2023-03-08 11:00:00',	355,	60.00);
insert into rental values(13,	3,	3,	'2023-04-13 12:00:00',	240,	40.00);
insert into rental values(14,	1,	1,	'2023-04-01 10:00:00',	235,	50.00);
insert into rental values(15,	1,	6,	'2023-05-01 10:00:00',	245,	60.00);
insert into rental values(16,	1,	2,	'2023-05-01 10:00:00',	250,	60.00);
insert into rental values(17,	1,	3,	'2023-06-01 10:00:00',	235,	40.00);
insert into rental values(18,	1,	4,	'2023-06-01 10:00:00',	255,	75.00);
insert into rental values(19,	1,	5,	'2023-07-01 10:00:00',	240,	50.00);
insert into rental values(20,	2,	2,	'2023-07-02 11:00:00',	445,	60.00);
insert into rental values(21,	3,	3,	'2023-07-03 12:00:00',	250,	40.00);
insert into rental values(22,	4,	4,	'2023-08-04 13:00:00',	235,	75.00);
insert into rental values(23,	5,	5,	'2023-08-05 14:00:00',	555,	50.00);
insert into rental values(24,	6,	6,	'2023-09-06 15:00:00',	240,	60.00);
insert into rental values(25,	7,	7,	'2023-09-07 16:00:00',	245,	40.00);
insert into rental values(26,	8,	8,	'2023-09-08 17:00:00',	250,	75.00);
insert into rental values(27,	9,	9,	'2023-10-09 18:00:00',	335,	50.00);
insert into rental values(28,	10,	10,	'2023-10-10 19:00:00',	255,	60.00);
insert into rental values(29,	10,	1,	'2023-10-10 19:00:00',	240,	50.00);
insert into rental values(30,	10,	2,	'2023-10-10 19:00:00',	245,	60.00);
insert into rental values(31,	10,	3,	'2023-10-10 19:00:00',	250,	40.00);
insert into rental values(32,	10,	4,	'2023-10-10 19:00:00',	235,	75.00);


insert into membership_type values(1,'Basic Monthly',	'Unlimited rides with non-electric bikes. Renews monthly.',	100.00);
insert into membership_type values(2,'Basic Annual',	'Unlimited rides with non-electric bikes. Renews annually.',500.00);
insert into membership_type values(3,'Premium Monthly',	'Unlimited rides with all bikes. Renews monthly.',	200.00);


insert into membership values(1,	2,	3,	'2023-08-01',	'2023-08-31',	500.00);
insert into membership values(2,	1,	2,	'2023-08-01',	'2023-08-31',	100.00);
insert into membership values(3,	3,	4,	'2023-08-01',	'2023-08-31',	200.00);
insert into membership values(4,	1,	1,	'2023-09-01',	'2023-09-30',	100.00);
insert into membership values(5,	2,	2,	'2023-09-01',	'2023-09-30',	500.00);
insert into membership values(6,	3,	3,	'2023-09-01',	'2023-09-30',	200.00);
insert into membership values(7,	1,	4,	'2023-10-01',	'2023-10-31',	100.00);
insert into membership values(8,	2,	5,	'2023-10-01',	'2023-10-31',	500.00);
insert into membership values(9,	3,	3,	'2023-10-01',	'2023-10-31',	200.00);
insert into membership values(10,	3,	1,	'2023-11-01',	'2023-11-30',	200.00);
insert into membership values(11,	2,	5,	'2023-11-01',	'2023-11-30',	500.00);
insert into membership values(12,	1,	2,	'2023-11-01',	'2023-11-30',	100.00);

*/


select * from customer;
select * from bike;
select * from rental;
select * from membership_type;
select * from membership;

-- 1. How many bikes does the shop own by category?
SELECT
	COUNT(*) no_of_bikes,
    category
FROM bike
GROUP BY category ;


-- 2. List of customer names with the total number of memberships purchased by each.
SELECT
	c.name AS customer_name,
    count(m.id) AS no_of_memberships
FROM customer c LEFT JOIN membership m
ON c.id = m.customer_id 
GROUP BY 1 ;


-- 3. Prepare a list of new rental prices for a special winter offer.
/*
	For each below category you can try any logic to generate new prices , use CASE stmts 
	mountain bike
	road bike
	hybrid
	electric
*/


-- 4. Counts of rented and available bikes in each category.
SELECT
	COALESCE(category, 'Total') AS category,
    rented_bikes,
    available_bikes
FROM (
	SELECT 
		category,
		COUNT(CASE WHEN status='rented' THEN 1 END) AS rented_bikes,
		COUNT(CASE WHEN status='available' THEN 1 END) AS available_bikes
	FROM bike
	GROUP BY 1 WITH rollup 
) T	;
    
    
-- 5. Total revenue from rentals by month, by year, and all-time.
SELECT
	YEAR(start_timestamp) as yr,
	MONTH(start_timestamp) AS mnth,
	SUM(total_paid) AS total_paid
FROM rental 
GROUP BY 1, 2 WITH ROLLUP
;


-- 6. Total revenue from memberships for each combination of year, month, and membership type.
SELECT
	YEAR(start_date) AS yr,
    MONTH(start_date) AS mnth,
    mt.name membership_name,
	SUM(total_paid) AS total_revenue
FROM membership m INNER JOIN membership_type mt
ON m.membership_type_id = mt.id
GROUP BY 1, 2, 3
ORDER BY 1, 2, 3 ;


-- 7. Memberships purchased in 2023, with subtotals and grand totals.
SELECT 
	COALESCE(membership_type_name, 'Grand Total') AS membership_type_name,
    mnth,
    total_revenue
FROM (
	SELECT
		mt.name membership_type_name,
		MONTH(m.start_date) AS mnth,
		SUM(m.total_paid) AS total_revenue
	FROM membership m INNER JOIN membership_type mt
	ON m.membership_type_id = mt.id
	WHERE YEAR(m.start_date) = '2023'
	GROUP BY 1, 2 WITH ROLLUP
	ORDER BY 1, 2
) T ;


-- 8. Segment customers based on the number of rentals.
WITH CTE AS (
	SELECT
		customer_id,
        CASE WHEN COUNT(customer_id) > 10 THEN 'More than 10'
			 WHEN COUNT(customer_id) BETWEEN 5 AND 10 THEN 'Between 5 and 10'
             WHEN COUNT(customer_id) < 5 THEN 'Less than 5'
        END AS category
	FROM rental
    GROUP BY 1
)
SELECT 
	category AS rental_count_category,
    COUNT(*) customer_count
FROM CTE 
GROUP BY 1
ORDER BY 2 DESC ;

