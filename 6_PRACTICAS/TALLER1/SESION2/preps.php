<?php
error_reporting(E_ALL);
$sql="CALL PREPS('Q',5,NULL,NULL)";
$f = mysqli_connect("", "root", "", "salud");

$a=mysqli_query($f,$sql);
while($e=mysqli_fetch_array($a,MYSQLI_NUM)){

if($e[0]==-1)
{
echo $e[1];
die();
}else{
    echo $e[1]."<br>"; 
}
}

?>