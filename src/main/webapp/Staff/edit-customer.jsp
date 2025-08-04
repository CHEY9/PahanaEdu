<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.pahanaedu2.customer.Customer" %>
<%@ page import="com.example.pahanaedu2.auth.User" %>
<%

    User user = (User) session.getAttribute("user");
    if (user == null || !"staff".equalsIgnoreCase(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    Customer customer = (Customer) request.getAttribute("customer");
    if (customer == null) {
        response.sendRedirect(request.getContextPath() + "/Staff/manage-customers");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Edit Customer</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
    <style>
        body {
            background-color: #f8f9fa;
        }
        .form-container {
            max-width: 550px;
            margin: 60px auto;
            background: #fff;
            padding: 30px 40px;
            border-radius: 15px;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
        }
        .form-title {
            text-align: center;
            margin-bottom: 30px;
            color: #0d6efd;
        }
        .form-control-icon {
            position: relative;
        }
        .form-control-icon input,
        .form-control-icon textarea {
            padding-right: 40px;
        }
        .form-control-icon i {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #999;
        }
        .btn-group-custom {
            display: flex;
            justify-content: space-between;
            margin-top: 25px;
        }
    </style>
</head>
<body>

<div class="form-container">
    <h3 class="form-title"><i class="fa fa-edit me-2"></i>Edit Customer</h3>

    <form action="<%= request.getContextPath() %>/Staff/edit-customer" method="post">
        <input type="hidden" name="id" value="<%= customer.getId() %>" />

        <div class="mb-3 form-control-icon">
            <label for="name" class="form-label">Full Name</label>
            <input type="text" id="name" class="form-control" name="name" value="<%= customer.getName() %>" required />
            <i class="fa fa-user"></i>
        </div>

        <div class="mb-3 form-control-icon">
            <label for="email" class="form-label">Email Address</label>
            <input type="email" id="email" class="form-control" name="email" value="<%= customer.getEmail() %>" required />
            <i class="fa fa-envelope"></i>
        </div>

        <div class="mb-3 form-control-icon">
            <label for="phone" class="form-label">Phone Number</label>
            <input type="text" id="phone" class="form-control" name="phone" value="<%= customer.getPhone() %>" required />
            <i class="fa fa-phone"></i>
        </div>

        <div class="mb-3 form-control-icon">
            <label for="address" class="form-label">Address</label>
            <textarea id="address" class="form-control" name="address" rows="3" required><%= customer.getAddress() %></textarea>
            <i class="fa fa-map-marker-alt"></i>
        </div>

        <div class="btn-group-custom">
            <button type="submit" class="btn btn-primary w-45">
                <i class="fa fa-save me-1"></i> Update Customer
            </button>
            <a href="<%= request.getContextPath() %>/Staff/manage-customers" class="btn btn-secondary w-45">
                <i class="fa fa-times me-1"></i> Cancel
            </a>
        </div>
    </form>
</div>

</body>
</html>
