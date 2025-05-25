<?php
	//--------------------------------------------------------------------------
	// File name:  getReviews.php
	// Author:     Alyssa Dixon
	// Date:       April 24, 2024
	// Class:      CS445
	// Assignment: Bookstore
	// Purpose:    Get and print review from command line
	//----------------------------------------------------------------------------

	require_once 'vendor/autoload.php';

	$client = new MongoDB\Client ('mongodb://localhost:27017');
	$bookID = intval ($argv[1]);

	$collection = $client->books->reviews;

	$data = $collection->find(['bid' => $bookID]);

	print ("Number of Reviews: " . 
		$collection->CountDocuments (['bid' => $bookID]) . "\n");

	$start = 0;
	foreach ($data as $review) {
		if ($start == 0) {
			print ("BookID: " . $review["bid"] . "\n\n");
			$start++;
		}
		print ("UserID: " .  $review["uid"] . "\n");
		print ("Stars: " . $review["stars"] . "\n");
		print ("Review: " . $review["review"] . "\n");

		$timestamp = $review["timestamp"]->toDateTime();
		$timestamp->setTimezone (new DateTimeZone('America/Los_Angeles'));
		print ("Date: " . $timestamp->format ("M d Y :: h:i:s a") . "\n\n");
	}
?>