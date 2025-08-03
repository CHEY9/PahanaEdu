
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
    <title>Create New Bill</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body>
<div class="container mt-5">
    <h2>Create New Bill</h2>

    <div>
        <p>Customers count: ${fn:length(customers)}</p>
        <p>Items count: ${fn:length(items)}</p>
    </div>

    <form action="${pageContext.request.contextPath}/Staff/create-bill" method="post">

        <div class="mb-3">
            <label for="customerId" class="form-label">Select Customer</label>
            <select id="customerId" name="customerId" class="form-select" required>
                <option value="">-- Select Customer --</option>
                <c:forEach var="customer" items="${customers}">
                    <option value="${customer.id}">${customer.name}</option>
                </c:forEach>
            </select>
        </div>

        <c:if test="${not empty errorMessage}">
            <div class="alert alert-warning" role="alert">
                    ${errorMessage}
            </div>
        </c:if>


        <!-- Items Table -->
        <table class="table table-bordered table-striped">
            <thead class="table-light">
            <tr>
                <th>Item Name</th>
                <th>Category</th>
                <th>Price (Rs.)</th>
                <th>Stock</th>
                <th>Quantity</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="item" items="${items}">
                <tr>
                    <td>${item.itemName}</td>
                    <td>${item.category}</td>
                    <td>${item.price}</td>
                    <td>${item.stockQuantity}</td>
                    <td>
                        <input type="number"
                               name="quantities"
                               min="0"
                               max="${item.stockQuantity}"
                        value="0"
                        class="form-control" />
                        <input type="hidden" name="itemIds" value="${item.itemId}" />
                        <input type="hidden" name="prices" value="${item.price}" />
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>

        <button type="submit" class="btn btn-primary">Generate Bill</button>
        <a href="${pageContext.request.contextPath}/staff/manage-bills" class="btn btn-secondary">Cancel</a>
    </form>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
