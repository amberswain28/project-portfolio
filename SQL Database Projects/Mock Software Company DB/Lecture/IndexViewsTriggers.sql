-- Active: 1708549946789@@127.0.0.1@3306@IntroSQL


-- 1
SELECT FName, LName, Title
FROM People, Students, `CurrentlyEnrolled`, `Courses`
WHERE People.PersonID=Students.StudentID
AND `Students`.`StudentID`=`CurrentlyEnrolled`.`StudentID`
AND `CurrentlyEnrolled`.`CourseID`=Courses.`CourseID`
AND Grade < 80;

-- 2
EXPLAIN SELECT FName, LName, Title
FROM  People, Students, `CurrentlyEnrolled`, `Courses`
WHERE People.PersonID=Students.StudentID
AND `Students`.`StudentID`=`CurrentlyEnrolled`.`StudentID`
AND `CurrentlyEnrolled`.`CourseID`=Courses.`CourseID`
AND Grade < 80;
/*
2.1: If you multiply all of the rows that it outputs, you get the value 5, which is not a bad time/efficiency
2.2: the table Courses is accessed with type ALL
2.3: Courses was type ALL because the query involved going through all of the courses 
			and their grades so it had to go through every row so it can take it's course ID and output it's title
2.4: It accesses Courses, then CurrentlyEnrolled, then Students, then People
2.5: Students's index is used, which is StudentID
2.6: Courses Type: ALL  ~ this means that the program had to scan the entire table to find matching rows
			CurrentlyEnrolled Type: ref ~  for each combination of rows from previous tables, the program needs to 
			scan through the indexed table to find all rows that match each combo, so for each combination of Courses and CourseID,
			CurrentlyEnrolled is read for any rows that match each combination, and there may be repeats
			Students Type: eq_ref ~ same thing as ref except that it only needs to match each combination of rows 
											to one matching row in the refernced table; for each combo of rows from `CurrentlyEnrolled` and StudentID, 
											it is only compared to one row from Students
			People Type: eq_ref ~ same as previous except instead of Students it is with the People table
*/
/* Side note: a non-unique index is multiple rows in the 
		table can have the same value for the indexed column(s) 
		combination of row - the process of pairing or associating each 
		row from one table with every row from another table based on certain conditions*/

-- 3
SELECT FName, LName, Grade, CourseID
FROM  People, Students, `CurrentlyEnrolled`
WHERE People.PersonID=Students.StudentID
AND `Students`.`StudentID`=`CurrentlyEnrolled`.`StudentID`
AND Grade < 80;

-- 4
EXPLAIN SELECT FName, LName, Grade, CourseID
FROM  People, Students, `CurrentlyEnrolled`
WHERE People.PersonID=Students.StudentID
AND `Students`.`StudentID`=`CurrentlyEnrolled`.`StudentID`
AND Grade < 80;
/*
4.0: Students and People keep the same "eq_ref" type, Courses is not used, and CurrentlyEnrolled type is now ALL; 
			"using where" is again on CurrentlyEnrolled and "using index" is again on Students
4.1: 14, which is a much worse effeciency than the previous query
4.2: CurrentlyEnrolled
4.3: Because it had to read through each row that matched the conditions given 
		in our query and it was the table that had all of the important columns that
		 we needed to compare including, Grade, StudentID, and CourseID. Each row of these combinations
		 was what we needed
4.4: CurrentlyEnrolled, Students, People
4.5: Students
4.6: CurrentlyEnrolled Type: ALL ~ we needed to read through all of the rows because each one was a
			combination of StudentID, Grade, and CourseID that we needed for the query to then compare the grade
			Students Type: eq_ref ~ for each combination of rows from `CurrentlyEnrolled`, it only needed to 
			match it to one row in Students
			People Type: eq_ref ~ for each combination of rows from `CurrentlyEnrolled`, it only needed to 
			match it to one row in People to get the first and last name



*/

-- 5
SELECT FName, LName, Grade, CourseID
FROM People, Students, `CurrentlyEnrolled`
WHERE People.PersonID=Students.StudentID
AND `Students`.`StudentID`=`CurrentlyEnrolled`.`StudentID`
AND Grade < 80
AND GPA > 2.0;

-- 6
EXPLAIN SELECT FName, LName, Grade, CourseID
FROM People, Students, `CurrentlyEnrolled`
WHERE People.PersonID=Students.StudentID
AND `Students`.`StudentID`=`CurrentlyEnrolled`.`StudentID`
AND Grade < 80
AND GPA > 2.0;
/*
6.0: It shows the same tables in the same order and the rows multiplied together is the same(14)
6.1: Students is marked as "using where" instead of "using index"
6.2: "using where" is also in the Students column because "using where" means that 
it is using that table to complete the WHERE clause and with this query, we also needed to grab the students
GPA for the WHERE clause which is in the Students table
*/

