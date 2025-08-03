<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.pahanaedu2.auth.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"admin".equalsIgnoreCase(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Profile</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h2>👤 Admin Profile</h2>
    <div class="card mt-3">
        <div class="card-body">
            <p><strong>Username:</strong> <%= user.getUsername() %></p>
            <a href="edit-profile.jsp" class="btn btn-warning">Edit Profile</a>
            <a href="change-password.jsp" class="btn btn-secondary">Change Password</a>
        </div>
    </div>
</div>
</body>
</html>
