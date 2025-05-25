<?php
	//----------------------------------------------------------------------------
	// File name:  showCart.php
	// Author:     Alyssa Dixon
	// Date:       April 24, 2024
	// Class:      CS445
	// Assignment: Bookstore
	// Purpose:    Displays a users cart to the website
	//----------------------------------------------------------------------------

	session_start();
	
	require_once ("../BookstoreDB/php/connDB.php");
	require_once ('basicErrorHandling.php');
	require_once 'queryCartFunctions.php';
	require_once 'queryGetFunctions.php';
	include ('./redirectNonAuthenticatedUser.php');

	$dbh = db_connect ();

	$userID = $_SESSION['auth_user_id'];
	
	$data = getCart ($dbh, $userID);

	$userDiscount = getUserDiscount ($dbh, $userID);
	$discountID = getDiscountIDByUser ($dbh, $userID);
	$allDiscounts = getAllDiscounts($dbh);

	$shippingMethods = getShippingMethods($dbh);
	
	if (isset ($_POST['btnUpdateCart'])) { 
		$editionID = $_POST['editionID'];
		$bookID = $_POST['bookID'];

		$inputQty = $_POST['qtyInput'];
		$qty = $_POST['qty'];
		$qtyChange = intval($inputQty) - intval($qty);

		alterQtyInCart($dbh, $userID, $bookID, $editionID, $qtyChange);

		echo("<meta http-equiv='refresh' content='1'>");
	} 
	if (isset ($_POST['btnRemoveCart'])) { 

		$editionID = $_POST['editionID'];
		$bookID = $_POST['bookID'];

		$qty = $_POST['qty'];
		$qtyChange = -(intval($qty));

		alterQtyInCart($dbh, $userID, $bookID, $editionID, $qtyChange);

		header("Refresh:0");
	} 
	if (isset ($_POST['btnUpdateDiscount'])) { 

		$discountName = $_POST['DiscountMethod'];
		updateCartDiscount($dbh, $userID, $discountName);

		header("Refresh:0");
	} 
	if (isset ($_POST['btnUpdateShipping'])) { 

		$shippingMethodValue = $_POST['ShippingMethod'];

		header("Refresh:0");
	}
	if (isset ($_POST['btnClearCart'])) {
		clearCart ($dbh, $userID);
		header("Refresh:0");
	}
	if (isset ($_POST['btnCheckout'])) {
		$shippingID = getShippingID ($dbh, $_POST['ShippingMethod']);

		if (!empty ($array)) {
			checkoutCart ($dbh, $userID, $shippingID);
		}
	
		header("Refresh:0");
	}

	$sqlOutString = "SELECT @OUT_PRICE";
	$sthOut = $dbh->prepare($sqlOutString);
	$sthOut->execute ();
	$outVal = $sthOut->fetch();

	if (!isset ($outVal) || $outVal[0] == null) {
		$outVal[0] = 0;
	}
?>

