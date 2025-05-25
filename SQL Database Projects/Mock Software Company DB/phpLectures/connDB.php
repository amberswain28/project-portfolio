function db_connect()
{
	$connectStr = 'mysql:host=localhose:3306;dbname=SoftwareDB';
	$dbh = new PDO($connectStr, 'toot', 'mariadb');
	return $dbh
}