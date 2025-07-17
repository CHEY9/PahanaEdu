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
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body>
<div class="container mt-5">
    <h2><%= isEdit ? "Edit" : "Add" %> Item</h2>
    <form action="manage-items" method="post">
        <input type="hidden" name="action" value="<%= isEdit ? "update" : "insert" %>"/>
        <% if (isEdit) { %>
        <input type="hidden" name="id" value="<%= item.getItemId() %>"/>
        <% } %>

        <div class="mb-3">
            <label for="itemName" class="form-label">Item Name:</label>
            <input type="text" name="itemName" id="itemName" class="form-control" value="<%= isEdit ? item.getItemName() : "" %>" required />
        </div>

        <div class="mb-3">
            <label for="category" class="form-label">Category:</label>
            <input type="text" name="category" id="category" class="form-control" value="<%= isEdit ? item.getCategory() : "" %>" required />
        </div>

        <div class="mb-3">
            <label for="description" class="form-label">Description:</label>
            <textarea name="description" id="description" class="form-control" required><%= isEdit ? item.getDescription() : "" %></textarea>
        </div>

        <div class="mb-3">
            <label for="price" class="form-label">Price:</label>
            <input type="number" step="0.01" name="price" id="price" class="form-control" value="<%= isEdit ? item.getPrice() : "" %>" required />
        </div>

        <div class="mb-3">
            <label for="stock" class="form-label">Stock Quantity:</label>
            <input type="number" name="stock" id="stock" class="form-control" value="<%= isEdit ? item.getStockQuantity() : "" %>" required />
        </div>

        <button type="submit" class="btn btn-primary"><%= isEdit ? "Update" : "Add" %></button>
        <a href="manage-items" class="btn btn-secondary">Cancel</a>
    </form>
</div>
</body>
</html>
