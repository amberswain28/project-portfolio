-- Active: 1712349615013@@127.0.0.1@3306@BookstoreDB
-- -----------------------------------------------------------------------------
--  File name:  Queries.sql
--  Author:     Alyssa Dixon, Amber Swain
--  Date:       March 22, 2024
--  Class:      CS445
--  Assignment: Bookstore
--  Purpose:    Contains the SQL query statements
-- -----------------------------------------------------------------------------
USE BookstoreDB;

-- -----------------------------------------------------------------------------
-- Query Discription: 1. List all of the customers first and last names.
-- Output: (FName, LName)
-- Sorted: none
-- Grouped: none
-- -----------------------------------------------------------------------------
SELECT FName, LName
FROM Users;

-- -----------------------------------------------------------------------------
-- Query Description: 2. To list all Books 
-- Output: Title, ISBN, EditionName
-- Sorted: none
-- Grouped: none
-- -----------------------------------------------------------------------------
SELECT Title, ISBN, EditionName 
FROM Books, BookEditions, Editions
WHERE
	Books.`BookID` = BookEditions.`BookID`
	AND Editions.`EditionID` = BookEditions.`EditionID`;

-- -----------------------------------------------------------------------------
-- Query Discription: 3. List the Name of all customers that have been with the 
-- company since before October 10, 2023 and the Books they purchased
-- Output: (FName, LName, Title, Edition, account creation date)
-- Sorted: none
-- Grouped: none
-- -----------------------------------------------------------------------------
SELECT FName, LName, Title, EditionName AS Edition, `CreationDate` 
	AS "Account Creation Date"
FROM Users, Books, InSale, Sales, Editions
WHERE Users.`CreationDate` < "2023-10-10"
AND Users.UserID = Sales.UserID
AND Sales.SaleID = InSale.SaleID
AND InSale.BookID = Books.`BookID`
AND InSale.`EditionID` = Editions.`EditionID`;
-- -----------------------------------------------------------------------------
-- Query Description: 4. Return average total cost for all sales
-- Output: Average Total Cost
-- Sorted: none
-- Grouped: none
-- Function/Procedure: calcTotalCost, calcSubtotalInSale
-- -----------------------------------------------------------------------------
SELECT AVG(calcTotalCost(SaleID)) AS "Average Total Cost"
FROM `Sales`; 

-- -----------------------------------------------------------------------------
-- Query Discription: 5. Find the customer that saved the most by applying a 
-- discount to one sale.
-- Output: FName, LName, sale timestamp, amount saved
-- Sorted: Amount Saved (high to low)
-- Grouped: none
-- Functions: calcMoneySaved(SaleID)
-- -----------------------------------------------------------------------------
SELECT FName, LName, Sales.Timestamp AS "sale timestamp",
	calcMoneySaved(Sales.SaleID) AS "amount saved"
FROM Sales, Users
WHERE Sales.UserID = Users.UserID
ORDER BY calcMoneySaved(Sales.SaleID) DESC, Sales.Timestamp ASC
LIMIT 1;

-- -----------------------------------------------------------------------------
-- Query Description: 6. Find all users that purchased any Edition of 
-- 										"All Systems Red"
-- Output: FName, LName, email
-- Sorted: none
-- Grouped: UserID
-- -----------------------------------------------------------------------------
SELECT FName, LName, Email
FROM Users, Sales, InSale, Books
WHERE
	Users.`UserID` = Sales.`UserID`
	AND Sales.`SaleID` = InSale.`SaleID`
	AND InSale.`BookID` = Books.`BookID`
	AND Books.Title = "All Systems Red"
GROUP BY Users.`UserID`; 

