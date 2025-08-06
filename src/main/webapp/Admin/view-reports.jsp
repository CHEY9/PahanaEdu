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
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>View Reports</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .report-card {
            transition: transform 0.2s ease-in-out;
        }
        .report-card:hover {
            transform: scale(1.02);
        }
        .card-icon-right {
            font-size: 1.5rem;
            color: #6c757d;
        }
    </style>
</head>
<body>
<div class="container mt-5">
    <h2 class="mb-4 text-center">📊 Admin Reports</h2>

    <div class="row g-4">
        <!-- Daily/Monthly Sales -->
        <div class="col-md-4">
            <a href="<%= request.getContextPath() %>/Admin/reports/daily-monthly.jsp" class="text-decoration-none text-dark">
                <div class="card report-card shadow-sm">
                    <div class="card-body d-flex justify-content-between align-items-center">
                        <div>
                            <h5 class="card-title mb-1">Daily/Monthly Sales</h5>
                            <p class="card-text text-muted">📆 Sales trends over time</p>
                        </div>
                        <div class="card-icon-right">➔</div>
                    </div>
                </div>
            </a>
        </div>

        <!-- Most Sold Items -->
        <div class="col-md-4">
            <a href="<%= request.getContextPath() %>/Admin/reports/most-sold-items.jsp" class="text-decoration-none text-dark">
                <div class="card report-card shadow-sm">
                    <div class="card-body d-flex justify-content-between align-items-center">
                        <div>
                            <h5 class="card-title mb-1">Most Sold Items</h5>
                            <p class="card-text text-muted">📦 Most Sold Items</p>
                        </div>
                        <div class="card-icon-right">➔</div>
                    </div>
                </div>
            </a>
        </div>

        <!-- Top Customers -->
        <div class="col-md-4">
            <a href="<%= request.getContextPath() %>/Admin/reports/top-customers.jsp" class="text-decoration-none text-dark">
                <div class="card report-card shadow-sm">
                    <div class="card-body d-flex justify-content-between align-items-center">
                        <div>
                            <h5 class="card-title mb-1">Top Customers</h5>
                            <p class="card-text text-muted">👥 Highest spending users</p>
                        </div>
                        <div class="card-icon-right">➔</div>
                    </div>
                </div>
            </a>
        </div>
    </div>

    <div class="text-center mt-5">
        <a href="<%= request.getContextPath() %>/admin/dashboard" class="btn btn-outline-secondary">⬅ Back to Dashboard</a>
    </div>
</div>
</body>
</html>
