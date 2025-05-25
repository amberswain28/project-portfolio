-- Active: 1708549946789@@127.0.0.1@3306@SoftwareDB
--Amber Swain 
-- PUnetID: swai8439

-- 1
CREATE OR REPLACE PROCEDURE query1 ()
READS SQL DATA
BEGIN
	SELECT FName, LName
	FROM `Person`, Employee
	WHERE Person.PersonID = Employee.`EmpID`;
END;
CALL query1();

-- 2
CREATE OR REPLACE PROCEDURE query2 (VALUE INT)
READS SQL DATA
BEGIN
	SELECT FName, LName, Salary
	FROM `Person`, Employee
	WHERE Person.PersonID = Employee.`EmpID`
	AND Salary > VALUE;
END;
CALL query2(60000);

-- 3
CREATE OR REPLACE PROCEDURE query3 (VERSION DECIMAL(3,2), LETTER CHARACTER)
READS SQL DATA
BEGIN
	SELECT Name
	FROM `SoftwareProduct`
	WHERE `CurrVersionNum` > VERSION
	AND Name LIKE CONCAT(Letter, '%');
END;
CALL query3(1.0, 'S');

-- 4
CREATE OR REPLACE PROCEDURE query4 (DATE DATE)
READS SQL DATA 
BEGIN 
	SELECT FName, LName, Name, FirstContactDate
	FROM Person, SoftwareProduct, Client, UsesProduct
	WHERE Person.`PersonID` = Client.`ClientID`
	AND Client.ClientID = UsesProduct.`ClientID`
	AND UsesProduct.`SoftwareID` = SoftwareProduct.`SoftwareID`
	AND `FirstContactDate` < DATE
	ORDER BY
		Client.`ClientID`;
END;

CALL query4('2010-10-10');
-- 5
CREATE OR REPLACE PROCEDURE query5 (DATEONE DATE, DATETWO DATE)
READS SQL DATA 
BEGIN 
	SELECT FName, LName, Name, FirstContactDate AS StartDate
	FROM Person, SoftwareProduct, Client, UsesProduct
	WHERE Person.`PersonID` = Client.`ClientID`
	AND Client.ClientID = UsesProduct.`ClientID`
	AND UsesProduct.`SoftwareID` = SoftwareProduct.`SoftwareID`
	AND (`FirstContactDate` < DATEONE OR `FirstContactDate` >= DATETWO)
	ORDER BY
		Client.`ClientID`;
END;
CALL query5('2010-10-10', '2011-01-01');

-- 6
CREATE OR REPLACE PROCEDURE query6 (PRODUCT VARCHAR(150))
READS SQL DATA 
BEGIN 
	SELECT AVG(Salary) as AverageSalary
	FROM Employee, SoftwareProduct, UsesProduct
	WHERE Employee.EmpID = UsesProduct.`PtOfContact_EmpID`
	AND `UsesProduct`.SoftwareID = SoftwareProduct.`SoftwareID`
	AND `SoftwareProduct`.Name = PRODUCT;
END;
CALL query6('Stellar Teller');

-- 7
CREATE OR REPLACE PROCEDURE query7 ()
READS SQL DATA 
BEGIN 
	SELECT `CurrVersionNum`, MAX(Salary)
	FROM Employee, SoftwareProduct, WorkingOn
	WHERE Employee.EmpID = WorkingOn.`EmpID`
	AND WorkingOn.`SoftwareID` = SoftwareProduct.`SoftwareID`
	AND CurrVersionNum IN (1.0, 2.0, 3.0)
	GROUP BY
		`CurrVersionNum`;
END;
CALL query7();

-- 8
CREATE OR REPLACE PROCEDURE query8()
READS SQL DATA 
BEGIN
	SELECT ServiceLevel, COUNT(*) AS Count
	FROM `UsesProduct`, `ServicePlan`
	WHERE `UsesProduct`.PlanID = ServicePlan.`PlanID`
	GROUP BY `ServiceLevel`;
END;
CALL query8();

-- 9
CREATE OR REPLACE PROCEDURE query9 (Level VARCHAR(50))
READS SQL DATA 
BEGIN
	SELECT FName, LName 
	FROM Person, Client, UsesProduct
	WHERE Person.PersonID = Client.`ClientID`
	AND Client.ClientID = UsesProduct.`ClientID`
	AND Client.ClientID NOT IN (
		SELECT Client.ClientID
		FROM Person, Client, UsesProduct, ServicePlan
		WHERE Person.PersonID = Client.`ClientID`
		AND Client.ClientID = UsesProduct.`ClientID`
		AND `UsesProduct`.PlanID = ServicePlan.`PlanID`
		AND ServiceLevel = Level);
	END;

	CALL query9('Gold');


CREATE OR REPLACE FUNCTION ReturnEmpID (FirstName VARCHAR(50), LastName VARCHAR (50))
RETURNS int(11)
BEGIN
	DECLARE EmployeeID int(11);
	SELECT EmpID INTO EmployeeID
	FROM Person, Employee
	WHERE Person.PersonID = Employee.`EmpID`
	AND Person.`FName` = FirstName
	AND Person.`LName` = LastName;
	RETURN EmployeeID;
	END;
SELECT ReturnEmpID('Oscar', 'Cox');
CREATE OR REPLACE FUNCTION ReturnSoftwareID (SName VARCHAR(50))
RETURNS int(11)
BEGIN
	DECLARE SID int(11);
	SELECT SoftwareID INTO SID
	FROM `SoftwareProduct`
	WHERE `SoftwareProduct`.Name = SName;
	RETURN SID;
	END;
SELECT ReturnSoftwareID('Word Precise');

CREATE OR REPLACE PROCEDURE InsertEmployee (FirstName VARCHAR(50), LastName VARCHAR(50), 
																		PhoneNumber VARCHAR(30), EmpEmail VARCHAR (150), EmpSalary int(9)) 
BEGIN
	INSERT INTO Person (FName, LName, PhoneNum, Email)
			VALUES (FirstName, LastName, PhoneNumber, EmpEmail);
	INSERT INTO Employee (EmpID, Salary) 
	VALUES ((SELECT PersonID FROM Person 
					WHERE Person.FName = FirstName AND Person.LName = LastName), EmpSalary);
END;

CREATE OR REPLACE PROCEDURE InsertSoftware (SName VARCHAR (50), VersionNum DECIMAL(3,2), 
																		FirstName VARCHAR(50), LastName VARCHAR(50))
BEGIN
	INSERT INTO `SoftwareProduct` (Name, `CurrVersionNum`, EmpID)
			VALUES (SName, VersionNum,
							(SELECT PersonID FROM Person 
							WHERE Person.FName = FirstName AND Person.LName = LastName));
END;

CREATE OR REPLACE PROCEDURE InsertWorksOn (EmployeeID int(11), SoftID int(11))
	BEGIN
	INSERT INTO WorkingOn (SoftwareID, EmpID) VALUES (SoftID, EmployeeID);
	END;

