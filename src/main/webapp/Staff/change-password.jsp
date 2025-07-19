<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.pahanaedu2.auth.User" %>
<%
  User user = (User) session.getAttribute("user");
  if (user == null || !"staff".equalsIgnoreCase(user.getRole())) {
    response.sendRedirect(request.getContextPath() + "/login.jsp");
    return;
  }
%>
<!DOCTYPE html>
<html>
<head>
  <title>Change Password</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
  <h2>🔐 Change Password</h2>
  <form action="change-password" method="post">
    <div class="mb-3">
      <label for="newPassword" class="form-label">New Password:</label>
      <input type="password" class="form-control" id="newPassword" name="newPassword" required>
    </div>
    <button type="submit" class="btn btn-primary">Change Password</button>
    <a href="profile.jsp" class="btn btn-secondary">Cancel</a>
  </form>
</div>
</body>
</html>
