<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login - PahanaEdu</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-image: url('<%= request.getContextPath() %>/images/background.jpg');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            background-attachment: fixed;
            position: relative;
        }

            body::before {
                content: "";
                position: fixed;
                top: 0;
                left: 0;
                height: 100%;
                width: 100%;
                background-color: rgba(0, 0, 0, 0.7);
                z-index: -1;
            }

            .login-container {
                font-weight: bold;
                position: relative;
                z-index: 1;
                max-width: 400px;
                margin: 100px auto;
                padding: 30px;
                border-radius: 15px;
                background: rgba(255, 255, 255, 0.6);
                box-shadow: 0 8px 32px rgba(0, 0, 0, 0.25);
                backdrop-filter: blur(12px);
                -webkit-backdrop-filter: blur(12px);
                border: 1px solid rgba(255, 255, 255, 0.3);
            }

            .form-icon {
                position: absolute;
                top: 11px;
                left: 10px;
                font-size: 16px;
                color: #aaa;
            }

            .input-group .form-control {
                padding-left: 30px;
            }
        .form-icon {
            position: absolute;
            top: 11px;
            left: 10px;
            font-size: 16px;
            color: #aaa;
        }
        .input-group .form-control {
            padding-left: 30px;
        }

    </style>
</head>
<body>
<div class="login-container">
    <h3 class="text-center mb-4">Login to PahanaEdu</h3>

    <form action="${pageContext.request.contextPath}/login" method="post" novalidate>
        <div class="mb-3 position-relative">
            <label for="username" class="form-label">Username</label>
            <div class="input-group">
                <span class="form-icon">@</span>
                <input name="username" id="username" type="text" class="form-control" required>
            </div>
        </div>

        <div class="mb-3 position-relative">
            <label for="password" class="form-label">Password</label>
            <div class="input-group">
                <span class="form-icon">🔒</span>
                <input name="password" id="password" type="password" class="form-control" required>
            </div>
        </div>

        <button type="submit" class="btn btn-primary w-100">Login</button>

        <%
            String errorParam = request.getParameter("error");
            String errorAttr = (String) request.getAttribute("errorMessage");
            String registeredParam = request.getParameter("registered");

            if (errorAttr != null) {
        %>
        <div class="alert alert-danger mt-3" role="alert">
            <%= errorAttr %>
        </div>
        <%
        } else if ("1".equals(errorParam)) {
        %>
        <div class="alert alert-danger mt-3" role="alert">
            Invalid username or password.
        </div>
        <%
        } else if ("1".equals(registeredParam)) {
        %>
        <div class="alert alert-success mt-3" role="alert">
            Registration successful! You can now log in.
        </div>
        <%
            }
        %>
        <%
            String resetParam = request.getParameter("reset");
            if ("1".equals(resetParam)) {
        %>
        <div class="alert alert-success mt-3" role="alert">
            Password reset successful! You can now log in.
        </div>
        <%
            }
        %>

    </form>

    <p class="mt-2 text-center">
        <a href="forgot-password.jsp">Forgot Password?</a>
    </p>

    <p class="mt-3 text-center">
        Don't have an account? <a href="register.jsp">Register</a>
    </p>
</div>

<script>
    document.querySelector("form").addEventListener("submit", function (e) {
        const usernameInput = document.querySelector("input[name='username']");
        const passwordInput = document.querySelector("input[name='password']");
        const username = usernameInput.value.trim();
        const password = passwordInput.value;

        // is the fields are empty?
        if (!username || !password) {
            alert("Please fill in both username and password.");
            e.preventDefault();
            return;
        }

        // Username length and character validation
        if (username.length < 4 || username.length > 10 || !/^[a-zA-Z0-9._-]+$/.test(username)) {
            alert("Username must be 4–10 characters and contain only letters, numbers, '.', '-', or '_'.");
            e.preventDefault();
            return;
        }

        // Password length and no-space validation
        if (password.length < 5 || password.includes(" ")) {
            alert("Password must be at least 5 characters long and cannot contain spaces.");
            e.preventDefault();
        }
    });
</script>

</body>
</html>
