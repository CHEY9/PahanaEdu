<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="java.util.Map" %>
<html>
<head>
    <title>Create New Bill</title>
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

        input[type="number"] {
            width: 60px;
        }
    </style>
</head>
<body>
<h2>Create New Bill</h2>

<form action="${pageContext.request.contextPath}/Staff/create-bill" method="post">
    <label>Select Customer:</label>
    <select name="customerId" required>
        <option value="">-- Select Customer --</option>
        <%
            List<Map<String, Object>> customers = (List<Map<String, Object>>) request.getAttribute("customers");
            for (Map<String, Object> customer : customers) {
        %>
        <option value="<%= customer.get("id") %>"><%= customer.get("name") %></option>
        <% } %>
    </select>

    <br><br>

    <table>
        <thead>
        <tr>
            <th>Item Name</th>
            <th>Category</th>
            <th>Price (LKR)</th>
            <th>Available Stock</th>
            <th>Quantity to Buy</th>
        </tr>
        </thead>
        <tbody>
        <%
            List<Map<String, Object>> items = (List<Map<String, Object>>) request.getAttribute("items");
            for (Map<String, Object> item : items) {
                int itemId = (int) item.get("id");
        %>
        <tr>
            <td><%= item.get("name") %></td>
            <td><%= item.get("category") %></td>
            <td><%= item.get("price") %></td>
            <td><%= item.get("stock") %></td>
            <td>
                <input type="number" name="quantity_<%= itemId %>" min="0" max="<%= item.get("stock") %>" value="0">
                <input type="hidden" name="itemId_<%= itemId %>" value="<%= itemId %>">
                <input type="hidden" name="price_<%= itemId %>" value="<%= item.get("price") %>">
            </td>
        </tr>
        <% } %>
        </tbody>
    </table>

    <br>
    <button type="submit">Generate Bill</button>
</form>

</body>
</html>
