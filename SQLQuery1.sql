--Homework Assignment: SQL Basics
--1. Practical Tasks
	--Use SSMS to complete the following:
	--1.	Create a new database named HomeworkDB.
	create database HomeworkDB
	use HomeworkDB
	--2.	Create a table called Students with the following structure:
		--○	StudentID (INT)
		--○	FullName (VARCHAR(50))
		--○	Age (INT)
		--○	GPA (DECIMAL(3, 2))
	create table Students(StudentID int, FullName varchar(50), Age int, GPA decimal(3, 2))
	--3.	Add a new column Email (VARCHAR(50)) to the Students table.
	alter table Students
	add Email varchar(50)
	--4.	Rename the column FullName to Name.
	exec sp_rename 'Students.FullName', 'Name', 'column'
	--5.	Drop the column Age from the Students table.
	alter table Students
	drop column Age
	--6.	Truncate the Students table.
	truncate table Students
--2. Query Writing
	--Write and test these queries:
		--1.	Retrieve the current server name using the appropriate command.
		select @@SERVERNAME
		--2.	Write a query to display today’s date and time.
		select getdate()
		--3.	Write a query to select all data from the Students table.
		select * from Students
