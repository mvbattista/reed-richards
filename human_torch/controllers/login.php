<?php

session_start();
session_regenerate_id(true); 

include_once('./../models/user.php');

$username='';
$password='';

if(isset($_POST['username'])){$username=$_POST['username'];}
if(isset($_POST['password'])){$password=$_POST['password'];}

$user_obj = new user($username);
if (isset($_SESSION['user_id'])) {
	$response = array('code' => 400, 'content' => 'Already logged in');
}
else {
	$response = $user_obj->login($password);
}

header('Content-Type: application/json');
echo json_encode($response, JSON_PRETTY_PRINT);


?>