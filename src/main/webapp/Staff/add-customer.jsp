<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.pahanaedu2.auth.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"staff".equalsIgnoreCase(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add New Customer</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        body {
            background-color: #f8f9fa;
        }

        .form-container {
            max-width: 550px;
            margin: 60px auto;
            background: #ffffff;
            padding: 30px 40px;
            border-radius: 15px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
        }

        .form-title {
            text-align: center;
            margin-bottom: 30px;
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
    <h3 class="form-title text-primary"><i class="fa fa-user-plus me-2"></i>Add New Customer</h3>

    <form action="<%= request.getContextPath() %>/Staff/add-customer" method="post">

        <div class="mb-3 form-control-icon">
            <label for="name" class="form-label">Full Name</label>
            <input type="text" class="form-control" id="name" name="name" placeholder="" required>
            <i class="fa fa-user"></i>
        </div>

        <div class="mb-3 form-control-icon">
            <label for="email" class="form-label">Email Address</label>
            <input type="email" class="form-control" id="email" name="email" placeholder="" required>
            <i class="fa fa-envelope"></i>
        </div>

        <div class="mb-3 form-control-icon">
            <label for="phone" class="form-label">Phone Number</label>
            <input type="text" class="form-control" id="phone" name="phone" placeholder="" required>
            <i class="fa fa-phone"></i>
        </div>

        <div class="mb-3 form-control-icon">
            <label for="address" class="form-label">Address</label>
            <textarea class="form-control" id="address" name="address" rows="3" placeholder="" required></textarea>
            <i class="fa fa-map-marker-alt"></i>
        </div>

        <div class="btn-group-custom">
            <button type="submit" class="btn btn-success w-45">
                <i class="fa fa-plus-circle me-1"></i> Add Customer
            </button>
            <a href="<%= request.getContextPath() %>/Staff/manage-customers" class="btn btn-secondary w-45">
                <i class="fa fa-times-circle me-1"></i> Cancel
            </a>
        </div>
    </form>
</div>

</body>
</html>
