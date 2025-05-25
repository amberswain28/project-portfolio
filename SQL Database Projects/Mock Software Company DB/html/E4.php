<body>
<?php
print "<table border=1> <tr>";
$num = 1; // create variable
while( $num <= 100)
{
print "<td>" . $num . "</td>";
$num += 1;
if (($num-1)%10 == 0)
{
print "</tr>";
}
}
print "</tr> </table>";
?>