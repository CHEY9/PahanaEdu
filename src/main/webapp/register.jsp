<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Register - PahanaEdu</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet" />
    <style>
        body {
            background: linear-gradient(135deg, #6fb1fc, #4364f7);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            padding: 20px;
        }
        .register-card {
            background: #fff;
            border-radius: 15px;
            box-shadow: 0 12px 30px rgba(0, 0, 0, 0.15);
            width: 100%;
            max-width: 480px;
            padding: 30px 35px;
        }
        h3 {
            font-weight: 700;
            margin-bottom: 25px;
            color: #2c3e50;
            text-align: center;
        }
        .input-with-icon {
            position: relative;
            margin-bottom: 1.5rem;
        }
        .input-with-icon i {
            position: absolute;
            right: 12px;
            top: 50%;
            transform: translateY(-50%);
            color: #6c757d;
            font-size: 1.3rem;
            pointer-events: none;
        }
        .input-with-icon input,
        .input-with-icon select {
            width: 100%;
            height: 45px;
            padding-right: 40px; /* space for icon on right */
            border-radius: 8px;
            border: 1px solid #ced4da;
            box-sizing: border-box;
            font-size: 1rem;
            transition: border-color 0.3s ease;
        }
        .input-with-icon input:focus,
        .input-with-icon select:focus {
            outline: none;
            border-color: #4364f7;
            box-shadow: 0 0 5px rgba(67, 100, 247, 0.5);
        }
        label {
            display: block;
            margin-bottom: 6px;
            font-weight: 600;
            color: #333;
        }
        .error-message {
            font-size: 0.85rem;
            color: #dc3545;
            margin-top: 4px;
            min-height: 18px;
        }
        .btn-primary {
            background: #4364f7;
            border: none;
            font-weight: 600;
            padding: 12px 0;
            border-radius: 12px;
            transition: background 0.3s ease;
            width: 100%;
        }
        .btn-primary:hover {
            background: #355bcc;
        }
        .back-link {
            display: block;
            margin-top: 15px;
            text-align: center;
            font-weight: 500;
            color: #4364f7;
            text-decoration: none;
            transition: color 0.3s ease;
        }
        .back-link:hover {
            color: #2c3e50;
        }
        label span.text-danger {
            margin-left: 2px;
        }
    </style>
</head>
<body>
<div class="register-card shadow">
    <h3>Create your account</h3>

    <c:if test="${not empty error}">
        <div class="alert alert-danger" role="alert">${error}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/register" method="post" id="registerForm" novalidate>

        <div class="input-with-icon">
            <label for="username">Username <span class="text-danger">*</span></label>
            <input
                    type="text"
                    id="username"
                    name="username"
                    placeholder="Enter username"
                    required
                    minlength="5"
                    maxlength="10"
                    pattern="[a-zA-Z0-9._-]{5,10}"
                    title="5-10 characters: letters, numbers, ., _, -"
                    value="${param.username != null ? param.username : ''}"
            />
            <i class="bi bi-person-fill"></i>
            <div class="error-message" id="usernameError"></div>
        </div>

        <div class="input-with-icon">
            <label for="password">Password <span class="text-danger">*</span></label>
            <input
                    type="password"
                    id="password"
                    name="password"
                    placeholder="Enter password"
                    required
                    minlength="6"
                    maxlength="10"
                    pattern="^(?=.*[0-9])(?=.*[A-Z])(?=.*[a-z])(?=.*[@#$%^&.+=!]).{6,10}$"
                    title="6-10 chars, include uppercase, lowercase, number & special char"
            />
            <i class="bi bi-lock-fill"></i>
            <div class="error-message" id="passwordError"></div>
        </div>

        <div class="input-with-icon">
            <label for="confirmPassword">Confirm Password <span class="text-danger">*</span></label>
            <input
                    type="password"
                    id="confirmPassword"
                    name="confirmPassword"
                    placeholder="Confirm password"
                    required
                    minlength="6"
                    maxlength="10"
            />
            <i class="bi bi-lock-fill"></i>
            <div class="error-message" id="confirmPasswordError"></div>
        </div>

        <div class="input-with-icon">
            <label for="email">Email <span class="text-danger">*</span></label>
            <input
                    type="email"
                    id="email"
                    name="email"
                    placeholder="Enter email"
                    required
                    value="${param.email != null ? param.email : ''}"
            />
            <i class="bi bi-envelope-fill"></i>
            <div class="error-message" id="emailError"></div>
        </div>

        <div class="input-with-icon">
            <label for="phone">Phone <span class="text-danger">*</span></label>
            <input
                    type="tel"
                    id="phone"
                    name="phone"
                    placeholder="Enter phone number"
                    required
                    pattern="\\d{10}"
                    title="Enter 10 digit phone number"
                    value="${param.phone != null ? param.phone : ''}"
            />
            <i class="bi bi-telephone-fill"></i>
            <div class="error-message" id="phoneError"></div>
        </div>

        <div class="input-with-icon">
            <label for="role">Role <span class="text-danger">*</span></label>
            <select id="role" name="role" required>
                <option value="" disabled ${param.role == null ? 'selected' : ''}>Select role</option>
                <option value="staff" ${param.role == 'staff' ? 'selected' : ''}>Staff</option>
                <option value="admin" ${param.role == 'admin' ? 'selected' : ''}>Admin</option>
            </select>
            <i class="bi bi-person-badge-fill"></i>
            <div class="error-message" id="roleError"></div>
        </div>

        <button type="submit" class="btn btn-primary">Register</button>
    </form>

    <a href="${pageContext.request.contextPath}/login.jsp" class="back-link">Back to Login</a>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    const form = document.getElementById('registerForm');
    const fields = ['username', 'password', 'confirmPassword', 'email', 'phone', 'role'];

    form.addEventListener('submit', function (e) {
        let valid = true;

        fields.forEach(f => {
            const errEl = document.getElementById(f + 'Error');
            errEl.textContent = '';
        });

        // Username validation
        const username = form.username.value.trim();
        if (!/^[a-zA-Z0-9._-]{5,10}$/.test(username)) {
            document.getElementById('usernameError').textContent = 'Username must be 5-10 characters (letters, numbers, ., _, -).';
            valid = false;
        }

        // Password validation
        const password = form.password.value;
        if (!/^(?=.*[0-9])(?=.*[A-Z])(?=.*[a-z])(?=.*[@#$%^&.+=!]).{6,10}$/.test(password)) {
            document.getElementById('passwordError').textContent = 'Password must be 6-10 chars and include uppercase, lowercase, number, and special char.';
            valid = false;
        }

        // Confirm password validation
        const confirmPassword = form.confirmPassword.value;
        if (password !== confirmPassword) {
            document.getElementById('confirmPasswordError').textContent = 'Passwords do not match.';
            valid = false;
        }

        // Email validation
        const email = form.email.value.trim();
        if (!/^[\w.-]+@[\w.-]+\.\w{2,}$/.test(email)) {
            document.getElementById('emailError').textContent = 'Invalid email format.';
            valid = false;
        }

        // Phone validation
        const phone = form.phone.value.trim();
        if (!/^\d{10}$/.test(phone)) {
            document.getElementById('phoneError').textContent = 'Phone number must be 10 digits.';
            valid = false;
        }

        // Role validation
        if (!form.role.value) {
            document.getElementById('roleError').textContent = 'Please select a role.';
            valid = false;
        }

        if (!valid) e.preventDefault();
    });
</script>
</body>
</html>
