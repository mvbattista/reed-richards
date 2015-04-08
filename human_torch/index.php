<?php
  session_start();
  if(isset($_SESSION['user_id'])){ header("location:main.php"); }
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
    <script src="js/login.js"></script>
    
    <link href="css/main.css" rel="stylesheet" media="screen">
  </head>
  
  <body>
    <div class="container">

      <form class="form-signin" id="login-form" name="login-form" method="post" action>
        <h2 class="form-signin-heading">Please sign in</h2>
        <input name="username" id="username" type="text" class="form-control" placeholder="Username" autofocus>
        <input name="password" id="password" type="password" class="form-control" placeholder="Password">
        <button name="Submit" id="login-button" class="btn btn-lg btn-primary btn-block" type="submit">Sign in</button>

        <div id="message"></div>
      </form>

    </div> <!-- /container -->

  </body>
</html>
