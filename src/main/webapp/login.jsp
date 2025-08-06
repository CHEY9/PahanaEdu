<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login - PahanaEdu</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: url('<%= request.getContextPath() %>/images/background.jpg') no-repeat center center fixed;
            background-size: cover;
            font-family: 'Segoe UI', sans-serif;
        }

        body::before {
            content: "";
            position: fixed;
            top: 0;
            left: 0;
            height: 100%;
            width: 100%;
            background-color: rgba(0, 0, 0, 0.65);
            z-index: -1;
        }

        .login-container {
            background: rgba(255, 255, 255, 0.15);
            border-radius: 16px;
            backdrop-filter: blur(12px);
            -webkit-backdrop-filter: blur(12px);
            border: 1px solid rgba(255, 255, 255, 0.3);
            padding: 35px 30px;
            max-width: 420px;
            margin: 100px auto;
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.4);
            color: #fff;
        }

        .form-label {
            color: #fff;
            font-weight: 500;
        }

        .input-group-text {
            background-color: rgba(255, 255, 255, 0.9);
            border-right: none;
        }

        .form-control {
            border-left: none;
        }

        .form-control:focus {
            box-shadow: none;
            border-color: #0d6efd;
        }

        .alert {
            font-size: 14px;
        }

        .btn-primary {
            background-color: #0d6efd;
            border: none;
        }

        .btn-primary:hover {
            background-color: #0b5ed7;
        }

        a {
            color: #fff;
        }

        a:hover {
            color: #ddd;
        }
    </style>
</head>
<body>

<div class="login-container">
    <h3 class="text-center mb-4">🔐 Login to PahanaEdu</h3>

    <form action="${pageContext.request.contextPath}/login" method="post" novalidate>
        <!-- Username -->
        <div class="mb-3">
            <label for="username" class="form-label">Username</label>
            <div class="input-group">
                <span class="input-group-text"><i class="fas fa-user"></i></span>
                <input name="username" id="username" type="text" class="form-control" placeholder="Enter your username" required>
            </div>
        </div>

        <!-- Password -->
        <div class="mb-3">
            <label for="password" class="form-label">Password</label>
            <div class="input-group">
                <span class="input-group-text"><i class="fas fa-lock"></i></span>
                <input name="password" id="password" type="password" class="form-control" placeholder="Enter your password" required>
            </div>
        </div>

        <!-- Error and Success Messages -->
        <%
            String errorParam = request.getParameter("error");
            String errorAttr = (String) request.getAttribute("errorMessage");
            String registeredParam = request.getParameter("registered");
            String resetParam = request.getParameter("reset");

            if (errorAttr != null) {
        %>
        <div class="alert alert-danger mt-3" role="alert">
            <%= errorAttr %>
        </div>
        <% } else if ("1".equals(errorParam)) { %>
        <div class="alert alert-danger mt-3" role="alert">
            Invalid username or password.
        </div>
        <% } else if ("1".equals(registeredParam)) { %>
        <div class="alert alert-success mt-3" role="alert">
            Registration successful! You can now log in.
        </div>
        <% } else if ("1".equals(resetParam)) { %>
        <div class="alert alert-success mt-3" role="alert">
            Password reset successful! You can now log in.
        </div>
        <% } %>

        <!-- Submit -->
        <div class="d-grid mt-3">
            <button type="submit" class="btn btn-primary">Login</button>
        </div>
    </form>

    <!-- Links -->
    <div class="text-center mt-3">
        <a href="forgot-password.jsp">Forgot Password?</a>
    </div>
    <div class="text-center mt-2">
        Don't have an account? <a href="register.jsp">Register</a>
    </div>
</div>

<script>
    // Basic form validation
    document.querySelector("form").addEventListener("submit", function (e) {
        const username = document.getElementById("username").value.trim();
        const password = document.getElementById("password").value;

        if (!username || !password) {
            alert("Please enter both username and password.");
            e.preventDefault();
            return;
        }

        if (username.length < 4 || username.length > 10 || !/^[a-zA-Z0-9._-]+$/.test(username)) {
            alert("Username must be 4–10 characters with only letters, numbers, '.', '-', or '_'.");
            e.preventDefault();
            return;
        }

        if (password.length < 5 || password.includes(" ")) {
            alert("Password must be at least 5 characters with no spaces.");
            e.preventDefault();
        }
    });
</script>

</body>
</html>
