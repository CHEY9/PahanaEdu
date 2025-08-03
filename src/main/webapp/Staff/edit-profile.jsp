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
  <title>Edit Profile</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
  <h2>✏️ Edit Profile</h2>
  <form action="update-profile" method="post">
    <div class="mb-3">
      <label for="username" class="form-label">New Username:</label>
      <input type="text" class="form-control" id="username" name="username" value="<%= user.getUsername() %>" required>
    </div>
    <button type="submit" class="btn btn-primary">Update</button>
    <a href="profile.jsp" class="btn btn-secondary">Cancel</a>
  </form>
</div>
</body>
</html>
