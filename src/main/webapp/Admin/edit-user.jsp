<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.pahanaedu2.auth.User" %>
<%
    User user = (User) request.getAttribute("user");
    String errorMessage = (String) request.getAttribute("errorMessage");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Edit User</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h2>Edit User</h2>

    <% if (errorMessage != null) { %>
    <div class="alert alert-danger"><%= errorMessage %></div>
    <% } %>

    <form action="<%= request.getContextPath() %>/Admin/edit-user" method="post">
        <input type="hidden" name="id" value="<%= user.getId() %>">
        <div class="mb-3">
            <label class="form-label">Username:</label>
            <input type="text" class="form-control" name="username" value="<%= user.getUsername() %>" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Email:</label>
            <input type="email" class="form-control" name="email" value="<%= user.getEmail() %>" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Phone:</label>
            <input type="text" class="form-control" name="phone" value="<%= user.getPhone() %>" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Role:</label>
            <select class="form-control" name="role" required>
                <option value="admin" <%= user.getRole().equals("admin") ? "selected" : "" %>>Admin</option>
                <option value="staff" <%= user.getRole().equals("staff") ? "selected" : "" %>>Staff</option>
            </select>
        </div>
        <button type="submit" class="btn btn-primary">Update</button>
        <a href="<%= request.getContextPath() %>/Admin/manage-users" class="btn btn-secondary">Cancel</a>
    </form>
</div>
</body>
</html>