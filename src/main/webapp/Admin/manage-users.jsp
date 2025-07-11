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
</head>
<body>
<div class="container mt-5">
    <h2>Manage Users</h2>

    <a href="add-user.jsp" class="btn btn-success mb-3">Add New User</a>

    <%
        String error = (String) request.getAttribute("errorMessage");
        if (error != null) {
    %>
    <div class="alert alert-danger"><%= error %></div>
    <% } %>

    <table class="table table-striped">
        <thead>
        <tr>
            <th>ID</th>
            <th>Username</th>
            <th>Email</th>
            <th>Phone</th>
            <th>Role</th>
            <th>Actions</th>
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
            <td><%= u.getRole() %></td>
            <td>
                <a href="edit-user.jsp?id=<%= u.getId() %>" class="btn btn-primary btn-sm">Edit</a>
                <a href="delete-user?id=<%= u.getId() %>" class="btn btn-danger btn-sm"
                   onclick="return confirm('Are you sure to delete this user?');">Delete</a>
            </td>
        </tr>
        <% }
        } else { %>
        <tr>
            <td colspan="6" class="text-center">No users found.</td>
        </tr>
        <% } %>
        </tbody>
    </table>
    <a href="dashboard.jsp" class="btn btn-secondary mt-3">Back to Dashboard</a>
</div>
</body>
</html>