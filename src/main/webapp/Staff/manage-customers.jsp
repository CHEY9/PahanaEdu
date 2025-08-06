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
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Manage Customers (Staff)</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .card {
            border-radius: 1rem;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
        }
        .table th, .table td {
            vertical-align: middle !important;
        }
        .search-form .form-control {
            border-radius: 0.5rem;
        }
        .btn i {
            margin-right: 6px;
        }
    </style>
</head>
<body>
<div class="container mt-5">
    <div class="card p-4">
        <h3 class="mb-4 text-primary"><i class="fas fa-users"></i> Manage Customers (Staff)</h3>

        <!-- Search Form -->
        <form method="get" action="manage-customers" class="row g-3 search-form mb-4">
            <div class="col-md-4">
                <input type="text" name="searchName" class="form-control" placeholder="Search by name"
                       value="<%= request.getParameter("searchName") != null ? request.getParameter("searchName") : "" %>">
            </div>
            <div class="col-md-4">
                <input type="text" name="searchPhone" class="form-control" placeholder="Search by phone"
                       value="<%= request.getParameter("searchPhone") != null ? request.getParameter("searchPhone") : "" %>">
            </div>
            <div class="col-md-2">
                <button type="submit" class="btn btn-outline-primary w-100"><i class="fas fa-search"></i>Search</button>
            </div>
            <div class="col-md-2">
                <a href="add-customer.jsp" class="btn btn-success w-100"><i class="fas fa-user-plus"></i> Add Customer</a>
            </div>
        </form>

        <!-- Customer Table -->
        <div class="table-responsive">
            <table class="table table-bordered table-striped table-hover">
                <thead class="table-light">
                <tr>
                    <th>#ID</th>
                    <th><i class="fas fa-user"></i> Name</th>
                    <th><i class="fas fa-envelope"></i> Email</th>
                    <th><i class="fas fa-phone"></i> Phone</th>
                    <th><i class="fas fa-map-marker-alt"></i> Address</th>
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
                        <a href="<%= request.getContextPath() %>/Staff/edit-customer?id=<%= c.getId() %>" class="btn btn-sm btn-primary">
                            <i class="fas fa-edit"></i>Edit
                        </a>
                        <a href="delete-customer?id=<%= c.getId() %>" class="btn btn-sm btn-danger"
                           onclick="return confirm('Are you sure you want to delete this customer?');">
                            <i class="fas fa-trash-alt"></i>Delete
                        </a>
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
        </div>

        <div class="mt-4">
            <a href="dashboard.jsp" class="btn btn-secondary"><i class="fas fa-arrow-left"></i> Back to Dashboard</a>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
