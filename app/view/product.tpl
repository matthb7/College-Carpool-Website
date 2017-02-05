<div id="main">
	<div id="content" style="display:block !important" >
		<h2>Product Details</h2>

		<div class="product" style="display:block" >
			<img class="product-image" src="<?= BASE_URL ?>/public/img/<?= $product['img_url'] ?>" alt=""/>
			<h3>To <?= $product['destination'] ?></h3>
			<p>From <?= $product['source'] ?></p>
			<p><?= $product['leave_time'] ?></p>
			<p>Details: <?= $product['description'] ?></p>
			<p class="price"><?= $product['price'] ?></p>
		</div>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
		<script async src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCKiMc7dPFyeR_vCrNoULLwcTqTA1yy13A&callback=initMap">    </script>
		<script type="text/javascript" src="<?= BASE_URL ?>/public/js/maps.js"></script>
		<div style="clear:both"></div>
	    <div id="map" style="display:block"  add1="<?= $product['source'] ?>" add2="<?= $product['destination'] ?>"></div>
		<br>
		<form method="POST">
			<button class="btn btn-primary" formaction="<?= BASE_URL ?>/back/">Go Back</button>
			<?php if (isset($_SESSION['user']) && ($_SESSION['user'] === 'ADMIN' || $product['creator_id'] == $_SESSION['id'])) { ?>
				<button class="btn btn-warning" formaction="<?= BASE_URL ?>/editProduct/<?= $product['id'] ?>">Edit</button>
				<button class="btn btn-danger" formaction="<?= BASE_URL ?>/deleteProduct/<?= $product['id'] ?>">Delete</button>
			<?php } ?>
			<?php if ($i->get("creator_id") != $_SESSION['id']) {
    			if(isset($_SESSION['user']) && in_array($i->get("creator_id"), $array)) { ?> 
					<button class="btn btn-warning" formaction="<?= BASE_URL ?>/follow/'<?= $row['id'] ?>">Unfollow</button>
				<?php } ?>
				<?php if(isset($_SESSION['user']) && !in_array($i->get("creator_id"), $array)) { ?>
					<button class="btn btn-success" formaction="<?= BASE_URL ?>/follow/'<?= $row['id'] ?>">Follow</button>
	            <?php } ?>
     		<?php } ?>
		</form>
	</div>

	<div id="sidebar"></div>
</div>
