<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%
    String currentPage = "customers";
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Customers - Admin Dashboard</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <!-- Bootstrap & Font Awesome -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

        <style>
            :root {
                --primary-color: #4f46e5;
                --highlight-color: #3b82f6;
                --danger-color: #dc3545;
            }

            body {
                display: flex;
                background-color: #f9fafb;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
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
                vertical-align: middle;
            }

            .table td {
                vertical-align: middle;
                text-align: center;
            }

            .btn-add {
                background-color: #0d6efd;
                color: white;
                font-weight: 600;
            }
            .btn-add:hover {
                background-color: #0b5ed7;
            }

            .btn-edit {
                background-color: #0d6efd;
                color: white;
                font-weight: 600;
            }
            .btn-edit:hover {
                background-color: #0b5ed7;
            }

            .btn-danger {
                background-color: var(--danger-color);
                color: white;
                font-weight: 600;
            }

            .modal-content {
                border-radius: 12px;
                box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
            }

            .modal-header {
                background-color: var(--highlight-color);
                color: white;
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
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2><i class="fas fa-users me-2"></i> Customer Accounts</h2>
                <button class="btn btn-add" data-bs-toggle="modal" data-bs-target="#addCustomerModal">
                    <i class="fas fa-plus"></i> Add Customer
                </button>
            </div>

            <div class="table-responsive">
                <table class="table table-bordered table-striped table-hover align-middle">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Account Number</th>
                            <th>Name</th>
                            <th>Address</th>
                            <th>Telephone</th>
                            <th>Password</th> <!-- ✅ Added Password Column -->
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            try {
                                Class.forName("com.mysql.cj.jdbc.Driver");
                                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3308/billing_system", "root", "");
                                Statement stmt = conn.createStatement();
                                ResultSet rs = stmt.executeQuery("SELECT * FROM customer_accounts");

                                while (rs.next()) {
                                    int customerId = rs.getInt("customerId");
                                    String account = rs.getString("accountNumber").replace("'", "\\'");
                                    String name = rs.getString("name").replace("'", "\\'").replace("\"", "\\\"");
                                    String address = rs.getString("address").replace("'", "\\'").replace("\"", "\\\"").replace("\n", "").replace("\r", "");
                                    String telephone = rs.getString("telephone").replace("'", "\\'");
                                    String password = rs.getString("password").replace("'", "\\'");
                        %>
                        <tr>
                            <td><%= customerId%></td>
                            <td><%= account%></td>
                            <td><%= name%></td>
                            <td><%= address%></td>
                            <td><%= telephone%></td>
                            <td><%= password%></td> <!-- ✅ Display password -->
                            <td>
                                <div class="d-flex justify-content-center gap-2">
                                    <button class="btn btn-sm btn-edit"
                                            data-bs-toggle="modal" data-bs-target="#editCustomerModal"
                                            onclick="populateEditForm('<%= customerId%>', '<%= account%>', '<%= name%>', `<%= address%>`, '<%= telephone%>', '<%= password%>')">
                                        <i class="fas fa-edit"></i> Edit
                                    </button>
                                    <a href="../CustomersServlet?action=delete&customerId=<%= customerId%>"
                                       onclick="return confirm('Are you sure you want to delete this customer?');"
                                       class="btn btn-sm btn-danger">
                                        <i class="fas fa-trash"></i> Delete
                                    </a>
                                </div>
                            </td>
                        </tr>
                        <%
                                }
                                conn.close();
                            } catch (Exception e) {
                                e.printStackTrace();
                                out.println("<tr><td colspan='7' class='text-danger'>Error loading customers</td></tr>");
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- ✅ Add Customer Modal -->
        <div class="modal fade" id="addCustomerModal" tabindex="-1" aria-labelledby="addCustomerModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form action="../CustomersServlet" method="post">
                        <input type="hidden" name="action" value="save">
                        <div class="modal-header">
                            <h5 class="modal-title">Add New Customer</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body row g-3">
                            <div class="col-md-6">
                                <label class="form-label">Account Number</label>
                                <input type="text" class="form-control" name="accountNumber" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Name</label>
                                <input type="text" class="form-control" name="name" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Telephone</label>
                                <input type="text" class="form-control" name="telephone" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Password</label>
                                <input type="text" class="form-control" name="password" required> <!-- ✅ Added Password -->
                            </div>
                            <div class="col-12">
                                <label class="form-label">Address</label>
                                <textarea class="form-control" name="address" required></textarea>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="submit" class="btn btn-add">Add Customer</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- ✅ Edit Customer Modal -->
        <div class="modal fade" id="editCustomerModal" tabindex="-1" aria-labelledby="editCustomerModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form action="../CustomersServlet" method="post">
                        <input type="hidden" name="action" value="edit">
                        <input type="hidden" id="editId" name="customerId">
                        <div class="modal-header">
                            <h5 class="modal-title">Edit Customer</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body row g-3">
                            <div class="col-md-6">
                                <label class="form-label">Account Number</label>
                                <input type="text" class="form-control" id="editAccount" name="accountNumber" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Name</label>
                                <input type="text" class="form-control" id="editName" name="name" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Telephone</label>
                                <input type="text" class="form-control" id="editTelephone" name="telephone" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Password</label>
                                <input type="text" class="form-control" id="editPassword" name="password" required> <!-- ✅ Added Password -->
                            </div>
                            <div class="col-12">
                                <label class="form-label">Address</label>
                                <textarea class="form-control" id="editAddress" name="address" required></textarea>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="submit" class="btn btn-edit">Update Customer</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- ✅ Script to Populate Edit Form -->
        <script>
            function populateEditForm(id, account, name, address, telephone, password) {
                document.getElementById("editId").value = id;
                document.getElementById("editAccount").value = account;
                document.getElementById("editName").value = name;
                document.getElementById("editAddress").value = address;
                document.getElementById("editTelephone").value = telephone;
                document.getElementById("editPassword").value = password; // ✅ Set password
            }
        </script>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
