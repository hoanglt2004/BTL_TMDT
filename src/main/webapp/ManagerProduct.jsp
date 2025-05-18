<form action="add" method="post">
    <div class="modal-header">
        <h4 class="modal-title">Add Product</h4>
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
    </div>
    <div class="modal-body">
        <div class="form-group">
            <label>Name</label>
            <input name="name" type="text" class="form-control" required>
        </div>
        <div class="form-group">
            <label>Image</label>
            <input name="image" type="text" class="form-control" required>
        </div>
        <div class="form-group">
            <label>Image 2</label>
            <input name="image2" type="text" class="form-control" required>
        </div>
        <div class="form-group">
            <label>Image 3</label>
            <input name="image3" type="text" class="form-control" required>
        </div>
        <div class="form-group">
            <label>Price</label>
            <input name="price" type="text" class="form-control" required>
        </div>
        <div class="form-group">
            <label>Brand</label>
            <textarea name="brand" class="form-control" required></textarea>
        </div>
        <div class="form-group">
            <label>Description</label>
            <textarea name="description" class="form-control" required></textarea>
        </div>
        <div class="form-group">
            <label>Category ID</label>
            <input name="cateID" type="text" class="form-control" required>
        </div>
    </div>
    <div class="modal-footer">
        <input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel">
        <input type="submit" class="btn btn-success" value="Add">
    </div>
</form>