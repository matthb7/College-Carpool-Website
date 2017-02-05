
function initMap() {
	var API_KEY = 'AIzaSyCKiMc7dPFyeR_vCrNoULLwcTqTA1yy13A';
	var Center = new google.maps.LatLng(18.210885, -67.140884);
	directionsService = new google.maps.DirectionsService();
	var map;
	directionsDisplay = new google.maps.DirectionsRenderer();
	var properties = {
		zoom: 20,
		mapTypeId: google.maps.MapTypeId.roadmap
	};

	map = new google.maps.Map(document.getElementById("map"), properties);
	directionsDisplay.setMap(map);

	
	var geocoder = new google.maps.Geocoder();
	var add1 = document.getElementById("map").getAttribute("add1");
	
	var add2 = document.getElementById("map").getAttribute("add2");
	$.ajax({
    type: "GET",
    url: "https://maps.googleapis.com/maps/api/geocode/json?address=" + add1 + "&sensor=false&key=" + API_KEY,
    dataType: "json",
    success:(function(data){
		start = data.results[0].geometry.location;
			$.ajax({
				type: "GET",
				url: "https://maps.googleapis.com/maps/api/geocode/json?address=" + add2 + "&sensor=false&key=" + API_KEY,
				dataType: "json",
				success:(function(data){
					end = data.results[0].geometry.location;
					
					
					Route();
				})
			});
		})
  });

  
}

function Route() {
	var request = {
		origin: start,
		destination: end,
		travelMode: google.maps.TravelMode.DRIVING
	};
	directionsService.route(request, function(result, status) {
		if (status == google.maps.DirectionsStatus.OK) {
			directionsDisplay.setDirections(result);
		}
		else
		{
			var marker = new google.maps.Marker({
				position: end,
				animation: google.maps.Animation.BOUNCE,
			});
			marker.setMap(map);
			//alert("couldn't get directions:" + status);
		}
	});

}