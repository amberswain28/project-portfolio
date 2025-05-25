-- Active: 1712180333585@@127.0.0.1@3306@BookstoreDB
<?php
//----------------------------------------------------------------------------
	// File name:  insertAuthors.php
	// Author:     Alyssa Dixon
	// Date:       April 4, 2024
	// Class:      CS445
	// Assignment: Bookstore
	// Purpose:    inserts author data into database
	//----------------------------------------------------------------------------
	require_once ("connDB.php");
	$conn = db_connect();

	if (($handle = fopen(
		"BookstoreDB_Data/CS445_BookStoreData_Authors.csv", "r")) !== FALSE) {
		while (($data = fgetcsv($handle, 1000, ",")) !== FALSE) {

			$sqlString = "CALL insertAuthor (:FName, :LName)";

			$sth = $conn->prepare($sqlString);
			$sth->bindValue(":FName", $data[0]);
			$sth->bindValue(":LName", $data[1]);
			
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