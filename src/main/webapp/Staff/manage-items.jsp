<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
  <title>Manage Items</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet" />
  <style>
    body {
      background-color: #f8f9fa;
    }
    .table th, .table td {
      vertical-align: middle;
    }
  </style>
</head>
<body>
<div class="container mt-5">
  <div class="d-flex justify-content-between align-items-center mb-4">
    <h2 class="fw-bold">📦 Manage Items</h2>
    <a href="${pageContext.request.contextPath}/Staff/manage-items" class="btn btn-outline-secondary">
      <i class="fas fa-list"></i> Full List
    </a>
  </div>

  <!-- Search Form -->
  <div class="card mb-4 shadow-sm">
    <div class="card-header bg-primary text-white">
      <i class="fas fa-search"></i> Filter Items
    </div>
    <div class="card-body">
      <form action="manage-items" method="get">
        <input type="hidden" name="action" value="search" />
        <div class="row g-3">
          <div class="col-md-3">
            <input type="text" name="itemName" class="form-control" placeholder="Item Name" />
          </div>
          <div class="col-md-3">
            <input type="text" name="category" class="form-control" placeholder="Category" />
          </div>
          <div class="col-md-2">
            <input type="number" step="0.01" name="minPrice" class="form-control" placeholder="Min Price" />
          </div>
          <div class="col-md-2">
            <input type="number" step="0.01" name="maxPrice" class="form-control" placeholder="Max Price" />
          </div>
          <div class="col-md-2 d-grid">
            <button type="submit" class="btn btn-primary">
              <i class="fas fa-search"></i> Search
            </button>
          </div>
        </div>
      </form>
    </div>
  </div>

  <!-- Add New Item -->
  <div class="mb-3">
    <a href="manage-items?action=new" class="btn btn-success">
      <i class="fas fa-plus-circle"></i> Add New Item
    </a>
  </div>

  <!-- Items Table -->
  <div class="table-responsive shadow-sm">
    <table class="table table-hover table-bordered align-middle">
      <thead class="table-dark">
      <tr>
        <th>ID</th>
        <th>Item Name</th>
        <th>Category</th>
        <th>Description</th>
        <th>Price</th>
        <th>Stock</th>
        <th>Actions</th>
      </tr>
      </thead>
      <tbody>
      <c:choose>
        <c:when test="${not empty listItems}">
          <c:forEach var="item" items="${listItems}">
            <tr>
              <td>${item.itemId}</td>
              <td>${item.itemName}</td>
              <td>${item.category}</td>
              <td>${item.description}</td>
              <td>Rs. ${item.price}</td>
              <td>${item.stockQuantity}</td>
              <td>
                <a href="manage-items?action=edit&id=${item.itemId}" class="btn btn-sm btn-warning me-1">
                  <i class="fas fa-edit"></i> Edit
                </a>
                <a href="manage-items?action=delete&id=${item.itemId}" class="btn btn-sm btn-danger"
                   onclick="return confirm('Are you sure to delete this item?');">
                  <i class="fas fa-trash-alt"></i> Delete
                </a>
              </td>
            </tr>
          </c:forEach>
        </c:when>
        <c:otherwise>
          <tr>
            <td colspan="7" class="text-center text-muted">No items found.</td>
          </tr>
        </c:otherwise>
      </c:choose>
      </tbody>
    </table>
  </div>

  <div class="mt-4">
    <a href="dashboard.jsp" class="btn btn-secondary">
      <i class="fas fa-arrow-left"></i> Back to Dashboard
    </a>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
