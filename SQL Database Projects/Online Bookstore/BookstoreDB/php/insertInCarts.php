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
		"BookstoreDB_Data/CS445_BookStoreData_Carts.csv", "r")) !== FALSE) {
		
		fgetcsv($handle, 1000, ",");
		while (($data = fgetcsv($handle, 1000, ",")) !== FALSE) {
			$data = array_filter($data, function ($value) {
				return $value !== null && $value !== '';
			});
	
			for ( $index = 3; $index < count ($data); $index += 3) {
	
				$sqlString = "CALL insertInCartFromFile (:FName, :LName, :Discount, 
				:Title, :Edition, :Quantity)";

				$sth2 = $conn->prepare($sqlString);
				$sth2->bindValue(":FName", $data[0]);
				$sth2->bindValue(":LName", $data[1]);
				$sth2->bindValue(":Discount", $data[2]);
				$sth2->bindValue(":Title", $data[$index]);
				$sth2->bindValue(":Edition", $data[$index + 1]);
				$sth2->bindValue(":Quantity", $data[$index + 2]);
				
				try {
					$sth2->execute ();
				}
				catch (PDOException $e) {
					printf ("getCode: " . $e . "\n");
				}
			
			}
		}
	}
?>