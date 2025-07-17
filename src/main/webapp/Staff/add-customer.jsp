<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.pahanaedu2.auth.User" %>
<%
    // Authorization check for staff
    User user = (User) session.getAttribute("user");
    if (user == null || !"staff".equalsIgnoreCase(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Add New Customer</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h2 class="mb-4">Add New Customer</h2>

    <form action="<%= request.getContextPath() %>/Staff/add-customer" method="post">
        <div class="mb-3">
            <label for="name" class="form-label">Name:</label>
            <input type="text" id="name" class="form-control" name="name" required>
        </div>

        <div class="mb-3">
            <label for="email" class="form-label">Email:</label>
            <input type="email" id="email" class="form-control" name="email" required>
        </div>

        <div class="mb-3">
            <label for="phone" class="form-label">Phone:</label>
            <input type="text" id="phone" class="form-control" name="phone" required>
        </div>

        <div class="mb-3">
            <label for="address" class="form-label">Address:</label>
            <textarea id="address" class="form-control" name="address" rows="3" required></textarea>
        </div>

        <button type="submit" class="btn btn-success">Add Customer</button>
        <a href="<%= request.getContextPath() %>/Staff/manage-customers" class="btn btn-secondary">Cancel</a>
    </form>
</div>
</body>
</html>
