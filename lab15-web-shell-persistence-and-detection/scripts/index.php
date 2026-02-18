<?php
echo "<h1>Test Application</h1>";
echo "<form method='GET' action=''>
 <input type='text' name='page' placeholder='Page name'>
 <input type='submit' value='Load'>
 </form>";

if(isset($_GET['page'])) {
 $page = $_GET['page'];

 if(file_exists($page . ".php")) {
     include($page . ".php");
 }
}
?>
