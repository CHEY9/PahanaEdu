<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
  <title>Edit Bill #${billId}</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body>
<div class="container mt-5">
  <h2>Edit Bill #${billId}</h2>
  <p><strong>Customer:</strong> ${customerName}</p>
  <p><strong>Bill Date:</strong> ${billDateTime}</p>

  <form action="${pageContext.request.contextPath}/staff/update-bill" method="post">
    <input type="hidden" name="billId" value="${billId}" />

    <table class="table table-bordered">
      <thead>
      <tr>
        <th>Item Name</th>
        <th>Quantity</th>
        <th>Unit Price (Rs.)</th>
        <th>Total Price (Rs.)</th>
      </tr>
      </thead>
      <tbody>
      <c:forEach var="item" items="${billItems}" varStatus="status">
        <tr>
          <td>${item.itemName}</td>
          <td>
            <input type="number" name="quantities" value="${item.quantity}" min="1" class="form-control" required />
          </td>
          <td>${item.unitPrice}</td>
          <td>${item.totalPrice}</td>
          <input type="hidden" name="itemNames" value="${item.itemName}" />
          <input type="hidden" name="unitPrices" value="${item.unitPrice}" />
        </tr>
      </c:forEach>
      </tbody>
    </table>

    <button type="submit" class="btn btn-primary">Save Changes</button>
    <a href="${pageContext.request.contextPath}/staff/manage-bills" class="btn btn-secondary">Cancel</a>
  </form>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
