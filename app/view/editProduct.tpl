<div id="main">
	<div id="content">
		<h2>Edit Product</h2>

		<form id="edit-product" action="<?= BASE_URL ?>/saveChanges/<?= $product['id'] ?>" method="POST">
			<div class="form-group">
				<label>
					Name: <input class="form-control" type="text" name="name" value="<?= $product['name'] ?>">
				</label>
			</div>

			<div class="form-group">
				<label>
					Destination: <input class="form-control" type="text" name="destination" value="<?= $product['destination'] ?>">
				</label>
			</div>

			<div class="form-group">
				<label>
					Source: <input class="form-control" type="text" name="source" value="<?= $product['source'] ?>">
				</label>
			</div>

			<div class="form-group">
				<label>
					Leave Time: <input class="form-control" type="text" name="leave_time" value="<?= $product['leave_time'] ?>">
				</label>
			</div>

			<div class="form-group">
				<label>
					Price ($): <input class="form-control" type="text" name="price" value="<?= $product['price'] ?>">
				</label>
			</div>

			<div class="form-group">
				<label>
					Available Seats: <input class="form-control" type="text" name="seats" value="<?= $product['seats'] ?>">
				</label>
			</div>

			<div class="form-group">
				<label>
					Extra Info: <textarea class="form-control" name="description"><?= $product['description'] ?></textarea>
				</label>
			</div>

			<div class="form-group">
				<label>
					Optional Image URL: <input class="form-control" type="text" name="url" value="<?= $product['img_url'] ?>">
				</label>
			</div>

			<input class="btn btn-primary" type="submit" name="submit" value="Save Changes">
		</form>
	</div>
</div>