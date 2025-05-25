-- Active: 1708549946789@@127.0.0.1@3306@Lectures
SHOW TABLES;
SHOW CREATE TABLE People;

SELECT *
FROM `People`
WHERE PersonID > 2;

SELECT *
FROM `CurrentlyEnrolled`
WHERE CourseID =1;

UPDATE `CurrentlyEnrolled`
SET Grade = Grade *0.9
WHERE CourseID = 1;

SELECT *
FROM People;

SELECT *
FROM `CurrentlyTeaching`;

DELETE FROM People WHERE PersonID = 1;

SELECT *
FROM `Courses`
WHERE MaxSize > 15;

SELECT *
FROM `Courses`
ORDER BY `Title`;

SELECT *
FROM `Courses`
WHERE `MaxSize` > 5
ORDER BY `MaxSize` DESC, `CourseID` DESC;

SELECT LName, COUNT(*)
FROM `People`
GROUP BY LName
ORDER BY LName;

SELECT LName, COUNT(*) AS LNameCount
FROM `People`;

SELECT COUNT(*) AS RowsInThePeopleTable
FROM `People`;

SELECT AVG(MaxSize), MAX(MaxSize), MIN(`MaxSize`)
FROM `Courses`
WHERE `MaxSize` > 5;


SELECT StudentID, AVG(Grade) as AvgGrade, COUNT(*) as NumbRows
FROM `CurrentlyEnrolled`
WHERE `Grade` > 20
GROUP BY `StudentID`
HAVING AvgGrade > 50 AND NumbRows > 1
ORDER BY AvgGrade DESC
LIMIT 1,2;

SELECT `Rank` as Title
FROM `Professors`
WHERE Title;