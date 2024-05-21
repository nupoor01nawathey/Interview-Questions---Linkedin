
Create table If Not Exists Users 
(
 user_id int, 
 user_name varchar(20), 
 credit int
);

Create table If Not Exists Transactions 
(
 trans_id int, 
 paid_by int, 
 paid_to int, 
 amount int, 
 transacted_on date
);

insert into Users (user_id, user_name, credit) values 
 ('1', 'Moustafa', '100'),
 ('2', 'Jonathan', '200'),
 ('3', 'Winston', '10000'),
 ('4', 'Luis', '800');

insert into Transactions (trans_id, paid_by, paid_to, amount, transacted_on) values 
('1', '1', '3', '400', '2020-08-01'),
('2', '3', '2', '500', '2020-08-02'),
('3', '2', '1', '200', '2020-08-03');

select * from users;
select * from transactions;


with combined as (
	select u.*,t1.paid_by,t2.paid_to,t1.amount as paid_by_amount, t2.amount as paid_to_amount
	from users u left join transactions t1 on u.user_id=t1.paid_by
	left join transactions t2 on u.user_id=t2.paid_to
),
amount_p as(
select 
	*,
    coalesce(credit - paid_by_amount + paid_to_amount, 0) as credit_p
  from combined 
)
select 
	user_id,
	user_name,
    credit,
    credit_p,
    case when credit_p > 0 then 'No' else 'Yes' end as credit_limit_breached
from amount_p ;
    



