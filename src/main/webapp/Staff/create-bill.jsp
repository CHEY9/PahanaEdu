<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Create New Bill</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        body {
            background: linear-gradient(to right, #e0f7fa, #e1bee7);
            min-height: 100vh;
        }
        .card {
            border-radius: 20px;
            box-shadow: 0 6px 24px rgba(0,0,0,0.1);
            background-color: #ffffffee;
        }
        h2 {
            font-weight: 600;
            color: #5e35b1;
        }
        .table thead {
            background-color: #d1c4e9;
            color: #4a148c;
        }
        .table tbody tr:nth-child(even) {
            background-color: #f3e5f5;
        }
        .badge {
            font-size: 1rem;
        }
        .btn-primary {
            background-color: #7e57c2;
            border-color: #7e57c2;
        }
        .btn-outline-secondary {
            border-color: #9575cd;
            color: #5e35b1;
        }
        .btn-outline-secondary:hover {
            background-color: #d1c4e9;
            color: #4a148c;
        }
    </style>
</head>
<body>
<div class="container my-5">
    <div class="card p-4">
        <h2 class="mb-4">🧾 Create New Bill</h2>

        <div class="mb-4">
            <span class="badge bg-primary me-2">Customers: ${fn:length(customers)}</span>
            <span class="badge bg-success">Items: ${fn:length(items)}</span>
        </div>

        <form action="${pageContext.request.contextPath}/Staff/create-bill" method="post">
            <div class="mb-4">
                <label for="customerId" class="form-label fw-semibold">Select Customer</label>
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

            <div class="table-responsive mb-4">
                <table class="table table-bordered table-hover align-middle">
                    <thead>
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
                            <td style="width: 150px;">
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
            </div>

            <div class="d-flex justify-content-between">
                <button type="submit" class="btn btn-primary">Generate Bill</button>
                <a href="${pageContext.request.contextPath}/staff/manage-bills" class="btn btn-outline-secondary">Cancel</a>
            </div>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
