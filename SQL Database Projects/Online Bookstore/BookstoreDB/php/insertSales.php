<?php
	//----------------------------------------------------------------------------
	// File name:  insertSales.php
	// Author:     Alyssa Dixon
	// Date:       April 11, 2024
	// Class:      CS445
	// Assignment: Bookstore
	// Purpose:    inserts Sale data into database
	//----------------------------------------------------------------------------

	require_once ("connDB.php");
	$conn = db_connect();

	if (($handle = fopen(
		"BookstoreDB_Data/CS445_BookStoreData_Sales.csv", "r")) !== FALSE) {
		
		fgetcsv($handle, 1000, ",");
		while (($data = fgetcsv($handle, 1000, ",")) !== FALSE) {
			$data = array_filter($data, function ($value) {
				return $value !== null && $value !== '';
			});

			for ( $index = 6; $index < count ($data); $index += 3) {
	
				$sqlString = "CALL insertInSaleFromFile (:FName, :LName, :Discount, 
				:Date, :Time, :Shipping, :Title, :Edition, :Quantity)";

				$sth = $conn->prepare($sqlString);
				$sth->bindValue(":FName", $data[0]);
				$sth->bindValue(":LName", $data[1]);
				$sth->bindValue(":Discount", $data[2]);
				$sth->bindValue(":Date", $data[3]);
				$sth->bindValue(":Time", $data[4]);
				$sth->bindValue(":Shipping", $data[5]);
				$sth->bindValue(":Title", $data[$index]);
				$sth->bindValue(":Edition", $data[$index + 1]);
				$sth->bindValue(":Quantity", $data[$index + 2]);
				
				try {
					$sth->execute ();
				}
				catch (PDOException $e) {
					printf ("getCode: " . $e . "\n");
				}
			
			}
		}
	}
?>