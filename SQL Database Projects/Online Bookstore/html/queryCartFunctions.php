<?php
	//--------------------------------------------------------------------------
	// File name:  queryCartFunctions.php
	// Author:     Alyssa Dixon
	// Date:       April 24, 2024
	// Class:      CS445
	// Assignment: Bookstore
	// Purpose:    Contains all functions to display and alter cart
	//----------------------------------------------------------------------------
	require_once ("../BookstoreDB/php/connDB.php");

	// -- ------------------------------------------------------------------------
	// -- Function Description: getCart
	// -- Input: userID
	// -- Output: None
	// -- -- ---------------------------------------------------------------------
	function getCart ($dbh, $userID) {

		$sqlString = "CALL GetCart (:userID, @OUT_PRICE)";

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
// -- Procedure Description: move cart items back to the store, no sale made
// -- Input: UserID
// -- Output: None
// -- --------------------------------------------------------------------------
	function clearCart ($dbh, $userID) {

		$sqlString = "CALL ClearCart_NoPurchase (:userID)";

		$sth = $dbh->prepare($sqlString);
		$sth->bindValue(":userID", $userID);
		
		try {
			$sth->execute ();
		}
		catch (PDOException $e) {
			printf ("getCode: " . $e->getCode () . "\n");
			printf ("getCode: " . $e->getMessage () . "\n");
		}
	}

// -- --------------------------------------------------------------------------
// -- Procedure Description: Checkout Cart (move Cart to sale)
// -- Input: UserID
// -- Output: None
// -- --------------------------------------------------------------------------
	function checkoutCart ($dbh, $userID, $shippingID) {

		$sqlString = "CALL CheckoutCart (:userID, :shippingID)";

		$sth = $dbh->prepare($sqlString);
		$sth->bindValue(":userID", $userID);
		$sth->bindValue(":shippingID", $shippingID);
		
		try {
			$sth->execute ();
		}
		catch (PDOException $e) {
			printf ("getCode: " . $e->getCode () . "\n");
			printf ("getMsg: " . $e->getMessage () . "\n");
		}
	}

// -- --------------------------------------------------------------------------
// -- Procedure Description: update the Discount of Carts
// -- Input: FName, LName, Discount
// -- Output: None
// -- --------------------------------------------------------------------------
	function updateCartDiscount ($dbh, $userID, $discountName) {

		$sqlString = "CALL updateCartDiscount (:userID, :discountName)";

		$sth = $dbh->prepare($sqlString);
		$sth->bindValue(":userID", $userID);
		$sth->bindValue(":discountName", $discountName);
		
		try {
			$sth->execute ();
		}
		catch (PDOException $e) {
			printf ("getCode: " . $e->getCode () . "\n");
			printf ("getCode: " . $e->getMessage () . "\n");
		}

	}

// -- --------------------------------------------------------------------------
// -- Procedure Description: Alter (+/-) quantity of bookEdition in wishlist
// -- Input: UID, BookID, EditionID, WishlistID
// -- Output: none
// -- -- -----------------------------------------------------------------------
	function alterQtyInCart ($dbh, $userID, $bookID, $editionID, $qtyChange) {

		$sqlString = "CALL AlterQtyInCart (:userID, :bookID, :editionID, 
			:qtyChange)";

		$sth = $dbh->prepare($sqlString);
		$sth->bindValue(":userID", $userID);
		$sth->bindValue(":bookID", $bookID);
		$sth->bindValue(":editionID", $editionID);
		$sth->bindValue(":qtyChange", $qtyChange);
	

		try {
			$sth->execute ();
			$rows = $sth->fetchAll();	
		}
		catch (PDOException) {
			$rows = null;
			echo '<script language="javascript">';
			echo 'alert("Not enough books in stock :(")';
			echo '</script>';
		}
		
		return $rows;
	}

// -- --------------------------------------------------------------------------
// -- Procedure Description: Add BookEdition to cart
// -- Input: UID, BookID, EditionID, Qty
// -- Output: none
// -- -- -----------------------------------------------------------------------
	function addToCart ($dbh, $userID, $bookID, $editionID, $qty) {
		$sqlString = "CALL AddBookEditionToCart (:userID, :bookID, :editionID, 
		:qtyChange)";

		$sth = $dbh->prepare($sqlString);
		$sth->bindValue(":userID", $userID);
		$sth->bindValue(":bookID", $bookID);
		$sth->bindValue(":editionID", $editionID);
		$sth->bindValue(":qtyChange", $qty);

		try {
			$sth->execute ();
			$rows = $sth->fetchAll();	
			echo '<script language="javascript">';
			echo 'alert("Book Added successfuly!")';
			echo '</script>';
		}
		catch (PDOException) {
			$rows = null;

			echo '<script language="javascript">';
			echo 'alert("Not enough books in stock :(")';
			echo '</script>';
		}
		
		return $rows;
	}
?>