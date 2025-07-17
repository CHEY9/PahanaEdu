<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.pahanaedu2.customer.Customer" %>
<%@ page import="com.example.pahanaedu2.auth.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"staff".equalsIgnoreCase(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    List<Customer> customers = (List<Customer>) request.getAttribute("customerList");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Manage Customers</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h2 class="mb-4">Manage Customers (Staff)</h2>

    <!-- 🔍 Search Form -->
    <form method="get" action="manage-customers" class="row g-3 mb-4">
        <div class="col-md-4">
            <input type="text" name="searchName" class="form-control" placeholder="Search by name"
                   value="<%= request.getParameter("searchName") != null ? request.getParameter("searchName") : "" %>">
        </div>
        <div class="col-md-4">
            <input type="text" name="searchPhone" class="form-control" placeholder="Search by phone"
                   value="<%= request.getParameter("searchPhone") != null ? request.getParameter("searchPhone") : "" %>">
        </div>
        <div class="col-md-2">
            <button type="submit" class="btn btn-primary">Search</button>
        </div>
    </form>

    <a href="add-customer.jsp" class="btn btn-success mb-3">➕ Add New Customer</a>

    <table class="table table-bordered table-striped">
        <thead class="table-light">
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Email</th>
            <th>Phone</th>
            <th>Address</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <%
            if (customers != null && !customers.isEmpty()) {
                for (Customer c : customers) {
        %>
        <tr>
            <td><%= c.getId() %></td>
            <td><%= c.getName() %></td>
            <td><%= c.getEmail() %></td>
            <td><%= c.getPhone() %></td>
            <td><%= c.getAddress() %></td>
            <td>
                <a href="<%= request.getContextPath() %>/Staff/edit-customer?id=<%= c.getId() %>" class="btn btn-sm btn-primary">Edit</a>
                <a href="delete-customer?id=<%= c.getId() %>" class="btn btn-sm btn-danger"
                   onclick="return confirm('Are you sure you want to delete this customer?');">Delete</a>
            </td>
        </tr>
        <%
            }
        } else {
        %>
        <tr>
            <td colspan="6" class="text-center text-muted">No customers found.</td>
        </tr>
        <% } %>
        </tbody>
    </table>

    <a href="dashboard.jsp" class="btn btn-secondary mt-3">⬅ Back to Dashboard</a>
</div>
</body>
</html>
