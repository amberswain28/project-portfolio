-- ------------------------------------------------------------------------------
-- File: 		CreateDatabase.sql
-- Author:	Chadd Williams
-- Date: 		9/15/2011
-- Class:		CS445
-- Purpose:	Build a database for use in class to demonstrate SQL commands
-- ------------------------------------------------------------------------------

-- comment out the following lines because students cannot
-- make databases on the public server

drop database if exists IntroSQL;
create database IntroSQL;

drop table if exists `CurrentlyEnrolled`;


use IntroSQL;

drop table if exists CurrentlyEnrolled;
drop table if exists CurrentlyTeaching;
drop table if exists Courses;
drop table if exists Students;
drop table if exists Professors;
drop table if exists People;
CREATE TABLE People (
	PersonID INT NOT NULL AUTO_INCREMENT,
	FName VARCHAR(50),
	LName VARCHAR(50),
	Login VARCHAR(20) NOT NULL,
	CONSTRAINT People_PersonID_PK PRIMARY KEY (PersonID),
	CONSTRAINT People_Login_U UNIQUE (Login)
) Engine=InnoDB  CHARACTER SET = utf8 COLLATE = utf8_bin;


CREATE TABLE Students (
	StudentID INT NOT NULL,
	GPA FLOAT DEFAULT 0.0,
	INDEX Students_GPA_IDX (GPA),
	CONSTRAINT Students_StudentID_PK PRIMARY KEY (StudentID),
	CONSTRAINT Students_StudentID_FK FOREIGN KEY (StudentID) 
		REFERENCES People(PersonID) ON DELETE CASCADE
) Engine=InnoDB;

CREATE TABLE Professors (
	ProfID INT NOT NULL,
	Rank ENUM ('Assistant', 'Associate', 'Full', 'Emeritus') NOT NULL,
	CONSTRAINT Professors_ProfID_PK PRIMARY KEY (ProfID),
	CONSTRAINT Professors_ProfID_FK FOREIGN KEY (ProfID) 
		REFERENCES People(PersonID) ON DELETE CASCADE
) Engine=InnoDB;

CREATE TABLE Courses (
	CourseID INT NOT NULL AUTO_INCREMENT,
	Title VARCHAR(50),
	MaxSize INT DEFAULT 24,
	CONSTRAINT Courses_CourseID_PK PRIMARY KEY (CourseID)
) Engine=InnoDB;



CREATE TABLE CurrentlyEnrolled (
	CourseID INT NOT NULL,
	StudentID INT NOT NULL,
	Grade FLOAT DEFAULT 100.0,
	CONSTRAINT CurrentlyEnrolled_CourseIDStudentID_PK PRIMARY KEY 
		(CourseID, StudentID),
	INDEX CurrentlyEnrolled_StudentID_IDX (StudentID),
	INDEX CurrentlyEnrolled_Grade_IDX (Grade),
	CONSTRAINT CurrentlyEnrolled_StudentID_FK FOREIGN KEY (StudentID) REFERENCES Students(StudentID) ON DELETE CASCADE,
	CONSTRAINT CurrentlyEnrolled_CourseID_FK FOREIGN KEY (CourseID) REFERENCES Courses(CourseID) ON DELETE CASCADE,
	CONSTRAINT CurrentlyEnrolled_ValidGrade_CC CHECK (Grade >= 0 AND Grade <= 100)
) Engine=InnoDB;

	
CREATE TABLE CurrentlyTeaching (
	CourseID INT NOT NULL,
	ProfID INT NOT NULL,
	Section INT NOT NULL,
	CONSTRAINT CurrentlyTeaching_CourseIDProfID_PK PRIMARY KEY 
		(CourseID, ProfID),
	INDEX CurrentlyTeaching_ProfID_IDX (ProfID),
	CONSTRAINT CurrentlyTeaching_CourseID_FK FOREIGN KEY (CourseID) 
		REFERENCES Courses(CourseID) ON DELETE CASCADE,
	CONSTRAINT CurrentlyTeaching_ProfID_FK FOREIGN KEY (ProfID) 
		REFERENCES Professors(ProfID) ON DELETE CASCADE,
	CONSTRAINT CurrentlyTeaching_CourseIDSection_U UNIQUE (CourseID, Section) 	
) Engine=InnoDB;


INSERT INTO People (  FName, LName, Login) VALUES ( "Chadd", "Williams","chadd"); --  1
INSERT INTO Professors (ProfID, Rank) VALUES (1, 'Associate');

INSERT INTO People (  FName, LName, Login) VALUES ( "Doug", "Ryan","ryand");
INSERT INTO Professors (ProfID, Rank) VALUES (2, 'Full');

INSERT INTO People (  FName, LName, Login) VALUES ("Shereen", "Khoja","shereen");
INSERT INTO Professors (ProfID, Rank) VALUES (3, 'Associate');