-- -----------------------------------------------------------------------------
-- Query Discription: 7. Find the user that has spent the most money in the 
-- year 2023
-- Output: FName, LName, total amount spent
-- Sorted: TotalAmount(high to low), then FName(AtoZ), then LName(AtoZ)
-- Grouped: UserID
-- Views: TotalSpent2023_VW
-- -----------------------------------------------------------------------------
CREATE OR REPLACE VIEW TotalSpent2023_VW AS 
SELECT FName, LName, calcTotalCost(Sales.SaleID) AS TotalSpent, Users.UserID
FROM Sales, Users
WHERE Sales.UserID = Users.UserID
AND YEAR(Sales.Timestamp) = 2023
ORDER BY Users.UserID;

SELECT FName, LName, SUM(TotalSpent) AS TotalAmount
FROM TotalSpent2023_VW
GROUP BY 
	UserID
ORDER BY TotalAmount DESC, FName ASC, LName ASC
LIMIT 1;
-- -----------------------------------------------------------------------------
-- Query Description: 8.  Find all the Editions of the book All Systems Red
-- Output: ISBN, Edition Name, Retail Price
-- Sorted: ISBN (low to high)
-- Grouped: none
-- -----------------------------------------------------------------------------
SELECT `ISBN`, `EditionName`, `Retail` AS retailPrice
FROM `BookEditions`, Editions, Books
WHERE
	Books.Title = "All Systems Red"
	AND `BookEditions`.`BookID` = Books.`BookID`
	AND `BookEditions`.`EditionID` = `Editions`.`EditionID`
ORDER BY `ISBN`;

-- -----------------------------------------------------------------------------
-- Query Discription: 9. Find how many orders each user has made in the 
-- year 2023
-- Output: FName, LName, numberOfOrders
-- Sorted: NumberOfOrders(high to low), then LName(AtoZ), then FName(AtoZ)
-- Grouped: UserID
-- Views: numOrders_VW
-- -----------------------------------------------------------------------------
CREATE OR REPLACE VIEW numOrders_VW AS 
SELECT Users.UserID, FName, LName, COUNT(*) AS numberOfOrders, `Timestamp`
FROM Sales, Users
WHERE Sales.UserID = Users.UserID
AND YEAR(Sales.Timestamp) = 2023
GROUP BY Users.UserID;

SELECT Users.FName, Users.LName, 
	COALESCE(numOrders_VW.`numberOfOrders`, 0) AS numberOfOrders
FROM Users LEFT JOIN `numOrders_VW` ON Users.`UserID` = numOrders_VW.`UserID`
ORDER BY NumberOfOrders DESC, LName ASC, FName ASC;

-- -----------------------------------------------------------------------------
-- Query Description: 10. Find all the users that made more than the average 
--										number of orders in the year 2023
-- Output: FName, LName, number of orders
-- Sorted: number Of Orders (High to low), LName, FName A->Z
-- Grouped: none
-- -----------------------------------------------------------------------------
SELECT FName, LName, COUNT(`SaleID`) AS numberOfOrders
FROM `Users`, `Sales`
WHERE
	Users.`UserID` = Sales.`UserID`
	AND YEAR(`Timestamp`) = 2023
GROUP BY Users.`UserID`
HAVING numberOfOrders > (
	SELECT AVG(numOrders)
	FROM (
		SELECT COUNT (`SaleID`) AS numOrders
		FROM `Users`, `Sales`
		WHERE
			Users.`UserID` = Sales.`UserID`
			AND YEAR(`Timestamp`) = 2023
		GROUP BY `Users`.`UserID`
	) AS subquery
)
ORDER BY numberOfOrders DESC, LName, FName;

-- -----------------------------------------------------------------------------
-- Query Discription: 11. Find the 10 most purchased books for 2023 
-- Output: ISBN, Title, Edition, total quantity purchased
-- Sorted: totalQuantityPurchased (high to low), Title(AtoZ), Edition(AtoZ)
-- Grouped: BookID and EditionID
-- Views: ISBNTitlesEditions_VW, Sales2023_VW
-- -----------------------------------------------------------------------------
CREATE OR REPLACE VIEW ISBNTitlesEditions_VW AS
SELECT ISBN AS ISBN, BookEditions.BookID, BookEditions.EditionID, 
	Title, Editions.`EditionName` AS Edition
