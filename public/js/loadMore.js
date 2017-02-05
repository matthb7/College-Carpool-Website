var itemNum = 3; //Loaded 3 items initially
$(document).ready(function(){
    $(".loadmore").click(function() {
        itemNum++;
        loadMore(itemNum);
    });

};

function loadMore(itemNum) {
    $.post('app/controller/productController.php?action=loadMore', 
        {'item': itemNum}, 
        function(data) {
            //Change button text and disable if no more content to load
            if (data.trim().length == 0) {
                $(".loadmore").text("No More Rides").prop("disabled", true);
            }
            $("#content").append(data);
    });
}