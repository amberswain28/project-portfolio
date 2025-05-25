<?php
	//----------------------------------------------------------------------------
	// File name:  insertBookEditions.php
	// Author:     Alyssa Dixon
	// Date:       April 4, 2024
	// Class:      CS445
	// Assignment: Bookstore
	// Purpose:    inserts BookEditions data into database
	//----------------------------------------------------------------------------
	require_once ("connDB.php");
	$conn = db_connect();

	if (($handle = fopen(
		"BookstoreDB_Data/CS445_BookStoreData_BookEditions.csv", "r")) !== FALSE) {

		fgetcsv($handle, 1000, ",");
		while (($data = fgetcsv($handle, 1000, ",")) !== FALSE) {
			$data = array_filter($data, function ($value) {
				return $value !== null && $value !== '';
			});

			$sqlEditionString = "CALL insertBookEditionFromFile (:Cover, :Title, 
			:EditionName, :Name, :PubDate, :BookISBN, :BookQty, :BookWholesale, 
			:BookRetail, :FName, :LName)";

			$sth = $conn->prepare($sqlEditionString);
			$sth->bindValue(":Cover", $data[0]);
			$sth->bindValue(":Title", $data[1]);
			$sth->bindValue(":EditionName", $data[4]);
			$sth->bindValue(":Name", $data[5]);
			$sth->bindValue(":PubDate", $data[6]);
			$sth->bindValue(":BookISBN", $data[7]);
			$sth->bindValue(":BookQty", $data[8]);
			$sth->bindValue(":BookWholesale", $data[9]);
			$sth->bindValue(":BookRetail", $data[10]);
			$sth->bindValue(":FName", $data[11]);
			$sth->bindValue(":LName", $data[12]);
			
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