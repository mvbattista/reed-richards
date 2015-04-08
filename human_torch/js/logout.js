$(document).ready(function(){
    
  $("#logout-button").click(function(){

      $.ajax({
        type: "POST",
        url: "logout.php",
        success: function(rawData){
          
          if (rawData['code'] === 200) {
            window.location="index.php"
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
    return false;
  });
});