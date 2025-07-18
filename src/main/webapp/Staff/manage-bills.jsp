<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
  <title>Manage Bills</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body>
<div class="container mt-5">
  <h2>Manage Bills</h2>

  <!-- Search Form -->
  <form action="manage-bills" method="get" class="mb-3">
    <div class="row g-2">
      <div class="col-md-3">
        <input type="text" name="billId" class="form-control" placeholder="Bill ID" value="${param.billId}" />
      </div>
      <div class="col-md-3">
        <input type="text" name="customerName" class="form-control" placeholder="Customer Name" value="${param.customerName}" />
      </div>
      <div class="col-md-3">
        <input type="date" name="dateFrom" class="form-control" placeholder="From Date" value="${param.dateFrom}" />
      </div>
      <div class="col-md-3">
        <input type="date" name="dateTo" class="form-control" placeholder="To Date" value="${param.dateTo}" />
      </div>
    </div>
    <div class="row mt-2">
      <div class="col-md-2">
        <button type="submit" class="btn btn-primary w-100">Search</button>
      </div>
      <div class="col-md-2">
        <a href="manage-bills" class="btn btn-secondary w-100">Reset</a>
      </div>
      <div class="col-md-8 text-end">
        <a href="${pageContext.request.contextPath}/Staff/create-bill-form" class="btn btn-success">+ Create New Bill</a>
      </div>
    </div>
  </form>

  <!-- Bills Table -->
  <table class="table table-bordered table-striped table-hover mt-3 align-middle">
    <thead class="table-dark">
    <tr>
      <th>Bill ID</th>
      <th>Customer ID</th>
      <th>Customer Name</th>
      <th>Date/Time</th>
      <th>Total Amount (Rs.)</th>
      <th>Actions</th>
    </tr>
    </thead>
    <tbody>
    <c:choose>
      <c:when test="${not empty bills}">
        <c:forEach var="bill" items="${bills}">
          <tr>
            <td>${bill.billId}</td>
            <td>${bill.customerId}</td>
            <td>${bill.customerName}</td>
            <td><fmt:formatDate value="${bill.billDateTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
            <td>${bill.totalAmount}</td>
            <td>
              <a href="bill-details?billId=${bill.billId}" class="btn btn-info btn-sm" title="View">View</a>
              <a href="edit-bill-form?billId=${bill.billId}" class="btn btn-warning btn-sm" title="Edit">Edit</a>
              <form action="delete-bill" method="post" style="display:inline" onsubmit="return confirm('Are you sure to delete this bill?');">
                <input type="hidden" name="billId" value="${bill.billId}" />
                <button type="submit" class="btn btn-danger btn-sm" title="Delete">Delete</button>
              </form>
              <a href="print-bill?billId=${bill.billId}" target="_blank" class="btn btn-success btn-sm" title="Print">Print</a>
            </td>
          </tr>
        </c:forEach>
      </c:when>
      <c:otherwise>
        <tr>
          <td colspan="6" class="text-center">No bills found.</td>
        </tr>
      </c:otherwise>
    </c:choose>
    </tbody>
  </table>

  <a href="${pageContext.request.contextPath}/Staff/dashboard.jsp" class="btn btn-secondary mt-3">⬅ Back to Dashboard</a>

</div>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
