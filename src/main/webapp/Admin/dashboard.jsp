<%@ page session="true" %>
<%
    com.example.pahanaedu2.auth.User user = (com.example.pahanaedu2.auth.User) session.getAttribute("user");
    if (user == null || !"admin".equals(user.getRole())) {
        response.sendRedirect("../login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
</head>
<body>
<h1>Welcome Admin: <%= user.getUsername() %></h1>
<p>This is the admin dashboard. You can manage staff, view reports, and more.</p>
</body>
</html>