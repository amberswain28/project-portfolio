-- Active: 1708549946789@@127.0.0.1@3306@Lectures
CREATE DATABASE Lectures;
USE Lectures;
CREATE OR REPLACE TABLE Employee(
	EmpID int(11) NOT NULL AUTO_INCREMENT,
	Fname varchar(50) DEFAULT NULL,
	Lname VARCHAR(50) DEFAULT NULL,
	DOB DATE NOT NULL,
	Email varchar(150) DEFAULT NULL,
	CONSTRAINT Employee_PK PRIMARY KEY (EmpID),
	CONSTRAINT Employee_Email_U UNIQUE(Email)
) Engine = InnoDB CHARACTER SET=utf8 COLLATE=utf8_bin;

INSERT INTO `Employee` (`Fname`, `Lname`, `DOB`, `Email`)
VALUES ('Shrek', 'Swain', '2000-05-10', 'shrek@gmail.com');
INSERT INTO `Employee` (`Fname`, `Lname`, `DOB`, `Email`)
VALUES ('Donkey', 'Swain', '2003-05-10', 'donkey@gmail.com');

CREATE OR REPLACE TABLE Department(
	DID int(11) AUTO_INCREMENT PRIMARY KEY,
	Name varchar(25) DEFAULT NULL,
	Budget int(11) NOT NULL DEFAULT 0
)Engine = InnoDB CHARACTER SET=utf8 COLLATE=utf8_bin;

CREATE OR REPLACE TABLE WorksIn(
	DID int(11) AUTO_INCREMENT,
	EmpID int(11) NOT NULL,
	StartedOnDate DATE NOT NULL,
	CONSTRAINT WorksIn_PK PRIMARY KEY (DID, EmpID),
	CONSTRAINT WorksIn_DID_FK FOREIGN KEY (DID) REFERENCES Department(DID),
	CONSTRAINT WorksIn_EmpID_FK FOREIGN KEY (EmpID) REFERENCES Employee(EmpID)
)Engine = InnoDB CHARACTER SET=utf8 COLLATE=utf8_bin;

INSERT INTO `Department` (`Name`) VALUES ('billing');
INSERT INTO `Department` (`Name`) VALUES ('IT');

INSERT INTO `WorksIn` (`DID`, `EmpID`, `StartedOnDate`) VALUES ('1','2', '2004-02-14');

SELECT * FROM `WorksIn`;

-- Plain arrow form Employee to WorksIn
CREATE OR REPLACE TABLE EmployeePlainArrow(
	EmpID int(11) NOT NULL AUTO_INCREMENT,
	Fname varchar(50) DEFAULT NULL,
	Lname VARCHAR(50) DEFAULT NULL,
	DOB DATE NOT NULL,
	Email varchar(150) DEFAULT NULL,
	DID int(11) NULL,
	StartedOnDate DATE DEFAULT NULL,
	CONSTRAINT Employee_PK PRIMARY KEY (EmpID),
	CONSTRAINT Employee_Email_U UNIQUE(Email),
	CONSTRAINT Employee_DID_PK FOREIGN KEY (DID) REFERENCES Department (DID)
) Engine = InnoDB CHARACTER SET=utf8 COLLATE=utf8_bin;

-- Bold Arrow from Employee to WorksIn
CREATE OR REPLACE TABLE EmployeeBoldArrow(
	EmpID int(11) NOT NULL AUTO_INCREMENT,
	Fname varchar(50) DEFAULT NULL,
	Lname VARCHAR(50) DEFAULT NULL,
	DOB DATE NOT NULL,
	Email varchar(150) DEFAULT NULL,
	DID int(11) NOT NULL,
	StartedOnDate DATE NOT NULL,
	CONSTRAINT EmployeeBoldArrow_PK PRIMARY KEY (EmpID),
	CONSTRAINT EmployeeBoldArrow_Email_U UNIQUE(Email),
	CONSTRAINT EmployeeBoldArrow_DID_PK FOREIGN KEY (DID) REFERENCES Department (DID)
) Engine = InnoDB CHARACTER SET=utf8 COLLATE=utf8_bin;

CREATE OR REPLACE TABLE Locations(
	LocID int(11) NOT NULL AUTO_INCREMENT,
	LocName varchar(100) DEFAULT NULL,
	CONSTRAINT Loacations_PK PRIMARY KEY (LocID)
) Engine = InnoDB CHARACTER SET=utf8 COLLATE=utf8_bin;

CREATE OR REPLACE TABLE PresentAt(
	LocID int(11) NOT NULL AUTO_INCREMENT,
	DeptID int(11) NOT NULL AUTO_INCREMENT,
	CONSTRAINT PresentAt_PK PRIMARY KEY (LocID, DeptID),
	CONSTRAINT PresentAt_LocID_FK FOREIGN KEY (LocID) REFERENCES Locations(LocID),
) Engine = InnoDB CHARACTER SET=utf8 COLLATE=utf8_bin;
