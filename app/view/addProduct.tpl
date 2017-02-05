<div id="main">
	<div id="content">
		<h2>New Product</h2>

		<form id="edit-product" action="<?= BASE_URL ?>/add/" method="POST">
			<div class="form-group">
				<label>
					Name: <input type="text" name="name">
				</label>
			</div>

			<div class="form-group">
				<label>
					Destination: <input type="text" name="destination">
				</label>
			</div>

			<div class="form-group">
				<label>
					Source: <input type="text" name="source">
				</label>
			</div>

			<div class="form-group">
				<label>
					Leave Time: <input type="text" name="leave_time">
				</label>
			</div>

			<div class="form-group">
				<label>
					Price ($): <input type="text" name="price">
				</label>
			</div>

			<div class="form-group">
				<label>
					Available Seats: <input type="text" name="seats">
				</label>
			</div>


			<div class="form-group">
				<label>
					Extra Info: <textarea name="description"></textarea>
				</label>
			</div>

			<div class="form-group">
				<label>
					Optional Image URL: <input type="text" name="url">
				</label>
			</div>

			<input class="btn btn-primary" type="submit" name="submit" value="Add Product">
		</form>
	</div>
</div>