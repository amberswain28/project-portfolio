<?php
	//--------------------------------------------------------------------------
	// File name:  logoutUser.php
	// Author:     Alyssa Dixon
	// Date:       April 24, 2024
	// Class:      CS445
	// Assignment: Bookstore
	// Purpose:    Logout user and unset session
	//----------------------------------------------------------------------------

session_start();

unset($_SESSION);
if (ini_get("session.use_cookies")) {
    $params = session_get_cookie_params();
    setcookie(session_name(), '', time() - 42000, $params["path"], 
		$params["domain"], $params["secure"],$params["httponly"]);
}
 
session_destroy();
header('Location: index.html');
?>