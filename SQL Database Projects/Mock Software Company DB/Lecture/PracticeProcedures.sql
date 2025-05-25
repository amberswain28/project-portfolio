-- Active: 1708549946789@@127.0.0.1@3306@IntroSQL

-- 1
CREATE PROCEDURE problem1 ()
READS SQL DATA
BEGIN
SELECT Login
FROM People;
END;
CALL problem1();
DROP PROCEDURE problem1;
-- 2
CREATE PROCEDURE problem2(parameter_GPA DECIMAL(3,2) )
READS SQL DATA 
BEGIN
SELECT StudentID
FROM `Students`
WHERE Students.`GPA` < parameter_GPA;
END;
CAll problem2(3.9);
DROP PROCEDURE problem2;

-- 3
CREATE PROCEDURE problem3(parameter_GPA1 DECIMAL, parameter_GPA2 DECIMAL )
READS SQL DATA 
BEGIN
SELECT StudentID
FROM `Students`
WHERE 
Students.`GPA` >= parameter_GPA1
AND
Students.`GPA` <= parameter_GPA2;
END;
CAll problem3(2.5, 3.9);
DROP PROCEDURE problem3;

-- 4 
CREATE PROCEDURE problem4(classTitle varchar(50) )
READS SQL DATA 
BEGIN
SELECT FName, LName
FROM `People`, `Students`, `CurrentlyEnrolled`, `Courses`
WHERE People.`PersonID` = Students.`StudentID`
AND Students.`StudentID` = CurrentlyEnrolled.`StudentID`
AND `CurrentlyEnrolled`.`CourseID` = Courses.`CourseID`
AND Courses.`Title` = classTitle;
END;
CAll problem4('CS150 Intro to Computer Science');
DROP PROCEDURE problem4;

-- 5
DROP PROCEDURE problem5;
CREATE PROCEDURE problem5(classTitle varchar(50) )
READS SQL DATA 
BEGIN
SELECT FName, LName
FROM `People`, `Students`, `CurrentlyEnrolled`, `Courses`
WHERE People.`PersonID` = Students.`StudentID`
AND Students.`StudentID` = CurrentlyEnrolled.`StudentID`
AND `CurrentlyEnrolled`.`CourseID` = Courses.`CourseID`
AND `Courses`.Title LIKE CONCAT('%', classTitle, '%');
END;
CAll problem5('CS150');

-- 6
DROP FUNCTION AvgGrade;
CREATE FUNCTION AvgGrade()
RETURNS DECIMAL(7,4)
BEGIN
    DECLARE avg_grade DECIMAL(7,4);
    
    SELECT AVG(Grade) INTO avg_grade
    FROM CurrentlyEnrolled;

    RETURN avg_grade;
END;

SELECT AvgGrade() AS AverageGrade;


-- 7
SELECT DISTINCT People.FName, People.LName, Courses.Title
FROM People, `Courses`, `CurrentlyEnrolled`, `Students`
WHERE
People.PersonID = Students.StudentID
AND Students.StudentID = CurrentlyEnrolled.StudentID
AND CurrentlyEnrolled.CourseID = Courses.CourseID 
AND CurrentlyEnrolled.Grade > (
    SELECT AvgGrade()
);

-- 8
SELECT 
    People.FName, 
    People.LName, 
    COUNT(*) AS NumCourses
FROM 
    People, Students, `CurrentlyEnrolled`, Courses
WHERE
    People.PersonID = Students.StudentID
    AND Students.StudentID = CurrentlyEnrolled.StudentID
    AND CurrentlyEnrolled.CourseID = Courses.CourseID
    AND CurrentlyEnrolled.Grade > (
        SELECT AvgGrade()
    )
GROUP BY 
    People.FName, 
    People.LName
		
ORDER BY
		NumCourses ASC;

	
-- 9
DROP FUNCTION `NumHigherAvg`;
CREATE FUNCTION NumHigherAvg(course_id INT) 
RETURNS DECIMAL(7,4)
BEGIN
    DECLARE avg_grade DECIMAL(7,4);
    
    SELECT AVG(Grade) INTO avg_grade
    FROM CurrentlyEnrolled
    WHERE CourseID = course_id;
    
    RETURN avg_grade;
END;
SELECT DISTINCT People.FName, People.LName, CurrentlyEnrolled.Grade
FROM 
    People, Students, CurrentlyEnrolled, Courses
WHERE 
    People.PersonID = Students.StudentID
    AND Students.StudentID = CurrentlyEnrolled.StudentID
    AND CurrentlyEnrolled.CourseID = 1
    AND CurrentlyEnrolled.Grade > NumHigherAvg(1);

	
	-- 9.5
SELECT DISTINCT People.FName, People.LName, CurrentlyEnrolled.Grade
FROM 
    People, Students, CurrentlyEnrolled, Courses
WHERE 
    People.PersonID = Students.StudentID
    AND Students.StudentID = CurrentlyEnrolled.StudentID
    AND CurrentlyEnrolled.CourseID = 3
    AND CurrentlyEnrolled.Grade > NumHigherAvg(3);

-- 10
-- couldn't get this to work 
/*DROP PROCEDURE AddToCS300;
CREATE PROCEDURE AddToCS300(studentID INT)
BEGIN
    IF EXISTS (
        SELECT `CurrentlyEnrolled`.Grade
        FROM CurrentlyEnrolled, Courses
        WHERE `CurrentlyEnrolled`.CourseID = Courses.`CourseID`
        AND Courses.Title = 'CS250 Intro to Computer Science II' AND `CurrentlyEnrolled`.StudentID = student_id
    ) THEN
        IF (SELECT Grade
            FROM CurrentlyEnrolled
            WHERE CourseID = (SELECT CourseID FROM Courses WHERE Title = 'CS250 Intro to Computer Science II') AND StudentID = student_id) >= 72 THEN
            INSERT INTO CurrentlyEnrolled (StudentID, CourseID, Grade)
                VALUES (student_id, (SELECT CourseID FROM Courses WHERE Title = 'CS300 Datastructures'), NULL);
            SELECT 'Student successfully added to CS 300' AS Message;
        ELSE
            SELECT 'Student achieved a grade less than 72 in CS 250' AS Error_Message;
        END IF;
    ELSE
        SELECT 'Student never took CS 250' AS Error_Message;
END;
CALL AddtoCS300(1); */

