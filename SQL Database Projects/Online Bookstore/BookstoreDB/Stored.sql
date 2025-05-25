
-- Active: 1712349615013@@127.0.0.1@3306@BookstoreDB
-- -----------------------------------------------------------------------------
--  File name:  Stored.sql
--  Author:     Alyssa Dixon, Amber Swain
--  Date:       March 22, 2024
--  Class:      CS445
--  Assignment: Bookstore
--  Purpose:    Contains the SQL stored procedures and functions
-- -----------------------------------------------------------------------------
-- -----------------------------------------------------------------------------
-- Procedure Description: To insert an author
-- Input: FName, LName
-- Output: None
-- -----------------------------------------------------------------------------
USE BookstoreDB;

DELIMITER $$

CREATE OR REPLACE PROCEDURE insertAuthor (p_FName VARCHAR (50), 
	p_LName VARCHAR (50))
READS SQL DATA
BEGIN
	INSERT IGNORE INTO `Authors` (`FName`, `LName`) VALUES 
		(p_FName, p_LName);
END $$


-- -----------------------------------------------------------------------------
-- Procedure Description: To insert a book
-- Input: Title
-- Output: None
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE insertBook (p_Title VARCHAR (75), 
	p_Cover VARCHAR (150))
READS SQL DATA
BEGIN
	INSERT IGNORE INTO `Books` (`Title`, `Cover`) VALUES (p_Title, p_Cover);		
END $$
 

-- -----------------------------------------------------------------------------
-- Function Description: To retrieve a bookID
-- Input: Title
-- Output: BookID
-- -----------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION getBookID (p_Title VARCHAR(75))
RETURNS INT
BEGIN
	DECLARE book_ID INT;

	SELECT `BookID` into book_ID
	FROM `Books`
	WHERE
		`Books`.`Title` = p_Title;

	IF book_ID IS NOT NULL THEN
		RETURN book_ID;
	ELSE
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Book ID null';
		RETURN NULL;
	END IF;

END $$
 

-- -----------------------------------------------------------------------------
-- Function Description: To retrieve an AuthorID
-- Input: Title
-- Output: AuthorID
-- -----------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION getAuthorID (p_FName VARCHAR(50), 
	p_LName VARCHAR(50))
RETURNS INT
BEGIN
	DECLARE author_ID INT;

	SELECT `AuthorID` into author_ID
	FROM `Authors`
	WHERE
		`Authors`.`FName` = p_FName
		AND `Authors`.`LName` = p_LName;

	IF author_ID IS NOT NULL THEN
		RETURN author_ID;
	ELSE
		RETURN NULL;
	END IF;

END $$
 

-- -----------------------------------------------------------------------------
-- Function Description: To retrieve a pubID
-- Input: Name
-- Output: PubID
-- -----------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION getPubID (p_Name VARCHAR(50))
RETURNS INT
BEGIN
	DECLARE pub_ID INT;

	SELECT PubID into pub_ID
	FROM `Publishers`
	WHERE
		`Publishers`.Name = p_Name;

	IF pub_ID IS NOT NULL THEN
		RETURN pub_ID;
	ELSE
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Pub ID null';
		RETURN NULL;
	END IF;

END $$
 

-- -----------------------------------------------------------------------------
-- Function Description: To retrieve an editionID
-- Input: Title
-- Output: EditionID
-- -----------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION getEditionID (p_EditionName VARCHAR(75))
RETURNS INT
BEGIN
	DECLARE edition_ID INT;

	SELECT `EditionID` into edition_ID
	FROM `Editions`
	WHERE
		`Editions`.EditionName = p_EditionName;

	IF edition_ID IS NOT NULL THEN
		RETURN edition_ID;
	ELSE
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Edition ID null';
		RETURN NULL;
	END IF;

END $$
 

-- -----------------------------------------------------------------------------
-- Procedure Description: To insert a publisher
-- Input: Name
-- Output: None
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE insertPublisher (p_name VARCHAR (50))
READS SQL DATA
BEGIN
	INSERT IGNORE INTO Publishers (`Name`) VALUES (p_name);
END $$
 

-- -----------------------------------------------------------------------------
-- Procedure Description: To insert an edition
-- Input: Title, Edition Name
-- Output: None
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE insertEdition (p_EditionName VARCHAR (50))
READS SQL DATA
BEGIN
	INSERT IGNORE INTO `Editions` (`EditionName`) VALUES (p_EditionName);
END $$
 

-- -----------------------------------------------------------------------------
-- Procedure Description: To insert a BookEdition
-- Input: Title, edition, publisher, pubDate, ISBN, wholesale, retail, 
--				forwardFName, forwardLName
-- Output: None
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE insertBookEditionFromFile (p_Cover VARCHAR (150), 
	p_Title VARCHAR (75), p_edition VARCHAR (50), p_publisher VARCHAR (50), 
	p_pubDate DATE, p_ISBN VARCHAR (15), p_qty INT (11), 
	p_wholesale DECIMAL (15, 4), p_retail DECIMAL (15,4), 
	p_forwardFName VARCHAR (50), p_forwardLName VARCHAR (50))
READS SQL DATA
BEGIN
	DECLARE pub_ID INT;
	DECLARE book_ID INT;
	DECLARE edition_ID INT;

	CALL insertBook (p_Title, p_Cover);
	CALL insertPublisher (p_publisher);
	CALL insertEdition (p_edition);

	SELECT getBookID (p_Title) INTO book_ID;
	SELECT getPubID (p_publisher) INTO pub_ID;
	SELECT getEditionID (p_edition) INTO edition_ID;

	IF book_ID IS NOT NULL AND pub_ID IS NOT NULL AND edition_ID IS NOT NULL THEN
		INSERT IGNORE INTO BookEditions (BookID, EditionID, ISBN, Quantity, 
			Wholesale, Retail, PubID, PubDate, AuthorID) VALUES
			(book_ID, edition_ID, p_ISBN, p_qty, p_wholesale, 
			p_retail, pub_ID, p_pubDate, 
			getAuthorID (p_forwardFName, p_forwardLName));
		
	END IF;
END $$
 
 -- -----------------------------------------------------------------------------
-- Procedure Description: To insert a BookEdition
-- Input: BookID, EditionID, PubID, pubDate, ISBN, wholesale, retail, AuthorID
-- Output: None
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE insertBookEdition (p_BookID INT (11), 
	p_EditionID INT (11), p_PubID INT (11), p_AuthorID INT (11), 
	p_Cover VARCHAR (150), p_pubDate DATE, p_ISBN VARCHAR (15), p_qty INT (11), 
	p_wholesale DECIMAL (15, 4), p_retail DECIMAL (15,4))
READS SQL DATA
BEGIN
	INSERT IGNORE INTO BookEditions (BookID, EditionID, ISBN, Quantity, 
		Wholesale, Retail, PubID, PubDate, AuthorID) VALUES
		(p_BookID, p_EditionID, p_ISBN, p_qty, p_wholesale, p_retail, p_PubID,
		p_pubDate, p_AuthorID);
END $$

-- -----------------------------------------------------------------------------
-- Procedure Description: To insert a write (book and author) relationship
-- Input: Title, FName, LName
-- Output: None
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE insertWroteFromFile (p_Title VARCHAR (75), 
	p_FName VARCHAR (50), p_LName VARCHAR (50))
