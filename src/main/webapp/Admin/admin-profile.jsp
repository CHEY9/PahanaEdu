<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.pahanaedu2.auth.User" %>
<%@ page import="java.io.File" %>

<%
    User user = (session != null) ? (User) session.getAttribute("user") : null;
    if (user == null || !"admin".equalsIgnoreCase(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Profile</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-5">
    <h2>Admin Profile</h2>
    <%
        String profilePicturePath = request.getContextPath() + "/uploads/profile-pictures/" + user.getUsername() + "_profile.jpg";
        File picFile = new File(application.getRealPath("/uploads/profile-pictures/" + user.getUsername() + "_profile.jpg"));
        boolean hasProfilePicture = picFile.exists();
    %>

    <div class="card mb-4">
        <div class="card-header">
            <h5>Current Profile Info</h5>
        </div>
        <div class="card-body">
            <p><strong>Username:</strong> <%= user.getUsername() %></p>
            <p><strong>Profile Picture:</strong></p>
            <% if (hasProfilePicture) { %>
            <img src="<%= profilePicturePath %>" alt="Profile Picture" class="img-thumbnail" style="width: 150px; height: 150px;">
            <% } else { %>
            <p>No profile picture uploaded.</p>
            <% } %>
        </div>
    </div>

    <form method="post" action="<%=request.getContextPath()%>/admin/update-profile" enctype="multipart/form-data">
        <div class="mb-3">
            <label class="form-label">Username:</label>
            <input type="text" name="username" class="form-control" value="<%= user.getUsername() %>" readonly>
        </div>

        <div class="mb-3">
            <label class="form-label">Change Password:</label>
            <input type="password" name="newPassword" class="form-control" placeholder="Leave blank to keep current">
        </div>

        <div class="mb-3">
            <label class="form-label">Upload Profile Picture:</label>
            <input type="file" name="profilePicture" class="form-control">
        </div>

        <div class="d-flex gap-2">
            <button type="submit" class="btn btn-primary">Update Profile</button>
            <a href="<%= request.getContextPath() %>/admin/dashboard" class="btn btn-secondary">⬅ Go Back</a>
        </div>

    </form>
</div>
</body>
</html>
