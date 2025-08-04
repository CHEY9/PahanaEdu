<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Audit Logs - Admin Dashboard</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .container {
            margin-top: 60px;
            max-width: 95%;
        }

        .card {
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            border: none;
        }

        .card-header {
            background-color: #0d6efd;
            color: white;
            padding: 20px;
            border-top-left-radius: 12px;
            border-top-right-radius: 12px;
        }

        .card-header h3 {
            margin: 0;
            font-weight: 600;
        }

        .table thead {
            background-color: #343a40;
            color: white;
        }

        .table tbody tr:hover {
            background-color: #f0f0f0;
        }

        .btn-back {
            margin-top: 20px;
        }

        .table-responsive {
            max-height: 500px;
            overflow-y: auto;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="card">
        <div class="card-header text-center">
            <h3>Audit Logs</h3>
        </div>
        <div class="card-body table-responsive">
            <table class="table table-bordered table-striped align-middle text-center">
                <thead>
                <tr>
                    <th>Log ID</th>
                    <th>User Name</th>
                    <th>Action</th>
                    <th>Description</th>
                    <th>Timestamp</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="log" items="${logList}">
                    <tr>
                        <td>${log.logId}</td>
                        <td>${log.username}</td>
                        <td><span class="badge bg-info">${log.action}</span></td>
                        <td>${log.description}</td>
                        <td>${log.timestamp}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
    <div class="text-center">
        <a href="dashboard.jsp" class="btn btn-outline-primary btn-back">Back to Dashboard</a>
    </div>
</div>
</body>
</html>
