<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Bill Details - Bill #${billId}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .bill-header {
            background-color: #343a40;
            color: #fff;
            padding: 20px 30px;
            border-radius: 8px 8px 0 0;
        }
        .bill-info p {
            font-size: 1.1rem;
            margin-bottom: 0.3rem;
        }
        .table thead {
            background-color: #007bff;
            color: white;
        }
        .total-row {
            font-weight: 700;
            font-size: 1.25rem;
            background-color: #e9ecef;
        }
        .btn-primary {
            min-width: 180px;
        }
    </style>
</head>
<body>
<div class="container my-5 p-0 shadow-sm rounded" style="max-width: 900px; background: white;">

    <div class="bill-header">
        <h2 class="mb-0">Bill Details <small class="text-muted">#${billId}</small></h2>
    </div>

    <div class="p-4 bill-info">
        <p><strong>Customer:</strong> <span class="text-primary">${customer.name}</span></p>
        <p><strong>Bill Date & Time:</strong> <span class="text-secondary">${billDateTime}</span></p>
        <p><strong>Staff:</strong> <span class="text-secondary">${staffUsername}</span></p>
    </div>

    <table class="table table-bordered mb-0">
        <thead>
        <tr>
            <th scope="col">Item Name</th>
            <th scope="col" class="text-center">Quantity</th>
            <th scope="col" class="text-end">Unit Price (Rs.)</th>
            <th scope="col" class="text-end">Total Price (Rs.)</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="item" items="${billItems}">
            <tr>
                <td>${item.itemName}</td>
                <td class="text-center">${item.quantity}</td>
                <td class="text-end">${item.unitPrice}</td>
                <td class="text-end">${item.totalPrice}</td>
            </tr>
        </c:forEach>
        <tr class="total-row">
            <td colspan="3" class="text-end">Grand Total:</td>
            <td class="text-end">Rs. ${totalAmount}</td>
        </tr>
        </tbody>
    </table>

    <div class="p-4 text-center">
        <a href="${pageContext.request.contextPath}/Staff/create-bill-form" class="btn btn-primary btn-lg">
            <i class="bi bi-plus-circle"></i> Create New Bill
        </a>
    </div>

</div>

<!-- Bootstrap Icons (optional) -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
