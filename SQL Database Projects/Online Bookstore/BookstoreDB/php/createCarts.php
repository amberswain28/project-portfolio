<?php
	require_once ("connDB.php");
	$conn = db_connect();
	if (($handle = fopen(
		"BookstoreDB_Data/CS445_BookStoreData_Users.csv", "r")) !== FALSE) {
		while (($data = fgetcsv($handle, 1000, ",")) !== FALSE) {
			$data = array_filter($data, function ($value) {
				return $value !== null && $value !== '';
			});
			
				$sqlString = "CALL createCart (:FName, :LName)";

				$sth = $conn->prepare($sqlString);
				$sth->bindValue(":FName", $data[0]);
				$sth->bindValue(":LName", $data[1]);

				try {
					$sth->execute ();
				}
				catch (PDOException $e) {
					printf ("getCode: " . $e->getCode () . "\n");
					printf ("getCode: " . $e->getMessage () . "\n");
				}
		}
	}
?>