

-- -----------------------------------------------------------------------------
--  File name:  Create.sql
--  Author:     Alyssa Dixon, Amber Swain
--  Date:       March 22, 2024
--  Class:      CS445
--  Assignment: Bookstore
--  Purpose:    Contains the SQL create table statements
-- -----------------------------------------------------------------------------
drop database if exists BookstoreDB;
create database BookstoreDB;

use BookstoreDB;   

CREATE OR REPLACE TABLE Publishers (
	PubID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	Name VARCHAR (50),
	CONSTRAINT Publishers_Name_U UNIQUE (Name)
) Engine=InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin;

CREATE OR REPLACE TABLE Authors (
	AuthorID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	FName VARCHAR (50),
	LName VARCHAR (50),
	CONSTRAINT Authors_FName_LName_U UNIQUE (FName, LName)
) Engine=InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin;

CREATE OR REPLACE TABLE Books (
	BookID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	Title VARCHAR (75),
	Cover VARCHAR (150),
	CONSTRAINT Books_Title_U UNIQUE (Title)
) Engine=InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin;

CREATE OR REPLACE TABLE Writes (
	BookID INT NOT NULL,
	AuthorID INT NOT NULL,
	CONSTRAINT Writes_AuthorID_BookID_PK PRIMARY KEY (BookID, AuthorID),
	CONSTRAINT Writes_AuthorID_FK FOREIGN KEY (AuthorID)
		REFERENCES Authors (AuthorID) ON DELETE CASCADE,
	CONSTRAINT Writes_BookID_FK FOREIGN KEY (BookID)
		REFERENCES Books (BookID) ON DELETE CASCADE
) Engine=InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin;

CREATE OR REPLACE TABLE Editions (
	EditionID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	EditionName VARCHAR (50),
	INDEX Editions_EditionName_IDX (EditionName),
	CONSTRAINT Editions_EditionName_U UNIQUE (EditionName)
) Engine=InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin;

CREATE OR REPLACE TABLE BookEditions (
	BookID INT NOT NULL,
	EditionID INT NOT NULL,
	ISBN VARCHAR (14),
	Quantity INT (5) NOT NULL,
	Wholesale DECIMAL (15, 4) NOT NULL,
	Retail DECIMAL (15, 4) NOT NULL,
	PubID INT NOT NULL,
	PubDate DATE NOT NULL,
	AuthorID INT DEFAULT NULL,
	INDEX BookEditions_Quantity_IDX (Quantity),
	CONSTRAINT BookEditions_AuthorID_EditionID_PK PRIMARY KEY (BookID, EditionID),
	CONSTRAINT Writes_EditionID_FK FOREIGN KEY (EditionID)
		REFERENCES Editions (EditionID) ON DELETE CASCADE,
	CONSTRAINT BookEditions_BookID_FK FOREIGN KEY (BookID)
		REFERENCES Books (BookID) ON DELETE CASCADE,
	CONSTRAINT BookEditions_PubID_FK FOREIGN KEY (PubID)
		REFERENCES Publishers (PubID),
	CONSTRAINT BookEditions_AuthorID_FK FOREIGN KEY (AuthorID)              
		REFERENCES Authors (AuthorID) ON DELETE CASCADE,
	CONSTRAINT BookEditions_ISBN_U UNIQUE (ISBN),
	CONSTRAINT BookEditions_ISBN_CHK CHECK (length(ISBN) = 10 OR
		length(ISBN) = 13)
) Engine=InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin;


CREATE OR REPLACE TABLE Users (
	UserID INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
	FName VARCHAR(50) NOT NULL,
	LName VARCHAR(50) NOT NULL,
	Username VARCHAR(50) NOT NULL,
	hashedPasswd VARBINARY(512) NOT NULL,
	salt VARBINARY(512) NOT NULL,
	CreationDate DATE NOT NULL,
	Email VARCHAR(150) NOT NULL,
	INDEX Users_FName_LName_IDX (FName, LName),
	INDEX Users_CreationDate_IDX (CreationDate),
	CONSTRAINT Users_Username_U UNIQUE (Username),
	CONSTRAINT Users_Email_U UNIQUE (Email),
	CONSTRAINT Users_ProperEmailFormat_CHK CHECK (Email LIKE '%_@_%._%')
) Engine=InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin;

CREATE OR REPLACE TABLE Shipping (
	ShippingID INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
	ShippingType VARCHAR(50) NOT NULL,
	Speed VARCHAR(50) NOT NULL,
	Cost DECIMAL (15, 4) NOT NULL,
	CONSTRAINT Shipping_ShippingType_U UNIQUE (ShippingType)
) Engine=InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin;

