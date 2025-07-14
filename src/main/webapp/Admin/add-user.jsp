<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.Map" %>

<%-- Declare helper method in declaration tag --%>
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
<html>
<head>
    <title>Add New User</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h2>Add New User</h2>

    <% if (errorMessage != null) { %>
    <div class="alert alert-danger"><%= errorMessage %></div>
    <% } %>

    <form action="<%= request.getContextPath() %>/Admin/add-user" method="post">
        <div class="mb-3">
            <label class="form-label">Username:</label>
            <input type="text" class="form-control" name="username" value="<%= getValue(formData, "username") %>" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Password:</label>
            <input type="password" class="form-control" name="password" required minlength="6">
        </div>

        <div class="mb-3">
            <label class="form-label">Email:</label>
            <input type="email" class="form-control" name="email" value="<%= getValue(formData, "email") %>" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Phone:</label>
            <input type="text" class="form-control" name="phone" value="<%= getValue(formData, "phone") %>" required pattern="\d{10}">
        </div>

        <div class="mb-3">
            <label class="form-label">Role:</label>
            <select class="form-control" name="role" required>
                <option value="">--Select Role--</option>
                <option value="admin" <%= "admin".equals(getValue(formData, "role")) ? "selected" : "" %>>Admin</option>
                <option value="staff" <%= "staff".equals(getValue(formData, "role")) ? "selected" : "" %>>Staff</option>
            </select>
        </div>

        <button type="submit" class="btn btn-success">Add User</button>
        <a href="<%= request.getContextPath() %>/Admin/manage-users" class="btn btn-secondary">Cancel</a>


    </form>
</div>
</body>
</html>
