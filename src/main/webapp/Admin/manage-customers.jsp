<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.pahanaedu2.customer.Customer" %>
<%@ page import="com.example.pahanaedu2.auth.User" %>
<%
    List<Customer> customers = (List<Customer>) request.getAttribute("customerList");
    User user = (User) session.getAttribute("user");
    if (user == null || !"admin".equalsIgnoreCase(user.getRole())) {
        response.sendRedirect("../login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>PahanaEdu | Manage Customers</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .container {
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .btn-sm {
            margin-right: 5px;
        }
    </style>
</head>
<body>
<div class="container mt-5">
    <h2 class="mb-4">🧾 Manage Customers</h2>

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
            <button type="submit" class="btn btn-primary w-100">🔍 Search</button>
        </div>
    </form>

    <table class="table table-striped table-hover">
        <thead class="table-dark">
        <tr>
            <th>#ID</th>
            <th>Name</th>
            <th>Email</th>
            <th>Phone</th>
            <th>Address</th>
            <th class="text-center">Actions</th>
        </tr>
        </thead>
        <tbody>
        <% if (customers != null && !customers.isEmpty()) {
            for (Customer c : customers) { %>
        <tr>
            <td><%= c.getId() %></td>
            <td><%= c.getName() %></td>
            <td><%= c.getEmail() %></td>
            <td><%= c.getPhone() %></td>
            <td><%= c.getAddress() %></td>
            <td class="text-center">
                <div class="d-flex justify-content-center">
                    <a href="edit-customer?id=<%= c.getId() %>" class="btn btn-primary btn-sm">✏️ Edit</a>
                    <a href="delete-customer?id=<%= c.getId() %>" class="btn btn-danger btn-sm"
                       onclick="return confirm('Are you sure you want to delete this customer?');">🗑️ Delete</a>
                </div>
            </td>
        </tr>
        <% }
        } else { %>
        <tr>
            <td colspan="6" class="text-center text-muted">No customers found.</td>
        </tr>
        <% } %>
        </tbody>
    </table>

    <div class="d-flex justify-content-between mt-3">
        <a href="add-customer.jsp" class="btn btn-success">➕ Add New Customer</a>
        <a href="dashboard.jsp" class="btn btn-secondary">⬅ Back to Dashboard</a>
    </div>
</div>
</body>
</html>