CREATE OR REPLACE TABLE Discounts (
	DiscountID INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
	DiscountName VARCHAR(50) NOT NULL,
	PercentageAmount DEC(15,4) DEFAULT NULL,
	DollarAmount DEC(15,4) DEFAULT NULL,
	StartDate DATE DEFAULT NULL,
	EndDate DATE DEFAULT NULL,
	CONSTRAINT Discounts_DiscountName_U UNIQUE (DiscountName),
	CONSTRAINT CheckPercentageAmount CHECK 
		(PercentageAmount >= 0 AND PercentageAmount <= 1),
	CONSTRAINT CheckDollarAmount CHECK (DollarAmount >= 0),
	CONSTRAINT CheckDiscountNulls CHECK (
		(DollarAmount IS NOT NULL AND PercentageAmount IS NULL) OR 
		(DollarAmount IS NULL AND PercentageAmount IS NOT NULL))
) Engine=InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin;

CREATE OR REPLACE TABLE Carts (
	CartID INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
	DiscountID INT(11) DEFAULT NULL,
	UserID INT(11) NOT NULL UNIQUE,
	CONSTRAINT Cart_DiscountID_FK FOREIGN KEY (DiscountID) 
		REFERENCES Discounts (DiscountID) ON DELETE CASCADE,
	CONSTRAINT Cart_UserID_FK FOREIGN KEY (UserID) 
		REFERENCES Users (UserID)
) Engine=InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin;

CREATE OR REPLACE TABLE WishLists (
	WishListID INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
	WishListName VARCHAR(50) NOT NULL,
	UserID INT(11) NOT NULL,    
	CONSTRAINT WishList_UserID_FK FOREIGN KEY (UserID) 
		REFERENCES Users (UserID) ON DELETE CASCADE,
	CONSTRAINT WishList_UserID_WLName_U UNIQUE (UserID, WishListName)
) Engine=InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin;



CREATE OR REPLACE TABLE Sales (
	SaleID INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
	Timestamp DATETIME NOT NULL,
	DiscountID INT(11) DEFAULT NULL,
	UserID INT(11) NOT NULL,
	ShippingID INT(11) NOT NULL,
	INDEX Sales_Timestamp_IDX (Timestamp),
	CONSTRAINT Sale_ShippingID_FK FOREIGN KEY (ShippingID) 
		REFERENCES Shipping (ShippingID),
	CONSTRAINT Sale_UserID_FK FOREIGN KEY (UserID) 
		REFERENCES Users (UserID) ON DELETE CASCADE,
	CONSTRAINT Sale_DiscountID_FK FOREIGN KEY (DiscountID) 
		REFERENCES Discounts (DiscountID),
	CONSTRAINT Sale_UserID_Timestamp_U UNIQUE (UserID, Timestamp)
) Engine=InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin;

CREATE OR REPLACE TABLE InWishList (
	WishListID INT(11) NOT NULL,
	BookID INT (11) NOT NULL,
	EditionID INT(11) NOT NULL,
	Quantity INT (11) NOT NULL,
	Note VARCHAR(300),
	CONSTRAINT InWishList_WishListID_BookID_EditionID_PK 
		PRIMARY KEY (WishListID, BookID, EditionID),
	CONSTRAINT InWishList_BookEditions_FK FOREIGN KEY (BookID, EditionID) 
		REFERENCES BookEditions (BookID, EditionID) ON DELETE CASCADE,
	CONSTRAINT InWishList_WishListID_FK FOREIGN KEY (WishListID) 
		REFERENCES WishLists (WishListID) ON DELETE CASCADE,
	CONSTRAINT InWishList_WishListID_BookEditinID_U 
		UNIQUE (WishListID, BookID, EditionID)
) Engine=InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin;


CREATE OR REPLACE TABLE InSale (
	SaleID INT(11) NOT NULL,
	BookID INT (11) NOT NULL,
	EditionID INT(11) NOT NULL,
	Quantity INT(11) NOT NULL,
	CONSTRAINT InSale_SaleID_FK FOREIGN KEY (SaleID) 
		REFERENCES Sales (SaleID),
	CONSTRAINT InSale_BookID_EditionID_FK FOREIGN KEY (BookID, EditionID) 
		REFERENCES BookEditions (BookID, EditionID),
	CONSTRAINT InSale_SaleID_BookID_EditionID_PK 
		PRIMARY KEY (SaleID, BookID, EditionID)
) Engine=InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin;


CREATE OR REPLACE TABLE InCart (
	CartID INT(11) NOT NULL,
	BookID INT (11) NOT NULL,
	EditionID INT(11) NOT NULL,
	Quantity INT(11) NOT NULL,
	CONSTRAINT InCart_CartID_BookID_EditionID_PK 
		PRIMARY KEY (CartID, BookID, EditionID),
	CONSTRAINT InCart_CartID_FK FOREIGN KEY (CartID) 
		REFERENCES Carts (CartID) ON DELETE CASCADE,
	CONSTRAINT InCart_BookID_EditionID_FK FOREIGN KEY (BookID, EditionID) 
		REFERENCES BookEditions (BookID, EditionID) ON DELETE CASCADE
) Engine=InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin;