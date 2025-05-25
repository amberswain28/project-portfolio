<?php
	//--------------------------------------------------------------------------
	// File name:  addReviewsFromFileCLI.php
	// Author:     Alyssa Dixon
	// Date:       April 24, 2024
	// Class:      CS445
	// Assignment: Bookstore
	// Purpose:    Insert reviews into mongodb from command line
	//----------------------------------------------------------------------------
	require_once 'vendor/autoload.php';
	require_once ("../BookstoreDB/php/connDB.php");
	$conn = db_connect();

	$client = new MongoDB\Client ('mongodb://localhost:27017');
	$client->books->drop();
	$client->books->createCollection ("reviews");
	

	if (($handle = fopen($argv[1], "r")) !== FALSE) {
		fgetcsv($handle, 1000, ",");
		while (($data = fgetcsv($handle, 1000, ",")) !== FALSE) {

			$sqlBookIDString = "SELECT getBookID (:Title)";
			$sqlUserIDString = "SELECT getUserID (:FName, :LName)";

			$sthBook = $conn->prepare($sqlBookIDString);
			$sthBook->bindValue(":Title", $data[0]);

			$sthUser = $conn->prepare($sqlUserIDString);
			$sthUser->bindValue(":FName", $data[1]);
			$sthUser->bindValue(":LName", $data[2]);

			try {
				$sthBook->execute ();
				$bookID = intval($sthBook->fetchColumn());
			}
			catch (PDOException $e) {
				printf ("getCode: " . $e->getCode () . "\n");
				printf ("getMessage: " . $e->getMessage () . "\n");
			}

			try {
				$sthUser->execute ();
				$userID = intval($sthUser->fetchColumn());
			}
			catch (PDOException $e) {
				printf ("getCode: " . $e->getCode () . "\n");
				printf ("getMessage: " . $e->getMessage () . "\n");
			}

			$review = $data[3];
			$stars = intval ($data[4]);
			$timestamp = $data[5];

			$collection = $client->books->reviews;

			$collection->insertOne([
				'bid' => $bookID,
				'uid' => $userID,
				'review' => $review,
				'stars' => $stars,
				'timestamp' => new MongoDB\BSON\UTCDateTime ($timestamp),
				]);
		}
	}
?>