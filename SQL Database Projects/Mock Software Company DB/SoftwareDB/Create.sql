-- Active: 1708549946789@@127.0.0.1@3306@SoftwareDB

DROP DATABASE IF EXISTS SoftwareDB;

CREATE DATABASE SoftwareDB;
USE SoftwareDB;

CREATE OR REPLACE TABLE Person (
	PersonID int(11) NOT NULL AUTO_INCREMENT,
	FName varchar(50),
	LName varchar(50),
	PhoneNum varchar(30),
	Email varchar(150),
	CONSTRAINT Person_PK PRIMARY KEY (PersonID),
	CONSTRAINT Person_Email_U UNIQUE (Email)
) Engine = InnoDB CHARACTER SET=utf8 COLLATE=utf8_bin;

CREATE OR REPLACE TABLE Client (
	ClientID int(11),
	FirstContactDate DATE,
	CONSTRAINT Client_ClientID_FK FOREIGN KEY (ClientID) REFERENCES Person(PersonID),
	CONSTRAINT ClientID_PK PRIMARY KEY (ClientID)
) Engine = InnoDB CHARACTER SET=utf8 COLLATE=utf8_bin;

CREATE OR REPLACE TABLE Employee (
	EmpID int(11),
	Salary int(9),
	CONSTRAINT Employee_EmpID_FK FOREIGN KEY (EmpID) REFERENCES Person(PersonID),
	CONSTRAINT EmpID_PK PRIMARY KEY (EmpID)
) Engine = InnoDB CHARACTER SET=utf8 COLLATE=utf8_bin;

CREATE OR REPLACE TABLE SoftwareProduct (
	SoftwareID int(11) NOT NULL AUTO_INCREMENT,
	Name varchar(150),
	CurrVersionNum DECIMAL(3,2),
	EmpID int(11) NOT NULL,
	Dependencies varchar(150) DEFAULT NULL,
	CONSTRAINT SoftwareProduct_Name_U UNIQUE (Name),
	CONSTRAINT SoftwareID_PK PRIMARY KEY (SoftwareID),
	CONSTRAINT SoftwarreProduct_EmpID_FK FOREIGN KEY (EmpID) REFERENCES Employee(EmpID)
) Engine = InnoDB CHARACTER SET=utf8 COLLATE=utf8_bin;

CREATE OR REPLACE TABLE WorkingOn (
SoftwareID int(11) NOT NULL,
EmpID int(11) NOT NULL,
CONSTRAINT WorkingOn_PK PRIMARY KEY (SoftwareID, EmpID),
CONSTRAINT WorkingOn_SoftwareID_FK FOREIGN KEY (SoftwareID) REFERENCES SoftwareProduct(SoftwareID),
CONSTRAINT WorkingOn_EmpID_FK FOREIGN KEY (EmpID) REFERENCES Employee(EmpID)
) Engine = InnoDB CHARACTER SET=utf8 COLLATE=utf8_bin;

CREATE OR REPLACE TABLE ServicePlan (
	PlanID int(11) NOT NULL AUTO_INCREMENT,
	Cost int(12) NOT NULL,
	ServiceLevel varchar(50) NOT NULL,
	CONSTRAINT ServicePlan_PK PRIMARY KEY (PlanID)
) Engine = InnoDB CHARACTER SET=utf8 COLLATE=utf8_bin;

-- UsesProduct table also contains PointOfContact relationship and BuysServicePlan
CREATE OR REPLACE TABLE UsesProduct (
	ClientID int(11) NOT NULL,
	SoftwareID int(11) NOT NULL,
	PtOfContact_EmpID int(11) NOT NULL,
	PlanID int(11) DEFAULT NULL,
	CONSTRAINT UsesProduct_PK PRIMARY KEY (ClientID, SoftwareID, PtOfContact_EmpID),
	CONSTRAINT PlanID_FK FOREIGN KEY (PlanID) REFERENCES ServicePlan(PlanID),
	CONSTRAINT UsesProduct_ClientID_FK FOREIGN KEY (ClientID) REFERENCES Client(ClientID),
	CONSTRAINT UsesProduct_PtOfContact_EmpID_FK FOREIGN KEY (PtOfContact_EmpID) REFERENCES Employee(EmpID),
	CONSTRAINT UsesProduct_SoftwareID_FK FOREIGN KEY (SoftwareID) REFERENCES SoftwareProduct(SoftwareID)
) Engine = InnoDB CHARACTER SET=utf8 COLLATE=utf8_bin;

CREATE OR REPLACE TABLE Dependent(
	ParentID int(11) NOT NULL,
	ChildID int(11) NOT NULL,
	CONSTRAINT Dependent_PK PRIMARY KEY (ParentID, ChildID),
	CONSTRAINT ParentID_FK FOREIGN KEY (ParentID) REFERENCES SoftwareProduct(EmpID)
	) Engine = InnoDB CHARACTER SET=utf8 COLLATE=utf8_bin;

ALTER TABLE `Dependent` ADD CONSTRAINT ChildID_FK FOREIGN KEY (ChildID) REFERENCES SoftwareProduct(EmpID)