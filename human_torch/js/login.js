$(document).ready(function(){
    
  $("#login-button").click(function(){

    var form_username = $("#username").val();
    var form_password = $("#password").val();
    
    if((form_username == "") || (form_password == "")) {
      $("#message").html("<div class=\"alert alert-danger alert-dismissable\"><button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-hidden=\"true\">&times;</button>Please enter a username and a password</div>");
    }
    else {
      $.ajax({
        type: "POST",
        url: "login.php",
        data: $("#login-form").serialize(),
        success: function(rawData){
          
          if (rawData['code'] === 200) {
            window.location="main.php"
          }
          else {
            $("#message").html("<div class=\"alert alert-danger alert-dismissable\"><button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-hidden=\"true\">&times;</button>" + rawData['message'] + "</div>");

          }
        },
        beforeSend:function()
        {
          $("#message").html("<p class='text-center'><img src='images/ajax-loader.gif'></p>")
        }
      });
    }
    return false;
  });
});