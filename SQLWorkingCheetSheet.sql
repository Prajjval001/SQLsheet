SELECT TOP (1000) [EmployeeID]
      ,[JobTitle]
      ,[Salary]
  FROM [SQLTute].[dbo].[EmployeeSalary]


/*
   GROUP BY, ORDER BY
*/

SELECT JobTitle, COUNT(JobTitle)
FROM SQLTute.dbo.EmployeeSalary
GROUP BY JobTitle


SELECT *
FROM SQLTute.dbo.EmployeeDetails
ORDER BY EmployeeID, Age, Gender


/*
     UPDATE, DELETE, INSERT
*/

SELECT *
FROM SQLTute.dbo.EmployeeDetails

UPDATE SQLTute.dbo.EmployeeDetails
SET Age = 36
WHERE EmployeeID = 1009

UPDATE SQLTute.dbo.EmployeeDetails
SET FirstName = 'Rocky'
WHERE EmployeeID = 1010 

DELETE FROM SQLTute.dbo.EmployeeDetails 
WHERE EmployeeID = 1010;



SELECT *
FROM SQLTute.dbo.EmployeeDetails


INSERT INTO SQLTute.DBO.EmployeeDetails(EmployeeID, FirstName, LastName, Gender)
VALUES(1010, 'Juan', 'Macky','Female')

INSERT INTO SQLTute.DBO.EmployeeDetails( FirstName, LastName, Age, Gender)
VALUES( 'Juan', 'Macky',24, 'Female')


SELECT * 
FROM SQLTute.dbo.EmployeeSalary

INSERT INTO SQLTute.dbo.EmployeeSalary( EmployeeID, JobTitle, Salary)
VALUES( 1010, 'IT Manager',24000)

INSERT INTO SQLTute.dbo.EmployeeSalary(  JobTitle, Salary)
VALUES(  'Business Manager',84000)



/*
    JOINS-- INNER/OUTER 
*/


SELECT *
FROM SQLTute.dbo.EmployeeDetails
INNER JOIN SQLTute.dbo.EmployeeSalary
		ON EmployeeDetails.EmployeeID = EmployeeSalary.EmployeeID


SELECT *
FROM SQLTute.dbo.EmployeeDetails
FULL OUTER JOIN SQLTute.dbo.EmployeeSalary
		ON EmployeeDetails.EmployeeID = EmployeeSalary.EmployeeID

SELECT *
FROM SQLTute.dbo.EmployeeDetails
LEFT OUTER JOIN SQLTute.dbo.EmployeeSalary
		ON EmployeeDetails.EmployeeID = EmployeeSalary.EmployeeID


SELECT *
FROM SQLTute.dbo.EmployeeDetails
RIGHT OUTER JOIN SQLTute.dbo.EmployeeSalary
		ON EmployeeDetails.EmployeeID = EmployeeSalary.EmployeeID


SELECT EmployeeDetails.EmployeeID, FirstName, LastName, JobTitle , Salary
FROM SQLTute.dbo.EmployeeDetails
INNER JOIN SQLTute.dbo.EmployeeSalary
		ON EmployeeDetails.EmployeeID = EmployeeSalary.EmployeeID
WHERE FirstName <> 'Ram'
ORDER BY Salary Desc

SELECT JobTitle , AVG(Salary)
FROM SQLTute.dbo.EmployeeDetails
INNER JOIN SQLTute.dbo.EmployeeSalary
		ON EmployeeDetails.EmployeeID = EmployeeSalary.EmployeeID
WHERE JobTitle = 'HR'
GROUP BY JobTitle


/*
  AS CLAUSE
*/


SELECT *
FROM SQLTute.dbo.EmployeeDetails AS Det
LEFT JOIN SQLTute.dbo.EmployeeSalary AS Sal
		ON Det.EmployeeID = Sal.EmployeeID

SELECT *
FROM SQLTute.dbo.EmployeeDetails AS Det
LEFT JOIN SQLTute.dbo.EmployeeSalary AS Sal
		ON Det.EmployeeID = Sal.EmployeeID



