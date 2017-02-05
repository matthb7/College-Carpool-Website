$(document).ready(function(){
    //hide submit button initially
    $("#sPW").css("display", "none")
    //Add password matching checking on changes in the fields
    $("#nPW").change(function() {validatePassword()});
    $("#cPW").change(function() {validatePassword()});
    });

function validatePassword() {
    //Show submit button
    $("#sPW").show();
    //Get values
    var nPW = $("#nPW").val();
    var cPW = $("#cPW").val();

    //Compare
    if (nPW != cPW) {
        $("#sPW").val("Passwords Don't Match").prop("disabled", true);
    }
    else {
        $("#sPW").val("Change Password").prop("disabled", false);
    }

}
