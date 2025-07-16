<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    if (request.getAttribute("dailySales") == null && request.getAttribute("monthlySales") == null) {
        response.sendRedirect(request.getContextPath() + "/Admin/reports/daily-monthly-reports");
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Daily and Monthly Sales Reports</title>
    <!-- Bootstrap 5 CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container my-5">
    <h1 class="text-center mb-4 text-primary">📊 Daily and Monthly Sales Reports</h1>

    <!-- Daily Sales Table -->
    <div class="card shadow mb-5">
        <div class="card-header bg-primary text-white">
            <h5 class="mb-0">📅 Daily Sales</h5>
        </div>
        <div class="card-body p-0">
            <table class="table table-bordered table-striped mb-0">
                <thead class="table-light">
                <tr>
                    <th>Date</th>
                    <th>Total Sales (LKR)</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="day" items="${dailySales}">
                    <tr>
                        <td>${day.date}</td>
                        <td>Rs. ${day.sales}</td>
                    </tr>
                </c:forEach>
                <c:if test="${empty dailySales}">
                    <tr><td colspan="2" class="text-danger text-center">No daily sales found</td></tr>
                </c:if>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Monthly Sales Table -->
    <div class="card shadow">
        <div class="card-header bg-success text-white">
            <h5 class="mb-0">📆 Monthly Sales</h5>
        </div>
        <div class="card-body p-0">
            <table class="table table-bordered table-striped mb-0">
                <thead class="table-light">
                <tr>
                    <th>Month</th>
                    <th>Total Sales (LKR)</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="month" items="${monthlySales}">
                    <tr>
                        <td>${month.month}</td>
                        <td>Rs. ${month.sales}</td>
                    </tr>
                </c:forEach>
                <c:if test="${empty monthlySales}">
                    <tr><td colspan="2" class="text-danger text-center">No monthly sales found</td></tr>
                </c:if>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Back Button -->
    <div class="mt-4 text-center">
        <a href="${pageContext.request.contextPath}/Admin/view-reports.jsp" class="btn btn-outline-secondary">
            ⬅ Back to Reports Menu
        </a>
    </div>
</div>

<!-- Bootstrap JS (Optional for components) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
