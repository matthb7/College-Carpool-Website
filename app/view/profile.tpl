<div id="main">
	<div id="content">
		<h2>Activity Feed</h2>
        <?php if (isset($_SESSION['editMessage'])) : ?>
            <p>Profile sucessfully updated</p>
        <?php endif; unset($_SESSION['editMessage'])?>
        <?php if (isset($_SESSION['follow'])) : ?>
            <p>User followed</p>
        <?php endif; unset($_SESSION['follow'])?>
        <?php if (isset($_SESSION['unfollow'])) : ?>
            <p>User unfollowed</p>
        <?php endif; unset($_SESSION['unfollow'])?>
		<?php foreach($allProducts as $i):  ?>
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
	   <div id="content">
		<h1><?= $profile->get('first_name')?> <?= $profile->get('last_name') ?></h1>
        <h2>Your Rides</h2>
        <?php if(sizeOf($products) != 0) {foreach($products as $p): ?>
            <div class="product small" testid="<?= $p->get('creator_id') ?>" testid2="<?= $_SESSION['id'] ?>">
                <img class="product-image" src="<?= BASE_URL.'/public/img/'.$p->get('img_url') ?>"/>
                <h3><a href="<?= BASE_URL.'/viewProduct/'.$p->get('id') ?>">To <?= $p->get('destination') ?></a></h3>
                <p>From <?= $p->get('source') ?></p>
                <p><?= $p->get('leave_time') ?></p>
                <p class="price"><?= $p->get('price') ?></p>
                <form method="POST">
                <button class="btn btn-warning" formaction="<?= BASE_URL.'/editProduct/'.$p->get('id') ?>">Edit</button>
                <button class="btn btn-danger" formaction="<?= BASE_URL.'/deleteProduct/'.$p->get('id') ?>">Delete</button>
                </form>
            </div>
        <?php endforeach; }?>
        <?php if(sizeOf($products) == 0) { ?>
            <h3>    No rides listed</h3>
        <?php } ?>
        <h2 style="clear:both">Your Account</h2>
        <form id="edit-information" action=<?= BASE_URL ?>/profile/update/ method="POST">
            <div class="form-group">
                <label>Username</label>
                <input type="text" class="form-control" name="un" value="<?= $profile->get('username')?>" disabled>
            </div>
            <div class="form-group"?>
                <label>First Name</label>
                <input type="text" class="form-control" name="fn" value="<?= $profile->get('first_name')?>" required>
            </div>
            <div class="form-group">
                <label>Last Name</label>
                <input type="text" class="form-control" name="ln" value="<?= $profile->get('last_name')?>" required>
            </div>
            <div class="form-group">
                <label>Email</label>
                <input type="email" class="form-control" name="em" value="<?= $profile->get('email')?>" required>
            </div>
            <?php if($profile->get('role') == 'd') : ?>
            <div class="form-group">
                <div class="radio">
                    <label><input type="radio" value="d" name="role" checked>Driver</label>
                </div>
                <div class="radio">
                    <label><input type="radio" value="r" name="role">Rider</label>
                </div>
            </div>
            <?php endif; ?>
            <?php if($profile->get('role') != 'd') : ?>
            <div class="form-group">
                <div class="radio">
                    <label><input type="radio" value="d" name="role">Driver</label>
                </div>
                <div class="radio">
                    <label><input type="radio" value="r" name="role" checked>Rider</label>
                </div>
            </div>
            <?php endif; ?>
            <input class="btn btn-primary" type="submit" name="submit" value="Submit Information">
        </form>
        <h2>Update Password</h2>
        <script type="text/javascript" src="<?= BASE_URL ?>/public/js/confirmPassword.js"></script>
        <form id="edit-pw" action=<?= BASE_URL ?>/profile/password/ method="POST">
            <div class="form-group">
                <label>New Password</label>
                <input type="password" class="form-control" name="nPW" id="nPW" required>
            </div>
            <div class="form-group">
                <label>Confirm New Password</label>
                <input type="password" class="form-control" name="cPW" id="cPW" required>
            </div>
            <input class="btn btn-primary" id="sPW" type="submit" name="submit" value="Change Password">
        </form>
        </div>
	<div id="sidebar"></div>
</div>
