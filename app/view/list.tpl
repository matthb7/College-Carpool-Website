<div id="main">
	<div id="content">
		<h2>Rides</h2>
        <?php if (isset($_SESSION['follow'])) : ?>
            <p>User followed</p>
        <?php endif; unset($_SESSION['follow'])?>
        <?php if (isset($_SESSION['unfollow'])) : ?>
            <p>User unfollowed</p>
        <?php endif; unset($_SESSION['unfollow'])?>
		<?php foreach($productRes as $i) {?>
			<form method="POST">
				<div class="product" testid="<?= $i->get('creator_id') ?>" testid2="<?= $_SESSION['id'] ?>">
					<img class="product-image" src="<?= BASE_URL ?>/public/img/<?= $i->get('img_url') ?>"/>
					<h3><a href="<?= BASE_URL ?>/viewProduct/<?= $i->get('id') ?>">To <?= $i->get('destination') ?></a></h3>
					<p>From <?= $i->get('source') ?></p>
					<p><?= $i->get('leave_time') ?></p>
					<p class="price"><?= $i->get('price') ?></p>

					<?php if (isset($_SESSION['user']) && (($_SESSION['user'] === 'ADMIN') || ($i->get('creator_id') == $_SESSION['id']))) { ?>
						<button class="btn btn-warning" formaction="<?= BASE_URL ?>/editProduct/<?= $i->get('id') ?>">Edit</button>
						<button class="btn btn-danger" formaction="<?= BASE_URL ?>/deleteProduct/<?= $i->get('id') ?>">Delete</button>
					<?php } ?>
                    <?php if(isset($_SESSION['user']) && in_array($i->get('creator_id'), $array1)) { ?>
					    <button class="btn btn-warning" formaction="<?= BASE_URL ?>/follow/<?= $i->get('creator_id') ?>">Unfollow</button>
                    <?php } ?>
					<?php if(isset($_SESSION['user']) && !in_array($i->get('creator_id'), $array1)) { ?>
					    <button class="btn btn-success" formaction="<?= BASE_URL ?>/follow/<?= $i->get('creator_id') ?>">Follow</button>
                    <?php } ?>
                    
                    <?php
					//in case the array hasn't been made yet
					$array;
					if($i->get('claimedArray') == "")
					{
						$array = array();
					}
					else
					{
						$array = unserialize($i->get('claimedArray'));
					}
					
					//numbers
					$green = $i->get('seats');
					$yellow = 0;
					foreach($array as $a)
					{
						if ($a == $_SESSION['id'])
						{
							$yellow = $yellow + 1;
						}
					}
					$red = count($array) - $yellow;//number claimed that isnt me.
					$green = $green - $red - $yellow;

					if (isset($_SESSION['user'])) {
						if ($green > 0) { ?>
							<p class="seatInfo" id="<?= $i->get('id') ?>" style="color:green;"> Click green slots to claim a seat! </p>
						<?php } 
						else if ($i->get('seats') > 0) { ?>
							<p class="seatInfo" id="<?= $i->get('id') ?>" style="color:red;"> There are no more available seats! </p>
						<?php }
						
						for ($x = 0; $x < $green; $x++) { ?>
		                    <svg id="<?= $_SESSION['id'] ?>" class="svg-seat" width="60" height="60">
								<rect class="seat" id="<?= $i->get('id') ?>" x="5" y="5" width="50" height="50" style="fill:green;" onClick="seatClick(event, <?= $i->get('id')?>, <?= $i->get('seats')?>);"/>
							</svg>
						<?php }

						for ($x = 0; $x < $yellow; $x++) { ?>
		                    <svg id="<?= $yellow ?>" class="svg-seat" width="60" height="60">
								<rect class="seat" id="<?= $i->get('id') ?>" x="5" y="5" width="50" height="50" style="fill:yellow;" onClick="seatClick(event, <?= $i->get('id')?>, <?= $i->get('seats')?>);"/>
							</svg>
						<?php }

						for ($x = 0; $x < $red; $x++) { ?>
		                    <svg id="<?= var_export($array) ?>" class="svg-seat" width="60" height="60">
								<rect class="seat" id="<?= $i->get('id') ?>" x="5" y="5" width="50" height="50" style="fill:red;" onClick="seatClick(event, <?= $i->get('id')?>, <?= $i->get('seats')?>);"/>
							</svg>
						<?php }
					} ?>
				</div>
			</form>
		<?php } ?>
	    <button type="button" id="loadmore" class="btn btn-primary btn-block">Load More Rides</button>
	</div>
</div>