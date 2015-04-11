<?php
require_once('db_config.php');

class user {
    private $username;
    private $user_id;
    private $is_admin;

    function __construct($in_username) {
        $this->username = $in_username;
    }

    function login($in_password) {
        $db = db_conn();
        $sql = 'SELECT id, is_admin FROM users WHERE username = \'' . $this->username . '\' AND password = MD5(\'' . $in_password . '\')';
        $res = $db->query($sql);
        $response = array();

        if($res === false) {
            trigger_error('Wrong SQL: ' . $sql . ' Error: ' . $conn->error, E_USER_ERROR);
            $response['code'] = 500;
            $response['message'] = 'Invalid database query';

        } elseif ($res->num_rows === 0) {
            # Invalid username or password
            $response['code'] = 401;
            $response['message'] = 'Invalid username or password';
        }
        else {
            $row = $res->fetch_row();
            # var_dump($row);
            $_SESSION["user_id"] = intval($row[0]);
            $_SESSION["user_is_admin"] = intval($row[1]);

            $response['code'] = 200;
            $response['content'] = array('user_id' => intval($row[0]), 'user_is_admin' => intval($row[1]) );

        }
        mysqli_close($db);

        return $response;

    }

    function is_logged_in() {
        return isset($_SESSION["user_id"]);
    }

}

?>
