-- Active: 1708549946789@@127.0.0.1@3306@SoftwareDB
-- 1
SELECT FName, LName
FROM Person, Employee
WHERE 
PersonID = EmpID;

-- 2
SELECT Name
FROM SoftwareProduct;
-- 3
SELECT Person.FName, Person.LName, Employee.Salary
FROM Person 
JOIN Employee on Person.PersonID = Employee.EmpID
WHERE Employee.Salary  > 60000;

-- 5
SELECT Person.FName, Person.LName 
FROM Person
JOIN SoftwareProduct on Person.PersonID = SoftwareProduct.EmpID;

-- 6
SELECT Person.FName, Person.LName, Employee.Salary
FROM Person
JOIN SoftwareProduct on Person.PersonID = SoftwareProduct.EmpID
JOIN Employee on Person.PersonID = Employee.EmpID;

-- 7
SELECT Person.FName, Person.LName, Employee.Salary, SoftwareProduct.Name 
FROM Person
JOIN SoftwareProduct on Person.PersonID = SoftwareProduct.EmpID
JOIN Employee on Person.PersonID = Employee.EmpID
WHERE Employee.Salary < 60000;

-- 8
SELECT Person.FName, Person.LName, SoftwareProduct.Name, Client.FirstContactDate
FROM Person
JOIN Client on Person.PersonID = Client.ClientID
JOIN `UsesProduct` on Client.ClientID = UsesProduct.`ClientID`
JOIN `SoftwareProduct` on `UsesProduct`.SoftwareID = SoftwareProduct.`SoftwareID`
WHERE Client.`FirstContactDate` < '2010-10-10';

-- 9
SELECT Person.FName, Person.LName, SoftwareProduct.Name, Client.FirstContactDate
FROM Person
JOIN Client on Person.PersonID = Client.ClientID
JOIN `UsesProduct` on Client.ClientID = UsesProduct.`ClientID`
JOIN `SoftwareProduct` on `UsesProduct`.SoftwareID = SoftwareProduct.`SoftwareID`
WHERE Client.`FirstContactDate` < '2010-10-10' OR Client.`FirstContactDate` > '2011-01-01';

-- 10
SELECT Person.FName, Person.LName, Employee.Salary
FROM Person
JOIN Employee on Person.PersonID = Employee.EmpID
ORDER BY Employee.Salary;

-- 11
SELECT AVG(Employee.Salary) AS 'Average Salary'
FROM `Employee`
WHERE Employee.EmpID IN 
(
	SELECT SoftwareProduct.EmpID
	FROM SoftwareProduct
);

-- 12
SELECT AVG(Employee.Salary) AS 'Average Salary'
FROM `Employee`
WHERE Employee.EmpID IN 
(
	SELECT UsesProduct.`PtOfContact_EmpID`
	FROM `UsesProduct`
	JOIN `SoftwareProduct` ON `UsesProduct`.`SoftwareID` = SoftwareProduct.`SoftwareID`
	WHERE `SoftwareProduct`.Name = 'Stellar Teller'
);

-- 13
SELECT ServicePlan.`ServiceLevel`, COUNT(UsesProduct.PlanID) AS count
FROM ServicePlan
LEFT JOIN UsesProduct ON ServicePlan.PlanID = UsesProduct.PlanID
GROUP BY ServicePlan.`ServiceLevel`;

-- Stretch Goals
-- 14...only returns 2 rows because there are not any Software Products with a 2.0 version number
SELECT SoftwareProduct.CurrVersionNum, MAX(Employee.Salary) AS Salary
FROM SoftwareProduct
JOIN WorkingOn ON SoftwareProduct.SoftwareID = WorkingOn.SoftwareID
JOIN Employee ON WorkingOn.EmpID = Employee.EmpID
WHERE SoftwareProduct.CurrVersionNum IN ('1.00', '2.00', '3.00')
GROUP BY SoftwareProduct.CurrVersionNum;
