<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String currentPage = "help"; // Define the current page
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <title>Help - Pahana Edu Admin</title>
        <meta name="viewport" content="width=device-width, initial-scale=1" />

        <!-- Bootstrap CSS & Icons -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet"/>

        <style>
            :root {
                --primary-color: #4f46e5;
                --highlight-color: #3b82f6;
            }
            body {
                display: flex;
                background-color: #f3f4f6;
            }
            .sidebar {
                width: 250px;
                height: 100vh;
                background: linear-gradient(180deg, var(--primary-color), #3730a3);
                color: white;
                padding-top: 20px;
                position: fixed;
            }
            .sidebar h3 {
                text-align: center;
                font-size: 1.5rem;
                font-weight: bold;
                margin-bottom: 20px;
            }
            .sidebar a {
                padding: 12px 20px;
                display: block;
                color: white;
                text-decoration: none;
                font-size: 1.1rem;
                transition: 0.3s;
                border-left: 4px solid transparent;
            }
            .sidebar a:hover {
                background-color: rgba(59, 130, 246, 0.2);
                color: #e0f2ff;
            }
            .sidebar a.active {
                background-color: var(--highlight-color);
                color: white;
                font-weight: bold;
                border-left: 4px solid #1e40af;
            }
            .main-content {
                margin-left: 250px;
                padding: 20px 40px;
                width: 100%;
                color: #1e3a8a;
            }
            h2 {
                font-weight: bold;
                margin-bottom: 20px;
            }
            h4 {
                margin-top: 25px;
                color: var(--primary-color);
            }
            p {
                font-size: 1rem;
                line-height: 1.6;
            }
            ul {
                list-style-type: disc;
                padding-left: 20px;
            }
        </style>
    </head>
    <body>

        <!-- Sidebar -->
        <div class="sidebar">
            <h3>Pahana Edu Admin</h3>
            <a href="dashboard.jsp" class="<%= "dashboard".equals(currentPage) ? "active" : ""%>">
                <i class="fas fa-tachometer-alt me-2"></i> Dashboard
            </a>

            <a href="customers.jsp" class="<%= "customers".equals(currentPage) ? "active" : ""%>">
                <i class="fas fa-users me-2"></i> Customers
            </a>
            <a href="items.jsp" class="<%= "items".equals(currentPage) ? "active" : ""%>">
                <i class="fas fa-book me-2"></i> Items(Books)
            </a>
            <a href="billing.jsp" class="<%= "billing".equals(currentPage) ? "active" : ""%>">
                <i class="fas fa-file-invoice-dollar me-2"></i> Billing
            </a>
            <!-- ✅ New Payments Section -->
            <a href="payments.jsp" class="sidebar-link <%= "payments".equals(currentPage) ? "active" : ""%>">
                <i class="fas fa-credit-card me-2"></i> Payments
            </a>
            <a href="help.jsp" class="<%= "help".equals(currentPage) ? "active" : ""%>">
                <i class="fas fa-question-circle me-2"></i> Help
            </a>
            <a href="logout.jsp">
                <i class="fas fa-sign-out-alt me-2"></i> Logout
            </a>
        </div>

        <!-- Main Content -->
        <div class="main-content">
            <h2><i class="fas fa-question-circle me-2"></i> System Help & User Guide</h2>

            <h4>1. User Authentication (Login)</h4>
            <p>
                Access to the system requires a valid username and password.
                Ensure your credentials are correct to log in securely.
            </p>

            <h4>2. Managing Customer Accounts</h4>
            <ul>
                <li><strong>Add New Customer:</strong> Click the "Add Customer" button on the Customers page to register a new customer account. Fill in all required details.</li>
                <li><strong>Edit Customer:</strong> Use the Edit button next to a customer record to update details like address or telephone.</li>
                <li><strong>Delete Customer:</strong> Delete unwanted customer records carefully; this action is irreversible.</li>
            </ul>

            <h4>3. Managing Items</h4>
            <ul>
                <li><strong>Add Items:</strong> Add books or items to your inventory through the Items page.</li>
                <li><strong>Edit / Delete Items:</strong> Use the provided controls to update or remove item details as needed.</li>
            </ul>

            <h4>4. Billing Management</h4>
            <ul>
                <li><strong>Add Bill:</strong> Generate a new bill by selecting a customer and entering the units consumed. The system calculates the amount automatically.</li>
                <li><strong>Edit Bill:</strong> Modify units consumed if necessary; the bill amount will update accordingly.</li>
                <li><strong>Delete Bill:</strong> Remove incorrect or obsolete bills.</li>
            </ul>

            <h4>5. Calculating Bill Amounts</h4>
            <p>
                The bill amount is computed automatically based on the formula: <br/>
                <em>Bill Amount = Units Consumed × Price Per Unit</em><br/>
                The price per unit is set by the system administrator.
            </p>

            <h4>6. Help & Support</h4>
            <p>
                If you encounter any issues or need further assistance, please contact the system administrator or refer to this help section.
            </p>

            <h4>7. Exiting the System</h4>
            <p>
                Use the Logout option in the sidebar to safely exit the system and protect your account.
            </p>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
