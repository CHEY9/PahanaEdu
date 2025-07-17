<%@ page import="java.util.*, com.example.pahanaedu2.model.BillItem" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  int billId = (int) request.getAttribute("billId");
  String customerName = (String) request.getAttribute("customerName");
  List<BillItem> billItems = (List<BillItem>) request.getAttribute("billItems");
  double totalAmount = (double) request.getAttribute("totalAmount");
%>
<!DOCTYPE html>
<html>
<head>
  <title>Bill Success</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body>
<div class="container mt-4">
  <h2>✅ Bill Successfully Created</h2>
  <p><strong>Bill ID:</strong> <%= billId %></p>
  <p><strong>Customer:</strong> <%= customerName %></p>
  <hr>
  <h4>Items Purchased:</h4>
  <table class="table table-bordered">
    <thead>
    <tr>
      <th>Item</th>
      <th>Qty</th>
      <th>Unit Price</th>
      <th>Total Price</th>
    </tr>
    </thead>
    <tbody>
    <% for (BillItem bi : billItems) { %>
    <tr>
      <td><%= bi.getItemName() %></td>
      <td><%= bi.getQuantity() %></td>
      <td><%= bi.getUnitPrice() %></td>
      <td><%= bi.getTotalPrice() %></td>
    </tr>
    <% } %>
    </tbody>
    <tfoot>
    <tr>
      <td colspan="3" class="text-end"><strong>Grand Total:</strong></td>
      <td><strong><%= totalAmount %></strong></td>
    </tr>
    </tfoot>
  </table>

  <a href="create-bill.jsp" class="btn btn-primary">🔄 New Bill</a>
  <button onclick="window.print()" class="btn btn-success">🖨️ Print Bill</button>
</div>
</body>
</html>
