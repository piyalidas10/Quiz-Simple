<?php
// Including database connections
require_once 'dbconnect.php';
// mysqli query to fetch all data from database

$showData = "SELECT choice_id FROM question_choices WHERE question_choices.is_right_choice='1' ORDER BY question_choices.question_id";
$result = mysql_query($showData) or die(mysql_error());
$data = array();
if(mysql_num_rows($result) > 0){
	while($row = mysql_fetch_assoc($result)){
		$data[] = $row;
	}
} else {
	echo "0 results";
};
print json_encode($data);
?>
