<?php
  session_start();
  if(!isset($_SESSION['user_id'])){ header("location:index.php"); }
?>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Login</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Bootstrap -->
    <link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.0.3/css/bootstrap.min.css">
    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="//code.jquery.com/jquery.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="//netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>
    <!-- The AJAX login script -->
    <script src="js/logout.js"></script>
    
    <link href="css/main.css" rel="stylesheet" media="screen">
  </head>
  
  <body>
    <div class="container">
      <div class="form-signin">
        <div class="alert alert-success">You have been <strong>successfully logged in</strong>.</div>
        <button name="logout-button" id="logout-button" class="btn btn-lg btn-primary btn-block">Logout</button>
        <!-- <a href="logout.php" class="btn btn-default btn-lg btn-block">Logout</a> -->
      </div>
    </div> <!-- /container -->
  </body>
</html>
