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
	function getSalt() {
		$charset = 'abcdefghijklmnopqrstuvwxyzABCDEGHIJKLMNOPQRSTUVWXYZ0123456789
			/\\][{}\'";:?.>,<!@#$%^&*()-_=+|';
		$randStringLen = 64;

		$randString = "";
		for ($i = 0; $i < $randStringLen; $i++) {
				$randString .= $charset[mt_rand(0, strlen($charset) - 1)];
		}

		return $randString;
 }

	if (($handle = fopen(
		"BookstoreDB_Data/CS445_BookStoreData_Users.csv", "r")) !== FALSE) {
		while (($data = fgetcsv($handle, 1000, ",")) !== FALSE) {

			$sqlString = "CALL insertUser (:FName, :LName, :Username, 
											:hashedPasswd, :salt, :CreationDate, :Email)";

			$salt = getSalt();
			$sth = $conn->prepare($sqlString);
			$sth->bindValue(":FName", $data[0]);
			$sth->bindValue(":LName", $data[1]);
			$sth->bindValue(":Username", $data[2]);
			$sth->bindValue(":hashedPasswd", password_hash($data[3].$salt, 
				PASSWORD_DEFAULT));
			$sth->bindValue(":salt", $salt);
			$sth->bindValue(":CreationDate", $data[4]);
			$sth->bindValue(":Email", $data[5]);
			
			try {
				$sth->execute ();
			}
			catch (PDOException $e) {
				printf ("getCode: " . $e->getCode () . "\n");
				printf ("getCode: " . $e->getMessage () . "\n");
			}

			$sqlCartString = "CALL createCart (:FName, :LName)";

				$sth2 = $conn->prepare($sqlCartString);
				$sth2->bindValue(":FName", $data[0]);
				$sth2->bindValue(":LName", $data[1]);

				try {
					$sth2->execute ();
				}
				catch (PDOException $e) {
					printf ("getCode: " . $e->getCode () . "\n");
					printf ("getCode: " . $e->getMessage () . "\n");
				}
		}
	}