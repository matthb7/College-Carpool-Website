<div id="main">
	<div id="content">
		<h2>Activity Feed</h2>
        <?php if (isset($_SESSION['follow'])) : ?>
            <p>User followed</p>
        <?php endif; unset($_SESSION['follow'])?>
        <?php if (isset($_SESSION['unfollow'])) : ?>
            <p>User unfollowed</p>
        <?php endif; unset($_SESSION['unfollow'])?>
        <?php foreach($products as $i):  ?>
			<?php if(isset($_SESSION['user']) && in_array($i->get('creator_id'), $array)) { ?>
				<form method="POST">
					<div class="product small" testid="<?= $i->get('creator_id') ?>" testid2="<?= $_SESSION['id'] ?>">
						<img class="product-image" src="<?= BASE_URL ?>/public/img/<?= $i->get('img_url') ?>"/>
						<h3><a href="<?= BASE_URL ?>/viewProduct/<?= $i->get('id') ?>">To <?= $i->get('destination') ?></a></h3>
						<p>From <?= $i->get('source') ?></p>
						<p><?= $i->get('leave_time') ?></p>
						<p class="price"><?= $i->get('price') ?></p>

						<?php if (isset($_SESSION['user']) && (($_SESSION['user'] === 'ADMIN') || ($i->get('creator_id') == $_SESSION['id']))) { ?>
							<button class="btn btn-warning" formaction="<?= BASE_URL ?>/editProduct/<?= $i->get('id') ?>">Edit</button>
							<button class="btn btn-danger" formaction="<?= BASE_URL ?>/deleteProduct/<?= $i->get('id') ?>">Delete</button>
						<?php } ?>
						<?php if(isset($_SESSION['user']) && in_array($i->get('creator_id'), $array)) { ?>
							<button class="btn btn-warning" formaction="<?= BASE_URL ?>/follow/<?= $i->get('creator_id') ?>">Unfollow</button>
						<?php } ?>
						<?php if(isset($_SESSION['user']) && !in_array($i->get('creator_id'), $array)) { ?>
							<button class="btn btn-success" formaction="<?= BASE_URL ?>/follow/<?= $i->get('creator_id') ?>">Follow</button>
						<?php } ?>
					</div>
				</form>
			<?php } ?>
		<?php endforeach; ?>
	</div>
</div>
