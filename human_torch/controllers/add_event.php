<?php

session_start();
session_regenerate_id(true); 

include_once('./../models/db_config.php');

$description = '';
$start_date = '';
$end_date = '';

if(isset($_POST['description'])){$description=$_POST['description'];}
if(isset($_POST['start_date'])){$start_date=$_POST['start_date'];}
if(isset($_POST['end_date'])){$end_date=$_POST['end_date'];}


if ( is_null($_SESSION['user_id']) or !($_SESSION["user_is_admin"])) {
	$response = array('code' => 401, 'content' => 'Not logged in');
}
else {

	$val_str = "\"$description\", \"$start_date\", \"$end_date\"";

	$db = db_conn();
    $sql = 'INSERT INTO events(description, start_date, end_date) VALUES (' . $val_str . ')';
    $res = $db->query($sql);
    $response = array();

    if($res === false) {
        trigger_error('Wrong SQL: ' . $sql . ' Error: ' . $conn->error, E_USER_ERROR);
        $response['code'] = 500;
        $response['message'] = 'Invalid database query';

    } 
    else {
    	$new_id = $db->insert_id;
    	$new_sql = "SELECT * FROM events WHERE id = $new_id;";
    	$new_res = $db->query($new_sql);
    	$response['content'] = array();
        while ($row = $new_res->fetch_assoc()) {
        	array_push($response['content'],  $row);
        }
        if (sizeof($response['content']) == 1) {
        	$response['content'] = $response['content'][0];
        }
        $response['code'] = 200;

    }
    mysqli_close($db);
 
}

header('Content-Type: application/json');
echo json_encode($response, JSON_PRETTY_PRINT);


?>