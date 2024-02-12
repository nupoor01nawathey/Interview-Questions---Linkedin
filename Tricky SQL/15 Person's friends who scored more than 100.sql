
create table person(
  PersonID int,
  Name char(10),
  Email	varchar(25),
  Score int
);

insert into person values(1,'Alice','alice2018@hotmail.com', 88);
insert into person values(2,'Bob','bob2018@hotmail.com', 11);
insert into person values(3,'Davis','davis2018@hotmail.com', 27);
insert into person values(4,'Tara','tara2018@hotmail.com', 45);
insert into person values(5,'John','john2018@hotmail.com', 63);

create table friends (
  PersonID int,
  FriendID int
);

insert into friends values(1,2);
insert into friends values(1,3);
insert into friends values(2,1);
insert into friends values(2,3);
insert into friends values(3,5);
insert into friends values(4,2);
insert into friends values(4,3);
insert into friends values(4,5);


select * from person ;
select * from friends ;


select 
  f.personID,
  count(1) total_friends,
  sum(p.score) total_score
from friends f inner join person p 
on f.FriendID=p.personID
group by f.PersonID
having total_score > 100
order by f.personID
;



