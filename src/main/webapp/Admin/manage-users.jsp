<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.pahanaedu2.auth.User" %>
<%
    List<User> users = (List<User>) request.getAttribute("users");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Users - Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }

        .container {
            background-color: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
        }

        h2 {
            margin-bottom: 25px;
        }

        .btn {
            border-radius: 20px;
        }

        .table {
            margin-top: 20px;
        }

        .table th, .table td {
            vertical-align: middle;
        }
    </style>
</head>
<body>
<div class="container mt-5">
    <div class="d-flex justify-content-between align-items-center">
        <h2><i class="bi bi-people-fill me-2"></i>Manage Users</h2>
        <a href="add-user.jsp" class="btn btn-success">
            <i class="bi bi-person-plus-fill"></i> Add New User
        </a>
    </div>

    <% String error = (String) request.getAttribute("errorMessage");
        if (error != null) { %>
    <div class="alert alert-danger mt-3"><%= error %></div>
    <% } %>

    <table class="table table-hover table-bordered mt-4">
        <thead class="table-dark">
        <tr>
            <th>ID</th>
            <th><i class="bi bi-person-circle"></i> Username</th>
            <th><i class="bi bi-envelope-fill"></i> Email</th>
            <th><i class="bi bi-telephone-fill"></i> Phone</th>
            <th><i class="bi bi-shield-lock-fill"></i> Role</th>
            <th><i class="bi bi-gear-fill"></i> Actions</th>
        </tr>
        </thead>
        <tbody>
        <% if (users != null && !users.isEmpty()) {
            for (User u : users) { %>
        <tr>
            <td><%= u.getId() %></td>
            <td><%= u.getUsername() %></td>
            <td><%= u.getEmail() %></td>
            <td><%= u.getPhone() %></td>
            <td><span class="badge bg-info text-dark"><%= u.getRole() %></span></td>
            <td>
                <a href="<%= request.getContextPath() %>/Admin/edit-user?id=<%= u.getId() %>" class="btn btn-sm btn-outline-primary me-1">
                    <i class="bi bi-pencil-square"></i> Edit
                </a>
                <a href="<%= request.getContextPath() %>/Admin/delete-user?id=<%= u.getId() %>"
                   class="btn btn-sm btn-outline-danger"
                   onclick="return confirm('Are you sure you want to delete this user?');">
                    <i class="bi bi-trash-fill"></i> Delete
                </a>
            </td>
        </tr>
        <% }
        } else { %>
        <tr>
            <td colspan="6" class="text-center text-muted">No users found.</td>
        </tr>
        <% } %>
        </tbody>
    </table>

    <div class="text-end mt-4">
        <a href="dashboard.jsp" class="btn btn-secondary">
            <i class="bi bi-arrow-left-circle"></i> Back to Dashboard
        </a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
