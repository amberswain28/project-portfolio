<?php
	//----------------------------------------------------------------------------
	// File name:  insertUsers.php
	// Author:     Amber Swain
	// Date:       April 11, 2024
	// Class:      CS445
	// Assignment: Bookstore
	// Purpose:     inserts Wishlist data into database
	//----------------------------------------------------------------------------
	require_once ("connDB.php");
	$conn = db_connect();
	if (($handle = fopen(
		"BookstoreDB_Data/CS445_BookStoreData_Shipping.csv", "r")) !== FALSE) {
		while (($data = fgetcsv($handle, 1000, ",")) !== FALSE) {
			$data = array_filter($data, function ($value) {
				return $value !== null && $value !== '';
			});
			
				
				$sqlString = "CALL insertShipping (:ShippingType, :Speed, :Cost)";

				$sth = $conn->prepare($sqlString);
				$sth->bindValue(":ShippingType", $data[0]);
				$sth->bindValue(":Speed", $data[1]);
				$sth->bindValue(":Cost", $data[2]);
				
				try {
					$sth->execute ();
				}
				catch (PDOException $e) {
					printf ("getCode: " . $e->getCode () . "\n");
					printf ("getCode: " . $e->getMessage () . "\n");
				}
		}
	}
?>