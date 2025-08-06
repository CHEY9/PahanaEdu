<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Verify OTP - PahanaEdu</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
  <style>
    body {
      background: linear-gradient(135deg, #6fb1fc, #4364f7);
      min-height: 100vh;
      display: flex;
      justify-content: center;
      align-items: center;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      padding: 20px;
    }
    .otp-container {
      background: #fff;
      padding: 2.8rem 2.5rem;
      border-radius: 1rem;
      box-shadow: 0 14px 38px rgba(0, 0, 0, 0.18);
      max-width: 400px;
      width: 100%;
    }
    h3 {
      font-weight: 700;
      color: #2c3e50;
      margin-bottom: 1.8rem;
      text-align: center;
      letter-spacing: 0.02em;
    }
    label {
      font-weight: 600;
      color: #495057;
      font-size: 1rem;
    }
    .form-control {
      border-radius: 0.6rem;
      font-size: 1.1rem;
      padding: 0.7rem 1rem;
      transition: border-color 0.3s ease, box-shadow 0.3s ease;
    }
    .form-control:focus {
      border-color: #4364f7;
      box-shadow: 0 0 10px rgba(67, 100, 247, 0.6);
      outline: none;
    }
    .btn-primary {
      background-color: #4364f7;
      border: none;
      font-weight: 700;
      padding: 0.85rem;
      font-size: 1.15rem;
      border-radius: 0.75rem;
      transition: background-color 0.3s ease, box-shadow 0.3s ease;
      width: 100%;
      margin-top: 1.5rem;
    }
    .btn-primary:hover,
    .btn-primary:focus {
      background-color: #355bcc;
      box-shadow: 0 7px 18px rgba(53, 91, 204, 0.5);
    }
    .alert {
      font-weight: 600;
      font-size: 0.95rem;
      margin-top: 1rem;
      border-radius: 0.6rem;
    }
    .back-link {
      display: block;
      margin-top: 1.8rem;
      text-align: center;
      font-weight: 600;
      color: #4364f7;
      text-decoration: none;
      transition: color 0.3s ease;
    }
    .back-link:hover,
    .back-link:focus {
      color: #2c3e50;
      text-decoration: underline;
    }
  </style>
</head>
<body>
<div class="otp-container shadow-sm">
  <h3>Verify OTP</h3>

  <form action="verify-otp" method="post" novalidate>
    <div class="mb-3">
      <label for="otp">Enter OTP sent to your email</label>
      <input
              type="text"
              id="otp"
              name="otp"
              class="form-control"
              maxlength="6"
              pattern="\d{6}"
              placeholder="6-digit OTP"
              required
              autocomplete="one-time-code"
              inputmode="numeric"
              title="Enter the 6-digit OTP"
      />
      <div class="invalid-feedback">Please enter a valid 6-digit OTP.</div>
    </div>

    <button type="submit" class="btn btn-primary">Verify OTP</button>

    <c:if test="${not empty errorMessage}">
      <div class="alert alert-danger" role="alert">${errorMessage}</div>
    </c:if>
  </form>

  <a href="forgot-password.jsp" class="back-link" tabindex="0">Back to Forgot Password</a>
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
