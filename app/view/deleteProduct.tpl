<div id="main">
	<div id="content">
		<h2>Are you sure you want to delete this product?</h2>

		<div class="product">
			<img class="product-image" src="<?= BASE_URL ?>/public/img/<?= $product['img_url'] ?>" alt=""/>
			<h3>To <?= $product['destination'] ?></h3>
			<p>From <?= $product['source'] ?></p>
			<p><?= $product['leave_time'] ?></p>
			<p>Details: <?= $product['description'] ?></p>
			<p class="price"><?= $product['price'] ?></p>
		</div>

		<form method="POST">
			<button class="btn btn-danger" formaction="<?= BASE_URL ?>/deleteConfirm/<?= $product['id'] ?>">YES DELETE</button>
			<button class="btn btn-primary" formaction="<?= BASE_URL ?>/back/">NO GO BACK</button>
		</form>
	</div>
</div>