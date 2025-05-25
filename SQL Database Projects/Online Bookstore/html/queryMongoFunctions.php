<?php

require_once 'vendor/autoload.php';
require_once ("../BookstoreDB/php/connDB.php");

function GetFullName($UserID){
	$conn = db_connect();
	$sqlString = "CALL GetUserFullName(:UserID)";

	$sth = $conn->prepare($sqlString);
	$sth->bindValue(":UserID", $UserID);
	$sth->execute();
	$Name = $sth->fetchAll();

	foreach($Name as $data){
		$UserName = $data["fullName"];
	}

	return $UserName;

}

function getReview ($bookID) {
	$client = new MongoDB\Client ('mongodb://localhost:27017');

	$collection = $client->books->reviews;

	$data = $collection->find(['bid' => $bookID]);
	?>
	<!DOCTYPE html>
	<html lang="en">
		<head>
			<title>All Books in Bookstore</title>
			<meta charset="utf-8">
			<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com
				bootstrap/3.4.1/css/bootstrap.min.css">
			<link rel="stylesheet" href="https://cdnjs.cloudflare.com
				/ajax/libs/bootstrap-table/1.18.3/bootstrap-table.min.css">
			<script src="https://ajax.googleapis.com
				/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
			<script src="https://maxcdn.bootstrapcdn.com
				/bootstrap/3.4.1/js/bootstrap.min.js"></script>
			<link rel="stylesheet" type="text/css" href="./styles.css">
		</head>


		<body>
			<div class="container"></div>
				<table class = "table table-bordered" data-toggle="table" 
					data-search="true" data-search-align="left" data-pagination="false" 
					data-sortable="true">            
					<thead>
						<tr>
							<th data-searchable="false" data-sortable="false">Name</th>
							<th data-searchable="false" data-sortable="true">Stars</th>
							<th data-searchable="true" data-sortable="false">Review</th>
							<th data-searchable="false" data-sortable="true">Timestamp</th>
							<th data-searchable="false" data-sortable="false">
									Number of Agrees</th>
							<th data-searchable="false" data-sortable="false">
									Number of Disagrees</th>
							<th data-searchable="false" data-sortable="false">Metric</th>
						</tr>
					</thead>
					<?php
					$totalStars = 0;
					$totalReviews = 0;
					foreach ($data as $review) { 
						?>
						<tr>
							<td><?php echo GetFullName($review["uid"])?> </td>
							<td><?php echo $review["stars"] ?> </td>
							<td><?php echo $review["review"]?> </td>
							<?php
							$timestamp = $review["timestamp"]->toDateTime();
							$timestamp->setTimezone (new DateTimeZone('America/Los_Angeles'));
							?>
							<td>Date:<?php echo $timestamp->format ("M d Y :: h:i:s a") ?></td>
							<?php

							$numAgrees = 0;
							$numDisagrees = 0;
							$metric = 0;
							if (isset($review["agree"])) {
								$numAgrees = count($review['agree']); 
								$metric += $numAgrees;
								?>
								<td><?php echo $numAgrees; ?></td>
								<?php
							}

							else {
								?>
								<td><?php echo "0" ?></td> 
								<?php
							}

							if (isset($review["disagree"])) {
								$numDisagrees = count($review['disagree']); 
								$metric -= ($numDisagrees/2);
								?>
								<td><?php echo $numDisagrees; ?></td> 
								<?php
							}
							else{ 
								?>
								<td><?php echo "0" ?></td> 
								<?php
							}

							
							if ($metric != 0) { 
								?>
								<td><?php echo $metric; ?></td> 
								<?php
							}
							else {
								?>
								<td><?php echo "0"; ?></td> 
								<?php
							}
							?>
						</tr>
						<?php
						$totalStars += $review["stars"];
						$totalReviews++;
					}?>
					<h4><strong>Reviews</strong><h4>
					<?php
					if ($totalReviews > 0){
						$averageStars = round($totalStars/$totalReviews, 2);
						?>
						<h5><strong>Average Stars: </strong><?php print $averageStars ?> <h5>
						<?php
					} 
					?>
				</table>
			</div>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-table
			/1.18.3/bootstrap-table.min.js"></script>
		</body>
	</html>
	<?php
	return $totalReviews;
}
db_close($conn);
?>                      