
Create table If Not Exists 
Visits (
 user_id int, 
 visit_date date
);

Create table If Not Exists 
Transactions1 (user_id int, 
transaction_date date, amount int
);

truncate table visits ; 
truncate table Transactions1 ;

insert into Visits (user_id, visit_date) values ('1', '2020-01-01');
insert into Visits (user_id, visit_date) values ('2', '2020-01-02');
insert into Visits (user_id, visit_date) values ('12', '2020-01-01');
insert into Visits (user_id, visit_date) values ('19', '2020-01-03');
insert into Visits (user_id, visit_date) values ('1', '2020-01-02');
insert into Visits (user_id, visit_date) values ('2', '2020-01-03');
insert into Visits (user_id, visit_date) values ('1', '2020-01-04');
insert into Visits (user_id, visit_date) values ('7', '2020-01-11');
insert into Visits (user_id, visit_date) values ('9', '2020-01-25');
insert into Visits (user_id, visit_date) values ('8', '2020-01-28');

insert into Transactions1 (user_id, transaction_date, amount) values ('1', '2020-01-02', '120');
insert into Transactions1 (user_id, transaction_date, amount) values ('2', '2020-01-03', '22');
insert into Transactions1 (user_id, transaction_date, amount) values ('7', '2020-01-11', '232');
insert into Transactions1 (user_id, transaction_date, amount) values ('1', '2020-01-04', '7');
insert into Transactions1 (user_id, transaction_date, amount) values ('9', '2020-01-25', '33');
insert into Transactions1 (user_id, transaction_date, amount) values ('9', '2020-01-25', '66');
insert into Transactions1 (user_id, transaction_date, amount) values ('8', '2020-01-28', '1');
insert into Transactions1 (user_id, transaction_date, amount) values ('9', '2020-01-25', '99');

select * from Visits order by user_id; 



-- RECURSIVE CTE NOT WORKING 
-- THIS IS A NON_WORKING SOLUTION
with recursive generate_seq as (
    select 0 as n
    union all
    select n+1 as n
    from generate_seq 
    where n < (select max(transactions_count) from only_visits_and_visits_plus_trans)
), 
only_visits_and_visits_plus_trans as ( 
	select 0 as transaction_count,count(1) as visit_count from visits t1 left join transactions1 t2 
	on t1.user_id=t2.user_id and t1.visit_date=t2.transaction_date
	where t2.user_id is null  -- only_visits logic
	UNION
	select transaction_count,
		count(1) visit_count
	from (
		select
			user_id, transaction_date, 
			count(1) as transaction_count
		from Transactions1 
		group by user_id, Transaction_date
	) A
	group by transaction_count 
)
select * from generate_seq ;

-- select 
-- 	* 
-- from generate_seq A left join only_visits_and_visits_plus_trans B
-- on A.transaction_count = B.transaction_count;


-- /* Write your T-SQL query statement below */
-- with cte1 as (
--     select v.user_id, visit_date, transaction_date, amount
--     from visits v left join transactions1 t on v.user_id = t.user_id and v.visit_date = t.transaction_date
-- ), cte2 as (
--     select user_id, visit_date, sum(case when amount is null then 0 else 1 end) as transactions_count
--     from cte1 
--     group by user_id, visit_date
-- ), cte3 as (
--     select max(transactions_count) as max_transactions_count
--     from cte2
-- ), cte4 as (
--     select 0 as n
--     union all
--     select n+1 as n
--     from cte4 
--     where n < (select max_transactions_count from cte3)
-- )
-- select n as transactions_count, count(transactions_count) as visits_count
-- from cte4 left join cte2 on cte4.n = cte2.transactions_count
-- group by n ;