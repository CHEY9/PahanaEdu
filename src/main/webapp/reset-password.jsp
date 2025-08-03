<!DOCTYPE html>
<html>
<head>
  <title>Reset Password - PahanaEdu</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container" style="max-width: 400px; margin-top: 100px;">
  <h3 class="text-center mb-4">Reset Password</h3>

  <form action="reset-password" method="post">
    <div class="mb-3">
      <label for="password" class="form-label">New Password</label>
      <input type="password" id="password" name="password" class="form-control" required minlength="6">
    </div>
    <div class="mb-3">
      <label for="confirmPassword" class="form-label">Confirm New Password</label>
      <input type="password" id="confirmPassword" name="confirmPassword" class="form-control" required minlength="6">
    </div>

    <button type="submit" class="btn btn-primary w-100">Reset Password</button>
  </form>

  <p class="mt-3 text-center">
    <a href="login.jsp">Back to Login</a>
  </p>
</div>
</body>
</html>
