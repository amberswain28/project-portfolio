<?php
session_start();

require_once ("../BookstoreDB/php/connDB.php");
require_once 'queryMongoFunctions.php';
require_once 'queryGetFunctions.php';
require_once 'queryCartFunctions.php';
include ('./redirectNonAuthenticatedUser.php');

$conn = db_connect ();

$userID = $_SESSION['auth_user_id'];

function getOneBook($gotISBN){
	$sqlString = "CALL GetBookDetailsByISBN (:ISBN)";
	$conn = db_connect ();
	$sth = $conn->prepare($sqlString);
	$sth->bindValue(":ISBN", $gotISBN);
	$sth->execute();
	return $sth->fetchAll();
}

if (isset ($_POST['btnAddToCart'])) {
    $userID = $_SESSION['auth_user_id'];
    $editionID = $_POST['editionID'];
    $bookID = $_POST['bookID'];
    addToCart ($conn, $userID, $bookID, $editionID, 1);
}

function AuthorsOutput($BookID){
	$sqlString = "CALL getAuthors (:BookID)";
	$conn = db_connect ();
	$sth = $conn->prepare($sqlString);
	$sth->bindValue(":BookID", $BookID);
	$sth->execute();
	return $sth->fetchAll();
}

if(isset($_GET['ISBN'])) 
{
    $gotISBN = $_GET['ISBN'];
}


foreach (getOneBook($gotISBN) as $data) {
    $Cover = $data['Cover'];
    $ISBN = $data['ISBN'];
    $Title = $data['Title'];
    $Edition = $data['Edition'];
    $Authors = $data['Authors'];
    $Price = $data['Retail'];
    $Quantity = $data['Quantity'];
}

$BookID = getBookID ($conn, $Title);
$EditionID = getEditionID ($conn, $Edition);
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <title><?php echo $Title; ?></title>
    <meta charset="utf-8">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com
			/bootstrap/3.4.1/css/bootstrap.min.css">

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com
			/ajax/libs/bootstrap-table/1.18.3/bootstrap-table.min.css">

    <script src="https://ajax.googleapis.com
			/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

    <script src="https://maxcdn.bootstrapcdn.com
			/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>

<body>
	<nav class="navbar navbar-light">
		<a style="color: var(--cream)" class="navbar-brand" href="#">
			Double A Books
				<a style="color: var(--cream)" class= "nav-link" 
					href="logoutUser.php"> logout
				</a>
		</a>
	</nav>

  <a href="showAllBooks.php" class="btn btn-info" role="button">Show All Books
	</a><br>
	<br>
	<a href="showCart.php" class="btn btn-info" 
		role="button">View Cart
	</a>
	<br>
	<br>

	<form method="post" action="">  
		<input type="hidden" name="bookID" value="<?php echo $BookID?>">
		<input type="hidden" name="editionID" value="<?php echo $EditionID?>">
		<input type="hidden" name="quantity" value="<?php echo $data['Quantity']?>">  
		<input type="submit" name="btnAddToCart" class="button btn btn-primary" '
			value="Add to Cart"/> 
	</form>

	<br>
	<div class="row">
			<div class="col-md-3">
					<img src="<?php echo $Cover; ?>" class="img-responsive" 
							alt="<?php echo $Title; ?> Cover" >
			</div>
	</div>

	<div class="row">
		<div class="col-md-9">
			<h2><?php echo $Title; ?></h2>
			<h4><strong>ISBN:</strong> <?php echo $ISBN; ?></h4>
			<h4><strong>Edition:</strong> <?php echo $Edition; ?></h4>
			
			<?php 

			if ($ISBN[0] == '9') {
				?>
				<h4><strong>Author(s):</strong></h4> 
				<?php
				foreach (AuthorsOutput($BookID) as $author) {
					$redis = new Redis();
					$redis->connect('localhost', 6379);
					$Name = $author['Name'];
					$redisKey = "author:{$Name}:link";
					$URL = $redis->get($redisKey);
					if (!empty($URL)) {
						$authorLink = $URL;
						?>
						<h4><a href="<?php echo $authorLink ?>" target="_blank">
											<?php echo $Name; ?></a><br></h4>
					<?php
					} 
					else {
						$openLibraryUrl =
							"https://openlibrary.org/api/books?bibkeys=ISBN:{$ISBN}&format=json&jscmd=data";
						$response = file_get_contents($openLibraryUrl);
						$bookData = json_decode($response, true);

						if (!empty($bookData["ISBN:{$ISBN}"]["authors"]))
						{
							$authors = $bookData["ISBN:{$ISBN}"]["authors"];

							foreach ($authors as $possibleAuthor) 
							{
								if ($Name == $possibleAuthor['name'] AND empty($URL)) {
									if (!empty($possibleAuthor['url'])) {
										?>
										<h4><a href="<?php echo $possibleAuthor['url']; ?>" target="_blank">
											<?php echo $Name; ?></a><br></h4>
										<?php
										$authorLink = $possibleAuthor['url'];
										$redis->set($redisKey, $authorLink);
										} 
									else {
										?>
										<h4><?php echo $Name; ?><br></h4>
										<?php
									}
								}

							}
						}
						else {
							?>
							<h4><?php echo $Name; ?><br></h4>
							<?php
						}

					}
				}
			}
							
			else {
				?>
				<h4><strong>Authors:</strong> <?php echo $Authors; ?></h4> 
				<?php
			}
			?>
			<h4><strong>Price:</strong> $<?php echo number_format($Price, 2);?></h4>
			<h4><strong>Quantity:</strong> <?php echo $Quantity; ?></h4>
		</div>
	</div>
  <?php 
	try {
		$bookID = getBookID($conn, $Title);
	}
	catch (PDOException $e) {
		printf ("getCode: " . $e->getCode () . "\n");
		printf ("getCode: " . $e->getMessage () . "\n");
	}
	getReview ($bookID);
	?>
</div>
<script src="https://cdnjs.cloudflare.com
	/ajax/libs/bootstrap-table/1.18.3/bootstrap-table.min.js"></script>
</body>
</html>
<?php 
db_close($conn); 
?>