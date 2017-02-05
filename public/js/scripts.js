var itemNum = 2; //Loaded 3 items initially
$(document).ready(function(){

  //event handler for the load more button
  $("#loadmore").click(function() {
      itemNum++;
      loadMore(itemNum);
      itemNum++; //because we load two at a time
  });

  // event handler for checkboxes with name "size"
  $('input[name="size"]').click(function(){
    // by default, hide everything
    $('div.product').hide();

    // iterate through only the checked checkboxes
    $('input[name="size"]:checked').each(function(){
      var checkedVal = $(this).val(); // value of checked box

      // show products matching that value
      switch(checkedVal) {
        case 's':
          $('div.product.small').show(); // show the Small items
          break;
        case 'm':
          $('div.product.medium').show();
          break;
        case 'l':
          $('div.product.large').show();
          break;
        case 'xl':
          $('div.product.xlarge').show();
          break;
      }
    });
  });

  // by default, check all the boxes
  $('input[name="size"]').each(function(){
    $(this).prop("checked", true); // check the box
  })



});

function loadMore(itemNum) {
    $.post('../app/controller/productController.php?action=loadMore', {'item': itemNum}, function(data) {
        //Change button text and disable if no more content to load
        if (data == "nothing") {
            $("#loadmore").text("No More Rides").prop("disabled", true);
        }
        else {
            //Add our content to the view page
            $("#content").append(data);
            //Move the load more button down
            $("#loadmore").detach().appendTo("#content");
        }
    });
}
