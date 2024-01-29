-- Airbnb, The problem is called as Most Popular Room Types.  
-- In this problem we will learn how to convert comma separated values into row.

create table airbnb_searches(
user_id int,
date_searched date,
filter_room_types varchar(200)
);

insert into airbnb_searches values
(1,'2022-01-01','entire home,private room')
,(2,'2022-01-02','entire home,shared room')
,(3,'2022-01-02','private room,shared room')
,(4,'2022-01-03','private room');

select * from airbnb_searches ;


WITH cte AS
(select user_id, date_searched, substring_index(filter_room_types,',',1) as room_search from airbnb_searches
union
select user_id, date_searched, substring_index(filter_room_types,',',-1) as room_search from airbnb_searches
) 
SELECT room_search,count(*) room_count
FROM cte
group by room_search 
; 