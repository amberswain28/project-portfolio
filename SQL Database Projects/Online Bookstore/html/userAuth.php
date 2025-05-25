<?php
	require_once ("../BookstoreDB/php/connDB.php");
	require_once 'queryValidUser.php';
	require_once 'queryGetFunctions.php';

	$dbh = db_connect ();
	session_start();

	if (isset ($_POST['txtUsername']) && isset ($_POST['txtPassword'])) {
		$username = $_POST['txtUsername'];
		$pswd = $_POST['txtPassword'];

		$result = queryValidUser ($dbh, $username, $pswd);
		$userID = queryGetUserID ($dbh, $username);
		if (TRUE == $result) {
			$_SESSION['VALID'] = 1;
			$_SESSION['auth_user_id'] = $userID;
			header ('Location: showAllBooks.php');
		}
		
	}
	else {
		header('Location: index.html');
	}
?>