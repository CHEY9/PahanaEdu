<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login - PahanaEdu</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: #f8f9fa;
        }
        .login-container {
            max-width: 400px;
            margin: 100px auto;
            padding: 30px;
            border-radius: 15px;
            background: white;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
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
    </form>

    <p class="mt-3 text-center">
        Don't have an account? <a href="register.jsp">Register</a>
    </p>
</div>

<script>
    document.querySelector("form").addEventListener("submit", function (e) {
        const username = document.querySelector("input[name='username']").value.trim();
        const password = document.querySelector("input[name='password']").value;

        if (username.length < 4 || !/^[a-zA-Z0-9._-]+$/.test(username)) {
            alert("Username must be 4–10 characters and contain only letters, numbers, '.', '-', '_'.");
            e.preventDefault();
            return;
        }

        if (password.length < 5 || password.includes(" ")) {
            alert("Password must be at least 5 characters long and cannot contain spaces.");
            e.preventDefault();
        }
    });
</script>
</body>
</html>
