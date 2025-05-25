<?php
		//----------------------------------------------------------------------------
	// File name:  queryValidUser.php
	// Author:     Alyssa Dixon
	// Date:       April 24, 2024
	// Class:      CS445
	// Assignment: Bookstore
	// Purpose:    Query if username and password used to login is a valid user
	//----------------------------------------------------------------------------

	require_once ("../BookstoreDB/php/connDB.php");
	require_once 'queryGetFunctions.php';

	function queryValidUser ($dbh, $username, $pswd) {
		$retVal = FALSE;
		$salt = queryGetSalt ($dbh, $username);
		$hashedPswd = queryGetHashedPswd($dbh, $username);

		if (password_verify ($pswd.$salt, $hashedPswd)) {
			$retVal = TRUE;
		}

		return $retVal;
	}
?>