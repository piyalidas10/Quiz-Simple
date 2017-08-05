<?php
	$server = "localhost";
	$username = "root";
	$password = "";
	$database = "quiz";

	$db_handle = mysql_connect($server, $username, $password);

        $conn = mysql_select_db($database, $db_handle);

        if ($conn) {

           //print "Database Found ";

        }
       else {

             die("Connection failed: " .mysql_connecet_error());

       }
?>
