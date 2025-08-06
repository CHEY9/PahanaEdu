<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Items</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet" />
    <style>
        .form-control::placeholder {
            font-style: italic;
        }
        .btn-sm i {
            margin-right: 4px;
        }
        .table-hover tbody tr:hover {
            background-color: #f1f1f1;
        }
        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
    </style>
</head>
<body>
<div class="container mt-5">
    <div class="section-header mb-4">
        <h2><i class="bi bi-box-seam"></i> Manage Items</h2>
        <a href="${pageContext.request.contextPath}/Admin/manage-items" class="btn btn-outline-secondary">
            <i class="bi bi-arrow-clockwise"></i> Reset Search
        </a>
    </div>

    <!-- Search Form -->
    <form action="manage-items" method="get" class="mb-4 p-3 border rounded bg-light">
        <input type="hidden" name="action" value="search" />
        <div class="row g-3">
            <div class="col-md-3">
                <input type="text" name="itemName" class="form-control" placeholder="🔍 Item Name" />
            </div>
            <div class="col-md-3">
                <input type="text" name="category" class="form-control" placeholder="📂 Category" />
            </div>
            <div class="col-md-2">
                <input type="number" step="0.01" name="minPrice" class="form-control" placeholder="💲 Min Price" />
            </div>
            <div class="col-md-2">
                <input type="number" step="0.01" name="maxPrice" class="form-control" placeholder="💲 Max Price" />
            </div>
            <div class="col-md-2">
                <button type="submit" class="btn btn-primary w-100">
                    <i class="bi bi-search"></i> Search
                </button>
            </div>
        </div>
    </form>

    <!-- Add New Item Button -->
    <div class="mb-3 text-end">
        <a href="manage-items?action=new" class="btn btn-success">
            <i class="bi bi-plus-circle"></i> Add New Item
        </a>
    </div>

    <!-- Items Table -->
    <div class="table-responsive">
        <table class="table table-bordered table-hover align-middle">
            <thead class="table-dark">
            <tr>
                <th>ID</th>
                <th>Item Name</th>
                <th>Category</th>
                <th>Description</th>
                <th>Price (Rs.)</th>
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
                            <td>${item.price}</td>
                            <td>${item.stockQuantity}</td>
                            <td>
                                <a href="manage-items?action=edit&id=${item.itemId}" class="btn btn-sm btn-warning">
                                    <i class="bi bi-pencil-square"></i> Edit
                                </a>
                                <a href="manage-items?action=delete&id=${item.itemId}" class="btn btn-sm btn-danger"
                                   onclick="return confirm('Are you sure to delete this item?');">
                                    <i class="bi bi-trash3"></i> Delete
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

    <a href="dashboard.jsp" class="btn btn-secondary mt-4">
        <i class="bi bi-arrow-left-circle"></i> Back to Dashboard
    </a>
</div>
</body>
</html>
