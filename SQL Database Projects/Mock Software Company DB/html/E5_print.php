<?php
session_start();
if( isset($_SESSION['PID']))
{
	$num = 1;
	while($num < $_SESSION['PID'])
	{
		print $num . "\n";
		$num+=1;
	}

}
else {
 var_dump($_SESSION);
}

?>