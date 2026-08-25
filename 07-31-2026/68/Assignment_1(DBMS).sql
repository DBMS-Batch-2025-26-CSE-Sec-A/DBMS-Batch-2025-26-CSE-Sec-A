Create database DBMSLAB;

use  DBMSLAB;

create table student (
Roll int (5),
Name Varchar (30),
Age int (5),
Course Varchar (5),
Math decimal (6,2),
Physics decimal (6,2),
Computer decimal (6,2),
Birthday Date
);
select * from student ;
desc student ;

create table MSc (
Roll int (5),
Name Varchar (30),
Age int (5),
Course Varchar (5),
Math decimal (6,2),
Physics decimal (6,2),
Computer decimal (6,2),
Birthday Date
);
desc MSc;

create table MCA (
Roll int (5),
First_Name Varchar (30),
Age int (5),
Department Varchar (5),
Math decimal (6,2),
Physics decimal (6,2),
Computer decimal (6,2),
Birthday Date
);
desc MCA;

insert into student 
(Roll, Name, Age, Course, Math, Physics, Computer, Birthday)
values 
(1, "Rahul", 19, "BCA", 79.5, 67, 89, '1993-06-15'),
(2, "Kunal", 21, "BCA", 68, 76, 59.5, '1991-08-16'),
(3, "Aditi", 20, "MSc", 90, 73, 56, '1992-09-20'),
(4, "Sumit", 20, "MCA", 57.5, 78, 81, '1991-12-07'),
(5, "Anirban", 22, "MCA", 80, 68,63, '1994-09-15'),
(6, "Kumkum", 21, "BCA", 72, 54.5, 60, '1995-02-08'),
(7, "Suman", 21, "BCA", 91.5,32,61, '1994-03-10'),
(8, "Rohit", 22, "MSc", 85, 76, 92, '1992-04-19');

desc student;
select * from student;

select * from student where roll = 5;
select * from student;
select * from student where course ="BCA";

insert into MCA
(Roll, First_Name, Age, Department, Math, Physics, Computer, Birthday)
values 
(1, "Sumit", 20, "MCA", 57.5, 78, 81, '1991-12-07'),
(2, "Anirban", 22, "MCA", 80, 68,63, '1994-09-15');

insert into MSc
(Roll, Name, Age, Course, Math, Physics, Computer, Birthday)
values 
(1, "Aditi", 20, "MSc", 90, 73, 56, '1992-09-20'),
(2, "Rohit", 22, "MSc", 85, 76, 92, '1992-04-19');

select * from student;
select * from MCA;

select Course, Roll, Name, Age, Math, Physics, Computer, Birthday from student;

set sql_safe_updates=0;
update student set Math = 95 where roll = 7;
select * from student;

update MCA set first_Name = "Sumitava" where roll = 1;
select * from mca;

delete from student where roll = 2;
select * from student;

delete from student;
select * from student;
