/* 
 * Process for adding a seat, make post request
 */
function seatClick(event, pid, totSeats) {
  // If seat was green set it to yellow, update info
  if (event.target.style.fill == "green") {
    $.post('../app/controller/productController.php?action=seatClick',
      {'seat':event.target.style.fill, 'pid':pid},
      function(data) {
        if (data >= totSeats) {
          var idStr = '.seatInfo#' + pid;
          $(idStr).text('There are no more available seats!');
          $(idStr).css('color', 'red');
        }
    });
    event.target.style.fill = "yellow";
  }
  // If seet was yellow set it to green, update info
  else if (event.target.style.fill == "yellow") {
    $.post('../app/controller/productController.php?action=seatClick',
      {'seat':event.target.style.fill, 'pid':pid},
      function(data) {
        if (data < totSeats) {
          var idStr = '.seatInfo#' + pid;
          $(idStr).text('Click green slots to claim a seat!');
          $(idStr).css('color', 'green');
      }
    });
    event.target.style.fill = "green";
  }
  else {
    // Can't add seat, do nothing
  }
}