FROM `BookEditions`, Books, Editions
WHERE BookEditions.BookID = Books.BookID
AND BookEditions.EditionID = Editions.`EditionID`;

CREATE OR REPLACE VIEW Sales2023_VW AS
SELECT SaleID 
FROM Sales 
WHERE YEAR(Timestamp) = 2023;

SELECT
	ISBNTitlesEditions_VW.`ISBN`,
	ISBNTitlesEditions_VW.Title,
	ISBNTitlesEditions_VW.Edition,
	SUM(InSale.`Quantity`) AS totalQuantityPurchased
FROM
	ISBNTitlesEditions_VW, InSale, Sales2023_VW
WHERE InSale.SaleID = Sales2023_VW.SaleID
AND ISBNTitlesEditions_VW.BookID = InSale.BookID 
AND ISBNTitlesEditions_VW.EditionID = InSale.EditionID
GROUP BY ISBNTitlesEditions_VW.BookID, ISBNTitlesEditions_VW.EditionID
ORDER BY totalQuantityPurchased DESC, Title ASC, Edition ASC
LIMIT 10;

-- -----------------------------------------------------------------------------
-- Query Description: 12.  Find the 10 most profitable books for 2023
-- Output: ISBN, Title, Edition, total profit
-- Sorted: total Profit (High to low), Title, Edition A->Z
-- Grouped: none
-- Function/Procedure: calcTotalCost, calcSubtotalInSale
-- -----------------------------------------------------------------------------
SELECT `ISBN`, `Title`, EditionName, 
	SUM((`Retail` - `Wholesale`) * InSale.`Quantity`) AS totalProfit
FROM `BookEditions`, Books, Editions, Sales, InSale
WHERE
	Sales.`SaleID` = InSale.`SaleID`
	AND InSale.`BookID` = BookEditions.`BookID`
	AND InSale.`EditionID` = BookEditions.`EditionID`
	AND BookEditions.`BookID` = Books.`BookID`
	AND BookEditions.`EditionID` = Editions.`EditionID`
	AND YEAR(`Timestamp`) = 2023
GROUP BY `ISBN`
ORDER BY totalProfit DESC, `Title`, `EditionName`
LIMIT 10;

-- -----------------------------------------------------------------------------
-- Query Discription: 13. How many of each type of Edition have been purchased
-- Output: Count (high to low), Eiditon Name Z -> A
-- Sorted: Count (high to low), Edition (ZtoA)
-- Grouped: EditionID
-- -----------------------------------------------------------------------------
SELECT SUM(InSale.`Quantity`) as Count, EditionName as Edition
FROM `InSale`, Editions
WHERE InSale.EditionID = Editions.EditionID
GROUP BY InSale.EditionID
ORDER BY Count DESC, EditionName DESC;

-- -----------------------------------------------------------------------------
-- Query Description: 14.  Find the 10 least profitable (most money losing) 
--										book editions
-- Output: Average Total Cost
-- Sorted: total profit (low to high), Title, Edition in A->Z order
-- Grouped: none
-- -----------------------------------------------------------------------------
SELECT `ISBN`, `Title`, EditionName, 
	SUM((`Retail` - `Wholesale`) * InSale.`Quantity`) AS totalProfit
FROM `BookEditions`, Books, Editions, InSale
WHERE
	InSale.`BookID` = BookEditions.`BookID`
	AND InSale.`EditionID` = BookEditions.`EditionID`
	AND BookEditions.`BookID` = Books.`BookID`
	AND BookEditions.`EditionID` = Editions.`EditionID`
GROUP BY `ISBN`
ORDER BY totalProfit, `Title`, `EditionName`
LIMIT 10;