<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>Manage Items</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body>
<div class="container mt-5">
    <h2>Manage Items</h2>

    <!-- Search Form -->
    <form action="manage-items" method="get" class="mb-3">
        <input type="hidden" name="action" value="search" />
        <div class="row g-2">
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
            <div class="col-md-2">
                <button type="submit" class="btn btn-primary w-100">Search</button>
            </div>
        </div>
    </form>
    <a href="${pageContext.request.contextPath}/Admin/manage-items" class="btn btn-secondary mb-3">
        Back to Full Item List
    </a>


    <!-- Add New Item Button -->
    <a href="manage-items?action=new" class="btn btn-success mb-3">Add New Item</a>


    <!-- Items Table -->
    <table class="table table-bordered table-striped">
        <thead>
        <tr>
            <th>ID</th>
            <th>ItemName</th>
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
                        <td>${item.price}</td>
                        <td>${item.stockQuantity}</td>
                        <td>
                            <a href="manage-items?action=edit&id=${item.itemId}" class="btn btn-primary btn-sm">Edit</a>
                            <a href="manage-items?action=delete&id=${item.itemId}" class="btn btn-danger btn-sm"
                               onclick="return confirm('Are you sure to delete this item?');">Delete</a>
                        </td>
                    </tr>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <tr>
                    <td colspan="7" class="text-center">No items found.</td>
                </tr>
            </c:otherwise>
        </c:choose>
        </tbody>
    </table>
    <a href="dashboard.jsp" class="btn btn-secondary mt-3">Back to Dashboard</a>
</div>
</body>
</html>