READS SQL DATA
BEGIN
	INSERT IGNORE INTO `Writes` (`BookID`, `AuthorID`) VALUES
		(getBookID (p_Title), getAuthorID (p_FName, p_LName));
END $$

-- -----------------------------------------------------------------------------
-- Procedure Description: To insert a write (book and author) relationship
-- Input: Title, FName, LName
-- Output: None
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE insertWrote (p_BookID INT (11), p_AuthorID INT (11))
READS SQL DATA
BEGIN
	INSERT IGNORE INTO `Writes` (`BookID`, `AuthorID`) VALUES
		(p_BookID, p_AuthorID);
END $$
 

-- -----------------------------------------------------------------------------
-- Procedure Description: To insert a Discount
-- Input: p_DiscountID, p_DiscountName, p_DecAmount, 
--				p_PercentageAmount, p_StartDate, p_EndDate
-- Output: None
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE insertDiscount (p_DiscountName VARCHAR(50),
 p_PercentageAmount DEC(15,4), p_DollarAmount DEC(15,4), p_StartDate DATE, 
 p_EndDate DATE)
BEGIN
	INSERT IGNORE INTO Discounts (DiscountName, PercentageAmount, DollarAmount,
		StartDate, EndDate) VALUES (p_DiscountName, p_PercentageAmount, 
		p_DollarAmount, p_StartDate, p_EndDate);
END $$


-- -----------------------------------------------------------------------------
-- Procedure Description: To insert Shipping Method
-- Input: p_ShippingType, p_Speed, p_Cost
-- Output: None
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE insertShipping (p_ShippingType VARCHAR(50), 
	p_Speed VARCHAR(50), p_Cost DECIMAL (15, 4))
BEGIN
	INSERT INTO Shipping (ShippingType, Speed, Cost) 
	VALUES (p_ShippingType, p_Speed, p_Cost);
END $$


-- -----------------------------------------------------------------------------
-- Function Description: To retrieve a UserID
-- Input: FName, LName
-- Output: None
-- -----------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION getUserID (p_FName VARCHAR(50), 
p_LName VARCHAR(50))
RETURNS INT
BEGIN
	DECLARE user_ID INT;

	SELECT UserID into user_ID
	FROM Users
	WHERE
		Users.`FName` = p_FName
		AND Users.`LName` = p_LName;

	IF user_ID IS NOT NULL THEN
		RETURN user_ID;
	ELSE
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'User ID null';
		RETURN NULL;
	END IF;

END $$

-- -----------------------------------------------------------------------------
-- Function Description: To retrieve a ShippingID
-- Input: Name
-- Output: ShippingID
-- -----------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION getShippingID (p_Name VARCHAR(50))
RETURNS INT
BEGIN
	DECLARE shipping_ID INT;

	SELECT ShippingID into shipping_ID
	FROM Shipping
	WHERE
		Shipping.ShippingType = p_Name;

	IF shipping_ID IS NOT NULL THEN
		RETURN shipping_ID;
	ELSE
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Shipping ID null';
		RETURN NULL;
	END IF;

END $$
 


-- -----------------------------------------------------------------------------
-- Function Description: To retrieve a DiscountID
-- Input: Name
-- Output: DiscountID
-- -----------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION getDiscountID (p_Name VARCHAR(50))
RETURNS INT
BEGIN
	DECLARE discount_ID INT;

	SELECT DiscountID into discount_ID
	FROM `Discounts`
	WHERE
		Discounts.DiscountName = p_Name;

	IF discount_ID IS NOT NULL THEN
		RETURN discount_ID;
	ELSE
		RETURN NULL;
	END IF;

END $$


-- -----------------------------------------------------------------------------
-- Procedure Description: To insert a User
-- Input: FName, LName, Username, hashedPasswd, salt, CreationDate, Email
-- Output: None
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE insertUser (p_FName VARCHAR(50), 
	p_LName VARCHAR(50), p_Username VARCHAR(50), p_hashedPasswd VARBINARY(512),  
	p_salt VARBINARY(512), p_CreationDate DATE, p_Email VARCHAR(150))
BEGIN
	INSERT INTO Users (FName, LName, Username, hashedPasswd, salt, CreationDate, 
			Email) VALUES 
		(p_FName, p_LName , p_Username, p_hashedPasswd, p_salt, p_CreationDate, 
		p_Email);
END $$


-- -----------------------------------------------------------------------------
-- Function Description: To retrieve a WishListID
-- Input: FName, LName, WishListName
-- Output: WishListID
-- -----------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION getWLID (p_FName VARCHAR (50), p_LName VARCHAR (50),
	p_WLName VARCHAR (50))
RETURNS INT
BEGIN
	DECLARE wl_ID INT;

	SELECT WishListID into wl_ID
	FROM WishLists, Users
	WHERE
		`Users`.UserID = WishLists.UserID
		AND `WishLists`.WishListName = p_WLName
		AND Users.`FName` = p_FName
		AND Users.`LName` = p_LName;

	IF wl_ID IS NOT NULL THEN
		RETURN wl_ID;
	ELSE
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Wishlist ID null';
		RETURN NULL;
	END IF;

END $$
 

-- -----------------------------------------------------------------------------
-- Procedure Description: To insert a wishlist
-- Input: FName, LName, WishListName
-- Output: None
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE insertWishList (p_FName VARCHAR (50), 
	p_LName VARCHAR (50), p_WLName VARCHAR (50))
READS SQL DATA
BEGIN
	INSERT IGNORE INTO `WishLists` (WishListName, UserID) VALUES
		(p_WLName, getUserID (p_FName, p_LName));
END $$

-- -----------------------------------------------------------------------------
-- Procedure Description: To insert a InWishlist (a wishlist BookEdition 
--												relationship)
-- Input: FName, LName, WishListName, Title, Edition, Quantity, Note
-- Output: None
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE insertInWishlistFromFile (p_FName VARCHAR (50), 
	p_LName VARCHAR (50), p_WLName VARCHAR (50), p_Title VARCHAR (75),
	p_Edition VARCHAR (50), p_Quantity INT (11), p_Note VARCHAR (300))
READS SQL DATA
BEGIN
	DECLARE wl_ID INT;
	DECLARE book_ID INT;
	DECLARE edition_ID INT;

	CALL insertWishList (p_FName, p_LName, p_WLName);

	SELECT getWLID (p_FName, p_LName, p_WLName) INTO wl_ID;
	SELECT getBookID (p_Title) INTO book_ID;
	SELECT getEditionID (p_edition) INTO edition_ID;

	INSERT IGNORE INTO InWishList (WishListID, BookID, EditionID, Quantity, Note) 
		VALUES (wl_ID, book_ID, edition_ID, p_Quantity, p_Note);
END $$

-- -----------------------------------------------------------------------------
-- Procedure Description: To insert a InWishlist (a wishlist BookEdition 
--												relationship)
-- Input: WishListID, BookID, EditionID, Quantity, Note
-- Output: None
-- -----------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE insertInWishlist (p_WishlistID INT (11),
	p_BookID INT (11), p_EditionID INT (11), p_Quantity INT (11), 
	p_Note VARCHAR (300))
READS SQL DATA
BEGIN
	INSERT IGNORE INTO InWishList (WishListID, BookID, EditionID, Quantity, Note) 
		VALUES (p_WishlistID, p_BookID, p_EditionID, p_Quantity, p_Note);
