-- ➡ Problem Statement :
-- AMAZON 
-- Write a SQL query to find total amount received by each merchant via Cash and Online mode.

-- Given Dataset: Sale Table:

CREATE TABLE SALE (
 merchant VARCHAR(255),
 amount INT,
 pay_mode VARCHAR(50) 
);

insert into SALE values('merchant_1',150,'cash');
insert into SALE values('merchant_1',500,'online');
insert into SALE values('merchant_2',450,'online');
insert into SALE values('merchant_1',100,'cash');
insert into SALE values('merchant_3',600,'cash');
insert into SALE values('merchant_5',200,'online');
insert into SALE values('merchant_2',100,'online');

select * from sale ;


select
  merchant,
  sum(case when pay_mode='cash' then amount else 0 end) as total_cash,
  sum(case when pay_mode='online' then amount else 0 end) as total_online
from sale 
group by merchant
;


