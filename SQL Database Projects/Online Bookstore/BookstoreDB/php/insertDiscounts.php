<?php
	//----------------------------------------------------------------------------
	// File name:  insertUsers.php
	// Author:     Alyssa Dixon, Amber Swain
	// Date:       April 11, 2024
	// Class:      CS445
	// Assignment: Bookstore
	// Purpose:     inserts Wishlist data into database
	//----------------------------------------------------------------------------
	require_once ("connDB.php");
	$conn = db_connect();
	if (($handle = fopen(
		"BookstoreDB_Data/CS445_BookStoreData_Discounts.csv", "r")) !== FALSE) {
		while (($data = fgetcsv($handle, 1000, ",")) !== FALSE) {
			$data = array_filter($data, function ($value) {
				return $value !== null && $value !== '';
			});
			
			$sqlString = "CALL insertDiscount (:DiscountName, :PercentageAmount, 
				:DollarAmount, :StartDate, :EndDate)";

			$sth = $conn->prepare($sqlString);
			$sth->bindValue(":DiscountName", $data[0]);
			if (isset($data[2])) {
				$sth->bindValue(":DollarAmount", $data[2]);
				$sth->bindValue(":PercentageAmount", NULL);
			}
			else if (isset($data[1])) {
				$sth->bindValue(":PercentageAmount", $data[1]);
				$sth->bindValue(":DollarAmount", NULL);
			}
			if (isset($data[3]) && isset($data[4])) {
				$sth->bindValue(":StartDate", $data[3]);
				$sth->bindValue(":EndDate", $data[4]);
			}
			else {
				$sth->bindValue(":StartDate", NULL);
				$sth->bindValue(":EndDate", NULL);
			}
			$sth->execute ();
		
			try {
				$sth->execute ();
			}
			catch (PDOException $e) {
				printf ("getCode: " . $e->getCode () . "\n");
				printf ("getMessage: " . $e->getMessage () . "\n");
			}
		}
	}
?>