END $$

-- -----------------------------------------------------------------------------
-- Function Description: To retrieve a SaleID
-- Input: FName, LName, Date, Time
-- Output: SaleID
-- -----------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION getSaleID (p_Timestamp DATETIME, p_UserID INT (11))
RETURNS INT
BEGIN
	DECLARE sale_ID INT;

	SELECT SaleID into sale_ID
	FROM `Sales`
	WHERE
		Sales.`UserID` = p_UserID
		AND Sales.`Timestamp` = p_Timestamp;

	IF sale_ID IS NOT NULL THEN
		RETURN sale_ID;
	ELSE
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Sale ID is null';
		RETURN NULL;
	END IF;

END $$


-- -----------------------------------------------------------------------------
-- Procedure Description: To insert a sale
-- Input: Timestamp, UserID, Discount, Shipping
-- Output: None
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE insertSale (p_Timestamp DATETIME, 
	p_UserID INT (11), p_Discount VARCHAR (50),
	p_Shipping VARCHAR (50))
READS SQL DATA
BEGIN
	INSERT IGNORE INTO `Sales` (`Timestamp`, `UserID`, `DiscountID`, `ShippingID`)
		VALUES (p_Timestamp, p_UserID, 
		getDiscountID (p_Discount), getShippingID (p_Shipping));
END $$

-- -----------------------------------------------------------------------------
-- Procedure Description: To insert a InSale (a Sale BookEdition relationship
--												relationship)
-- Input: FName, LName, Discount, Date, Time, Shipping, Book, Edition, Quantity
-- Output: None
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE insertInSaleFromFile (p_FName VARCHAR (50), 
	p_LName VARCHAR (50), p_Discount VARCHAR (50), p_Date VARCHAR (50), 
	p_Time VARCHAR (50),p_Shipping VARCHAR (50), p_Title VARCHAR (75), 
	p_Edition VARCHAR (50), p_Quantity INT (11))
READS SQL DATA
BEGIN
	DECLARE sale_ID INT;
	DECLARE book_ID INT;
	DECLARE edition_ID INT;
	DECLARE user_ID INT;

	DECLARE timestamp DATETIME;

	SELECT  CAST(CONCAT (p_Date, ' ', p_Time) AS DATETIME) INTO timestamp;
	SELECT getUserID (p_FName, p_LName) INTO user_ID;

	CALL insertSale (timestamp, user_ID, p_Discount, p_Shipping);

	SELECT getSaleID (timestamp, user_ID) INTO sale_ID;
	SELECT getBookID (p_Title) INTO book_ID;
	SELECT getEditionID (p_edition) INTO edition_ID;

	INSERT INTO InSale (SaleID, BookID, EditionID, Quantity) 
		VALUES (sale_ID, book_ID, edition_ID, p_Quantity);
END $$

-- -----------------------------------------------------------------------------
-- Procedure Description: To insert a InSale (a Sale BookEdition relationship)
-- Input: SaleID, BookID, EditionID, Quantity
-- Output: None
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE insertInSale (p_SaleID INT (11), p_BookID INT (11),
	p_EditionID INT (11), p_Quantity INT (11))
READS SQL DATA
BEGIN
	INSERT INTO InSale (SaleID, BookID, EditionID, Quantity) 
		VALUES (p_SaleID, p_BookID, p_EditionID, p_Quantity);
END $$
-- -----------------------------------------------------------------------------
-- Procedure Description: Create a Cart
-- Input: FName, LName
-- Output: None
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE CreateCart (p_FName VARCHAR(50), 
	p_LName VARCHAR(50))
BEGIN
	INSERT INTO Carts(UserID) VALUES (getUserID(p_FName, p_LName));
END $$


-- -----------------------------------------------------------------------------
-- Procedure Description: update the Discount of Carts
-- Input: FName, LName, Discount
-- Output: None
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE updateCartDiscount (p_UserID INT (11),
	p_Discount VARCHAR(50))
BEGIN
	UPDATE Carts 
	SET DiscountID = getDiscountID(p_Discount)
	WHERE `Carts`.UserID = p_UserID;
END $$

-- -----------------------------------------------------------------------------
-- Procedure Description: To insert a InCart (a Sale BookEdition relationship
--												relationship)
-- Input: FName, LName, Book, Edition, Quantity
-- Output: None
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE insertInCartFromFile (p_FName VARCHAR (50), 
	p_LName VARCHAR (50), p_Discount VARCHAR (50), p_Title VARCHAR (75), 
	p_Edition VARCHAR (50), p_Quantity INT (11))
READS SQL DATA
BEGIN
	DECLARE cart_ID INT;
	DECLARE book_ID INT;
	DECLARE edition_ID INT;
	DECLARE user_ID INT;

	SELECT getUserID (p_FName, p_LName) INTO user_ID;
	SELECT getCartID (user_ID) INTO cart_ID;
	SELECT getBookID (p_Title) INTO book_ID;
	SELECT getEditionID (p_edition) INTO edition_ID;

	CALL updateCartDiscount (user_ID, p_Discount);

	INSERT INTO InCart (CartID, BookID, EditionID, Quantity) 
		VALUES (cart_ID, book_ID, edition_ID, p_Quantity);
END $$

-- -----------------------------------------------------------------------------
-- Procedure Description: To insert a InCart (a Sale BookEdition relationship)
-- Input: CartID, BookID, EditionID, Quantity
-- Output: None
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE insertInCart (p_cartID INT (11), p_BookID INT (11),
	p_EditionID INT (11), p_Quantity INT (11))
READS SQL DATA
BEGIN
	INSERT INTO InCart (CartID, BookID, EditionID, Quantity) 
		VALUES (cart_ID, book_ID, edition_ID, p_Quantity);
END $$


-- -----------------------------------------------------------------------------
-- Function Description: To retrieve a CartID
-- Input: Name
-- Output: CartID
-- -----------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION getCartID (p_UserID INT(11))
RETURNS INT
BEGIN
	DECLARE cart_ID INT;

	SELECT CartID into cart_ID
	FROM Carts
	WHERE
		Carts.UserID = p_UserID;

	IF cart_ID IS NOT NULL THEN
		RETURN cart_ID;
	ELSE
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Cart ID null';
		RETURN NULL;
	END IF;

END $$


-- -----------------------------------------------------------------------------
-- Function Description: Calculate the Total Cost in Sale (Subtotal-discount)
-- Input: SaleID
-- Output: Total Cost (DECIMAL 15, 4)
-- -----------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION calcTotalSaleCost (p_SaleID INT (11))
RETURNS DECIMAL (15, 4)
BEGIN
	
	DECLARE subtotal DECIMAL (15, 4);
	DECLARE dollarDiscount DECIMAL (15, 4);
	DECLARE percentDiscount DECIMAL (15, 4);

	SELECT calcSubtotalInSale (p_SaleID) INTO subtotal;

	SELECT `PercentageAmount` INTO percentDiscount
	FROM `Discounts`, `Sales`
	WHERE
		Sales.`SaleID` = p_SaleID
		AND Sales.`DiscountID` = Discounts.DiscountID;

	SELECT DollarAmount INTO dollarDiscount
	FROM `Discounts`, `Sales`
	WHERE
		Sales.`SaleID` = p_SaleID
		AND Sales.`DiscountID` = Discounts.`DiscountID`;

	IF percentDiscount IS NOT NULL THEN
			RETURN ((subtotal) - ((subtotal) * percentDiscount));
	ELSEIF dollarDiscount IS NOT NULL THEN
		IF subtotal >= dollarDiscount THEN
			RETURN (subtotal - dollarDiscount);
		ELSE
			RETURN 0.0000;
		END IF;		
	ELSE
			RETURN subtotal;
	END IF;
