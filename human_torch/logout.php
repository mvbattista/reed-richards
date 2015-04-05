<?php

session_start();
session_regenerate_id(true); 

if (isset($_SESSION['user_id'])) {
	unset($_SESSION['user_id']);
	unset($_SESSION['user_is_admin']);
	$response = array('code' => 200, 'content' => 'Log out successful');
}
else {
	$response = array('code' => 400, 'content' => 'Already logged out');
}
header('Content-Type: application/json');
echo json_encode($response, JSON_PRETTY_PRINT);

?>