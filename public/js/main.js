$(document).ready(function(){
    $(".submitSearch").click(function(){
      var find = $(".search").find("#rideName").val();
      if (find == "") {
        $("li").show();
      }
      else {
        $("li:not(:contains('" + find + "'))").hide();
      }
    });
});

$(document).ready(function(){
    $("li.link").click(function(){
      location.href = "details.html";
    });
});

$(document).ready(function(){
    $(".submitLog").click(function(){
      var emtpy = document.getElementById("empty");
      var ret = document.createElement("p");
      ret.textContent = "Username/Password Incorrect!";
      empty.appendChild(ret);
    });
});

$(document).ready(function() {
  //Width PX minus scrollbar
  var width = $('body').innerWidth();
  $("#footerImg").css("width", width + "px");
});