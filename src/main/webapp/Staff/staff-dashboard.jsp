<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="com.example.pahanaedu2.auth.User" %>

<%
    User user = (session != null) ? (User) session.getAttribute("user") : null;
    if (user == null || !"staff".equalsIgnoreCase(user.getRole())) {
        response.sendRedirect("../login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Staff Dashboard</title>
    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet"
            crossorigin="anonymous"
    />
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="#">PahanaEdu Staff</a>
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
    <p class="lead">Use the options below to manage bills and customers.</p>

    <div class="row g-4">
        <div class="col-sm-6 col-md-4">
            <a href="<%= request.getContextPath() %>/Staff/create-bill" class="btn btn-primary w-100 py-3 fs-5">
                Create New Bill
            </a>
        </div>
        <div class="col-sm-6 col-md-4">
            <a href="<%= request.getContextPath() %>/Staff/view-bills" class="btn btn-success w-100 py-3 fs-5">
                View All Bills
            </a>
        </div>
        <div class="col-sm-6 col-md-4">
            <a href="<%= request.getContextPath() %>/Staff/manage-customers" class="btn btn-warning w-100 py-3 fs-5">
                Manage Customers
            </a>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
</body>
</html>
