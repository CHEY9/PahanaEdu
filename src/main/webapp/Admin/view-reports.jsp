<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.pahanaedu2.auth.User" %>
<%
    User user = (session != null) ? (User) session.getAttribute("user") : null;
    if (user == null || !"admin".equalsIgnoreCase(user.getRole())) {
        response.sendRedirect("../login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View Reports</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body>
<div class="container mt-5">
    <h2 class="mb-4">📊 View Reports</h2>

    <div class="list-group">
        <a href="<%= request.getContextPath() %>/Admin/reports/daily-monthly.jsp" class="list-group-item list-group-item-action">
            📆 Daily/Monthly Sales Reports
        </a>
        <a href="<%= request.getContextPath() %>/Admin/reports/most-sold-items.jsp" class="list-group-item list-group-item-action">
            📦 Most Sold Items
        </a>
        <a href="<%= request.getContextPath() %>/Admin/reports/top-customers.jsp" class="list-group-item list-group-item-action">
            👥 Top Customers
        </a>
    </div>

    <a href="<%= request.getContextPath() %>/admin/dashboard" class="btn btn-secondary mt-4">⬅ Go Back</a>
</div>
</body>
</html>
