<?php
	//----------------------------------------------------------------------------
	// File name:  insertWrote.php
	// Author:     Alyssa Dixon
	// Date:       April 11, 2024
	// Class:      CS445
	// Assignment: Bookstore
	// Purpose:    inserts Wrote data into database
	//----------------------------------------------------------------------------
	require_once ("connDB.php");
	$conn = db_connect();

	if (($handle = fopen(
		"BookstoreDB_Data/CS445_BookStoreData_Wrote.csv", "r")) !== FALSE) {
		while (($data = fgetcsv($handle, 1000, ",")) !== FALSE) {
			$data = array_filter($data, function ($value) {
				return $value !== null && $value !== '';
			});
			
			for ( $index = 1; $index < count ($data); $index += 2) {
	
				$sqlWriteString = "CALL insertWroteFromFile (:Title, :FName, :LName)";

				$sth = $conn->prepare($sqlWriteString);
				$sth->bindValue(":Title", $data[0]);
				$sth->bindValue(":FName", $data[$index]);
				$sth->bindValue(":LName", $data[$index + 1]);
				
				try {
					$sth->execute ();
				}
				catch (PDOException $e) {
					printf ("getCode: " . $e->getCode () . "\n");
					printf ("getMessage: " . $e->getMessage () . "\n");
				}
			
			}
		}
	}
?>