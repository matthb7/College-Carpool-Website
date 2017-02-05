<div id="main">
	<div id="content">
		<h2>Login</h2>
		<?php if (isset($_SESSION['err'])) { ?>
			<p style="color: red;">Invalid Credentials</p>
			<?php unset($_SESSION['err']); ?>
		<?php } ?>

		<form id="login" action="<?= BASE_URL ?>/login/process" method="POST">
			<div class="form-group">
				<input type="text" name="un" placeholder="Username">
			</div>
		  	<div class="form-group">
		  		<input type="password" name="pw" placeholder="Password">
		  	</div>
		  	<input class="btn btn-primary" type="submit" name="submit" value="Log In">
		</form>
	</div>

	<div id="sidebar"></div>
</div>