<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Forgot Password - PahanaEdu</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
  <style>
    body {
      background: #f8f9fa;
      display: flex;
      align-items: center;
      justify-content: center;
      min-height: 100vh;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }
    .forgot-container {
      background: white;
      padding: 2.5rem 2rem;
      border-radius: 0.5rem;
      box-shadow: 0 4px 15px rgb(0 0 0 / 0.1);
      width: 100%;
      max-width: 420px;
    }
    h3 {
      font-weight: 600;
      margin-bottom: 1.5rem;
      color: #212529;
    }
    label {
      font-weight: 500;
    }
    .btn-primary {
      background-color: #0d6efd;
      border: none;
      font-weight: 600;
      padding: 0.75rem;
      transition: background-color 0.3s ease;
    }
    .btn-primary:hover {
      background-color: #0b5ed7;
    }
    .back-link {
      color: #0d6efd;
      text-decoration: none;
      font-weight: 500;
    }
    .back-link:hover {
      text-decoration: underline;
    }
  </style>
</head>
<body>
<div class="forgot-container">
  <h3 class="text-center">Forgot Password</h3>
  <p class="text-center text-muted mb-4">Enter your registered email below. We'll send you a secure OTP to reset your password.</p>

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
      />
      <div class="invalid-feedback">
        Please enter a valid email address.
      </div>
    </div>

    <button type="submit" class="btn btn-primary w-100">Send OTP</button>
  </form>

  <p class="mt-4 text-center">
    <a href="login.jsp" class="back-link">Back to Log in</a>
  </p>
</div>

<script>
  // Client-side validation bootstrap style
  (() => {
    'use strict'
    const form = document.querySelector('form')

    form.addEventListener('submit', event => {
      if (!form.checkValidity()) {
        event.preventDefault()
        event.stopPropagation()
      }
      form.classList.add('was-validated')
    }, false)
  })()
</script>
</body>
</html>
