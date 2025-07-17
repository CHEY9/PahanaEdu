<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List,java.util.Map" %>
<html>
<head>
  <title>Bills List</title>
  <style>
    table {
      width: 100%;
      border-collapse: collapse;
    }
    th, td {
      border: 1px solid #ccc;
      padding: 8px;
      text-align: left;
    }
    a.view-link {
      text-decoration: none;
      color: blue;
    }
  </style>
</head>
<body>
<h2>Bills List</h2>

<table>
  <thead>
  <tr>
    <th>Bill ID</th>
    <th>Customer</th>
    <th>Total Amount (LKR)</th>
    <th>Date/Time</th>
    <th>Actions</th>
  </tr>
  </thead>
  <tbody>
  <%
    List<Map<String, Object>> billsList = (List<Map<String, Object>>) request.getAttribute("billsList");
    if (billsList != null && !billsList.isEmpty()) {
      for (Map<String, Object> bill : billsList) {
  %>
  <tr>
    <td><%= bill.get("billId") %></td>
    <td><%= bill.get("customerName") %></td>
    <td><%= bill.get("totalAmount") %></td>
    <td><%= bill.get("dateTime") %></td>
    <td><a class="view-link" href="<%= request.getContextPath() %>/staff/bill-details?billId=<%= bill.get("billId") %>">View Details</a></td>
  </tr>
  <%      }
  } else { %>
  <tr><td colspan="5">No bills found.</td></tr>
  <% } %>
  </tbody>
</table>

</body>
</html>
