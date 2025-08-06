<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Forgot Password - PahanaEdu</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
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
    .forgot-container {
      background: #fff;
      padding: 3rem 2.5rem;
      border-radius: 1rem;
      box-shadow: 0 12px 35px rgba(0, 0, 0, 0.12);
      width: 100%;
      max-width: 420px;
      transition: box-shadow 0.3s ease;
    }
    .forgot-container:hover {
      box-shadow: 0 20px 50px rgba(0, 0, 0, 0.2);
    }
    h3 {
      font-weight: 700;
      margin-bottom: 1.8rem;
      color: #2c3e50;
      text-align: center;
      letter-spacing: 0.02em;
    }
    p.text-muted {
      font-size: 0.95rem;
      margin-bottom: 2rem;
      color: #6c757d;
      text-align: center;
      line-height: 1.4;
    }
    label {
      font-weight: 600;
      color: #495057;
    }
    .form-control {
      border-radius: 0.5rem;
      font-size: 1rem;
      padding: 0.625rem 1rem;
      transition: border-color 0.3s ease, box-shadow 0.3s ease;
    }
    .form-control:focus {
      border-color: #4364f7;
      box-shadow: 0 0 8px rgba(67, 100, 247, 0.5);
      outline: none;
    }
    .btn-primary {
      background-color: #4364f7;
      border: none;
      font-weight: 700;
      padding: 0.75rem;
      font-size: 1.1rem;
      border-radius: 0.7rem;
      transition: background-color 0.3s ease, box-shadow 0.3s ease;
      width: 100%;
    }
    .btn-primary:hover,
    .btn-primary:focus {
      background-color: #355bcc;
      box-shadow: 0 6px 15px rgba(53, 91, 204, 0.5);
    }
    .back-link {
      color: #4364f7;
      font-weight: 600;
      text-decoration: none;
      display: inline-block;
      margin-top: 1.8rem;
      text-align: center;
      width: 100%;
      transition: color 0.3s ease;
    }
    .back-link:hover,
    .back-link:focus {
      color: #2c3e50;
      text-decoration: underline;
    }
    .invalid-feedback {
      font-size: 0.875rem;
      font-weight: 600;
    }
  </style>
</head>
<body>
<div class="forgot-container shadow-sm">
  <h3>Forgot Password</h3>
  <p class="text-muted">
    Enter your registered email below. We'll send you a secure OTP to reset your password.
  </p>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

  <c:if test="${not empty errorMessage}">
    <div class="alert alert-danger" role="alert">${errorMessage}</div>
  </c:if>


  <form action="send-otp" method="post" novalidate>
    <div class="mb-3">
      <label for="email" class="form-label">Registered Email Address</label>
      <input
              type="email"
              id="email"
              name="email"
              class="form-control"
              placeholder="name@example.com"
              required
              autofocus
              autocomplete="email"
              aria-describedby="emailHelp"
      />
      <div class="invalid-feedback">
        Please enter a valid email address.
      </div>
    </div>

    <button type="submit" class="btn btn-primary">Send OTP</button>
  </form>

  <a href="login.jsp" class="back-link" tabindex="0">Back to Log in</a>
</div>

<script>
  (() => {
    'use strict';
    const form = document.querySelector('form');

    form.addEventListener('submit', event => {
      if (!form.checkValidity()) {
        event.preventDefault();
        event.stopPropagation();
      }
      form.classList.add('was-validated');
    }, false);
  })();
</script>
</body>
</html>
