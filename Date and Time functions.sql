
-- MYSQL Write a query to get the weekday name for a specific date.
SELECT DAYNAME("1990-01-01") as name_of_day ;

-- MYSQL Write a query to get the month name for a specific date.
SELECT MONTH("1990-01-01") as name_of_month ;

-- MYSQL Write a query to get the number of days in a specific month.
SELECT DAY(LAST_DAY("1990-01-01")) as no_of_days ;
SELECT DAYOFMONTH(LAST_DAY("1990-01-01")) as no_of_days ;