-- 7
/*
added this line into CurrentlyEnrolled: INDEX CurrentlyEnrolled_Grade_IDX (Grade)
*/


-- 8
EXPLAIN SELECT FName, LName, Grade, CourseID
FROM  People, Students, `CurrentlyEnrolled`
WHERE People.PersonID=Students.StudentID
AND `Students`.`StudentID`=`CurrentlyEnrolled`.`StudentID`
AND Grade < 80;
/*
8.0: It outputs the same tables in the same order(CurrentlyEnrolled, Students, People), 
the ref column paths are the same
8.1: CurrentlyEnrolled now has a "using index" note alongside it already saying "using where",
the type for CurrentlyEnrolled is range, the product of the rows multiplied together is 
now 4 and in teh possible_keys column, alongside CurrentlyEnrolled_StudentID_IDX is now 
CurrentlyEnrolled_Grade_IDX
8.2: Yes 
8.3: Becuase it allowed the program to access less rows which improved the overall proficiency,
especially becuase we are dealing with a smaller data set. By having the "range" type, only rows 
that are in a given range are retrieved, using an index to select the rows. 
*/

-- 9
/*
added the following line into Students: INDEX Students_GPA_IDX (GPA)
*/

-- 10
EXPLAIN SELECT FName, LName, Grade, CourseID
FROM People, Students, `CurrentlyEnrolled`
WHERE People.PersonID=Students.StudentID
AND `Students`.`StudentID`=`CurrentlyEnrolled`.`StudentID`
AND Grade < 80
AND GPA > 2.0;
/*
10.0: It outputs the same tables in the same order(CurrentlyEnrolled, Students, People), 
the ref column paths are the same
10.1: CurrentlyEnrolled now has a "using index" note alongside it already saying "using where",
the type for CurrentlyEnrolled is range, the product of the rows multiplied together is 
now 4, and in the possible_keys column, alongside PRIMARY as a possible one is Students_GPA_IDX
10.2: Yes
10.3: It was helpful because it was able to maintain the same product of multiplying the rows
together, which was 4, and was also able to offer up another possible_key, which can be helpful
if you want to make sure that each key is unique
*/

-- 11
-- VIEW that contains all of the Students(StudentID, FName,LName, Login, GPA)
CREATE VIEW AllStudents_VW AS
SELECT StudentID, FName, LName, Login, GPA 
FROM Students, People
WHERE People.PersonID = Students.StudentID

-- 12
SELECT FName, LName, Grade, CourseID
FROM `AllStudents_VW`, `CurrentlyEnrolled`
WHERE `AllStudents_VW`.StudentID = CurrentlyEnrolled.`StudentID`
AND Grade < 80
AND GPA > 2.0;

EXPLAIN SELECT FName, LName, Grade, CourseID
FROM `AllStudents_VW`, `CurrentlyEnrolled`
WHERE `AllStudents_VW`.StudentID = CurrentlyEnrolled.`StudentID`
AND Grade < 80
AND GPA > 2.0;
/*
12.0: Everything is the same
12.1: There are not any differences 
12.2: No, because the VIEW only involves Students and People, while the query has needs to access 
CurrentlyEnrolled, and we did not specify it to use the view. We would have had to SELECT
the view and added additional clauses to further filter out the data
*/

-- 13
-- added check constrint into CurrentlyEnrolled function

-- 14 test check CONSTRAINT
INSERT INTO CurrentlyEnrolled (CourseID, StudentID, Grade) VALUES (1,3,-5);
INSERT INTO CurrentlyEnrolled (CourseID, StudentID, Grade) VALUES (1,3,103);
-- 15
CREATE TRIGGER UpdateGPA_Insert 
AFTER INSERT ON CurrentlyEnrolled
FOR EACH ROW 
BEGIN
DECLARE IDstudent INT;
SET IDstudent = NEW.StudentID;
UPDATE `Students`
SET GPA = (
	SELECT AVG(GRADE)
	FROM `CurrentlyEnrolled`
	WHERE IDstudent = `StudentID`
	)
WHERE IDstudent = `StudentID`;
END;
DROP TRIGGER UpdateGPA_Insert;

-- 15
SELECT GPA 
FROM `Students`
WHERE `StudentID` = 13;

-- 16
-- Since there is not a proper way put in place to calculate GPA, 
-- we will assume that GPA is calculated on a 100pt scale
INSERT INTO CurrentlyEnrolled (CourseID, StudentID, Grade) VALUES (3,13,65);
DELETE FROM `CurrentlyEnrolled`
WHERE StudentID = 13 AND CourseID = 3;

