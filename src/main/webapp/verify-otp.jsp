<!DOCTYPE html>
<html>
<head>
  <title>Verify OTP - PahanaEdu</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container" style="max-width: 400px; margin-top: 100px;">
  <h3 class="text-center mb-4">Verify OTP</h3>

  <form action="verify-otp" method="post">
    <div class="mb-3">
      <label for="otp" class="form-label">Enter OTP sent to your email</label>
      <input type="text" id="otp" name="otp" class="form-control" maxlength="6" required>
    </div>

    <button type="submit" class="btn btn-primary w-100">Verify OTP</button>

    <% String errorMessage = (String) request.getAttribute("errorMessage"); %>
    <% if (errorMessage != null) { %>
    <div class="alert alert-danger" role="alert">
      <%= errorMessage %>
    </div>
    <% } %>
  </form>

  <p class="mt-3 text-center">
    <a href="forgot-password.jsp">Back to Forgot Password</a>
  </p>
</div>
</body>
</html>