/*    
     UNION, UNION ALL
*/


CREATE TABLE SQLTute.dbo.ContractEmployee(
	EmployeeID int,
	FirstName varchar(50),
	LastName varchar(50),
	Age int,
	Gender varchar(50));

INSERT INTO SQLTute.dbo.ContractEmployee(EmployeeID, FirstName, LastName, Age, Gender)
VALUES (1050, 'Akshay', 'Dev', 61, 'Male')

INSERT INTO SQLTute.dbo.ContractEmployee(EmployeeID, FirstName, LastName, Age, Gender)
VALUES (1042, 'priya', 'Agrawal', 28, 'Female')

INSERT INTO SQLTute.dbo.ContractEmployee(EmployeeID, FirstName, LastName, Age, Gender)
VALUES (1050, 'Sakshi', 'Makhija', 36, 'Female')

INSERT INTO SQLTute.dbo.ContractEmployee(EmployeeID, FirstName, LastName, Age, Gender)
VALUES (1050, 'Shiv', 'Anand', 58, 'Male')

SELECT *
FROM SQLTute.dbo.EmployeeDetails
 
SELECT *
FROM SQLTute.dbo.ContractEmployee


SELECT *
FROM SQLTute.Dbo.EmployeeDetails
FULL OUTER JOIN SQLTute.dbo.ContractEmployee 
 ON EmployeeDetails.EmployeeID = ContractEmployee.EmployeeID

SELECT *
FROM SQLTute.dbo.EmployeeDetails
UNION 
SELECT *
FROM SQLTute.dbo.ContractEmployee


SELECT *
FROM SQLTute.dbo.EmployeeDetails
UNION ALL
SELECT *
FROM SQLTute.dbo.ContractEmployee
ORDER BY EmployeeID



/*
   CASE STATEMENT
*/


SELECT FirstName, LastName, Age,
CASE 
	WHEN Age > 30 THEN 'OLD'
	WHEN Age = 50 THEN 'OLDEST'        -- this would not work because the SQL returns the very first condition that follows.
	WHEN Age BETWEEN 26 AND 30 THEN 'YOUNG'
	ELSE 'NEWBIE'
END
FROM SQLTute.dbo.EmployeeDetails
ORDER BY Age




SELECT FirstName, LastName, JobTitle, Salary,
CASE 
	WHEN JobTitle = 'Salesman' THEN Salary + (Salary * .10)
	WHEN JobTitle = 'SalesAssociate' THEN Salary + (Salary * .20)
	WHEN JobTitle = 'SalesManager' THEN Salary + (Salary * .30)
	WHEN JobTitle = 'HR' THEN Salary + (Salary * .000001)
	ELSE Salary + (Salary * 0.03)
END AS SalaryAfterAppraisal
FROM SQLTute.dbo.EmployeeDetails
JOIN SQLTute.dbo.EmployeeSalary
	ON EmployeeDetails.EmployeeID = EmployeeSalary.EmployeeID


/*
     Having Clause
*/


SELECT JobTitle , Count(JobTitle)
FROM SQLTute.dbo.EmployeeDetails
JOIN SQLTute.dbo.EmployeeSalary
		ON EmployeeDetails.EmployeeID = EmployeeSalary.EmployeeID
Group By JobTitle
HAVING COUNT(JobTitle) > 1


SELECT JobTitle , AVG(Salary)
FROM SQLTute.dbo.EmployeeDetails
JOIN SQLTute.dbo.EmployeeSalary
		ON EmployeeDetails.EmployeeID = EmployeeSalary.EmployeeID
Group By JobTitle
HAVING AVG(Salary) >45000
ORDER BY AVG(Salary)


/*
    PARTITION BY
*/

SELECT FirstName, LastName, Gender, Salary,
COUNT(Gender) OVER (PARTITION BY Gender) as TotalGender
FROM SQLTute.dbo.EmployeeDetails det
JOIN SQLTute.dbo.EmployeeSalary sal
	ON det.EmployeeID = sal.EmployeeID