END $$


-- -----------------------------------------------------------------------------
-- Function Description: Calculate Subtotal of a sale
-- Input: SaleID
-- Output: SubTotal (DECIMAL 15, 4)
-- -- --------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION calcSubtotalInSale (p_SaleID INT (11))
RETURNS DECIMAL (15, 4)
BEGIN
	DECLARE subtotal DECIMAL (15, 4);
	DECLARE shippingCost DECIMAL (15, 4);

	SELECT SUM(BookEditions.`Retail` * InSale.`Quantity`) INTO subtotal
	FROM BookEditions, InSale
	WHERE
		InSale.`SaleID` = p_SaleID
		AND `BookEditions`.`BookID` = InSale.`BookID`
		AND BookEditions.`EditionID` = InSale.`EditionID`
	GROUP BY `InSale`.`SaleID`;

	SELECT `Cost` INTO shippingCost
	FROM `Shipping`, `Sales`
	WHERE
		Shipping.`ShippingID` = Sales.`ShippingID`
		AND Sales.`SaleID` =  p_SaleID;

	IF subtotal IS NOT NULL AND shippingCost IS NOT NULL THEN
		RETURN subtotal + shippingCost;
	ELSE
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'sale subtotal is null';
		RETURN NULL;
	END IF;
END $$

-- -----------------------------------------------------------------------------
-- Function Description: Calculate Money Saved From Discount
-- Input: SaleID
-- Output: moneySaved (DECIMAL 15, 4)
-- -- ---------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION calcMoneySaved (p_SaleID INT (11))
RETURNS DECIMAL (15, 4)
BEGIN
	
	DECLARE subtotal DECIMAL (15, 4);
	DECLARE dollarDiscount DECIMAL (15, 4);
	DECLARE percentDiscount DECIMAL (15, 4);
	DECLARE moneySaved DECIMAL(15,4);

	SELECT calcSubtotalInSale (p_SaleID) INTO subtotal;

	SELECT `PercentageAmount` INTO percentDiscount
	FROM `Discounts`, `Sales`
	WHERE
		Sales.`SaleID` = p_SaleID
		AND Sales.`DiscountID` = Discounts.DiscountID;

	SELECT DollarAmount INTO dollarDiscount
	FROM `Discounts`, `Sales`
	WHERE
		Sales.`SaleID` = p_SaleID
		AND Sales.`DiscountID` = Discounts.`DiscountID`;

	IF percentDiscount IS NOT NULL THEN
			RETURN (subtotal * percentDiscount);
	ELSEIF dollarDiscount IS NOT NULL THEN
		IF subtotal >= dollarDiscount THEN
			RETURN dollarDiscount;
		ELSE
			RETURN subtotal;
		END IF;		
	ELSE
			RETURN null;
	END IF;
END $$


-------------------- Stored Queries Due 4/19 -----------------------------------



-- -----------------------------------------------------------------------------
-- Procedure Description: 1. Update User Email
-- Input: UID, Email
-- Output: none
-- -- --------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE updateUserEmail (p_UID INT (11), 
	p_email VARCHAR (50))
MODIFIES SQL DATA
BEGIN
	UPDATE `Users`
	SET Email = p_email 
	WHERE 
		`UserID` = p_UID;
END $$

-- -----------------------------------------------------------------------------
-- Function Description: 2. Get User (display user profile)
-- Input: UID
-- Output: FName, LName, Username, CreationDate, Email
-- -- --------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE getUser (p_UID INT (11))       
READS SQL DATA
BEGIN
	SELECT FName, LName, Username, CreationDate, Email
	FROM `Users`
	WHERE
		`Users`.`UserID` = p_UID;
END $$

-- -----------------------------------------------------------------------------
-- Procedure Description: 3. display all the books in the store, a page at
-- a time, displaying Number per page.
-- Input: P-StartIndex, p_Number
-- Output: EndIndex, PageNum
-- -----------------------------------------------------------------------------
CREATE  OR REPLACE VIEW BookAuthors_VW AS
SELECT Title, BookID,
	(SELECT GROUP_CONCAT(Authors.FName, ' ', Authors.LName SEPARATOR ', ')
	FROM Writes
	JOIN Authors ON Writes.AuthorID = Authors.AuthorID
	WHERE Writes.BookID = Books.BookID
	GROUP BY Writes.BookID) AS Authors
FROM Books;

CREATE OR REPLACE VIEW AllBookEditions_VW AS
SELECT BookAuthors_VW.Title, BookAuthors_VW.Authors, BookEditions.BookID, 
	BookEditions.EditionID, BookEditions.ISBN, Editions.`EditionName` AS Edition
FROM BookAuthors_VW
JOIN BookEditions ON BookAuthors_VW.BookID = BookEditions.BookID
JOIN Editions ON BookEditions.EditionID = Editions.EditionID
ORDER BY ISBN ASC;


CREATE OR REPLACE PROCEDURE GetBookEditions(p_StartIndex INT(15), 
	p_Number INT(15), OUT EndIndex INT, OUT PageNum INT)
BEGIN
	DECLARE tableCount INT;
	SELECT COUNT(*) FROM AllBookEditions_VW INTO tableCount;
	IF (p_StartIndex > tableCount) THEN
		SET EndIndex = tableCount;
	ELSE
		SELECT ISBN, Title, Edition, Authors
		FROM AllBookEditions_VW 
		ORDER BY `ISBN` ASC
		LIMIT p_Number
		OFFSET p_StartIndex;
		SET EndIndex = (p_StartIndex + p_Number);
		SET PageNum = p_Number;
	END IF;
END $$

-- -----------------------------------------------------------------------------
-- Procedure Description: 4. display all the information about that
-- book edition including quantity in stock and price.
-- Input: P-BookID, p_EditionID
-- Output: Stock, Price
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE GetBookEditionInfo(p_BookID INT(15), 
	p_EditionID INT(15), OUT Stock INT, OUT Price INT)
BEGIN
	SELECT Title, EditionName as 'Edition', Quantity as 'Stock', Retail, ISBN, 
		PubDate
	FROM BookEditions, Books, Editions
	WHERE BookEditions.BookID = Books.BookID
	AND BookEditions.EditionID = Editions.`EditionID`
	AND BookEditions.BookID = p_BookID
	AND BookEditions.EditionID = p_EditionID;
	
	SELECT Quantity into Stock
	FROM BookEditions 
	WHERE BookEditions.BookID = p_BookID 
	AND BookEditions.EditionID = p_EditionID;

	SELECT Retail into Price
	FROM BookEditions 
	WHERE BookEditions.BookID = p_BookID 
	AND BookEditions.EditionID = p_EditionID;
END $$


