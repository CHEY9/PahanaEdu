<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.Map" %>

<%-- Helper method to safely fetch form field values --%>
<%!
    private String getValue(Map<String, String[]> formData, String name) {
        if (formData != null && formData.get(name) != null) {
            return formData.get(name)[0];
        }
        return "";
    }
%>
<%
    String errorMessage = (String) request.getAttribute("errorMessage");
    Map<String, String[]> formData = (Map<String, String[]>) request.getAttribute("formData");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Add New User - PahanaEdu</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        body {
            background-color: #f9fafb;
        }
        .card {
            max-width: 600px;
            margin: 40px auto;
            padding: 2rem;
            border-radius: 1rem;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            background: #ffffff;
        }
        h2 {
            font-weight: 600;
            margin-bottom: 1.5rem;
            text-align: center;
            color: #333;
        }
        .form-label {
            font-weight: 500;
        }
        .btn-group {
            display: flex;
            justify-content: flex-end;
            gap: 1rem;
            margin-top: 1.5rem;
        }
    </style>
</head>
<body>
<div class="card">
    <h2>➕ Add New User</h2>

    <% if (errorMessage != null) { %>
    <div class="alert alert-danger" role="alert">
        <%= errorMessage %>
    </div>
    <% } %>

    <form action="<%= request.getContextPath() %>/Admin/add-user" method="post" novalidate>
        <div class="mb-3">
            <label for="username" class="form-label">Username</label>
            <input
                    type="text"
                    class="form-control"
                    id="username"
                    name="username"
                    value="<%= getValue(formData, "username") %>"
                    required
                    pattern="[a-zA-Z0-9._-]{4,20}"
                    title="4-20 characters; letters, numbers, '.', '-', '_' only"
            >
        </div>

        <div class="mb-3">
            <label for="password" class="form-label">Password</label>
            <input
                    type="password"
                    class="form-control"
                    id="password"
                    name="password"
                    required
                    minlength="6"
                    placeholder="At least 6 characters"
            >
        </div>

        <div class="mb-3">
            <label for="email" class="form-label">Email</label>
            <input
                    type="email"
                    class="form-control"
                    id="email"
                    name="email"
                    value="<%= getValue(formData, "email") %>"
                    required
                    placeholder="example@example.com"
            >
        </div>

        <div class="mb-3">
            <label for="phone" class="form-label">Phone</label>
            <input
                    type="text"
                    class="form-control"
                    id="phone"
                    name="phone"
                    value="<%= getValue(formData, "phone") %>"
                    required
                    pattern="\\d{10}"
                    title="Enter a valid 10-digit phone number"
                    placeholder="e.g. 0712345678"
            >
        </div>

        <div class="mb-3">
            <label for="role" class="form-label">Role</label>
            <select class="form-select" id="role" name="role" required>
                <option value="" disabled <%= "".equals(getValue(formData, "role")) ? "selected" : "" %>>-- Select Role --</option>
                <option value="admin" <%= "admin".equals(getValue(formData, "role")) ? "selected" : "" %>>Admin</option>
                <option value="staff" <%= "staff".equals(getValue(formData, "role")) ? "selected" : "" %>>Staff</option>
            </select>
        </div>

        <div class="btn-group">
            <a href="<%= request.getContextPath() %>/Admin/manage-users" class="btn btn-outline-secondary">Cancel</a>
            <button type="submit" class="btn btn-success">Add User</button>
        </div>
    </form>
</div>
<script>

    document.querySelector('form').addEventListener('submit', function (e) {
        const username = this.username.value.trim();
        if (!/^[a-zA-Z0-9._-]{4,20}$/.test(username)) {
            alert('Username must be 4-20 characters and contain only letters, numbers, ".", "-", or "_".');
            e.preventDefault();
        }
        const phone = this.phone.value.trim();
        if (!/^\d{10}$/.test(phone)) {
            alert('Please enter a valid 10-digit phone number.');
            e.preventDefault();
        }
    });
</script>
</body>
</html>
