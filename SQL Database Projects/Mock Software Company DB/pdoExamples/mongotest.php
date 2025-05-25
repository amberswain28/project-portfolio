
<?php
require 'vendor/autoload.php';

// connect to mongo
$client = new MongoDB\Client('mongodb://localhost:27017');
	
// open a collection
$collection = $client->example->test;

// insert one document (a php associative array)
$collection->insertOne([ 'message' => 'SUCCESS']);

// find the one document
$recvdData = $collection->findOne();

// dispay the document
var_dump($recvdData);

// delete all the documents in the collection
//$collection->deleteMany([]);

?>