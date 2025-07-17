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
    <title>Staff Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="#">
            <img src="<%= request.getContextPath() %>/images/logo1.jpg" alt="Logo" width="30" height="30" class="d-inline-block align-text-top me-2">
            PahanaEdu Staff
        </a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <span class="navbar-text text-white me-3">
                        Welcome, <strong><%= user.getUsername() %></strong>
                    </span>
                </li>
                <li class="nav-item">
                    <form action="<%= request.getContextPath() %>/logout" method="post" class="d-inline">
                        <button class="btn btn-outline-light btn-sm" type="submit">Logout</button>
                    </form>
                </li>
            </ul>
        </div>
    </div>
</nav>

<div class="container mt-5">
    <h1 class="mb-4">Staff Dashboard</h1>

    <%
        Object lowStockRaw = request.getAttribute("lowStockItems");
        List<Item> lowStockItems = (lowStockRaw instanceof List) ? (List<Item>) lowStockRaw : new ArrayList<>();

        if (lowStockItems != null && !lowStockItems.isEmpty()) {
    %>
    <div class="alert alert-warning mt-4">
        <h5>⚠️ Low Stock Alert</h5>
        <ul>
            <% for (Item item : lowStockItems) { %>
            <li><strong><%= item.getItemName() %></strong> (Stock: <%= item.getStockQuantity() %>)</li>
            <% } %>
        </ul>
    </div>
    <%
        }
    %>
    <div class="row g-4 mt-4">
        <div class="col-sm-6 col-md-4">
            <a href="<%= request.getContextPath() %>/Staff/manage-customers" class="btn btn-warning w-100 py-3 fs-5">
                Manage Customers
            </a>
        </div>
        <div class="col-sm-6 col-md-4">
            <a href="<%= request.getContextPath() %>/Staff/manage-items" class="btn btn-info w-100 py-3 fs-5">
                Manage Items
            </a>
        </div>
        <div class="col-sm-6 col-md-4">
            <a href="<%= request.getContextPath() %>/Manage-bills" class="btn btn-secondary w-100 py-3 fs-5">
                Manage Bills
            </a>
        </div>
        <div class="col-sm-6 col-md-4">
            <a href="<%= request.getContextPath() %>/Staff/staff-profile.jsp" class="btn btn-success w-100 py-3 fs-5">
                Profile Management
            </a>
        </div>
        <div class="col-sm-6 col-md-4">
            <a href="<%= request.getContextPath() %>/Staff/help.jsp" class="btn btn-outline-primary w-100 py-3 fs-5">
                ❓ Help & Support
            </a>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
