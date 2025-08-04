<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.pahanaedu2.item.Item" %>
<%
  Item item = (Item) request.getAttribute("item");
  boolean isEdit = (item != null);
%>
<!DOCTYPE html>
<html>
<head>
  <title><%= isEdit ? "Edit" : "Add" %> Item</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
</head>
<body class="bg-light">

<div class="container mt-5">
  <div class="card shadow-sm border-0">
    <div class="card-header bg-primary text-white d-flex justify-content-between align-items-center">
      <h5 class="mb-0">
        <i class="bi <%= isEdit ? "bi-pencil-square" : "bi-plus-circle" %>"></i>
        <%= isEdit ? "Edit Item" : "Add New Item" %>
      </h5>
    </div>
    <div class="card-body">
      <form action="manage-items" method="post">
        <input type="hidden" name="action" value="<%= isEdit ? "update" : "insert" %>"/>
        <% if (isEdit) { %>
        <input type="hidden" name="id" value="<%= item.getItemId() %>"/>
        <% } %>

        <div class="mb-3">
          <label for="ItemName" class="form-label">Item Name</label>
          <input type="text" class="form-control" id="ItemName" name="ItemName"
                 value="<%= isEdit ? item.getItemName() : "" %>" placeholder="Enter item name" required>
        </div>

        <div class="mb-3">
          <label for="category" class="form-label">Category</label>
          <input type="text" class="form-control" id="category" name="category"
                 value="<%= isEdit ? item.getCategory() : "" %>" placeholder="e.g. Stationery, Electronics" required>
        </div>

        <div class="mb-3">
          <label for="description" class="form-label">Description</label>
          <textarea class="form-control" id="description" name="description" rows="3"
                    placeholder="Enter item description" required><%= isEdit ? item.getDescription() : "" %></textarea>
        </div>

        <div class="row">
          <div class="col-md-6 mb-3">
            <label for="price" class="form-label">Price (LKR)</label>
            <input type="number" step="0.01" class="form-control" id="price" name="price"
                   value="<%= isEdit ? item.getPrice() : "" %>" placeholder="0.00" required>
          </div>
          <div class="col-md-6 mb-3">
            <label for="stock" class="form-label">Stock Quantity</label>
            <input type="number" class="form-control" id="stock" name="stock"
                   value="<%= isEdit ? item.getStockQuantity() : "" %>" required>
          </div>
        </div>

        <div class="d-flex justify-content-end">
          <a href="manage-items" class="btn btn-secondary me-2">
            <i class="bi bi-arrow-left-circle"></i> Cancel
          </a>
          <button type="submit" class="btn btn-success">
            <i class="bi <%= isEdit ? "bi-save" : "bi-plus-circle" %>"></i>
            <%= isEdit ? "Update Item" : "Add Item" %>
          </button>
        </div>
      </form>
    </div>
  </div>
</div>

</body>
</html>
