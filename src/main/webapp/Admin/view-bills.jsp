<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>View Bills</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }

        .container {
            margin-top: 50px;
        }

        .table thead {
            background-color: #212529;
            color: #ffffff;
        }

        .table tbody tr:hover {
            background-color: #e9ecef;
        }

        h2 {
            font-weight: 700;
            margin-bottom: 30px;
            color: #343a40;
            text-align: center;
        }

        .btn-back {
            display: block;
            margin: 30px auto 0;
            padding: 10px 20px;
            font-weight: 500;
        }

        .table th, .table td {
            vertical-align: middle;
            text-align: center;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>🧾 All Billing Records</h2>
    <div class="table-responsive">
        <table class="table table-bordered table-hover align-middle">
            <thead>
            <tr>
                <th>Bill ID</th>
                <th>Customer ID</th>
                <th>Item ID</th>
                <th>Quantity</th>
                <th>Unit Price</th>
                <th>Total Price</th>
                <th>Bill Date & Time</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="bill" items="${billList}">
                <tr>
                    <td>${bill.billId}</td>
                    <td>${bill.id}</td>
                    <td>${bill.itemId}</td>
                    <td>${bill.quantity}</td>
                    <td>${bill.unitPrice}</td>
                    <td>${bill.totalPrice}</td>
                    <td>${bill.billDateTime}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>

    <a href="${pageContext.request.contextPath}/Admin/dashboard.jsp" class="btn btn-secondary btn-back">
        ⬅ Back to Dashboard
    </a>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
