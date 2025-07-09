<%@ page session="true" %>
<%
    com.example.pahanaedu2.auth.User user = (com.example.pahanaedu2.auth.User) session.getAttribute("user");
    if (user == null || !"staff".equals(user.getRole())) {
        response.sendRedirect("../login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Staff Dashboard</title>
</head>
<body>
<h1>Welcome, Staff: <%= user.getUsername() %></h1>
<p>This is the staff dashboard. You can manage customer data and billing.</p>
</body>
</html>