-- -----------------------------------------------------------------------------
-- Procedure Description: 5. Add BookEdition to wishlist
-- Input: UID, BookID, EditionID, Qty, Note, WishlistID
-- Output: none
-- -- --------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE AddBookEditionToWishlist (p_BookID INT (11),
	p_EditionID INT (11), p_Qty INT (11), p_Note VARCHAR (300),
	p_WishlistID INT (11))
MODIFIES SQL DATA
BEGIN
	DECLARE bookInWishlist INT;

	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
		RESIGNAL;
	END;

	SET autocommit = 0;
	START TRANSACTION;
		
		SELECT COUNT(*) INTO bookInWishlist
		FROM InWishList
		WHERE
			`InWishList`.WishlistID = p_WishlistID
			AND `InWishList`.`BookID` = p_BookID
			AND `InWishList`.`EditionID` = p_EditionID;

		IF (bookInWishlist > 0) THEN
			CALL AlterQtyInWishlist (p_BookID, p_EditionID, p_Qty, p_WishlistID);
		ELSE
			IF (p_Qty < 1) THEN
				SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = 'Must add at least 1 book to wishlist';
			ELSE
				INSERT INTO `InWishList` (`WishListID`, `BookID`, `EditionID`,
				`Quantity`, `Note`) VALUES 
				(p_WishlistID, p_BookID, p_EditionID, p_Qty, p_Note);
			END IF;
		END IF;
	COMMIT;
	SET autocommit = 1;
END $$


-- -----------------------------------------------------------------------------
-- Procedure Description: Alter (+/-) quantity of bookEdition in wishlist
-- Input: UID, BookID, EditionID, WishlistID
-- Output: none
-- -- --------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE AlterQtyInWishList (p_BookID INT (11), 
	p_EditionID INT (11), p_QtyChange INT (11), p_WishlistID INT (11))
MODIFIES SQL DATA
BEGIN

	DECLARE bookQuantity INT;

	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
		RESIGNAL;
	END;

	SET autocommit = 0;
	START TRANSACTION;
		
		SELECT Quantity INTO bookQuantity
		FROM InWishList
		WHERE
			`InWishList`.WishlistID = p_WishlistID
			AND `InWishList`.`BookID` = p_BookID
			AND `InWishList`.`EditionID` = p_EditionID;

		IF (bookQuantity + p_QtyChange < 1) THEN
			DELETE FROM `InWishList` 
			WHERE
				`InWishList`.WishlistID = p_WishlistID
				AND `InWishList`.`BookID` = p_BookID
				AND `InWishList`.`EditionID` = p_EditionID;
		ELSE
			UPDATE `InWishList`
				SET `Quantity` = `Quantity`+ p_QtyChange
				WHERE
					`InWishList`.`BookID` = p_BookID
					AND `InWishList`.`EditionID` = p_EditionID
					AND `InWishList`.`WishListID` = p_WishlistID;
		END IF;
	COMMIT;
	SET autocommit = 1;
END $$


-- -----------------------------------------------------------------------------
-- Procedure Description: 6. Add BookEdition to cart
-- Input: UID, BookID, EditionID, Qty
-- Output: none
-- -- --------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE AddBookEditionToCart (p_UID INT (11), 
	p_BookID INT (11), p_EditionID INT (11), p_Qty INT (11))
MODIFIES SQL DATA
BEGIN
	DECLARE cart_ID INT (11);
	DECLARE bookInCart INT;

	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
		RESIGNAL;
	END;

	SET autocommit = 0;
	START TRANSACTION;

		SELECT getCartID (p_UID) INTO cart_ID;

		SELECT COUNT(*) INTO bookInCart
		FROM InCart
		WHERE
			`InCart`.`CartID` = cart_ID
			AND `InCart`.`BookID` = p_BookID
			AND `InCart`.`EditionID` = p_EditionID;

		IF (bookInCart > 0) THEN
			CALL AlterQtyInCart(p_UID, p_BookID, p_EditionID, p_Qty);
		ELSE
			IF (p_Qty < 1) THEN
				SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = 'Must add at least 1 book to cart';
			ELSE
				CALL AlterQtyInBookstore (p_BookID, p_EditionID, p_Qty);  
				INSERT INTO `InCart` (`CartID`, `BookID`, `EditionID`, `Quantity`)
				VALUES (cart_ID, p_BookID, p_EditionID, p_Qty);
			END IF;
		END IF;
	COMMIT;
	SET autocommit = 1;
END $$


-- -----------------------------------------------------------------------------
-- Procedure Description: 7. Alter quantity of bookEditions in cart
-- Input: BookID, EditionID, Qty
-- Output: none
-- -- --------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE AlterQtyInCart (p_UID INT (11), 
	p_BookID INT (11), p_EditionID INT (11), p_QtyChange INT (11))
MODIFIES SQL DATA
BEGIN
	DECLARE bookQuantity INT;
	DECLARE cart_ID INT (11);
	DECLARE bookInCart INT;

	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
		RESIGNAL;
	END;

	SET autocommit = 0;
	START TRANSACTION;

		SELECT getCartID (p_UID) INTO cart_ID;

		SELECT Quantity INTO bookQuantity
		FROM `InCart`
		WHERE
			`InCart`.`CartID` = cart_ID
			AND `InCart`.`BookID` = p_BookID
			AND `InCart`.`EditionID` = p_EditionID;

		IF (bookQuantity + p_QtyChange < 1) THEN
			CALL `AlterQtyInBookstore` (p_BookID, p_EditionID, p_QtyChange);

			DELETE FROM `InCart`
			WHERE
				`InCart`.`CartID` = cart_ID
				AND `InCart`.`BookID` = p_BookID
				AND `InCart`.`EditionID` = p_EditionID;
		ELSE
			CALL AlterQtyInBookstore (p_BookID, p_EditionID, p_QtyChange);  
			
			UPDATE `InCart`
				SET `Quantity` = `Quantity`+ p_QtyChange
				WHERE
					`InCart`.`CartID` = cart_ID
					AND `InCart`.`BookID` = p_BookID
					AND `InCart`.`EditionID` = p_EditionID;
		END IF;
	COMMIT;
	SET autocommit = 1;
END $$

-- -----------------------------------------------------------------------------
-- Procedure Description: remove books from bookstore quantity (stock)
-- Input: BookID, EditionID, Qty
-- Output: none
-- -- --------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE AlterQtyInBookstore (p_BookID INT (11), 
	p_EditionID INT (11), p_QtyChange INT (11))
MODIFIES SQL DATA
BEGIN
	DECLARE bookQuantity INT;

	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
		RESIGNAL;
	END;

	SET autocommit = 0;
	START TRANSACTION;
		
		SELECT Quantity INTO bookQuantity
		FROM `BookEditions`
		WHERE
			BookEditions.`BookID` = p_BookID
			AND BookEditions.`EditionID` = p_EditionID;

		IF (bookQuantity - p_QtyChange < 0) THEN
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'Not enough books in stock';
		ELSE
			UPDATE `BookEditions`
				SET `Quantity` = `Quantity`- p_QtyChange
				WHERE
					`BookEditions`.`BookID` = p_BookID
					AND `BookEditions`.`EditionID` = p_EditionID;
		END IF;
	COMMIT;
	SET autocommit = 1;
END $$

