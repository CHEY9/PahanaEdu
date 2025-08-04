<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add New Customer - PahanaEdu</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .card {
            border-radius: 1rem;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }
        h2 {
            font-weight: 600;
        }
    </style>
</head>
<body>
<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card p-4">
                <h2 class="text-center mb-4">🧾 Add New Customer</h2>

                <form action="<%= request.getContextPath() %>/Admin/add-customer" method="post">
                    <div class="mb-3">
                        <label for="name" class="form-label">👤 Full Name</label>
                        <input type="text" class="form-control" name="name" id="name" placeholder="" required>
                    </div>

                    <div class="mb-3">
                        <label for="email" class="form-label">📧 Email Address</label>
                        <input type="email" class="form-control" name="email" id="email" placeholder="" required>
                    </div>

                    <div class="mb-3">
                        <label for="phone" class="form-label">📞 Phone Number</label>
                        <input type="text" class="form-control" name="phone" id="phone" placeholder="" required>
                    </div>

                    <div class="mb-3">
                        <label for="address" class="form-label">🏠 Address</label>
                        <textarea class="form-control" name="address" id="address" rows="3" placeholder="" required></textarea>
                    </div>

                    <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                        <a href="<%= request.getContextPath() %>/Admin/manage-customers" class="btn btn-outline-secondary me-2">Cancel</a>
                        <button type="submit" class="btn btn-success">Add Customer</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
</html>
