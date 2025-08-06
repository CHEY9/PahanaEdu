<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <title>Reset Password - PahanaEdu</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
  <style>
    body {
      background: linear-gradient(to right, #6a11cb, #2575fc);
      height: 100vh;
      display: flex;
      justify-content: center;
      align-items: center;
      font-family: 'Segoe UI', sans-serif;
    }
    .card {
      border: none;
      border-radius: 15px;
      box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
    }
    .form-control:focus {
      box-shadow: none;
      border-color: #2575fc;
    }
    .input-group-text {
      background: #fff;
      border-left: none;
    }
    .form-label {
      font-weight: 500;
    }
    .btn-primary {
      background-color: #2575fc;
      border: none;
    }
    .btn-primary:hover {
      background-color: #1b5fd0;
    }
  </style>
</head>
<body>

<div class="card p-4" style="width: 100%; max-width: 400px;">
  <h4 class="text-center mb-4">🔒 Reset Your Password</h4>

  <form action="reset-password" method="post">
    <!-- New Password -->
    <div class="mb-3">
      <label for="password" class="form-label">New Password</label>
      <div class="input-group">
        <input type="password" id="password" name="password" class="form-control" required minlength="6" placeholder="Enter new password">
        <span class="input-group-text">
          <i class="fas fa-lock"></i>
        </span>
      </div>
    </div>

    <!-- Confirm Password -->
    <div class="mb-3">
      <label for="confirmPassword" class="form-label">Confirm New Password</label>
      <div class="input-group">
        <input type="password" id="confirmPassword" name="confirmPassword" class="form-control" required minlength="6" placeholder="Confirm password">
        <span class="input-group-text">
          <i class="fas fa-lock"></i>
        </span>
      </div>
    </div>

    <!-- Submit Button -->
    <div class="d-grid">
      <button type="submit" class="btn btn-primary">Reset Password</button>
    </div>
  </form>

  <div class="text-center mt-3">
    <a href="login.jsp" class="text-decoration-none">Back to Login</a>
  </div>
</div>

</body>
</html>
