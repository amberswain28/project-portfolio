<?php
	//--------------------------------------------------------------------------
	// File name:  generateRandomReviewAgreeDisagree.php
	// Author:     Alyssa Dixon
	// Date:       April 24, 2024
	// Class:      CS445
	// Assignment: Bookstore
	// Purpose:    Generates the csv of agree/disagree arrays for reviews
	//----------------------------------------------------------------------------

require_once 'vendor/autoload.php';
require_once ("../BookstoreDB/php/connDB.php");
require_once 'queryGetFunctions.php';
	
	function checkValueInArray ($array, $fname, $lname) {
		$retVal = FALSE;
		foreach ($array as $subarray) {
			$fnameKey = in_array ($fname, $subarray, true);
			$lnameKey = in_array ($lname, $subarray, true);

			if ($fnameKey != FALSE && $lnameKey != FALSE) {
				return TRUE;
			}
		}
		return FALSE;
	}

	function generateAgreeDisagreeRow ($dbh, $array, $row, $msg) {
		$title = getTitle ($dbh, $row["bid"]);

		$r_user = getUserName ($dbh, $row['uid']);
		$r_fname = $r_user[0]['FName'];
		$r_lname = $r_user[0]['LName'];
		
		$userID = rand (1, 75);
		$user = getUserName ($dbh, $userID);
		$fname = $user[0]['FName'];
		$lname = $user[0]['LName'];
			
				while (checkValueInArray($array, $fname, $lname) ||
					$userID == $row['uid']) {
				$userID = rand (1, 75);
				$user = getUserName ($dbh, $userID);
				$fname = $user[0]['FName'];
				$lname = $user[0]['LName'];
		}

		$timestamp = new MongoDB\BSON\UTCDateTime (new DateTime ());

		array_push (
			$array, [$title, $r_fname, $r_lname, $msg, $fname, $lname, $timestamp]);

		return $array;
	}

	header('Content-Type: text/csv; charset=utf-8');
	header('Content-Disposition: attachment;' . 
		'filename=randomReviewAgreeDisagree.csv');

	$dbh = db_connect();

	$client = new MongoDB\Client ('mongodb://localhost:27017');

	$collection = $client->books->reviews;

	$reviewData = $collection->find();
	$arrayCSV = [['title', 'reviewer_fname', 'reviewer_lname', 'AGREE/DISAGREE', 
		'fname', 'lname', 'timestamp']];

	$count = 0;
	$fp = fopen('randomReviewAgreeDisagree.csv', 'w');
	
	$subarray = [];

	foreach ($reviewData as $row) {
		// Generate 5 Aggrees
		if ($count >= 0 && $count < 5) {
			$subarray = [];
			for ($index = 0; $index < 5; $index++) {
				$subarray = generateAgreeDisagreeRow ($dbh, $subarray, $row, "AGREE");
			}
			$arrayCSV = array_merge($arrayCSV, $subarray);
		}

		//Generate 5 Disagrees
		if ($count >= 5 && $count < 10) {
			$subarray = [];
			for ($index = 0; $index < 5; $index++) {
				$subarray = generateAgreeDisagreeRow ($dbh, $subarray, $row, 
					"DISAGREE");
			}
			$arrayCSV = array_merge($arrayCSV, $subarray);
		}

		//Generate mix (10) of agree disagree
		if ($count >= 10 && $count < 20) {
			$subarray = [];
			for ($index = 0; $index < 10; $index++) {
				$randBool = rand (0, 1);
				if ($randBool == 0) {
					$subarray = generateAgreeDisagreeRow ($dbh, $subarray, $row, "AGREE");
				}
				elseif ($randBool == 1) {
					$subarray = generateAgreeDisagreeRow ($dbh, $subarray, $row, 
						"DISAGREE");
				}
			}
			$arrayCSV = array_merge($arrayCSV, $subarray);
		}

		$count++;
	}

	foreach ($arrayCSV as $row) {
		fputcsv($fp, $row);
	}

	fclose($fp);
?>