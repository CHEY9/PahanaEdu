<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.pahanaedu2.customer.Customer" %>
<%@ page import="com.example.pahanaedu2.auth.User" %>
<%
    // Authorization check
    User user = (User) session.getAttribute("user");
    if (user == null || !"staff".equalsIgnoreCase(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    // Load customer object
    Customer customer = (Customer) request.getAttribute("customer");
    if (customer == null) {
        response.sendRedirect(request.getContextPath() + "/Staff/manage-customers");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Customer</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h2>Edit Customer</h2>

    <form action="<%= request.getContextPath() %>/Staff/edit-customer" method="post">
        <input type="hidden" name="id" value="<%= customer.getId() %>">

        <div class="mb-3">
            <label class="form-label">Name:</label>
            <input type="text" class="form-control" name="name" value="<%= customer.getName() %>" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Email:</label>
            <input type="email" class="form-control" name="email" value="<%= customer.getEmail() %>" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Phone:</label>
            <input type="text" class="form-control" name="phone" value="<%= customer.getPhone() %>" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Address:</label>
            <textarea class="form-control" name="address" rows="3" required><%= customer.getAddress() %></textarea>
        </div>

        <button type="submit" class="btn btn-primary">Update Customer</button>
        <a href="<%= request.getContextPath() %>/Staff/manage-customers" class="btn btn-secondary">Cancel</a>
    </form>
</div>
</body>
</html>
