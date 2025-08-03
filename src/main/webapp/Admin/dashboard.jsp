<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="com.example.pahanaedu2.auth.User" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.pahanaedu2.item.Item" %>
<%@ page import="java.util.ArrayList" %>


<%
    User user = (session != null) ? (User) session.getAttribute("user") : null;
    if (user == null || !"admin".equalsIgnoreCase(user.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<%
    if (request.getAttribute("lowStockItems") == null) {
        response.sendRedirect(request.getContextPath() + "/admin/dashboard");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Admin Dashboard</title>
    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet"
            integrity="sha384-..."
            crossorigin="anonymous"
    />
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <div class="container">
            <a class="navbar-brand" href="#">
                <img src="<%= request.getContextPath() %>/images/logo1.jpg" alt="Logo" width="30" height="30" class="d-inline-block align-text-top me-2">
                PahanaEdu Admin
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
    <h1 class="mb-4">Admin Dashboard</h1>

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
    <p>Total low stock items: <%= lowStockItems.size() %></p>
    <p class="lead">Use the options below to manage the system.</p>

    <div class="row g-4">
        <div class="col-sm-6 col-md-4">
            <a href="<%= request.getContextPath() %>/Admin/manage-users" class="btn btn-primary w-100 py-3 fs-5">
                Manage Users
            </a>
        </div>
        <div class="col-sm-6 col-md-4">
            <a href="<%= request.getContextPath() %>/Admin/manage-customers" class="btn btn-warning w-100 py-3 fs-5">
                Manage Customers
            </a>
        </div>
        <div class="col-sm-6 col-md-4">
            <a href="${pageContext.request.contextPath}/Admin/manage-items" class="btn btn-outline-primary w-100 py-3 fs-5">
                Manage Items
            </a>
        </div>
        <div class="col-sm-6 col-md-4">
            <a href="${pageContext.request.contextPath}/view-bills" class="btn btn-secondary w-100 py-3 fs-5">
                View Bills
            </a>

        </div>
        <div class="col-sm-6 col-md-4">
            <a href="${pageContext.request.contextPath}/Admin/view-audit-logs" class="btn btn-dark w-100 py-3 fs-5">
                Audit Logs
            </a>
        </div>
        <div class="col-sm-6 col-md-4">
            <a href="<%= request.getContextPath() %>/Admin/view-reports" class="btn btn-info w-100 py-3 fs-5">
                View Reports
            </a>
        </div>
        <div class="col-sm-6 col-md-4">
        <a href="<%= request.getContextPath() %>/Admin/admin-profile.jsp" class="btn btn-success w-100 py-3 fs-5">
            Profile Management
            </a>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
</body>
</html>
