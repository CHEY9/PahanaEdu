<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="com.example.pahanaedu2.auth.User" %>
<%@ page import="com.example.pahanaedu2.item.Item" %>
<%@ page import="java.util.List" %>

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
    List<Item> lowStockItems = (List<Item>) request.getAttribute("lowStockItems");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Staff Dashboard | PahanaEdu</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">

    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', sans-serif;
        }
        .dashboard-header {
            margin-top: 50px;
            margin-bottom: 30px;
        }
        .dashboard-header h1 {
            font-weight: 600;
        }
        .action-card {
            transition: transform 0.2s ease;
            border-radius: 0.5rem;
            box-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075);
        }
        .action-card:hover {
            transform: scale(1.02);
        }
        .navbar-brand img {
            border-radius: 50%;
        }
        .alert-warning ul {
            padding-left: 1.2rem;
        }
    </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow-sm">
    <div class="container">
        <a class="navbar-brand d-flex align-items-center" href="#">
            <img src="<%= request.getContextPath() %>/images/logo1.jpg" alt="Logo" width="32" height="32" class="me-2">
            <span>PahanaEdu Staff</span>
        </a>
        <div class="d-flex align-items-center ms-auto">
            <span class="navbar-text text-white me-3">
                Welcome, <strong><%= user.getUsername() %></strong>
            </span>
            <form action="<%= request.getContextPath() %>/logout" method="post" class="mb-0">
                <button class="btn btn-outline-light btn-sm">Logout</button>
            </form>
        </div>
    </div>
</nav>

<div class="container">


    <div class="dashboard-header text-center">
        <h1 class="mb-3">Staff Dashboard</h1>
        <p class="text-muted lead">Assist and manage your responsibilities efficiently.</p>
    </div>

    <!-- Low Stock Alert -->
    <% if (lowStockItems != null && !lowStockItems.isEmpty()) { %>
    <div class="alert alert-warning shadow-sm">
        <h5 class="mb-2"><i class="fas fa-box-open me-2"></i>Low Stock Items</h5>
        <ul class="mb-0">
            <% for (Item item : lowStockItems) { %>
            <li><strong><%= item.getItemName() %></strong> – Stock: <%= item.getStockQuantity() %></li>
            <% } %>
        </ul>
    </div>
    <% } %>

    <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-4 mt-4">
        <div class="col">
            <a href="<%= request.getContextPath() %>/Staff/manage-customers" class="btn btn-warning action-card w-100 py-3 fs-5">
                <i class="fas fa-user-friends me-2"></i> Manage Customers
            </a>
        </div>
        <div class="col">
            <a href="<%= request.getContextPath() %>/Staff/manage-items" class="btn btn-outline-primary action-card w-100 py-3 fs-5">
                <i class="fas fa-boxes me-2"></i> Manage Items
            </a>
        </div>
        <div class="col">
            <a href="<%= request.getContextPath() %>/view-bills" class="btn btn-secondary action-card w-100 py-3 fs-5">
                <i class="fas fa-file-invoice me-2"></i> View Bills
            </a>
        </div>
        <div class="col">
            <a href="<%= request.getContextPath() %>/Staff/profile.jsp" class="btn btn-success action-card w-100 py-3 fs-5">
                <i class="fas fa-user-cog me-2"></i> Profile Management
            </a>
        </div>
        <div class="col">
            <a href="<%= request.getContextPath() %>/Staff/help.jsp" class="btn btn-info action-card w-100 py-3 fs-5 text-white">
                <i class="fas fa-question-circle me-2"></i> Help & Support
            </a>
        </div>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
