<div id="main">
  <div id="content">
  	<?php if (!isset($_SESSION['user'])) { ?>
  		<p>Not registered? Sign up!</p>
        <p>All fields required</p>

  		<form id="login" action="<?= BASE_URL ?>/register" method="POST">
            <div class="form-group">
                <label>Username</label>
                <input type="text" class="form-control" name="un" required>
            </div>
            <div class="form-group">
                <label>Password</label>
  		  		<input type="password" class="form-control" name="pw" required>
  		  	</div>
            <div class="form-group">
                <label>First Name</label>
                <input type="text" class="form-control" name="fn" required>
            </div>
            <div class="form-group">
                <label>Last Name</label>
                <input type="text" class="form-control" name="ln" required>
            </div>
            <div class="form-group">
                <label>Email</label>
                <input type="email" class="form-control" name="em" required>
            </div>
            <div class="form-group">
                <div class="radio">
                    <label><input type="radio" value="d" name="role" checked>Driver</label>
                </div>
                <div class="radio">
                    <label><input type="radio" value="r" name="role">Rider</label>
                </div>
            </div>
  		  	<input class="btn btn-primary" type="submit" name="submit" value="Sign Up">
  		</form>
  	<?php } else { ?>
  		<h1>Congrats!</h1>
  		<h1>Successful Login!</h1>
  		<h1>Please Explore the Site!</h1>
  	<?php } ?>
  </div>
</div>