-- -----------------------------------------------------------------------------
-- Function Description: 8. Calculate Cart Cost (after discount)
-- Input: UID
-- Output: Total Cost
-- -- --------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION getCartCost (p_UID INT (11))
RETURNS DECIMAL (15, 4)
BEGIN
	
	DECLARE subtotal DECIMAL (15, 4);
	DECLARE dollarDiscount DECIMAL (15, 4);
	DECLARE percentDiscount DECIMAL (15, 4);

	SELECT calcSubtotalInCart (p_UID) INTO subtotal;

	SELECT `PercentageAmount` INTO percentDiscount
	FROM `Discounts`, `Carts`
	WHERE
		Carts.`CartID` = p_UID
		AND Carts.`DiscountID` = Discounts.DiscountID;

	SELECT DollarAmount INTO dollarDiscount
	FROM `Discounts`, `Carts`
	WHERE
		Carts.`CartID` = p_UID
		AND Carts.`DiscountID` = Discounts.`DiscountID`;

	IF percentDiscount IS NOT NULL THEN
			RETURN ((subtotal) - ((subtotal) * percentDiscount));
	ELSEIF dollarDiscount IS NOT NULL THEN
		IF subtotal >= dollarDiscount THEN
			RETURN (subtotal - dollarDiscount);
		ELSE
			RETURN 0.0000;
		END IF;		
	ELSE
			RETURN subtotal;
	END IF;
END $$

-- -----------------------------------------------------------------------------
-- Function Description: 8. Calculate subtotal Cart Cost
-- Input: CartID
-- Output: Subtotal
-- -- --------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION calcSubtotalInCart (p_CartID INT (11))
RETURNS DECIMAL (15, 4)
BEGIN
	DECLARE subtotal DECIMAL (15, 4);

	SELECT SUM(BookEditions.`Retail` * InCart.`Quantity`) INTO subtotal
	FROM BookEditions, InCart
	WHERE
		InCart.`CartID` = p_CartID
		AND `BookEditions`.`BookID` = InCart.`BookID`
		AND BookEditions.`EditionID` = InCart.`EditionID`
	GROUP BY `InCart`.`CartID`;

	IF subtotal IS NOT NULL THEN
		RETURN subtotal;
	ELSE
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'cart subtotal is null';
		RETURN NULL;
	END IF;
END $$

-- -----------------------------------------------------------------------------
-- Function Description: Calculate Total of Book in Cart
-- Input: CartID
-- Output: total
-- -- --------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION calcBookTotalInCart (p_CartID INT (11), 
 	p_ISBN VARCHAR (14))
RETURNS DECIMAL (15, 4)
BEGIN
	DECLARE total DECIMAL (15, 4);

	SELECT BookEditions.`Retail` * InCart.`Quantity` INTO total
	FROM BookEditions, InCart
	WHERE
		InCart.`CartID` = p_CartID
		AND `BookEditions`.`BookID` = InCart.`BookID`
		AND BookEditions.`EditionID` = InCart.`EditionID`
		AND `BookEditions`.`ISBN` = p_ISBN;

	IF total IS NOT NULL THEN
		RETURN total;
	ELSE
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'cart total is null';
		RETURN NULL;
	END IF;
END $$

-- -----------------------------------------------------------------------------
-- Procedure Description: 9. move cart items back to the store, no sale made
-- Input: UserID
-- Output: None
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE ClearCart_NoPurchase (p_UserID INT(11))
BEGIN
	DECLARE c_BookID INT(11);
	DECLARE c_EditionID INT(11);
	DECLARE c_Quantity INT(11);

  DECLARE done BOOLEAN DEFAULT FALSE;
	DECLARE userCartCursor CURSOR FOR
			SELECT BookID, EditionID, Quantity
			FROM InCart
			WHERE CartID = p_UserID;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
		RESIGNAL;
	END;
	SET autocommit = 0;

	START TRANSACTION;
	OPEN userCartCursor;
	FETCH userCartCursor INTO c_BookID, c_EditionID, c_Quantity;

	WHILE NOT done DO
		UPDATE BookEditions
		SET Quantity = Quantity + c_Quantity
		WHERE BookID = c_BookID AND EditionID = c_EditionID;

		FETCH userCartCursor INTO c_BookID, c_EditionID, c_Quantity;
	END WHILE;
	CLOSE userCartCursor;

	DELETE FROM InCart WHERE CartID = p_UserID;
	UPDATE Carts SET DiscountID = NULL WHERE UserID = p_UserID;
	COMMIT;
	SET autocommit = 1;
END $$

-- -----------------------------------------------------------------------------
-- Procedure Description: 10. Create Account
-- Input: All User Table Columns (except UserID)
-- Output: None
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE CreateAccount (p_FName VARCHAR(50), 
	p_LName VARCHAR(50), p_Username VARCHAR(50), p_hashedPasswd VARBINARY(512),  
	p_salt VARBINARY(512), p_CreationDate DATE, p_Email VARCHAR(150))
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
		RESIGNAL;
	END;
	SET autocommit = 0;
	START TRANSACTION;
		INSERT INTO Users (FName, LName, Username, hashedPasswd, salt, CreationDate, 
				Email) VALUES 
			(p_FName, p_LName , p_Username, p_hashedPasswd, p_salt, p_CreationDate, 
			p_Email);
	COMMIT;
	SET autocommit = 1;
END $$


------------------------- Added for Front End/Final portion --------------------

-- -----------------------------------------------------------------------------
-- Function Description: getSalt
-- Input: username
-- Output: salt
-- -- --------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION GetSalt(p_Username VARCHAR(50))
RETURNS VARBINARY (512)
BEGIN

	DECLARE saltVal VARBINARY (512);

	SELECT salt INTO saltVal
	FROM `Users`
	WHERE
		Users.`Username` = p_Username;

	RETURN saltVal;
END $$

-- -----------------------------------------------------------------------------
-- Function Description: GetHashedPswd
-- Input: username
-- Output: hashedPswd
-- -- --------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION GetHashedPswd(p_Username VARCHAR(50))
RETURNS VARBINARY (512)
BEGIN

	DECLARE hashPswd VARBINARY (512);

	SELECT `hashedPasswd` INTO hashPswd
	FROM `Users`
	WHERE
		Users.`Username` = p_Username;

	RETURN hashPswd;
END $$

-- -----------------------------------------------------------------------------
-- Function Description: To retrieve a UserID with username
-- Input: Username
-- Output: UserID
-- -----------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION GetUserIDWithUName (p_Username VARCHAR(50))
RETURNS INT
BEGIN
	DECLARE user_ID INT;

	SELECT UserID into user_ID
	FROM Users
	WHERE
		Users.`Username` = p_Username;

	IF user_ID IS NOT NULL THEN
		RETURN user_ID;
	ELSE
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'User ID null';
		RETURN NULL;
	END IF;

END $$

-- -----------------------------------------------------------------------------
-- View Description: list all authors of a book
-- -----------------------------------------------------------------------------

CREATE OR REPLACE VIEW Writes_VW AS 
SELECT Authors.`AuthorID`, Authors.FName, Authors.LName, Books.`BookID`, 
	Books.`Title`, BookEditions.ISBN, BookEditions.`EditionID`
FROM `Authors`, `Writes`, `Books`, BookEditions
	WHERE
		`Writes`.`AuthorID` = Authors.`AuthorID`
		AND Writes.`BookID` = Books.`BookID`
		AND `BookEditions`.`BookID` = Writes.`BookID`; 

