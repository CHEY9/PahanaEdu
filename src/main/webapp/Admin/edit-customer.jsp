<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.pahanaedu2.customer.Customer" %>
<%
  Customer customer = (Customer) request.getAttribute("customer");
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Edit Customer - PahanaEdu</title>
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
  <style>
    body {
      background-color: #f8f9fa;
    }
    .container {
      max-width: 600px;
      margin-top: 60px;
      background: white;
      padding: 2rem 2.5rem;
      border-radius: 1rem;
      box-shadow: 0 4px 15px rgba(0,0,0,0.1);
    }
    h2 {
      margin-bottom: 2rem;
      font-weight: 700;
      color: #0d6efd;
      text-align: center;
    }
    .btn-group {
      margin-top: 1.5rem;
      display: flex;
      justify-content: flex-end;
      gap: 1rem;
    }
  </style>
</head>
<body>

<div class="container">
  <h2>Edit Customer</h2>

  <form action="<%= request.getContextPath() %>/Admin/edit-customer" method="post" novalidate>
    <input type="hidden" name="id" value="<%= customer.getId() %>">

    <div class="mb-3">
      <label for="name" class="form-label">Name</label>
      <input
              type="text"
              id="name"
              name="name"
              class="form-control"
              value="<%= customer.getName() %>"
              required
              minlength="2"
              maxlength="100"
      >
    </div>

    <div class="mb-3">
      <label for="email" class="form-label">Email</label>
      <input
              type="email"
              id="email"
              name="email"
              class="form-control"
              value="<%= customer.getEmail() %>"
              required
      >
    </div>

    <div class="mb-3">
      <label for="phone" class="form-label">Phone</label>
      <input
              type="tel"
              id="phone"
              name="phone"
              class="form-control"
              value="<%= customer.getPhone() %>"
              required
              pattern="^\+?[0-9\s\-]{7,15}$"
              title="Phone number should be 7 to 15 digits and may include +, spaces, or dashes."
      >
    </div>

    <div class="mb-3">
      <label for="address" class="form-label">Address</label>
      <textarea
              id="address"
              name="address"
              class="form-control"
              rows="3"
              required
              minlength="5"
              maxlength="250"
      ><%= customer.getAddress() %></textarea>
    </div>

    <div class="btn-group">
      <a href="<%= request.getContextPath() %>/Admin/manage-customers" class="btn btn-outline-secondary">Cancel</a>
      <button type="submit" class="btn btn-primary">Update Customer</button>
    </div>
  </form>
</div>

</body>
</html>
