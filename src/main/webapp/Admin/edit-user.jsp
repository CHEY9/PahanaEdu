<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.pahanaedu2.auth.User" %>
<%
    User user = (User) request.getAttribute("user");
    String errorMessage = (String) request.getAttribute("errorMessage");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Edit User - PahanaEdu</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        body {
            background-color: #f8f9fa;
        }
        .container {
            max-width: 600px;
            margin-top: 60px;
            background: white;
            padding: 2rem 2.5rem;
            border-radius: 1rem;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }
        h2 {
            margin-bottom: 2rem;
            font-weight: 700;
            color: #0d6efd;
            text-align: center;
        }
        .btn-group {
            margin-top: 1.5rem;
            display: flex;
            justify-content: flex-end;
            gap: 1rem;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Edit User</h2>

    <% if (errorMessage != null) { %>
    <div class="alert alert-danger" role="alert"><%= errorMessage %></div>
    <% } %>

    <form action="<%= request.getContextPath() %>/Admin/edit-user" method="post" novalidate>
        <input type="hidden" name="id" value="<%= user.getId() %>" />

        <div class="mb-3">
            <label for="username" class="form-label">Username</label>
            <input
                    type="text"
                    id="username"
                    name="username"
                    class="form-control"
                    value="<%= user.getUsername() %>"
                    required
                    minlength="4"
                    maxlength="20"
                    pattern="[a-zA-Z0-9._-]+"
                    title="Username must be 4-20 characters and contain only letters, numbers, '.', '-', or '_'"
            />
        </div>

        <div class="mb-3">
            <label for="email" class="form-label">Email</label>
            <input
                    type="email"
                    id="email"
                    name="email"
                    class="form-control"
                    value="<%= user.getEmail() %>"
                    required
            />
        </div>

        <div class="mb-3">
            <label for="phone" class="form-label">Phone</label>
            <input
                    type="tel"
                    id="phone"
                    name="phone"
                    class="form-control"
                    value="<%= user.getPhone() %>"
                    required
                    pattern="^\+?[0-9\s\-]{7,15}$"
                    title="Phone number should be 7 to 15 digits and may include +, spaces, or dashes."
            />
        </div>

        <div class="mb-3">
            <label for="role" class="form-label">Role</label>
            <select id="role" name="role" class="form-control" required>
                <option value="">-- Select Role --</option>
                <option value="admin" <%= "admin".equals(user.getRole()) ? "selected" : "" %>>Admin</option>
                <option value="staff" <%= "staff".equals(user.getRole()) ? "selected" : "" %>>Staff</option>
            </select>
        </div>

        <div class="btn-group">
            <a href="<%= request.getContextPath() %>/Admin/manage-users" class="btn btn-outline-secondary">Cancel</a>
            <button type="submit" class="btn btn-primary">Update</button>
        </div>
    </form>
</div>
</body>
</html>
