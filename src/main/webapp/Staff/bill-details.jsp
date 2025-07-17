<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.Map, java.util.List" %>
<html>
<head>
    <title>Bill Details</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid #ccc;
            padding: 8px;
        }
    </style>
</head>
<body>
<h2>Bill Details</h2>

<%
    Map<String, Object> bill = (Map<String, Object>) request.getAttribute("bill");
    List<Map<String, Object>> itemsList = (List<Map<String, Object>>) request.getAttribute("itemsList");
%>

<p><strong>Bill ID:</strong> <%= bill.get("billId") %></p>
<p><strong>Customer:</strong> <%= bill.get("customerName") %></p>
<p><strong>Date/Time:</strong> <%= bill.get("dateTime") %></p>
<p><strong>Total Amount (LKR):</strong> <%= bill.get("totalAmount") %></p>

<h3>Items</h3>
<table>
    <thead>
    <tr>
        <th>Item Name</th>
        <th>Category</th>
        <th>Quantity</th>
        <th>Unit Price (LKR)</th>
        <th>Total Price (LKR)</th>
    </tr>
    </thead>
    <tbody>
    <% for (Map<String, Object> item : itemsList) { %>
    <tr>
        <td><%= item.get("itemName") %></td>
        <td><%= item.get("category") %></td>
        <td><%= item.get("quantity") %></td>
        <td><%= item.get("unitPrice") %></td>
        <td><%= item.get("totalPrice") %></td>
    </tr>
    <% } %>
    </tbody>
</table>

<p><a href="<%= request.getContextPath() %>/staff/bills">Back to Bills List</a></p>
</body>
</html>
