<?php

function db_conn() {
    $db_conn = mysqli_connect('localhost', 'human_torch', 'flameon', 'human_torch');
    if (!$db_conn) {
        die('Could not connect: ' . $db->connect_error);
    }
    return $db_conn;
}

?>