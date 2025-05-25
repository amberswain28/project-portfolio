<?php
function db_connect ()
{
	$config = parse_ini_file ("/workspaces/bookstoredb-bookstoredb_team3/db.ini", true);

	$db = $config['mariadb']['dbname'];
	$host = $config['mariadb']['host'];
	$port = $config['mariadb']['port'];
	$user = $config['mariadb']['user'];
	$password = $config['mariadb']['password'];

	$connectStr = 'mysql:host=' . $host . ":" . $port . ";dbname=" . $db;
	$dbh = new PDO ($connectStr, $user, $password);
	return $dbh;
}

function db_close (&$dbh)
{
	$dbh = NULL;
}
?>