<?php
	//----------------------------------------------------------------------------
	// File name:  insertWishLists.php
	// Author:     Alyssa Dixon
	// Date:       April 11, 2024
	// Class:      CS445
	// Assignment: Bookstore
	// Purpose:     inserts Wishlist data into database
	//----------------------------------------------------------------------------
	require_once ("connDB.php");
	$conn = db_connect();

	if (($handle = fopen(
		"BookstoreDB_Data/CS445_BookStoreData_WishLists.csv", "r")) !== FALSE) {
		
		fgetcsv($handle, 1000, ",");
		while (($data = fgetcsv($handle, 1000, ",")) !== FALSE) {
			$data = array_filter($data, function ($value) {
				return $value !== null && $value !== '' && $value != 0;
			});

			for ( $index = 3; $index < count ($data); $index += 4) {
	
				$sqlString = "CALL insertInWishListFromFile (:FName, :LName, :WLName,
					:Title, :Edition, :Quantity, :Note)";

				$sth2 = $conn->prepare($sqlString);
				$sth2->bindValue(":FName", $data[0]);
				$sth2->bindValue(":LName", $data[1]);
				$sth2->bindValue(":WLName", $data[2]);
				$sth2->bindValue(":Title", $data[$index]);
				$sth2->bindValue(":Edition", $data[$index + 1]);
				$sth2->bindValue(":Quantity", $data[$index + 2]);
				if (isset ($data[$index + 3])) {
					$sth2->bindValue(":Note", $data[$index + 3]);
				}
				else {
					$sth2->bindValue(":Note", NULL);
				}
				
				
				try {
					$sth2->execute ();
				}
				catch (PDOException $e) {
					printf ("getCode: " . $e. "\n");
					printf ("getMessage: " . $e->getMessage () . "\n");
				}
			
			}
		}
	}
?>