<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="com.example.pahanaedu2.auth.User" %>
<%@ page import="com.example.pahanaedu2.item.Item" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>

<%
    User user = (session != null) ? (User) session.getAttribute("user") : null;
    if (user == null || !"admin".equalsIgnoreCase(user.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }
    if (request.getAttribute("lowStockItems") == null) {
        response.sendRedirect(request.getContextPath() + "/admin/dashboard");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Admin Dashboard | PahanaEdu</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', sans-serif;
        }
        .dashboard-header {
            margin-top: 40px;
            margin-bottom: 20px;
        }
        .dashboard-header h1 {
            font-weight: 600;
        }
        .action-card {
            transition: transform 0.2s ease;
        }
        .action-card:hover {
            transform: scale(1.03);
        }
    </style>
</head>
<body>


<nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow-sm">
    <div class="container">
        <a class="navbar-brand" href="#">
            <img src="<%= request.getContextPath() %>/images/logo1.jpg" alt="Logo" width="30" height="30" class="d-inline-block align-text-top me-2">
            PahanaEdu Admin
        </a>
        <div class="collapse navbar-collapse justify-content-end">
            <span class="navbar-text text-white me-3">
                Welcome, <strong><%= user.getUsername() %></strong>
            </span>
            <form action="<%= request.getContextPath() %>/logout" method="post" class="d-inline">
                <button class="btn btn-outline-light btn-sm" type="submit">Logout</button>
            </form>
        </div>
    </div>
</nav>

<div class="container">

    <div class="dashboard-header text-center">
        <h1 class="mb-3">Admin Dashboard</h1>
        <p class="lead text-muted">Monitor & manage your system operations here.</p>
    </div>

    <!-- Low Stock Alert -->
    <%
        List<Item> lowStockItems = (List<Item>) request.getAttribute("lowStockItems");
        if (lowStockItems != null && !lowStockItems.isEmpty()) {
    %>
    <div class="alert alert-warning shadow-sm">
        <h5 class="mb-2"><i class="fas fa-box-open me-2"></i>Low Stock Alert</h5>
        <ul class="mb-0">
            <% for (Item item : lowStockItems) { %>
            <li><strong><%= item.getItemName() %></strong> (Stock: <%= item.getStockQuantity() %>)</li>
            <% } %>
        </ul>
    </div>
    <%
        }
    %>

    <p>Total low stock items: <%= lowStockItems.size() %></p>

    <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-4 mt-4">
        <div class="col">
            <a href="<%= request.getContextPath() %>/Admin/manage-users" class="btn btn-primary action-card w-100 py-3 fs-5">
                <i class="fas fa-users me-2"></i> Manage Users
            </a>
        </div>
        <div class="col">
            <a href="<%= request.getContextPath() %>/Admin/manage-customers" class="btn btn-warning action-card w-100 py-3 fs-5">
                <i class="fas fa-user-friends me-2"></i> Manage Customers
            </a>
        </div>
        <div class="col">
            <a href="<%= request.getContextPath() %>/Admin/manage-items" class="btn btn-outline-primary action-card w-100 py-3 fs-5">
                <i class="fas fa-boxes-stacked me-2"></i> Manage Items
            </a>
        </div>
        <div class="col">
            <a href="<%= request.getContextPath() %>/view-bills" class="btn btn-secondary action-card w-100 py-3 fs-5">
                <i class="fas fa-file-invoice-dollar me-2"></i> View Bills
            </a>
        </div>
        <div class="col">
            <a href="<%= request.getContextPath() %>/Admin/view-audit-logs" class="btn btn-dark action-card w-100 py-3 fs-5">
                <i class="fas fa-list-alt me-2"></i> Audit Logs
            </a>
        </div>
        <div class="col">
            <a href="<%= request.getContextPath() %>/Admin/view-reports" class="btn btn-info action-card w-100 py-3 fs-5">
                <i class="fas fa-chart-line me-2"></i> View Reports
            </a>
        </div>
        <div class="col">
            <a href="<%= request.getContextPath() %>/Admin/admin-profile.jsp" class="btn btn-success action-card w-100 py-3 fs-5">
                <i class="fas fa-user-cog me-2"></i> Profile Management
            </a>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
</body>
</html>
