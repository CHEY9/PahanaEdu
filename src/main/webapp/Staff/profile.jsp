<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.pahanaedu2.auth.User" %>
<%@ page import="java.io.File" %>

<%
  User user = (session != null) ? (User) session.getAttribute("user") : null;
  if (user == null || !"staff".equalsIgnoreCase(user.getRole())) {
    response.sendRedirect(request.getContextPath() + "/login.jsp");
    return;
  }
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Staff Profile | PahanaEdu</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
  <style>
    body {
      background-color: #f8f9fa;
      font-family: 'Segoe UI', sans-serif;
    }
    .profile-container {
      max-width: 600px;
      margin: 60px auto;
      background: white;
      padding: 30px 40px;
      border-radius: 15px;
      box-shadow: 0 0 15px rgba(0,0,0,0.1);
    }
    .profile-picture {
      width: 150px;
      height: 150px;
      object-fit: cover;
      border-radius: 50%;
      border: 3px solid #0d6efd;
      margin-bottom: 15px;
    }
    .form-label {
      font-weight: 600;
    }
    .btn-group {
      display: flex;
      gap: 10px;
    }
  </style>
</head>
<body>

<div class="profile-container">
  <h2 class="mb-4 text-center text-primary">Staff Profile</h2>

  <%
    String profilePicturePath = request.getContextPath() + "/uploads/profile-pictures/" + user.getUsername() + "_staff_profile.jpg";
    File picFile = new File(application.getRealPath("/uploads/profile-pictures/" + user.getUsername() + "_staff_profile.jpg"));
    boolean hasProfilePicture = picFile.exists();
  %>

  <div class="text-center mb-4">
    <% if (hasProfilePicture) { %>
    <img src="<%= profilePicturePath %>" alt="Profile Picture" class="profile-picture" />
    <% } else { %>
    <img src="<%= request.getContextPath() %>/images/default-profile.png" alt="Default Profile Picture" class="profile-picture" />
    <p class="text-muted">No profile picture uploaded.</p>
    <% } %>
  </div>

  <form method="post" action="<%=request.getContextPath()%>/staff/update-profile" enctype="multipart/form-data">
    <div class="mb-3">
      <label class="form-label" for="username">Username</label>
      <input type="text" id="username" name="username" class="form-control" value="<%= user.getUsername() %>" readonly />
    </div>

    <div class="mb-3">
      <label class="form-label" for="newPassword">Change Password</label>
      <input type="password" id="newPassword" name="newPassword" class="form-control" placeholder="Leave blank to keep current password" />
    </div>

    <div class="mb-4">
      <label class="form-label" for="profilePicture">Upload Profile Picture</label>
      <input type="file" id="profilePicture" name="profilePicture" class="form-control" accept="image/*" />
      <small class="form-text text-muted">Supported formats: JPG, PNG. Max size: 2MB.</small>
    </div>

    <div class="btn-group justify-content-center">
      <button type="submit" class="btn btn-primary px-4">
        <i class="fa fa-save me-1"></i> Update Profile
      </button>
      <a href="<%= request.getContextPath() %>/Staff/dashboard.jsp" class="btn btn-secondary px-4">
        <i class="fa fa-arrow-left me-1"></i> Go Back
      </a>
    </div>
  </form>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/js/all.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
