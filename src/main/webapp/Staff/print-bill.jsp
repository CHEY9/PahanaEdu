<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
  <title>Print Bill #${billId}</title>
  <style>
    body { font-family: monospace; }
    .bill-container {
      width: 600px;
      margin: 20px auto;
      border: 1px solid black;
      padding: 15px;
    }
    table {
      width: 100%;
      border-collapse: collapse;
      margin-top: 15px;
    }
    th, td {
      border: 1px solid black;
      padding: 6px 10px;
      text-align: left;
    }
    .text-right { text-align: right; }
    .total { font-weight: bold; }
    @media print {
      .no-print { display: none; }
    }
  </style>
</head>
<body>

<div class="bill-container">
  <h2>Bill #${billId}</h2>
  <p><strong>Customer:</strong> ${customerName}</p>
  <p><strong>Date/Time:</strong> ${billDateTime}</p>

  <table>
    <thead>
    <tr>
      <th>Item</th>
      <th>Qty</th>
      <th>Unit Price (Rs.)</th>
      <th>Total (Rs.)</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="item" items="${billItems}">
      <tr>
        <td>${item.itemName}</td>
        <td>${item.quantity}</td>
        <td class="text-right">${item.unitPrice}</td>
        <td class="text-right">${item.totalPrice}</td>
      </tr>
    </c:forEach>
    <tr class="total">
      <td colspan="3" class="text-right">Grand Total:</td>
      <td class="text-right">Rs. ${totalAmount}</td>
    </tr>
    </tbody>
  </table>

  <div class="no-print" style="margin-top: 20px; text-align: center;">
    <button onclick="window.print()">Print this bill</button>
    <button onclick="window.close()">Close</button>
  </div>
</div>

</body>
</html>
