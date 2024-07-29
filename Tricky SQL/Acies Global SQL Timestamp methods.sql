-- 1. Find out the time an employee has spent in office on a particular day (office hours = last logout time - first login time)
-- Acies Global SQL Interview Question | Employee Swipe in and Swipe out

drop table if exists swipe ;
CREATE TABLE swipe (
  employee_id INT,
  activity_type VARCHAR(10),
  activity_time datetime
);

-- Insert sample data
INSERT INTO swipe (employee_id, activity_type, activity_time) VALUES
(1, 'login', '2024-07-23 08:00:00'),
(1, 'logout', '2024-07-23 12:00:00'),
(1, 'login', '2024-07-23 13:00:00'),
(1, 'logout', '2024-07-23 17:00:00'),
(2, 'login', '2024-07-23 09:00:00'),
(2, 'logout', '2024-07-23 11:00:00'),
(2, 'login', '2024-07-23 12:00:00'),
(2, 'logout', '2024-07-23 15:00:00'),
(1, 'login', '2024-07-24 08:30:00'),
(1, 'logout', '2024-07-24 12:30:00'),
(2, 'login', '2024-07-24 09:30:00'),
(2, 'logout', '2024-07-24 10:30:00');

select * from swipe ; 


-- 1. Find out the time an employee has spent in office on a particular day (office hours = last logout time - first login time)
-- 2. Find out real working hours inside the ODC, consider one login, logout that differ gives productive hours
-- do the same for each employee each day and other login, logout for each of the days

with employee_activity as ( 	
  select 
    *,
  lead(activity_time) over(partition by employee_id, date_format(activity_time,'%Y-%m-%d') order by activity_time) log_out_time
  from swipe
)
select 
  employee_id, 
  date_format(activity_time,'%Y-%m-%d') date, 
  extract(hour from max(log_out_time)-min(activity_time)) as total_working_hours,
  extract(hour from sum(log_out_time-activity_time)) as actual_working_hours
from employee_activity 
where activity_type = 'login'
group by 1,2
;




