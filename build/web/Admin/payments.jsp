<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Payment" %>

<%
    String currentPage = "payments";
    List<Payment> payments = (List<Payment>) request.getAttribute("payments");
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Payments - Admin Dashboard</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!-- Bootstrap & FontAwesome -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

        <style>
            :root {
                --primary-color: #4f46e5;
                --highlight-color: #3b82f6;
            }
            body {
                display: flex;
                background-color: #f9fafb;
                font-family: 'Segoe UI', sans-serif;
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
            .sidebar a.active {
                background-color: var(--highlight-color);
                border-left: 4px solid #1e40af;
            }
            .main-content {
                margin-left: 250px;
                padding: 30px;
                width: calc(100% - 250px);
            }
            h2 {
                color: #1e3a8a;
                font-weight: bold;
            }
            .table th {
                background-color: var(--highlight-color);
                color: white;
                text-align: center;
            }
            .table td {
                text-align: center;
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
            <a href="Admin/customers.jsp" class="<%= "customers".equals(currentPage) ? "active" : ""%>">
                <i class="fas fa-users me-2"></i> Customers
            </a>
            <a href="Admin/items.jsp" class="<%= "items".equals(currentPage) ? "active" : ""%>">
                <i class="fas fa-book me-2"></i> Items(Books)
            </a>
            <a href="Admin/billing.jsp" class="<%= "billing".equals(currentPage) ? "active" : ""%>">
                <i class="fas fa-file-invoice-dollar me-2"></i> Billing
            </a>
            <a href="../GetPaymentsServlet" class="<%= "payments".equals(currentPage) ? "active" : ""%>">
                <i class="fas fa-credit-card me-2"></i> Payments
            </a>
            <a href="Admin/help.jsp" class="<%= "help".equals(currentPage) ? "active" : ""%>">
                <i class="fas fa-question-circle me-2"></i> Help
            </a>
            <a href="logout.jsp">
                <i class="fas fa-sign-out-alt me-2"></i> Logout
            </a>
        </div>

        <!-- Main Content -->
        <div class="main-content">
            <h2><i class="fas fa-credit-card me-2"></i> Payment History</h2>

            <div class="table-responsive mt-4">
                <table class="table table-bordered table-striped">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Book Title</th>
                            <th>Card Number</th>
                            <th>Quantity</th>
                            <th>Amount</th>
                            <th>Date</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            if (payments != null && !payments.isEmpty()) {
                                for (Payment p : payments) {
                        %>
                        <tr>
                            <td><%= p.getPaymentId()%></td>
                            <td><%= p.getBookTitle()%></td>
                            <td><%= p.getCardNumber()%></td>
                            <td><%= p.getQuantity()%></td>
                            <td>$<%= p.getAmount()%></td>
                            <td><%= p.getPaymentDate()%></td>
                        </tr>
                        <%
                            }
                        } else {
                        %>
                        <tr>
                            <td colspan="6" class="text-center text-muted">No payments found.</td>
                        </tr>
                        <% }%>
                    </tbody>
                </table>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>