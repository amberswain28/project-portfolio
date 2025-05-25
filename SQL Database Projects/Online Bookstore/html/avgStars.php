<?php
	//--------------------------------------------------------------------------
	// File name:  averageStarsPerReview.php
	// Author:     Alyssa Dixon
	// Date:       May 3, 2024
	// Class:      CS445
	// Assignment: Bookstore
	// Purpose:    Calculate Avg Stars
	//----------------------------------------------------------------------------

	require_once 'vendor/autoload.php';

	$client = new MongoDB\Client ('mongodb://localhost:27017');
	$bookID = intval ($argv[1]);

	$collection = $client->books->reviews;

	$data = $collection->find(['bid' => $bookID]);

	$totalReviews = $collection->CountDocuments (['bid' => $bookID]);
	print ("Number of Reviews: " . 
		$totalReviews . "\n");

		$totalStars = 0;
	foreach ($data as $review) {
		$totalStars = $totalStars +  intval($review["stars"]);
	}

	if ($collection->CountDocuments (['bid' => $bookID]) > 0) {
		$averageStars = round($totalStars/$totalReviews, 2);
	}
	print ("Average Stars: " .$averageStars . "\n");
?>