-- -----------------------------------------------------------------------------
-- Procedure Description: Display names of authors
-- Input: BookID, EditionID
-- Output: FName, LName
-- Views: Writes_VW
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE getAuthors (p_BookID INT (11))
READS SQL DATA
BEGIN
	SELECT DISTINCT CONCAT(Writes_VW.`FName`, " ", Writes_VW.`LName`) AS Name
	FROM `Writes_VW`
	WHERE
		`Writes_VW`.`BookID` = p_BookID;
END $$
CALL getAuthors(216)

-- -----------------------------------------------------------------------------
-- View Description: List all attributes for displaying a cart
-- -----------------------------------------------------------------------------

CREATE OR REPLACE VIEW FrontEndCart_VW AS
SELECT Carts.UserID AS UserID, Users.FName, Users.LName, Carts.`DiscountID`, 
	BookEditions.`ISBN`,BookEditions.BookID, Books.Title, BookEditions.
	`EditionID`, Editions.`EditionName`, BookEditions.`Retail`, InCart.`Quantity`, 
	calcBookTotalInCart (Carts.`CartID`, BookEditions.`ISBN`) AS BookTotal
FROM `Carts`, InCart, BookEditions, Books, Editions, Users
WHERE 
	Carts.`CartID` = InCart.`CartID`
	AND InCart.`BookID` = BookEditions.`BookID`
	AND InCart.`EditionID` = BookEditions.`EditionID`
	AND BookEditions.`BookID` = Books.`BookID`
	AND BookEditions.`EditionID` = Editions.`EditionID`
	AND Carts.`UserID` = Users.`UserID`;

-- -----------------------------------------------------------------------------
-- Procedure Description: Display the books and prices in a users cart
-- Input: UserID
-- Output: ISBN, Title, Authors, Retail, Quantity, BookTotalPrice, Total Price
-- -----------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE GetCart (p_UserID INT (11), 
	OUT TotalPrice DECIMAL (14, 4))
READS SQL DATA
BEGIN

	DECLARE bookTotal DECIMAL (15, 4);

	SELECT `FrontEndCart_VW`.ISBN, FrontEndCart_VW.Title, 
		FrontEndCart_VW.`Retail`, FrontEndCart_VW.`Quantity`,
		FrontEndCart_VW.BookTotal, FrontEndCart_VW.`BookID`, 
		FrontEndCart_VW.`EditionID`
	FROM `FrontEndCart_VW`
	WHERE
		FrontEndCart_VW.`UserID` = p_UserID;

	SELECT getCartCost (p_UserID) INTO TotalPrice; 
END $$

-- -----------------------------------------------------------------------------
-- Function Description: To retrieve the discount value on a users cart
-- Input: UserID
-- Output: Discount Value
-- -----------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION GetUserDiscount (p_UserID INT (11))
RETURNS DECIMAL (15, 4)
BEGIN

	DECLARE percentDiscount DECIMAL (15, 4);
	DECLARE dollarDiscount DECIMAL (15, 4);

	SELECT `PercentageAmount` INTO percentDiscount
	FROM `Discounts`, `Carts`
	WHERE
		Carts.`CartID` = p_UserID
		AND Carts.`DiscountID` = Discounts.DiscountID;

	SELECT DollarAmount INTO dollarDiscount
	FROM `Discounts`, `Carts`
	WHERE
		Carts.`CartID` = p_UserID
		AND Carts.`DiscountID` = Discounts.`DiscountID`;
	
	IF percentDiscount IS NOT NULL THEN
		return percentDiscount;
	ELSEIF dollarDiscount IS NOT NULL THEN
		return dollarDiscount;
	ELSE
		return NULL;
	END IF;
END $$

-- -----------------------------------------------------------------------------
-- Function Description: To retrieve the discount name on a cart
-- Input: UserID
-- Output: Discount Name
-- -----------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION getDiscountIDByUser (p_UserID INT (11))
RETURNS INT
BEGIN
	DECLARE discount_ID INT;

	SELECT Discounts.DiscountID into discount_ID
	FROM `Discounts`, `Carts`
	WHERE
		Discounts.`DiscountID` = Carts.`DiscountID`
		AND Carts.`CartID` =  p_UserID;

	IF discount_ID IS NOT NULL THEN
		RETURN discount_ID;
	ELSE
		RETURN NULL;
	END IF;

END $$

-- -----------------------------------------------------------------------------
-- Function Description: To retrieve the discount value of a discount
-- Input: DiscountID
-- Output: Discount Value
-- -----------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION GetDiscount (p_DiscountID INT (11))
RETURNS DECIMAL (15, 4)
BEGIN

	DECLARE percentDiscount DECIMAL (15, 4);
	DECLARE dollarDiscount DECIMAL (15, 4);

	SELECT `PercentageAmount` INTO percentDiscount
	FROM `Discounts`, `Carts`
	WHERE
		Discounts.`DiscountID` = p_DiscountID;

	SELECT DollarAmount INTO dollarDiscount
	FROM `Discounts`, `Carts`
	WHERE
		Discounts.`DiscountID` = p_DiscountID;
	
	IF percentDiscount IS NOT NULL THEN
		return percentDiscount;
	ELSEIF dollarDiscount IS NOT NULL THEN
		return dollarDiscount;
	ELSE
		return NULL;
	END IF;
END $$

-- -----------------------------------------------------------------------------
-- Prceudure Description: To retrieve list of Discounts Available
-- Input: UserID
-- Output: Discount Value
-- -----------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE GetAllDiscounts ()
READS SQL DATA
BEGIN
	SELECT DiscountID, DiscountName, `PercentageAmount`, `DollarAmount`
	FROM `Discounts`;
END $$

-- -----------------------------------------------------------------------------
-- Procedure Description: To retrieve list of all shipping methods
-- Input:
-- Output: ShippingID, ShippingType, Speed, Cost
-- -----------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE GetShippingMethods () 
READS SQL DATA
BEGIN
	SELECT `ShippingID`, `ShippingType`, `Speed`, `Cost`
	FROM Shipping;
END $$

-- -----------------------------------------------------------------------------
-- Procedure Description: Checkout Cart (move Cart to sale)
-- Input: UserID
-- Output: None
-- -----------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE CheckoutCart (p_UserID INT(11),
	p_ShippingID INT (11))
BEGIN
	DECLARE c_BookID INT(11);
	DECLARE c_EditionID INT(11);
	DECLARE c_Quantity INT(11);
	DECLARE discountID INT (11);
	DECLARE sale_ID INT (11);
	DECLARE time_stamp DATETIME;

  DECLARE done BOOLEAN DEFAULT FALSE;
	DECLARE userCartCursor CURSOR FOR
			SELECT BookID, EditionID, Quantity
			FROM InCart
			WHERE CartID = p_UserID;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
		RESIGNAL;
	END;
	SET autocommit = 0;

	START TRANSACTION;
	OPEN userCartCursor;
	FETCH userCartCursor INTO c_BookID, c_EditionID, c_Quantity;

	-- get discountID and current timestamp
	SELECT getDiscountIDByUser (p_UserID) INTO discountID;
	SELECT CURRENT_TIMESTAMP INTO time_stamp;

	-- insert sale
  INSERT INTO `Sales` (`Timestamp`, `DiscountID`, `UserID`, 
		`ShippingID`) VALUES
		(time_stamp, discountID, p_UserID, p_ShippingID);
  
	-- get sale id that was just created
  SELECT getSaleID (time_stamp, p_UserID) INTO sale_ID;

	WHILE NOT done DO

		-- insert each row of Incart into InSale
		INSERT INTO `InSale` (`SaleID`, `BookID`, `EditionID`, `Quantity`) VALUES
			(sale_ID, c_BookID, c_EditionID, c_Quantity);

		FETCH userCartCursor INTO c_BookID, c_EditionID, c_Quantity;
	END WHILE;
	CLOSE userCartCursor;

	-- delete from in cart
	DELETE FROM `InCart`
		WHERE
			InCart.`CartID` = p_UserID;

	COMMIT;
	SET autocommit = 1;
