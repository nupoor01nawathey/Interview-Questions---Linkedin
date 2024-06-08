-- Accenture SQL Interview Question | Database Case Sensitivity vs Insensitivity

CREATE TABLE employees  (employee_id int,employee_name varchar(15), email_id varchar(15) );

delete from employees;

INSERT INTO employees (employee_id,employee_name, email_id) VALUES ('101','Liam Alton', 'li.al@abc.com');
INSERT INTO employees (employee_id,employee_name, email_id) VALUES ('102','Josh Day', 'jo.da@abc.com');
INSERT INTO employees (employee_id,employee_name, email_id) VALUES ('103','Sean Mann', 'se.ma@abc.com'); 
INSERT INTO employees (employee_id,employee_name, email_id) VALUES ('104','Evan Blake', 'ev.bl@abc.com');
INSERT INTO employees (employee_id,employee_name, email_id) VALUES ('105','Toby Scott', 'jo.da@abc.com');
INSERT INTO employees (employee_id,employee_name, email_id) VALUES ('106','Anjali Chouhan', 'JO.DA@ABC.COM');
INSERT INTO employees (employee_id,employee_name, email_id) VALUES ('107','Ankit Bansal', 'AN.BA@ABC.COM');

select * from (
select 
  *,
  ascii(email_id) ascii_email_id,
  rank() over(partition by email_id order by ascii(email_id) desc) rn
from employees 
) t
where t.rn=1 ;

