<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Audit Logs</title>
    <!-- Bootstrap CSS CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        body {
            background-color: #f4f6f9;
        }
        .container {
            margin-top: 50px;
        }
        .table thead {
            background-color: #343a40;
            color: white;
        }
        .table tbody tr:hover {
            background-color: #f1f1f1;
        }
        h2 {
            margin-bottom: 30px;
            color: #333;
            font-weight: 600;
        }
    </style>
</head>
<body>
<div class="container">
    <h2 class="text-center">Audit Logs</h2>
    <div class="table-responsive">
        <table class="table table-bordered table-striped">
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
                    <td>${log.action}</td>
                    <td>${log.description}</td>
                    <td>${log.timestamp}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
    <a href="dashboard.jsp" class="btn btn-secondary mt-3">Back to Dashboard</a>
</div>
</body>
</html>
