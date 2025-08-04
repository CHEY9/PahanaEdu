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
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Admin Profile - PahanaEdu</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        body {
            background-color: #f8f9fa;
        }
        .profile-img {
            width: 160px;
            height: 160px;
            object-fit: cover;
            border-radius: 50%;
            border: 3px solid #0d6efd;
            box-shadow: 0 0 10px rgba(13, 110, 253, 0.5);
        }
        .card {
            max-width: 600px;
            margin: 40px auto;
            padding: 2rem;
            border-radius: 1rem;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            background: #fff;
        }
        .form-label {
            font-weight: 600;
        }
        .btn-group {
            margin-top: 1.5rem;
            display: flex;
            justify-content: flex-end;
            gap: 1rem;
        }
    </style>
</head>
<body>

<div class="card">
    <h2 class="mb-4 text-center">Admin Profile</h2>

    <%
        String profilePicturePath = request.getContextPath() + "/uploads/profile-pictures/" + user.getUsername() + "_profile.jpg";
        File picFile = new File(application.getRealPath("/uploads/profile-pictures/" + user.getUsername() + "_profile.jpg"));
        boolean hasProfilePicture = picFile.exists();
    %>

    <div class="d-flex align-items-center mb-4 gap-4">
        <% if (hasProfilePicture) { %>
        <img src="<%= profilePicturePath %>" alt="Profile Picture" class="profile-img" />
        <% } else { %>
        <div class="profile-img d-flex justify-content-center align-items-center bg-secondary text-white">
            <span class="fs-1">👤</span>
        </div>
        <% } %>
        <div>
            <h4><%= user.getUsername() %></h4>
            <p class="text-muted">Administrator</p>
        </div>
    </div>

    <form method="post" action="<%= request.getContextPath() %>/admin/update-profile" enctype="multipart/form-data" novalidate>
        <div class="mb-3">
            <label for="username" class="form-label">Username (readonly)</label>
            <input type="text" id="username" name="username" class="form-control" value="<%= user.getUsername() %>" readonly>
        </div>

        <div class="mb-3">
            <label for="newPassword" class="form-label">Change Password</label>
            <input type="password" id="newPassword" name="newPassword" class="form-control" placeholder="Leave blank to keep current password" minlength="6" />
            <div class="form-text">At least 6 characters if changing password.</div>
        </div>

        <div class="mb-3">
            <label for="profilePicture" class="form-label">Upload Profile Picture</label>
            <input type="file" id="profilePicture" name="profilePicture" class="form-control" accept="image/*" />
            <div class="form-text">Max file size 2MB. Allowed types: JPG, PNG, GIF.</div>
        </div>

        <div class="btn-group">
            <a href="<%= request.getContextPath() %>/admin/dashboard" class="btn btn-outline-secondary">⬅ Back to Dashboard</a>
            <button type="submit" class="btn btn-primary">Update Profile</button>
        </div>
    </form>
</div>

<script>

    const form = document.querySelector('form');
    form.addEventListener('submit', (e) => {
        const pwd = form.newPassword.value.trim();
        if (pwd && pwd.length < 6) {
            alert('Password must be at least 6 characters.');
            e.preventDefault();
            return;
        }
        const fileInput = form.profilePicture;
        if (fileInput.files.length > 0) {
            const file = fileInput.files[0];
            const allowedTypes = ['image/jpeg', 'image/png', 'image/gif'];
            if (!allowedTypes.includes(file.type)) {
                alert('Only JPG, PNG, and GIF images are allowed.');
                e.preventDefault();
                return;
            }
            const maxSize = 2 * 1024 * 1024;
            if (file.size > maxSize) {
                alert('File size must be less than 2MB.');
                e.preventDefault();
                return;
            }
        }
    });
</script>

</body>
</html>
