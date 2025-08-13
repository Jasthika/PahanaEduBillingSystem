<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String currentPage = "billing";
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <title>Billing - Pahana Edu Admin</title>
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet" />
        <style>
            :root {
                --primary-color: #4f46e5;
                --highlight-color: #3b82f6;
            }
            body {
                display: flex;
                background-color: #f3f4f6;
                margin: 0;
                min-height: 100vh;
            }
            .sidebar {
                width: 250px;
                height: 100vh;
                background: linear-gradient(180deg, var(--primary-color), #3730a3);
                color: white;
                padding-top: 20px;
                position: fixed;
                overflow-y: auto;
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
            .sidebar a:hover,
            .sidebar a.active {
                background-color: var(--highlight-color);
                font-weight: bold;
                border-left: 4px solid #1e40af;
            }
            .main-content {
                margin-left: 250px;
                padding: 20px;
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
            .btn-add {
                background: var(--highlight-color);
                color: white;
                border: none;
            }
            .btn-add:hover {
                background: #2563eb;
            }
        </style>
    </head>
    <body>

        <!-- Sidebar -->
        <div class="sidebar">
            <h3>Pahana Edu Admin</h3>
            <a href="dashboard.jsp" class="<%= "dashboard".equals(currentPage) ? "active" : ""%>"><i class="fas fa-tachometer-alt me-2"></i> Dashboard</a>
            <a href="customers.jsp" class="<%= "customers".equals(currentPage) ? "active" : ""%>"><i class="fas fa-users me-2"></i> Customers</a>
            <a href="items.jsp" class="<%= "items".equals(currentPage) ? "active" : ""%>"><i class="fas fa-book me-2"></i> Items(Books)</a>
            <a href="billing.jsp" class="<%= "billing".equals(currentPage) ? "active" : ""%>"><i class="fas fa-file-invoice-dollar me-2"></i> Billing</a>
            <a href="../GetPaymentsServlet" class="<%= "payments".equals(currentPage) ? "active" : ""%>">
                <i class="fas fa-credit-card me-2"></i> Payments
            </a>
            <a href="help.jsp" class="<%= "help".equals(currentPage) ? "active" : ""%>"><i class="fas fa-question-circle me-2"></i> Help</a>
            <a href="logout.jsp"><i class="fas fa-sign-out-alt me-2"></i> Logout</a>
        </div>

        <!-- Main content -->
        <div class="main-content">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2><i class="fas fa-file-invoice-dollar me-2"></i> Billing Management</h2>
                <button class="btn btn-add" data-bs-toggle="modal" data-bs-target="#addBillModal">
                    <i class="fas fa-plus"></i> Add Bill
                </button>
            </div>

            <!-- Bills Table -->
            <table class="table table-striped table-hover align-middle">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Account Number</th>
                        <th>Customer Name</th>
                        <th>Total Amount (Rs.)</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3308/billing_system", "root", "");
                            String sql = "SELECT b.billId, c.accountNumber, c.name, b.totalAmount FROM bills b JOIN customer_accounts c ON b.customerId = c.customerId ORDER BY b.billDate DESC";
                            Statement stmt = conn.createStatement();
                            ResultSet rs = stmt.executeQuery(sql);
                            int rowNum = 1;
                            while (rs.next()) {
                    %>
                    <tr>
                        <td><%= rowNum++%></td>
                        <td><%= rs.getString("accountNumber")%></td>
                        <td><%= rs.getString("name")%></td>
                        <td><%= String.format("%.2f", rs.getDouble("totalAmount"))%></td>
                        <td>
                            <a href="printBill.jsp?billId=<%= rs.getInt("billId")%>" target="_blank" class="btn btn-sm btn-secondary">
                                <i class="fas fa-print"></i> Print
                            </a>
                        </td>
                    </tr>
                    <%
                            }
                            conn.close();
                        } catch (Exception e) {
                            e.printStackTrace();
                            out.println("<tr><td colspan='5' class='text-danger'>Error loading bills</td></tr>");
                        }
                    %>
                </tbody>
            </table>
        </div>

        <!-- Add Bill Modal -->
        <div class="modal fade" id="addBillModal" tabindex="-1" aria-labelledby="addBillModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <form action="../BillingServlet" method="post" id="addBillForm">
                    <input type="hidden" name="action" value="save" />
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Add New Bill</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">

                            <!-- Customer Selection -->
                            <div class="mb-3">
                                <label class="form-label">Select Customer</label>
                                <select name="customerId" class="form-select" required>
                                    <option value="" disabled selected>-- Select Customer --</option>
                                    <%
                                        try (Connection conn2 = DriverManager.getConnection("jdbc:mysql://localhost:3308/billing_system", "root", ""); Statement stmt2 = conn2.createStatement(); ResultSet rs2 = stmt2.executeQuery("SELECT customerId, accountNumber, name FROM customer_accounts ORDER BY name")) {
                                            while (rs2.next()) {
                                    %>
                                    <option value="<%= rs2.getInt("customerId")%>"><%= rs2.getString("accountNumber")%> - <%= rs2.getString("name")%></option>
                                    <%
                                            }
                                        } catch (Exception e) {
                                            out.println("<option disabled>Error loading customers</option>");
                                        }
                                    %>
                                </select>
                            </div>

                            <!-- Books Purchased -->
                            <div class="mb-3">
                                <label class="form-label">Books Purchased</label>
                                <table class="table table-bordered">
                                    <thead>
                                        <tr>
                                            <th>Book</th>
                                            <th>Price Per Unit (Rs.)</th>
                                            <th>Quantity</th>
                                            <th>Amount (Rs.)</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>
                                                <select name="bookId" class="form-select" onchange="updateBookPrice(this)">
                                                    <option value="" disabled selected>-- Select Book --</option>
                                                    <%
                                                        try {
                                                            Class.forName("com.mysql.cj.jdbc.Driver");
                                                            Connection conn3 = DriverManager.getConnection("jdbc:mysql://localhost:3308/billing_system", "root", "");
                                                            Statement stmt3 = conn3.createStatement();
                                                            ResultSet rs3 = stmt3.executeQuery("SELECT bookId, title, pricePerUnit FROM books ORDER BY title");
                                                            while (rs3.next()) {
                                                                int bookId = rs3.getInt("bookId");
                                                                String title = rs3.getString("title");
                                                                double price = rs3.getDouble("pricePerUnit");
                                                    %>
                                                    <option value="<%=bookId%>" data-price="<%=price%>"><%= title%></option>
                                                    <%
                                                            }
                                                            conn3.close();
                                                        } catch (Exception e) {
                                                            out.println("<option disabled>Error loading books</option>");
                                                        }
                                                    %>
                                                </select>
                                            </td>
                                            <td><input type="text" name="price" class="form-control" readonly value="0.00"></td>
                                            <td><input type="number" name="quantity" class="form-control" value="1" min="1" oninput="updateAmount(this)"></td>
                                            <td><input type="text" name="amount" class="form-control" readonly value="0.00"></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>

                            <!-- Total -->
                            <div class="mb-3 text-end">
                                <label class="form-label">Total Amount (Rs.): </label>
                                <input type="text" id="totalAmount" name="totalAmount" readonly class="form-control w-25 d-inline-block text-end" value="0.00" />
                            </div>

                        </div>
                        <div class="modal-footer">
                            <button type="submit" class="btn btn-add">Generate Bill</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <script>
            function updateBookPrice(selectElem) {
                const selected = selectElem.options[selectElem.selectedIndex];
                const price = selected.getAttribute("data-price") || 0;

                const row = selectElem.closest("tr");
                const priceInput = row.querySelector('input[name="price"]');
                const qtyInput = row.querySelector('input[name="quantity"]');
                const amountInput = row.querySelector('input[name="amount"]');

                priceInput.value = parseFloat(price).toFixed(2);
                const qty = parseInt(qtyInput.value) || 1;
                amountInput.value = (price * qty).toFixed(2);

                updateTotal();
            }

            function updateAmount(qtyElem) {
                const row = qtyElem.closest("tr");
                const price = parseFloat(row.querySelector('input[name="price"]').value) || 0;
                const qty = parseInt(qtyElem.value) || 1;
                row.querySelector('input[name="amount"]').value = (price * qty).toFixed(2);

                updateTotal();
            }

            function updateTotal() {
                let total = 0;
                document.querySelectorAll('input[name="amount"]').forEach(input => {
                    total += parseFloat(input.value) || 0;
                });
                document.getElementById("totalAmount").value = total.toFixed(2);
            }
        </script>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    </body>
</html>
