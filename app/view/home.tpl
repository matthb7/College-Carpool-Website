<div id="main">
<?php if (!isset($_SESSION['user'])) { ?>
	<div id="info">
		<h1>Find the Perfect Ride</h1>
		<p id="msg">
			Caruize is the perfect way to find other students headed to the same place.
			Just a few short steps is all thats required to get to your destination. Let us
			take care of the rest!
		</p>

		<div id="app" style="margin-top: 1%;">
			<img src="<?= BASE_URL ?>/public/img/app.jpg" alt="app"/>
		</div>

		<div id="icons">
			<div id="add">
				<span class="glyphicon glyphicon-search" aria-hidden="true"></span>
				<h2>Search</h2></br>
				<p>Tell us where you are headed and we will try to match you with the best fit</p>
			</div>
			<div id="edit">
				<span class="glyphicon glyphicon-user" aria-hidden="true"></span>
				<h2>Coordinate</h2></br>
				<p>Once you select a ride we make it easy for you to communicate with others</p>
			</div>
			<div id="delete">
				<span class="glyphicon glyphicon-road" aria-hidden="true"></span>
				<h2>Road Trip</h2></br>
				<p>Be on your way to your destination. Enjoy!</p>
			</div>
		</div>
	</div>
	<div id="sidebar"></div>
	<?php } else { ?>
		show activity here
	<?php } ?>
</div>