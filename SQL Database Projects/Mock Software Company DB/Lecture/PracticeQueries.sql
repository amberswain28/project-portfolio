-- Active: 1708549946789@@127.0.0.1@3306@IntroSQL
Use IntroSQL;

SHOW TABLES;

-- question 1
SELECT Login
FROM People;

-- question 2
SELECT StudentID
FROM Students
WHERE GPA > 2.5;

-- question 3
SELECT StudentID
FROM Students
WHERE GPA
BETWEEN 2.5 AND 3.0;

-- question 4
SELECT StudentID, GPA
FROM Students
ORDER BY `GPA` DESC;

-- question 5
SELECT AVG(Grade) FROM `CurrentlyEnrolled`;

-- question 6
SELECT AVG(Grade), CourseID
FROM `CurrentlyEnrolled`
GROUP BY `CourseID`;

-- question 7
SELECT AVG(Grade), CourseID
FROM `CurrentlyEnrolled`
GROUP BY `CourseID`
HAVING AVG(Grade) > 80;

-- question 8
SELECT MAX(Grade), `CourseID`
FROM `CurrentlyEnrolled`
GROUP BY `CourseID`
ORDER BY `CourseID`;

-- question 9
SELECT FName, LName
FROM People, Students
WHERE People.PersonID=Students.StudentID;

-- question 10
SELECT FName, LName, Title
FROM People, Students, `CurrentlyEnrolled`, `Courses`
WHERE People.PersonID=Students.StudentID
AND `Students`.`StudentID`=`CurrentlyEnrolled`.`StudentID`
AND `CurrentlyEnrolled`.`CourseID`=Courses.`CourseID`
AND Grade >= 80;

-- question 11
SELECT FName, LName, Grade
FROM People, Students, `CurrentlyEnrolled`, `Courses`
WHERE People.PersonID=Students.StudentID
AND `Students`.`StudentID`=`CurrentlyEnrolled`.`StudentID`
AND `CurrentlyEnrolled`.`CourseID`=Courses.`CourseID`
AND title='CS150 Intro to Computer Science'
ORDER BY Grade DESC
LIMIT 2;


-- question 12
SELECT FName, LName, Grade
FROM People 
JOIN `CurrentlyEnrolled` ON People.PersonID = CurrentlyEnrolled.StudentID
JOIN Courses ON `CurrentlyEnrolled`.`CourseID`=Courses.`CourseID`
WHERE  `CurrentlyEnrolled`.CourseID = 1
AND Grade > (
SELECT AVG(Grade)
FROM `CurrentlyEnrolled`
WHERE CourseID = 1
);

-- another way to do question 12
SELECT FName, LName, Grade
FROM People, Students, `CurrentlyEnrolled`, `Courses`
WHERE People.PersonID=Students.StudentID
AND `Students`.`StudentID`=`CurrentlyEnrolled`.`StudentID`
AND `CurrentlyEnrolled`.`CourseID`=Courses.`CourseID`
AND title='CS150 Intro to Computer Science'
HAVING Grade > (
SELECT AVG(Grade)
FROM `CurrentlyEnrolled`
WHERE CourseID = 1
);

-- Bonus
SELECT DISTINCT StudentID
FROM `CurrentlyEnrolled`
WHERE CourseID <> (
	SELECT `CourseID`
	FROM `Courses`
	WHERE `Title` = 'CS150 Intro to Computer Science'
);