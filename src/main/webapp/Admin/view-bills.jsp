<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>View Bills</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
</head>
<body>
<div class="container mt-5">
    <h2>All Bills</h2>

    <table class="table table-bordered">
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

    <a href="${pageContext.request.contextPath}/Admin/dashboard.jsp" class="btn btn-secondary">⬅ Back to Dashboard</a>
</div>
</body>
</html>
