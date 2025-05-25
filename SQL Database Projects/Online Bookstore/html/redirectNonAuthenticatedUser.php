<?php
	//----------------------------------------------------------------------------
	// File name:  redirectNonAuthenticatedUser.php
	// Author:     Alyssa Dixon
	// Date:       April 30, 2024
	// Class:      CS445
	// Assignment: Bookstore
	// Purpose:    If a user is not logged in, redirect user back to login
	//----------------------------------------------------------------------------

	if (!isset ($_SESSION['VALID']) || $_SESSION['VALID'] != 1) {
			echo "<script> location.href='index.html'; </script>";
			exit;
		}
?>