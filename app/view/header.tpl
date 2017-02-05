<?php
	//session_start();
	function isSelected($pn, $link) {
		if($pn == $link) {
			return ' id="selected-nav" ';
		}
	}
?>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
  	<meta name="description" content="Hokie Gear is an awesome Virginia Tech apparel online store.">
	<title>Caruize | <?= $pageName ?></title>

	<link rel="stylesheet" type="text/css" href="<?= BASE_URL ?>/public/css/styles.css">
	<link rel="stylesheet" type="text/css" href="<?= BASE_URL ?>/public/css/graphics.css">
	<link href="https://fonts.googleapis.com/css?family=Abhaya+Libre" rel="stylesheet">
  	<script type="text/javascript" src="<?= BASE_URL ?>/public/js/jquery-3.1.0.min.js"></script>
  	<script type="text/javascript" src="<?= BASE_URL ?>/public/js/scripts.js"></script>
  	<script type="text/javascript" src="<?= BASE_URL ?>/public/js/d3.v4.min.js"></script>
  	<script type="text/javascript" src="<?= BASE_URL ?>/public/js/graphics.js"></script>
  	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
	<div id="wrapper">
			<nav class="navbar navbar-inverse">
  				<div class="container-fluid">
    				<div class="navbar-header">
      					<a class="navbar-brand" href="#">Caruize</a>
    				</div>
    				<ul class="nav navbar-nav">
      					<li class=""><a href="<?= BASE_URL ?>/">Home</a></li>
      					<li><a href="<?= BASE_URL ?>/viewList/">Rides</a></li>
      					<?php if (isset($_SESSION['role'])){ if ($_SESSION['role'] == "d") { ?>
      						<li><a href="<?= BASE_URL ?>/addProduct/">Post Ride</a></li>
      					<?php }} ?>
    				</ul>
    				<?php if (!isset($_SESSION['user'])) { ?>
	    				<ul class="nav navbar-nav navbar-right">
	      					<li><a href="<?= BASE_URL ?>/signup/"><span class="glyphicon glyphicon-user"></span> Sign Up</a></li>
	      					<li><a href="<?= BASE_URL ?>/login/"><span class="glyphicon glyphicon-log-in"></span> Login</a></li>
	    				</ul>
	    			<?php } else { ?>
	    				<ul class="nav navbar-nav navbar-right">
                            <li><a href="<?= BASE_URL ?>/profile/"><span class="glyphicon glyphicon-user"></span> My Profile</a></li>
	      					<li><a href="<?= BASE_URL ?>/logout/"><span class="glyphicon glyphicon-log-in"></span> Logout</a></li>
	    				</ul>
	    			<?php } ?>
  				</div>
			</nav>
		</div>

		<div id="wrap">
