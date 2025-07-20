<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    if (request.getAttribute("topCustomers") == null) {
        response.sendRedirect(request.getContextPath() + "/Admin/reports/top-customers");
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Top Customers Report</title>
    <!-- Bootstrap 5 CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container my-5">
    <h1 class="text-center mb-4 text-info">👥 Top Customers Report</h1>

    <div class="card shadow">
        <div class="card-header bg-info text-white">
            <h5 class="mb-0">Highest Spending Customers</h5>
        </div>
        <div class="card-body p-0">
            <table class="table table-bordered table-striped mb-0">
                <thead class="table-light">
                <tr>
                    <th>Customer Name</th>
                    <th>Total Spent (LKR)</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="customer" items="${topCustomers}">
                    <tr>
                        <td>${customer.name}</td>
                        <td>Rs. ${customer.totalSpent}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <div class="mt-4 text-center">
        <a href="${pageContext.request.contextPath}/Admin/view-reports.jsp" class="btn btn-outline-secondary">
            ⬅ Back to Reports Menu
        </a>
    </div>
</div>

<!-- Bootstrap JS (optional) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
