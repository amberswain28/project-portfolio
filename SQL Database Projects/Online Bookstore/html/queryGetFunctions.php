<?php
		//--------------------------------------------------------------------------
	// File name:  queryGetFunctions.php
	// Author:     Alyssa Dixon
	// Date:       April 24, 2024
	// Class:      CS445
	// Assignment: Bookstore
	// Purpose:    Contains all get functions used
	//----------------------------------------------------------------------------

// -- -------------------------------------------------------------------------
// -- Function Description: To retrieve a booktitle from id
// -- Input: BookiD
// -- Output: Title
// -- --------------------------------------------------------------------------
	function getTitle ($dbh, $bookID) {

		$sth = $dbh->prepare("SELECT getTitle (:bookID)");
		$sth->bindValue (":bookID", $bookID);
		
		try {
			$sth->execute ();
			$retVal = $sth->fetch(); 
		}
		catch (PDOException $e) {
			printf ("getCode: " . $e->getCode () . "\n");
			printf ("getCode: " . $e->getMessage () . "\n");
		}

		return $retVal[0];
	}
	
// -- --------------------------------------------------------------------------
// -- Function Description: To retrieve a bookID
// -- Input: Title
// -- Output: BookID
// -- --------------------------------------------------------------------------
	function getBookID ($dbh, $name) {

		$sth = $dbh->prepare("SELECT getBookID (:name)");
		$sth->bindValue (":name", $name);
		
		try {
			$sth->execute ();
			$retVal = $sth->fetch(); 
		}
		catch (PDOException $e) {
			printf ("getCode: " . $e->getCode () . "\n");
			printf ("getCode: " . $e->getMessage () . "\n");
		}

		return $retVal[0];
	}

// -- --------------------------------------------------------------------------
// -- Function Description: To retrieve an editionID
// -- Input: Title
// -- Output: EditionID
// -- --------------------------------------------------------------------------
	function getEditionID ($dbh, $name) {

		$sth = $dbh->prepare("SELECT getEditionID (:name)");
		$sth->bindValue (":name", $name);
		
		try {
			$sth->execute ();
			$retVal = $sth->fetch(); 
		}
		catch (PDOException $e) {
			printf ("getCode: " . $e->getCode () . "\n");
			printf ("getCode: " . $e->getMessage () . "\n");
		}

		return $retVal[0];
	}

// -- --------------------------------------------------------------------------
// -- Function Description: To retrieve a user's first and last name from id
// -- Input: UserID
// -- Output: FName, LName
// -- --------------------------------------------------------------------------
	function getUserName ($dbh, $userID) {

		$sqlString = "CALL getUserName(:userID)";

		$sth = $dbh->prepare($sqlString);
		$sth->bindValue(":userID", $userID);
		
		try {
			$sth->execute ();
			$rows = $sth->fetchAll();
		}
		catch (PDOException $e) {
			printf ("getCode: " . $e->getCode () . "\n");
			printf ("getCode: " . $e->getMessage () . "\n");
		}
		
		return $rows;
	}

// -- --------------------------------------------------------------------------
// -- Function Description: To retrieve a UserID with username
// -- Input: Username
// -- Output: UserID
// -- --------------------------------------------------------------------------
	function queryGetUserID ($dbh, $username) {

		$sth = $dbh->prepare("SELECT GetUserIDWithUName (:username)");
		$sth->bindValue (":username", $username);
		
		try {
			$sth->execute ();
			$retVal = $sth->fetch(); 
		}
		catch (PDOException $e) {
			printf ("getCode: " . $e->getCode () . "\n");
			printf ("getCode: " . $e->getMessage () . "\n");
		}

		return $retVal[0];
	}

// -- --------------------------------------------------------------------------
// -- Function Description: Get names of authors
// -- Input: BookID, EditioniD
// -- Output: FName, LName
// -- --------------------------------------------------------------------------
	function getAuthors ($dbh, $bookID, $editionID) {

		$sqlString = "CALL getAuthors (:bookID, :editionID)";

		$sth = $dbh->prepare($sqlString);
		$sth->bindValue(":bookID", $bookID);
		$sth->bindValue(":editionID", $editionID);
		
		try {
			$sth->execute ();
			$rows = $sth->fetchAll();
		}
		catch (PDOException $e) {
			printf ("getCode: " . $e->getCode () . "\n");
			printf ("getCode: " . $e->getMessage () . "\n");
		}
		
		return $rows;
	}

// -- --------------------------------------------------------------------------
// -- Function Description: To retrieve the discount value of a discount
// -- Input: DiscountID
// -- Output: Discount Value
// -- --------------------------------------------------------------------------
	function getDiscount ($dbh, $discountID) {

		$sqlString = "SELECT GetDiscount (:discountID)";

		$sth = $dbh->prepare($sqlString);
		$sth->bindValue(":discountID", $discountID);
		
		try {
			$sth->execute ();
			$retVal = $sth->fetch();
		}
		catch (PDOException $e) {
			printf ("getCode: " . $e->getCode () . "\n");
			printf ("getCode: " . $e->getMessage () . "\n");
		}
		
		return $retVal[0];
	}