END $$

-- --------------------------------------------------------------------------
-- Function Description: To retrieve a book title
-- Input: BookID
-- Output: Title
-- --------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION getTitle (p_BookID INT (11))
RETURNS VARCHAR (50)
BEGIN
	DECLARE bookTitle VARCHAR (50);

	SELECT Title INTO bookTitle
	FROM `Books`
	WHERE
		`BookID` = p_BookID;
	
	IF bookTitle IS NOT NULL THEN
		RETURN bookTitle;
	ELSE
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Book Title null';
		RETURN NULL;
	END IF;
END $$

-- -----------------------------------------------------------------------------
-- Function Description: To retrieve a user's first and last name from id
-- Input: UserID
-- Output: FName, LName
-- -----------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE getUserName (p_UserID INT (11))
BEGIN
	SELECT FName, LName
	FROM `Users`
	WHERE
		Users.`UserID` = p_UserID;
END $$

-- -----------------------------------------------------------------------------
-- View Description: Show all books with list of their author(s) as a column
-- -----------------------------------------------------------------------------
CREATE  OR REPLACE VIEW BookAuthors_VW AS
SELECT Title, BookID,
	(SELECT GROUP_CONCAT(Authors.FName, ' ', Authors.LName SEPARATOR ', ')
	FROM Writes
	JOIN Authors ON Writes.AuthorID = Authors.AuthorID
	WHERE Writes.BookID = Books.BookID
	GROUP BY Writes.BookID) AS Authors
FROM Books;

-- -----------------------------------------------------------------------------
-- Prceudure Description: To retrieve a specific number of Book Editions to 
--												display
-- Input: StartIndex, Number, EndIndex, PageNum
-- Output: ISBN, Title, Edition, Authors
-- -----------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE GetBookEditions(p_StartIndex INT(15), 
	p_Number INT(15), OUT EndIndex INT, OUT PageNum INT)
BEGIN
	DECLARE tableCount INT;
	SELECT COUNT(*) FROM AllBookEditions_VW INTO tableCount;
	IF (p_StartIndex > tableCount) THEN
		SET EndIndex = tableCount;
	ELSE
		SELECT ISBN, Title, Edition, Authors
		FROM AllBookEditions_VW 
		ORDER BY `ISBN` ASC
		LIMIT p_Number
		OFFSET p_StartIndex;
		SET EndIndex = (p_StartIndex + p_Number);
		SET PageNum = p_Number;
	END IF;
END $$

-- -----------------------------------------------------------------------------
-- View Description: Show all books Editions
-- -----------------------------------------------------------------------------
CREATE OR REPLACE VIEW AllBookEditions_VW AS
SELECT BookEditions.ISBN, BookAuthors_VW.Title,
	Editions.`EditionName` AS Edition, BookAuthors_VW.Authors
FROM BookAuthors_VW
JOIN BookEditions ON BookAuthors_VW.BookID = BookEditions.BookID
JOIN Editions ON BookEditions.EditionID = Editions.EditionID
ORDER BY ISBN ASC;

-- -----------------------------------------------------------------------------
-- Function Description: Count book editions
-- Input: 
-- Output: Count
-- -----------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION BookEditionsCount()
RETURNS INT
BEGIN
	DECLARE rowCount INT;

	SELECT COUNT(*) INTO rowCount
	FROM `AllBookEditions_VW`;

	RETURN rowCount; 
END $$

-- -----------------------------------------------------------------------------
-- Prceudure Description: Search for Book By Title
-- Input: SearchText, StartIndex, NumPerPage, EndIndex, PageNum
-- Output: *
-- -----------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE SearchBookByTitle(p_SearchTerm VARCHAR(75), 
	p_StartIndex INT, p_NumPerPage INT, OUT EndIndex INT, OUT PageNum INT)
BEGIN
    DECLARE EndIndex INT;
    SET EndIndex = p_StartIndex + p_NumPerPage;
    SET PageNum = p_NumPerPage;


    SELECT *
    FROM `AllBookEditions_VW`
    WHERE Title LIKE CONCAT('%', p_SearchTerm, '%')
    LIMIT p_NumPerPage
		OFFSET p_StartIndex;
END;

CREATE OR REPLACE PROCEDURE AuthorNames()
BEGIN
	SELECT CONCAT(FName, ' ', LName) AS Name FROM Authors;
END $$

-- -----------------------------------------------------------------------------
-- Procedure Description: Output books written by given author
-- Input: UserID
-- Output: Discount Value
-- -----------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE GetBookEditionsByAuthor(p_AuthorName VARCHAR(75))
BEGIN
		SELECT ISBN, Title, Edition, Authors
		FROM AllBookEditions_VW
		WHERE Authors LIKE CONCAT('%', p_AuthorName, '%')
		ORDER BY `ISBN` ASC;
END $$

-- -----------------------------------------------------------------------------
-- Procedure Description: Get Book Info with ISBN
-- Input: ISBN
-- Output: *
-- -----------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE GetBookDetailsByISBN(IN p_ISBN VARCHAR(20))
BEGIN
		DECLARE v_BookID INT;
    DECLARE v_Cover VARCHAR(255);
    DECLARE v_Title VARCHAR(255);
    DECLARE v_Authors VARCHAR(255);
    DECLARE v_Edition VARCHAR(50);
    DECLARE v_Retail DECIMAL(15,4);
    DECLARE v_Quantity INT;


    SELECT BookID INTO v_BookID 
		FROM BookEditions 
		WHERE ISBN = p_ISBN;

    
    SELECT Cover INTO v_Cover 
		FROM Books 
		WHERE BookID = v_BookID;

    SELECT Title, Edition, Authors INTO v_Title, v_Edition, v_Authors 
		FROM AllBookEditions_VW 
		WHERE ISBN = p_ISBN;

    SELECT Retail, Quantity INTO v_Retail, v_Quantity 
		FROM BookEditions 
		WHERE ISBN = p_ISBN;

    SELECT v_Cover AS Cover, p_ISBN AS ISBN, v_Title AS Title, 
			v_Edition AS Edition, v_Authors AS Authors, v_Retail AS Retail, 
			v_Quantity AS Quantity;
END $$

-- -----------------------------------------------------------------------------
-- Procedure Description: Find user's name by ID
-- Input: UserID
-- Output: Fname, LName
-- -----------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE GetUserFullName(p_UserID INT)
BEGIN
    DECLARE fullName VARCHAR(255);
    
    SELECT CONCAT(FName, ' ', LName) AS fullName
    FROM Users
    WHERE UserID = p_UserID;
    
END $$
