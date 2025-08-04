<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="com.example.pahanaedu2.auth.User" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.pahanaedu2.item.Item" %>
<%@ page import="java.util.ArrayList" %>

<%
    User user = (session != null) ? (User) session.getAttribute("user") : null;
    if (user == null || !"staff".equalsIgnoreCase(user.getRole())) {
        response.sendRedirect("../login.jsp");
        return;
    }
    if (request.getAttribute("lowStockItems") == null) {
        response.sendRedirect(request.getContextPath() + "/Staff/staff-dashboard");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Staff Dashboard | PahanaEdu</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f9f9f9;
        }
        .dashboard-card {
            transition: transform 0.2s ease;
        }
        .dashboard-card:hover {
            transform: scale(1.02);
        }
        .navbar-brand img {
            border-radius: 5px;
        }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark bg-primary shadow-sm">
    <div class="container">
        <a class="navbar-brand d-flex align-items-center" href="#">
            <img src="<%= request.getContextPath() %>/images/logo1.jpg" alt="Logo" width="35" height="35" class="me-2">
            <strong>PahanaEdu Staff</strong>
        </a>
        <div class="d-flex align-items-center">
            <span class="text-white me-3">
                Welcome, <strong><%= user.getUsername() %></strong>
            </span>
            <form action="<%= request.getContextPath() %>/logout" method="post" class="mb-0">
                <button class="btn btn-outline-light btn-sm" type="submit">
                    <i class="fas fa-sign-out-alt"></i> Logout
                </button>
            </form>
        </div>
    </div>
</nav>

<div class="container py-5">
    <h2 class="mb-4">👋 Welcome to the Staff Dashboard</h2>

    <%
        Object lowStockRaw = request.getAttribute("lowStockItems");
        List<Item> lowStockItems = (lowStockRaw instanceof List) ? (List<Item>) lowStockRaw : new ArrayList<>();
        if (lowStockItems != null && !lowStockItems.isEmpty()) {
    %>
    <div class="alert alert-warning border-start border-5 border-warning" role="alert">
        <h5 class="mb-2"><i class="fas fa-box-open"></i> Low Stock Alert</h5>
        <ul class="mb-0">
            <% for (Item item : lowStockItems) { %>
            <li><strong><%= item.getItemName() %></strong> (Stock: <%= item.getStockQuantity() %>)</li>
            <% } %>
        </ul>
    </div>
    <% } %>

    <div class="row g-4 mt-4">
        <div class="col-md-4">
            <a href="<%= request.getContextPath() %>/Staff/manage-customers" class="text-decoration-none">
                <div class="card dashboard-card shadow-sm p-4 text-center bg-white h-100">
                    <i class="fas fa-users fa-2x text-primary mb-3"></i>
                    <h5>Manage Customers</h5>
                </div>
            </a>
        </div>
        <div class="col-md-4">
            <a href="<%= request.getContextPath() %>/Staff/manage-items" class="text-decoration-none">
                <div class="card dashboard-card shadow-sm p-4 text-center bg-white h-100">
                    <i class="fas fa-boxes fa-2x text-info mb-3"></i>
                    <h5>Manage Items</h5>
                </div>
            </a>
        </div>
        <div class="col-md-4">
            <a href="<%= request.getContextPath() %>/staff/manage-bills" class="text-decoration-none">
                <div class="card dashboard-card shadow-sm p-4 text-center bg-white h-100">
                    <i class="fas fa-file-invoice-dollar fa-2x text-secondary mb-3"></i>
                    <h5>Manage Bills</h5>
                </div>
            </a>
        </div>
        <div class="col-md-4">
            <a href="<%= request.getContextPath() %>/Staff/profile.jsp" class="text-decoration-none">
                <div class="card dashboard-card shadow-sm p-4 text-center bg-white h-100">
                    <i class="fas fa-user-cog fa-2x text-success mb-3"></i>
                    <h5>Profile Management</h5>
                </div>
            </a>
        </div>
        <div class="col-md-4">
            <a href="<%= request.getContextPath() %>/Staff/help.jsp" class="text-decoration-none">
                <div class="card dashboard-card shadow-sm p-4 text-center bg-white h-100">
                    <i class="fas fa-question-circle fa-2x text-dark mb-3"></i>
                    <h5>Help & Support</h5>
                </div>
            </a>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/js/all.min.js"></script>
</body>
</html>