// -- --------------------------------------------------------------------------
// -- Function Description: To retrieve the discount value on a users cart
// -- Input: UserID
// -- Output: Discount Value
// -- --------------------------------------------------------------------------
	function getUserDiscount ($dbh, $userID) {

		$sqlString = "SELECT GetUserDiscount (:userID)";

		$sth = $dbh->prepare($sqlString);
		$sth->bindValue(":userID", $userID);
		
		try {
			$sth->execute ();
			$retVal = $sth->fetch();
		}
		catch (PDOException $e) {
			printf ("getCode: " . $e->getCode () . "\n");
			printf ("getCode: " . $e->getMessage () . "\n");
		}
		
		return $retVal[0];
	}

// -- --------------------------------------------------------------------------
// -- Function Description: To retrieve the discount name on a cart
// -- Input: UserID
// -- Output: Discount Name
// -- --------------------------------------------------------------------------
	function getDiscountIDByUser ($dbh, $userID) {

		$sqlString = "SELECT getDiscountIDByUser (:userID)";

		$sth = $dbh->prepare($sqlString);
		$sth->bindValue(":userID", $userID);
		
		try {
			$sth->execute ();
			$retVal = $sth->fetch();
		}
		catch (PDOException $e) {
			printf ("getCode: " . $e->getCode () . "\n");
			printf ("getCode: " . $e->getMessage () . "\n");
		}
		
		return $retVal[0];
	}

// -- --------------------------------------------------------------------------
// -- Prceudure Description: To retrieve list of Discounts Available
// -- Input: UserID
// -- Output: Discount Value
// -- --------------------------------------------------------------------------
	function getAllDiscounts ($dbh) {

		$sqlString = "CALL GetAllDiscounts ()";

		$sth = $dbh->prepare($sqlString);
		
		try {
			$sth->execute ();
			$rows = $sth->fetchAll();
		}
		catch (PDOException $e) {
			printf ("getCode: " . $e->getCode () . "\n");
			printf ("getCode: " . $e->getMessage () . "\n");
		}
		
		return $rows;
	}

// -- --------------------------------------------------------------------------
// -- Function Description: To retrieve a ShippingID
// -- Input: Name
// -- Output: ShippingID
// -- --------------------------------------------------------------------------
	function getShippingID ($dbh, $name) {

		$sth = $dbh->prepare("SELECT getShippingID (:name)");
		$sth->bindValue (":name", $name);
		
		try {
			$sth->execute ();
			$retVal = $sth->fetch(); 
		}
		catch (PDOException $e) {
			printf ("getCode: " . $e->getCode () . "\n");
			printf ("getCode: " . $e->getMessage () . "\n");
		}

		return $retVal[0];
	}

// -- --------------------------------------------------------------------------
// -- Procedure Description: To retrieve list of all shipping methods
// -- Input:
// -- Output: ShippingID, ShippingType, Speed, Cost
// -- --------------------------------------------------------------------------
	function getShippingMethods ($dbh) {

		$sqlString = "CALL GetShippingMethods ()";

		$sth = $dbh->prepare($sqlString);
		
		try {
			$sth->execute ();
			$rows = $sth->fetchAll();
		}
		catch (PDOException $e) {
			printf ("getCode: " . $e->getCode () . "\n");
			printf ("getCode: " . $e->getMessage () . "\n");
		}
		
		return $rows;
	}

// -- --------------------------------------------------------------------------
// -- Function Description: getSalt
// -- Input: username
// -- Output: salt
// -- -- -----------------------------------------------------------------------
	function queryGetSalt ($dbh, $username) {

		$sth = $dbh->prepare("SELECT GetSalt (:username)");
		$sth->bindValue (":username", $username);
		
		try {
			$sth->execute ();
			$retVal = $sth->fetch(); 
		}
		catch (PDOException $e) {
			printf ("getCode: " . $e->getCode () . "\n");
			printf ("getCode: " . $e->getMessage () . "\n");
		}

		return $retVal[0];
	}

// -- --------------------------------------------------------------------------
// -- Function Description: GetHashedPswd
// -- Input: username
// -- Output: hashedPswd
// -- -- -----------------------------------------------------------------------
	function queryGetHashedPswd ($dbh, $username) {

		$sth = $dbh->prepare("SELECT GetHashedPswd (:username)");
		$sth->bindValue (":username", $username);
		
		try {
			$sth->execute ();
			$retVal = $sth->fetch(); 
		}
		catch (PDOException $e) {
			printf ("getCode: " . $e->getCode () . "\n");
			printf ("getCode: " . $e->getMessage () . "\n");
		}

		return $retVal[0];
	}

?>