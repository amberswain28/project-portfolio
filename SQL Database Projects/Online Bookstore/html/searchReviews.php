<?php
		//--------------------------------------------------------------------------
	// File name:  searchReviews.php
	// Author:     Alyssa Dixon
	// Date:       April 24, 2024
	// Class:      CS445
	// Assignment: Bookstore
	// Purpose:    Searches the mongodb reviews for a book containing specified
	//						 text
	//----------------------------------------------------------------------------

	require_once 'vendor/autoload.php';

	$client = new MongoDB\Client ('mongodb://localhost:27017');
	$bookID = intval ($argv[1]);
	$inputText = $argv[2];

	$collection = $client->books->reviews;

	$data = $collection->find(['bid' => $bookID, 
		'review' => ['$regex' => new MongoDB\BSON\Regex ($inputText, 'i')]]);
	
	$start = 0;

	print ("Number of Reviews: " . 
		$collection->CountDocuments (['bid' => $bookID, 
		'review' => ['$regex' => new MongoDB\BSON\Regex ($inputText, 'i')]]) .
		"\n");
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