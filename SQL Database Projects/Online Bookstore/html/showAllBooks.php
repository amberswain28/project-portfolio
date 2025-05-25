<?php
session_start();

require_once ("../BookstoreDB/php/connDB.php");
include ('./redirectNonAuthenticatedUser.php');

$conn = db_connect ();

$userID = $_SESSION['auth_user_id'];

function getBookEditionsByAuthor($conn, $startIndex, $numBookEditions, $author)
{
    if ($author == "NULL"){
        $sqlString = "CALL GetBookEditions (:StartIndex, :Number, @OUT_VALUE, @OUT_NUMBER)";
        $sth = $conn->prepare($sqlString);
        $sth->bindValue(":StartIndex", $startIndex);
        $sth->bindValue(":Number", $numBookEditions);
        $sth->execute();
    }
    else{
        $sqlString = "CALL GetBookEditionsByAuthor (:Author)";
        $sth = $conn->prepare($sqlString);
        $sth->bindValue(":Author", $author);
        $sth->execute();
    }
    return $sth->fetchAll();
}

function getBookEditionsCount($conn)
{
    $sqlString = "SELECT BookEditionsCount() AS rowCount";
    $sth = $conn->prepare($sqlString);
    $sth->execute();
    $result = $sth->fetch();
    return $result['rowCount'];
}

function getAuthors(){
    $conn = db_connect();
    $sqlStringAuthors = "CALL AuthorNames ()";
    $sth = $conn->prepare($sqlStringAuthors);
    $sth->execute();
    $Names = $sth->fetchAll();
    return $Names;
}



if (isset($_GET['author'])) {
    $author = urldecode($_GET['author']);
} else {
    $author = "NULL";
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>All Books in Bookstore</title>
    <meta charset="utf-8">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-table/1.18.3/bootstrap-table.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <link rel="stylesheet" type="text/css" href="./styles.css">
</head>
<body>
<nav class="navbar navbar-light">
			<a style="color: var(--cream)" class="navbar-brand" href="#">
			Double A Books
			<a style="color: var(--cream)" class= "nav-link" href="logoutUser.php"> logout </a>
			</a>
		</nav>
<a href="showCart.php" class="btn btn-info" role="button">View Cart</a>
<table class = "table table-bordered" data-toggle="table" data-search="true" data-search-align="left" data-pagination="true" data-page-size="4" data-page-list="[4]">            
            <thead>
            <tr>
                <th data-searchable="false">ISBN</th>
                <th data-searchable="true">Title</th>
                <th data-searchable="false">Edition</th>
                <th data-searchable="false">Author(s)</th>
            </tr>
            </thead>
            <tr>
                <?php
                    $rows = getBookEditionsByAuthor($conn, 0, getBookEditionsCount($conn), $author);
                    foreach ($rows as $row)
                    { ?>
                    <td><a href="showOneBook.php?ISBN=<?php echo $row['ISBN']; ?>"><?php echo $row['ISBN']; ?></a></td>
                    <td><?php echo $row['Title'] ?> </td>
                    <td><?php echo $row['Edition'] ?> </td>
                    <td><?php echo $row['Authors'] ?> </td>
                    </tr>
                    <?php
                    }
                ?>
            </table>                                     
    <div class="dropdown">
    <button class="btn btn-primary dropdown-toggle" type="button" data-toggle="dropdown">Authors
    <span class="caret"></span></button>
    <ul class="dropdown-menu">
    <?php
    $authors = getAuthors();
    foreach ($authors as $Name) { ?>
        <?php $authorName = $Name['Name']; ?>
        <li><a href="showAllBooks.php?author=<?php echo $authorName; ?>"><?php echo $Name['Name']; ?></a></li>
    <?php }?>
    </ul>
  </div>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-table/1.18.3/bootstrap-table.min.js"></script>
</body>
</html>

