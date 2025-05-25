<?php
  // Author: 			Chadd Williams
  // File: 				connDB.php
  // Date:				March 18, 2013
  // Class:				CS 445	
  // Project: 		In Class PDO Examples
  // Description: create a connection

   # pdo_testdb_connect.php - function for connecting to the "test" database

   function db_connect ()
   {
     $dbh = new PDO("mysql:host=127.0.0.1;dbname=NAME", 
      "USER", "PASS");
		 $dbh->setAttribute (PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
	
     return ($dbh);
   }
	 
	 function db_close (&$dbh)
	 {
	 	$dbh = NULL;
	 }
	 
?>
