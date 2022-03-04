-----------------------LAB3-------------------
-------PART1-------
----CREATE DATABASE
create database SchoolDB;

-----LIST ALL DATABASES
SELECT name 
FROM sys.databases;  

----CREATE STUDENTS TABLE
--create table students(
--stdID int not null,
--stdName varchar(20),
--stdEmail text,
--IntakeYear int,
--constraint pk_students primary key (stdID)
--);

----CREATE STUDENTS TABLE WITH PRIMARY KEY
create table students_with_pk(
stdID int not null,
stdName varchar(20),
stdEmail text,
IntakeYear int,
constraint pk_students primary key (stdID, stdName)
);

-----ADD COLUMN TO STUDENTS TABLE WITH PRIMARY KEY
alter table students_with_pk
add data text;

-----DROP COLUMN TO STUDENTS TABLE WITH PRIMARY KEY
alter table students_with_pk
drop column data;

----CHANGE THE DATATYPE IN COLUMN StdName
alter table students_with_pk
alter column StdName varchar(200);

----ADD CONSTRAINT TO PRIMARY KEY FROM TABLE
alter table students_with_pk
add constraint pk_students primary key (stdID, stdName);

----DELETING TABLE 
drop table students_with_pk;

----------------PART 2------------------------
-----------------CREATING DATA TABLE
--------CREATE STUDENTS  TABLE
create table Students (
StdID int not null primary key(stdID),
StdName varchar(125),
StdEmail text,
IntakeYear int
);

--------CREATE LECTURER  TABLE
create table Lecturer (
lctID int not null primary key,
lctName varchar(125)
);

--------CREATE COURSE  TABLE
create table Course (
CourseID int not null primary key,
CourseName varchar(100),
lctID int foreign key (lctID) references Lecturer (lctID)
);

--------CREATE ENROLMENT  TABLE
create table Enrolment (
EnrolmentID int not null primary key,
StdID int foreign key(StdID) references Students (StdID),
CourseID int foreign key(CourseID) references Course (CourseID)
);


---------ADD COLUMN DEPARTMENT TO LECTURER  TABLE
alter table lecturer 
add department varchar(12);

---------DROP COLUMN DEPARTMENT TO LECTURER  TABLE
alter table lecturer 
drop column department;

----------------------------------------------------------
----------------------------------------------------------
----------------LAB4---------------------
----CREATE STUDENTS TABLE
create table students(
stdID int not null,
stdName varchar(20),
stdEmail text,
IntakeYear int,
constraint pk_students primary key (stdID)
);

----CREATE LECTURER TABLE
create table lecturer(
lctID int,
lctName varchar(125)
);

----INSERT DATA INTO LECTURER TABLE
insert into lecturer(lctID, lctName)
values (1, 'Ms. Inson');

----INSERT PARTIAL DATA INTO STUDENTS TABLE
insert into students(stdID, stdName, IntakeYear)
values (123456, 'Enson Liu', 2017);
insert into students(stdID, stdName, IntakeYear)
values (234567, 'Ahmad Samsul', 2017);

----INSERTING MULTIPLE RECORDS IN TO TABLE
insert into students(stdID, stdName, IntakeYear)
values (345678, 'Vinesh Ak Siva', 2017),
	   (456789, 'John Sena', 2012);

----UPDATE SINGLE RECORD
update students
set stdEmail = 'asmsul@gmail.com' , IntakeYear = 2018
where stdName = 'Enson Liu';

----UPDATE MULITPLE RECORD IN A TABLE
update students
set	
stdEmail = case when stdName = 'Enson Liu' then 'ahmad@gmail.com' 
				when stdName = 'Ahmad Samsul' then 'asmsul@gmail.com'
				when stdName = 'Vinesh Ak Siva' then 'sivavinesh@gmail.com'
				when stdName = 'John Sena' then 'senaj@gmail.com'
			end, 
IntakeYear = case when stdName = 'Enson Liu' then 2016 
				when stdName = 'Ahmad Samsul' then 2018
				when stdName = 'Vinesh Ak Siva' then 2018
				when stdName = 'John Sena' then 2012
			end;





