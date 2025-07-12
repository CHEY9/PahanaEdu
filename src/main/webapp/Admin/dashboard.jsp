<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="com.example.pahanaedu2.auth.User" %>

<%
    User user = (session != null) ? (User) session.getAttribute("user") : null;
    if (user == null || !"admin".equalsIgnoreCase(user.getRole())) {
        response.sendRedirect("login.jsp");
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
        <a class="navbar-brand" href="#">PahanaEdu Admin</a>
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
            <a href="<%= request.getContextPath() %>/Admin/manage-bills.jsp" class="btn btn-secondary w-100 py-3 fs-5">
                View Bills
            </a>
        </div>
        <div class="col-sm-6 col-md-4">
            <a href="<%= request.getContextPath() %>/Admin/audit-logs.jsp" class="btn btn-dark w-100 py-3 fs-5">
                Audit Logs
            </a>
        </div>
        <div class="col-sm-6 col-md-4">
            <a href="<%= request.getContextPath() %>/Admin/view-reports.jsp" class="btn btn-info w-100 py-3 fs-5">
                View Reports
            </a>
        </div>

    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
</body>
</html>
