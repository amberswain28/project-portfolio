<?php
	//--------------------------------------------------------------------------
	// File name:  addAgreeDisagreeToReview.php
	// Author:     Alyssa Dixon
	// Date:       April 24, 2024
	// Class:      CS445
	// Assignment: Bookstore
	// Purpose:    Updates reviews with aggree/disagree to reviews
	//----------------------------------------------------------------------------
require_once 'vendor/autoload.php';
require_once ("../BookstoreDB/php/connDB.php");

$dbh = db_connect ();
$client = new MongoDB\Client ('mongodb://localhost:27017');

if (($handle = fopen($argv[1], "r")) !== FALSE) {
	fgetcsv($handle, 1000, ",");
	while (($data = fgetcsv($handle, 1000, ",")) !== FALSE) {

		$sqlBookIDString = "SELECT getBookID (:Title)";
		$sqlReviewerUserIDString = "SELECT getUserID (:FName, :LName)";
		$sqlUserIDString = "SELECT getUserID (:FName, :LName)";

		$sthBook = $dbh->prepare($sqlBookIDString);
		$sthBook->bindValue(":Title", $data[0]);

		$sthReviewerUser = $dbh->prepare($sqlReviewerUserIDString);
		$sthReviewerUser->bindValue(":FName", $data[1]);
		$sthReviewerUser->bindValue(":LName", $data[2]);

		$sthUser = $dbh->prepare($sqlUserIDString);
		$sthUser->bindValue(":FName", $data[4]);
		$sthUser->bindValue(":LName", $data[5]);

		try {
			$sthBook->execute ();
			$bookID = intval($sthBook->fetchColumn());
		}
		catch (PDOException $e) {
			printf ("getCode: " . $e->getCode () . "\n");
			printf ("getMessage: " . $e->getMessage () . "\n");
		}

		try {
			$sthReviewerUser->execute ();
			$r_userID = intval($sthReviewerUser->fetchColumn());
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

		$collection = $client->books->reviews;

		if ($data[3] == "AGREE") {
			$setValues = [ '$push' => ['agree' => ['uid' => $userID, 
				'timestamp' => new MongoDB\BSON\UTCDateTime ($data[6])]]];
		}
		elseif ($data[3] == "DISAGREE") {
			$setValues = [ '$push' => ['disagree' => ['uid' => $userID, 
				'timestamp' =>  new MongoDB\BSON\UTCDateTime ($data[6])]]];
		}
		
		$updatedResult = $collection->updateOne (['bid' => $bookID, 
			'uid' => $r_userID], $setValues);
	}
}
?>