----RENAMING TABLE NAMES 
exec sp_rename '[dbo].[Course ]', 'Course'
exec sp_rename '[dbo].[Enrolment ]', 'Enrolment'
exec sp_rename '[dbo].[Lecturer ]', 'Lecturer'
exec sp_rename '[dbo].[Students ]', 'Students'



--------------LAB4 ASSIGNMENT------------
/*----QUESTION 1
Insert three (3) data to each of the table in the tables created in lab 3
1.	Fill in the lecturer table using the details of your favorite lecturers. 5 Points
*/
insert into lecturer(lctID, lctName)
values (010, 'Trump'),
	   (080, 'Dr. Umar'),
	   (096, 'Dr.oZ');

---2.	Fill in the course table using the details of your favorite courses. 5 Points
insert into course(CourseID, CourseName,	lctID)
values (001,'Mathematics', 096),
	   (002,'Use of English', 010),
	   (005,'Statistics', 010);

---3.	Fill in the students table using your own details and two of your course mates beside you in the lab. 5 Points
insert into students(StdID, StdName, StdEmail, IntakeYear)
values (10010,'Johnathan Trueheart', 'jtrueheart@outlook.com', 2019),
	   (10025,'King', 'king@outlook.com', 2019),
	   (10032,'Joyner', 'joyner@outlook.com', 2019);


---4.	Fill in the appropriate information in the enrollment table using your data and your course mates’ data. 5 Points
insert into enrolment(EnrolmentID, StdID, CourseID)
values (001, 10010, 001),
	   (002, 10010, 002),
	   (003, 10010, 005),
	   (004, 10025, 001),
	   (005, 10025, 002),
	   (006, 10025, 005),
	   (007, 10032, 001),
	   (008, 10032, 002),
	   (009, 10032, 005);

/*----QUESTION 2
Select and display all the data in table course. 2 Points
*/
select * from Course

/*----QUESTION 3
Select and display your own data from students table using your student ID. 2Points
*/
select * from students
where stdName = 'Johnathan Trueheart'

/*----QUESTION 4
Update your own year of intake in the students table to 2022. 2 Points
*/
update students
set IntakeYear = 2022
where stdName = 'Johnathan Trueheart'; 

select * from students;

/*----QUESTION 5
Delete one lecturer from your lecturer table. 2 Points
*/
alter table course
drop constraint FK__Course__lctID__4AB81AF0;
delete from lecturer
where lctID = 96;

/*----QUESTION 6
Delete all lecturers from your lecturer table. 2 Points
*/	
truncate table lecturer;

/*----QUESTION 7
	Update the information in Figure 1 into your students table using the SQL command you learnt previously. 10 Points
*/	
insert into students (StdID, StdName, StdEmail,	IntakeYear)
values	(123456, 'Enson Liu', 'ahmad@gmail.com' , 2016),
		(234567, 'Ahmad Samsul', 'asmsul@gmail.com' , 2018),
		(345678, 'Vinesh Ak Siva', 'sivavinesh@gmail.com' , 2018),
		(456789, 'John Sena', 'senaj@gmail.com' , 2012);

select * from students

/*----QUESTION 8
Perform the operation below:
1.	Retrieve the distinct list of intake year from the table students. 5 Points
*/
select distinct IntakeYear from students;

--2. Sort the distinct list of intake year from the table in descending order. 5 Points
select distinct IntakeYear from students
order by 1 desc;

--3. Retrieve a data from table students where the name of the student is Enson Liu and the year of intake is 2016. 5 Points
select * from Students
where StdName = 'Enson Liu' and IntakeYear = 2016;

--4. Retrieve the data from table students where the name of the student is Enson Liu or the year of intake is 2012. 5 Points
select * from Students
where StdName = 'Enson Liu' or IntakeYear = 2012

--5.	List all the student in table students that are not from the year 2018. 5 Points
select * from Students
where IntakeYear != 2018

--6.	Calculate the sum and average value for the student id in the table students. 5 Points
select sum(stdid) Sum_of_StdID, avg(stdid) Avg_of_StdID from students;

--7.	Show the largest year in the table students. 5 Points
select max(intakeyear) Max_Year from Students;

--8.	Show the smallest student id in the table students. 5 Points
select min(stdid) Smallest_StdID from students;