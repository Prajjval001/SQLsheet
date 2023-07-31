/*
   Query for CTEs(Common Table Expressions) 
   These are not stored anywhere in DB like the Temp tables in temp DB
*/

WITH CTE_Employee AS (
SELECT FirstName, LastName, Gender, Salary,
COUNT(gender) OVER (PARTITION BY Gender) AS TotalGender,
AVG(Salary) OVER (PARTITION BY Gender) AS AvgSalary
FROM SQLTute..EmployeeDetails emp
JOIN SQLTute..EmployeeSalary sal
	ON emp.EmployeeID = sal.EmployeeID
WHERE Salary > '45000'
)
SELECT FirstName, AvgSalary      --Select would only work when written just after with statement
FROM CTE_Employee



/*
    TEMP TABLES
*/


CREATE TABLE #temp_Employee(
EmployeeID int,
JobTitle varchar(100),
Salary int
)

SELECT * 
FROM #temp_Employee


INSERT INTO #temp_Employee VALUES (
101, 'Senior Manager', 60000)

INSERT INTO #temp_Employee VALUES (
105, 'Receptionist', 25000)

INSERT INTO #temp_Employee VALUES (
110, 'Salesman', 35000)


INSERT INTO #temp_Employee
SELECT * 
FROM SQLTute..EmployeeSalary



DROP TABLE IF EXISTS #TEMP_Employee2
CREATE TABLE #TEMP_Employee2(
JobTitle varchar(50),
EmployeePerJob int,
AvgAge int,
AvgSalary int
)

INSERT INTO #TEMP_Employee2 
SELECT JobTitle, COUNT(JobTitle), Avg(Age), Avg(Salary)
FROM SQLTute..EmployeeDetails emp
JOIN SQLTute..EmployeeSalary sal
	ON emp.EmployeeID = sal.EmployeeID
GROUP BY JobTitle

SELECT *
FROM #TEMP_Employee2



/*
    String Functions - TRIM, LTRIM, RTRIM, REPLACR, SUBSTRING, UPPER, LOWER
*/


CREATE TABLE EmployeeErrors (
EmployeeID varchar(50)
,FirstName varchar(50)
,LastName varchar(50)
)

Insert into EmployeeErrors Values 
('1001  ', 'RAKESH', 'Sachdeva')
,('  1002', 'Pammi', 'Singhaniya')
,('1005', 'PAul', 'Hinder - Forced')

SELECT *
FROM EmployeeErrors


-- Using Trim, LTRIM, RTRIM

SELECT EmployeeID, TRIM(EmployeeID) AS IDtrim
FROM EmployeeErrors

SELECT EmployeeID, LTRIM(EmployeeID) AS IDtrim
FROM EmployeeErrors

SELECT EmployeeID, RTRIM(EmployeeID) AS IDtrim
FROM EmployeeErrors


-- Using REPLACE 

SELECT LastName, REPLACE(LastName, '- Forced', '') AS Replaced
FROM EmployeeErrors


-- Using Substring

SELECT SUBSTRING(FirstName, 1,3)
FROM EmployeeErrors



-- Using Upper and Lower

SELECT FirstName, LOWER(FirstName)
FROM EmployeeErrors


SELECT FirstName, UPPER(FirstName)
FROM EmployeeErrors



/*
   STORED PROCEDURES
*/

CREATE PROCEDURE TEST1
AS 
SELECT * 
FROM EmployeeDetails


EXEC TEST1


CREATE PROCEDURE Temp_Employee
AS 
CREATE TABLE #temp_emp (
JobTitle varchar (50),
EmployeePerJob int ,
AvgAge int , 
AvgSalary int 
)


INSERT INTO #temp_emp
SELECT JobTitle, COUNT(JobTitle), Avg(Age), Avg(Salary)
FROM SQLTute..EmployeeDetails emp
JOIN SQLTute..EmployeeSalary sal
	ON emp.EmployeeID = sal.EmployeeID
GROUP BY JobTitle

SELECT *
FROM #temp_emp



EXEC Temp_Employee @JobTitle = 'SalesManager'



/*

  Subqueries (in the Select, From, and Where Statement)

*/

SELECT EmployeeID, JobTitle, Salary
FROM EmployeeSalary

-- Subquery in Select

SELECT EmployeeID, Salary, (Select AVG(Salary) From EmployeeSalary) as AllAvgSalary
FROM EmployeeSalary

-- How to do it with Partition By


SELECT EmployeeID, Salary, AVG(Salary) OVER () AS AllAvgSalary
FROM EmployeeSalary


-- Why Group By doesn't work


SELECT EmployeeID, Salary, AVG(Salary) AS AllAvgSalary
FROM EmployeeSalary
GROUP BY EmployeeID, Salary
ORDER BY EmployeeID


-- Subquery in From

SELECT emp.EmployeeID, AllAvgSalary
FROM
	(SELECT EmployeeID, Salary, AVG(Salary) OVER () AS AllAvgSalary
	 FROM EmployeeSalary) emp
ORDER BY emp.EmployeeID


-- Subquery in Where


SELECT EmployeeID, JobTitle, Salary
FROM EmployeeSalary
WHERE EmployeeID in (
	SELECT EmployeeID 
	FROM EmployeeDetails
	WHERE Age > 30)
