<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="com.example.pahanaedu2.auth.User" %>

<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"staff".equalsIgnoreCase(user.getRole())) {
        response.sendRedirect("../login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>User Guide & Help | PahanaEdu Staff</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />

    <style>
        body {
            background: #f9fafb;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            color: #333;
        }
        header, footer {
            background-color: #343a40;
            color: white;
            padding: 1rem 0;
        }
        main.container {
            margin-top: 2rem;
            margin-bottom: 3rem;
            max-width: 900px;
        }
        h1, h2 {
            font-weight: 700;
            color: #0d6efd;
        }
        h3 {
            margin-top: 1.5rem;
            margin-bottom: 1rem;
            color: #495057;
        }
        p {
            line-height: 1.6;
        }
        ul {
            list-style-type: disc;
            padding-left: 20px;
        }
        .btn-back {
            margin-top: 2rem;
        }
        footer {
            text-align: center;
            font-size: 0.9rem;
        }
    </style>
</head>
<body>

<header>
    <nav class="navbar navbar-expand-lg navbar-dark container">
        <a class="navbar-brand" href="<%= request.getContextPath() %>/Staff/staff-dashboard.jsp">
            <img src="<%= request.getContextPath() %>/images/logo1.jpg" alt="Logo" width="30" height="30" class="d-inline-block align-text-top me-2" />
            PahanaEdu Staff Portal
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarMenu" aria-controls="navbarMenu" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarMenu">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link" href="<%= request.getContextPath() %>/Staff/staff-dashboard.jsp">Dashboard</a>
                </li>
                <li class="nav-item">
                    <form action="<%= request.getContextPath() %>/logout" method="post" class="d-inline">
                        <button class="btn btn-outline-light btn-sm" type="submit">Logout</button>
                    </form>
                </li>
            </ul>
        </div>
    </nav>
</header>

<main class="container">
    <h1>User Guide & Help</h1>

    <section>
        <p>Welcome to <strong>PahanaEdu</strong>! This guide will help you understand the main features of the system and how to use them effectively as a staff member.</p>
        <p>Use the navigation above or the back button at the bottom of the page to return to your dashboard anytime.</p>
    </section>

    <hr />

    <section>
        <h2>1. System Overview</h2>
        <p>PahanaEdu is a billing management system designed to streamline customer billing, inventory management, and staff operations. As a staff user, your main responsibilities include managing customers, items, and bills efficiently.</p>
    </section>

    <section>
        <h2>2. Key Features & How to Use Them</h2>

        <h3>Manage Customers</h3>
        <p>Access the "Manage Customers" section to:</p>
        <ul>
            <li><strong>Add new customers:</strong> Enter customer details like name, contact info, and save.</li>
            <li><strong>Edit existing customers:</strong> Update customer details as needed.</li>
            <li><strong>View customer list:</strong> See all customers and search/filter through them.</li>
        </ul>

        <h3>Manage Items</h3>
        <p>This section allows you to manage the products/items in stock:</p>
        <ul>
            <li><strong>Add new items:</strong> Include item name, category, description, price, and stock quantity.</li>
            <li><strong>Edit item details:</strong> Update prices or stock levels.</li>
            <li><strong>Stock Alerts:</strong> Be notified when items are low in stock so you can restock timely.</li>
        </ul>

        <h3>Manage Bills</h3>
        <p>Here you can create and manage customer bills:</p>
        <ul>
            <li><strong>Create new bills:</strong> Select customer, add multiple items with quantities, and the system calculates totals.</li>
            <li><strong>View bill details:</strong> Check all items, prices, quantities, and totals for each bill.</li>
            <li><strong>Edit or delete bills:</strong> Modify or remove bills when necessary.</li>
            <li><strong>Print bills:</strong> Generate printable versions for customers.</li>
        </ul>

        <h3>Profile Management</h3>
        <p>Manage your profile information and change your password securely in the Profile section.</p>
    </section>

    <section>
        <h2>3. Step-by-Step: Creating a New Bill</h2>
        <ol>
            <li>Go to <strong>Manage Bills</strong> from the dashboard.</li>
            <li>Click the <strong>Create New Bill</strong> button.</li>
            <li>Select the customer from the dropdown or add a new customer first.</li>
            <li>Add items by selecting them from the available items list and entering quantities.</li>
            <li>Check the total amount automatically calculated at the bottom.</li>
            <li>Submit the bill to save it in the system.</li>
            <li>You can view the bill details or print the bill for the customer.</li>
        </ol>
    </section>

    <section>
        <h2>4. Tips for Effective Use</h2>
        <ul>
            <li>Keep customer and item data up to date for accurate billing.</li>
            <li>Regularly check stock alerts to prevent selling out-of-stock items.</li>
            <li>Always review bill details before finalizing to avoid errors.</li>
            <li>Use the search and filter features to quickly find customers, items, or bills.</li>
            <li>Log out when you finish your session to keep the system secure.</li>
        </ul>
    </section>

    <section>
        <h2>5. Getting Further Help</h2>
        <p>If you encounter any issues or need assistance, please contact the support team via email at <a href="mailto:support@pahanaedu.com">support@pahanaedu.com</a> or call <strong>+94 71 412 1417</strong>.</p>
    </section>

    <a href="<%= request.getContextPath() %>/Staff/staff-dashboard.jsp" class="btn btn-outline-primary btn-back">
        &larr; Back to Dashboard
    </a>
</main>

<footer>
    <div class="container">
        &copy; <%= java.time.Year.now() %> PahanaEdu. All rights reserved.
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