INSERT INTO People (  FName, LName, Login) VALUES ("Edna", "Krabappel","krab");
INSERT INTO Professors (ProfID, Rank) VALUES (4, 'Emeritus');


INSERT INTO People (  FName, LName, Login) VALUES ("Bart", "Simpson","bart"); -- 5
INSERT INTO Students (StudentID, GPA) VALUES (5,0.1);

INSERT INTO People (  FName, LName, Login) VALUES ("Maggie", "Simpson","maggie");
INSERT INTO Students (StudentID) VALUES (6);

INSERT INTO People (  FName, LName, Login) VALUES ("Lisa", "Simpson","lisa");
INSERT INTO Students (StudentID, GPA) VALUES (7, 4.0);

INSERT INTO People (  FName, LName, Login) VALUES ("Homer", "Simpson","homer");
INSERT INTO Students (StudentID, GPA) VALUES (8, 1.0);

INSERT INTO People (  FName, LName, Login) VALUES ("Marge", "Simpson","marge");
INSERT INTO Students (StudentID, GPA) VALUES (9, 2.9);

INSERT INTO People (  FName, LName, Login) VALUES ("Grandpa", "Simpson","onion"); -- 10
INSERT INTO Students (StudentID, GPA) VALUES (10, 3.89);

INSERT INTO People (  FName, LName, Login) VALUES ("Krusty", "Clown","krusty");
INSERT INTO Students (StudentID, GPA) VALUES (11, 1.2);

INSERT INTO People (  FName, LName, Login) VALUES ("Comic", "BookGuy","jeff");
INSERT INTO Students (StudentID, GPA) VALUES (12, 3.99);

INSERT INTO People (  FName, LName, Login) VALUES ("Disco", "Stu","leisure");
INSERT INTO Students (StudentID, GPA) VALUES (13, 1.973);

INSERT INTO People (  FName, LName, Login) VALUES ("Nick", "Riviera","everybody");
INSERT INTO Students (StudentID, GPA) VALUES (14, 1.823);

INSERT INTO People (  FName, LName, Login) VALUES ("Otto", "Mann","fing"); -- 15
INSERT INTO Students (StudentID, GPA) VALUES (15, 0.42);


INSERT INTO Courses (CourseID, Title) VALUES (NULL, "CS150 Intro to Computer Science" ); -- 1
INSERT INTO Courses (CourseID, Title) VALUES (NULL, "CS250 Intro to Computer Science II" ); -- 2
INSERT INTO Courses (CourseID, Title, MaxSize) VALUES (NULL, "CS300 Datastructures" , 15); -- 3
INSERT INTO Courses (CourseID, Title, MaxSize) VALUES (NULL, "CS445 Databases", 5 ); -- 4
INSERT INTO Courses (CourseID, Title, MaxSize) VALUES (NULL, "CS493 Software Engineering", 3 ); -- 5


INSERT INTO CurrentlyEnrolled (CourseID, StudentID, Grade) VALUES (1,5,85);
INSERT INTO CurrentlyEnrolled (CourseID, StudentID, Grade) VALUES (1,6,100);
INSERT INTO CurrentlyEnrolled (CourseID, StudentID) VALUES (1,7);
INSERT INTO CurrentlyEnrolled (CourseID, StudentID, Grade) VALUES (1,8,88);

INSERT INTO CurrentlyEnrolled (CourseID, StudentID, Grade) VALUES (4,15,85);
INSERT INTO CurrentlyEnrolled (CourseID, StudentID, Grade) VALUES (4,14,32);
INSERT INTO CurrentlyEnrolled (CourseID, StudentID) VALUES (4,13);
INSERT INTO CurrentlyEnrolled (CourseID, StudentID, Grade) VALUES (4,12,99);
INSERT INTO CurrentlyEnrolled (CourseID, StudentID, Grade) VALUES (4,11,78);

INSERT INTO CurrentlyEnrolled (CourseID, StudentID) VALUES (5,13);
INSERT INTO CurrentlyEnrolled (CourseID, StudentID, Grade) VALUES (5,12,98);
INSERT INTO CurrentlyEnrolled (CourseID, StudentID, Grade) VALUES (5,11,78);


INSERT INTO CurrentlyEnrolled (CourseID, StudentID) VALUES (3,9);
INSERT INTO CurrentlyEnrolled (CourseID, StudentID, Grade) VALUES (3,11,78);


INSERT INTO CurrentlyTeaching (CourseID, ProfID, Section) VALUES (1, 3, 1);
INSERT INTO CurrentlyTeaching (CourseID, ProfID, Section) VALUES (1, 2, 2);
INSERT INTO CurrentlyTeaching (CourseID, ProfID, Section) VALUES (2, 1, 1);
INSERT INTO CurrentlyTeaching (CourseID, ProfID, Section) VALUES (3, 1, 2);
INSERT INTO CurrentlyTeaching (CourseID, ProfID, Section) VALUES (5, 2, 1);