<!doctype html>
<html>
	<head>
		<meta charset="utf-8">
			<meta name="viewport" 
			content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<link 
			rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/
			css/bootstrap.min.css" integrity=
			"sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" 
			crossorigin="anonymous">
			<link rel="stylesheet" type="text/css" href="./styles.css">
		<title> Cart </title>
	</head>
	<body>
		<nav class="navbar navbar-light">
			<a style="color: var(--cream)" class="navbar-brand" href="#">
			<img src="./imgs/icon_book_cream.png" style="color: var(--cream)" 
				width="30" height="30" class="d-inline-block align-top" alt="">
			Double A Books
			<a style="color: var(--cream)" class= "nav-link" href="logoutUser.php"> 
				logout </a>
			</a>
		</nav>
		<h1> Shopping Cart </h1>
		<table class="table table-striped table-bordered table-sm"> 
			<thead>
			<tr>
				<th>ISBN</th>
				<th>Title</th>
				<th>Authors</th>
				<th>Retail Price</th>
				<th>Quantity</th>
				<th>Total Price</th>
			</tr>
			</thead>
			<tbody>
			<tr>
				<?php
					foreach ($data as $row) {
						$authors = getAuthors ($dbh, $row['BookID'], $row['EditionID']);
				?>
				<tr>
				<td> <?php echo $row['ISBN']; ?> </td> 
				<td> <?php echo $row['Title']; ?> </td> 
				<td> 
					<?php
						$count = 0;
						$size = count ($authors); 
						foreach ($authors as $author) {
							if (($count == 0 && $count == $size - 1) || $count == $size - 1) {
								echo $author['FName'] . " " . $author['LName'];
							}
							else {
								echo $author['FName'] . " " . $author['LName'] . ", ";
							}
							$count++;
						}
					?>
				</td>
				<td><?php echo number_format($row['Retail'], 2); ?> </td>
				<td>
					<form method="post" action=""> 
					
					<input type="number" id="qtyInput" name="qtyInput" min="1" 
					value="<?php echo $row["Quantity"] ?>" />

					<input type="hidden" name="bookID" 
						value="<?php echo $row['BookID']?>">
					<input type="hidden" name="editionID" 
						value="<?php echo $row['EditionID']?>">
					<input type="hidden" name="qty" value="<?php echo $row['Quantity']?>">
					
					<input type="submit" name="btnUpdateCart" class="button" 
						value="Update"/>
						
					<input type="submit" name="btnRemoveCart" class="button" 
						value="Remove"/> 
					</form>
					
				</td>
				<td> <?php echo number_format($row['BookTotal'], 2) ?></td>
				</tr><br>
				<?php
				
					}
				?>
			</tr>
			</tbody>
		</table>
		
		<form method="POST" action="">
			<label for="DiscountMethod"> <h3> Discount Type: </h3></label>
			<select name="DiscountMethod">
					<option></option>
				<?php
					foreach ($allDiscounts as $discount) {
						if ($discountID == $discount['DiscountID']) {
				?>
							<option selected="selected" 
								value="<?php echo $discount['DiscountName'] ?>" > 
								<?php echo $discount['DiscountName'] ?>
							</option>
				<?php
						}
						else {
				?>
							<option value="<?php echo $discount['DiscountName'] ?>"> 
								<?php echo $discount['DiscountName'] ?>
							</option>
				<?php
						}
					}
				?>
			</select>
				<input type="submit" name="btnUpdateDiscount" class="button" 
					value="Change Discount"/>
		</form>
		<?php
			if ($userDiscount != 0) {
				if ($userDiscount < 1) {
					print '<h5 style="margin-left: 25px"> Discount: ' . 
						(number_format($userDiscount, 2) * 100) . '% </h5>';
				}
				else {
					print '<h5 style="margin-left: 25px"> Discount: $' . 
						number_format($userDiscount, 2) . '</h5>';
				}
			}
		?>

		<?php
			print "<h3 style='margin-left: 25px'>" . "Discounted Total Price: $" .
			 number_format ($outVal[0], 2) . "</h3>" . "<br>";
		?>

		<form method="POST" action="">
			<label for="ShippingMethod"> <h3> Shipping Method: </h3></label>
			<select name="ShippingMethod" required>
				<option></option>
				<?php
					foreach ($shippingMethods as $method) {
						if ($shippingMethodValue == $method['ShippingType']) {
							?>
							<option 
								data-cost="<?php echo $method['Cost'] ?>"
								selected="selected" 
								value="<?php echo $method['ShippingType'] ?>" 
								name="<?php echo $method['ShippingType'] ?>"> 
									<?php echo $method['ShippingType'] ?>
							</option>
							<?php							
						}
						else {
							?>
							<option data-attributes="<?php echo $method['Cost'] ?>" 
								value="<?php echo $method['ShippingType'] ?>"> 
								<?php echo $method['ShippingType'] . ', $' .
								 number_format($method['Cost'], 2) ?></option>
						<?php
						}
						?>
				<?php
					}
				?>
			</select>
			<br>
			<input styles="background-color: #2a4d58" type="submit" name="btnCheckout" 
				class="button btn btn-primary" value="Checkout"/>
		</form>
		<br>
			
		<div>
		<form method="POST" action="">
			<input type="submit" name="btnClearCart" 
				class="btn btn-info" role="button" 
				value="Clear Cart"/>
		</form>
		<br>
		</div>

  <a href="showAllBooks.php" class="btn btn-info" 
		role="button"> See All Books </a>
	</body>
</html>

<?php
	db_close($dbh);
?>