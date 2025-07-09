<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Register - PahanaEdu</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f4f4f4;
        }
        .container {
            width: 400px;
            margin: 80px auto;
            background: #fff;
            padding: 25px 30px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h2 {
            text-align: center;
            margin-bottom: 20px;
        }
        .error {
            color: red;
            margin-bottom: 15px;
        }
        input[type="text"], input[type="password"], input[type="email"], input[type="tel"], select {
            width: 100%;
            padding: 10px;
            margin: 8px 0 15px 0;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        input[type="submit"] {
            width: 100%;
            padding: 12px;
            background: #5cb85c;
            color: white;
            border: none;
            border-radius: 4px;
            font-size: 16px;
        }
        input[type="submit"]:hover {
            background: #4cae4c;
        }
    </style>
    <script>
        function validateForm() {
            const username = document.forms["registerForm"]["username"].value;
            const password = document.forms["registerForm"]["password"].value;
            const confirmPassword = document.forms["registerForm"]["confirmPassword"].value;
            const email = document.forms["registerForm"]["email"].value;
            const phone = document.forms["registerForm"]["phone"].value;

            const usernamePattern = /^[a-zA-Z0-9._-]{5,10}$/;
            const passwordPattern = /^(?=.*[0-9])(?=.*[A-Z])(?=.*[a-z])(?=.*[@#$%^&.+=!]).{5,10}$/;
            const emailPattern = /^[\w.-]+@[\w.-]+\.\w{2,}$/;
            const phonePattern = /^\d{10}$/;

            let error = "";

            if (!usernamePattern.test(username)) {
                error += "Username must be 5-10 characters (letters, numbers, ., _, -).\\n";
            }

            if (!passwordPattern.test(password)) {
                error += "Password must be 6-10 chars and include uppercase, lowercase, number, and special char.\\n";
            }

            if (password !== confirmPassword) {
                error += "Passwords do not match.\\n";
            }

            if (!emailPattern.test(email)) {
                error += "Invalid email format.\\n";
            }

            if (!phonePattern.test(phone)) {
                error += "Phone number must be 10 digits.\\n";
            }

            if (error !== "") {
                alert(error.replace(/\\n/g, "\n"));  // Convert \\n to actual newline
                return false;
            }

            return true;
        }
    </script>
</head>
<body>
<div class="container">
    <h2>User Registration</h2>

    <!-- Show server-side validation error -->
    <%
        String error = (String) request.getAttribute("error");
        if (error != null) {
    %>
    <div class="error">
        <%= error %>
    </div>
    <%
        }
    %>

    <form action="${pageContext.request.contextPath}/register" method="post" onsubmit="return validateForm();">
        <label>Username</label>
        <input type="text" name="username" required>

        <label>Password</label>
        <input type="password" name="password" required>

        <label>Confirm Password</label>
        <input type="password" name="confirmPassword" required>

        <label>Email</label>
        <input type="email" name="email" required>

        <label>Phone</label>
        <input type="tel" name="phone" required>

        <label>Role</label>
        <select name="role" required>
            <option value="staff">Staff</option>
            <option value="admin">Admin</option>
        </select>

        <input type="submit" value="Register">
    </form>
</div>
</body>
</html>
