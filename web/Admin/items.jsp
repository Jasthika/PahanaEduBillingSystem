<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String currentPage = "items"; // For active sidebar highlighting
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Books - Admin Dashboard</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!-- Bootstrap & FontAwesome -->
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
                font-family: 'Segoe UI', Tahoma, sans-serif;
            }

            /* Sidebar */
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

            /* Main Content */
            .main-content {
                margin-left: 250px;
                padding: 30px;
                width: calc(100% - 250px);
            }

            h2 {
                color: #1e3a8a;
                font-weight: bold;
            }

            /* Table */
            .table th {
                background-color: var(--highlight-color);
                color: white;
                text-align: center;
                vertical-align: middle;
            }
            .table td {
                text-align: center;
                vertical-align: middle;
            }
            .table img.book-thumb {
                height: 60px;
                border-radius: 6px;
                object-fit: cover;
            }

            /* Buttons */
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

            /* Modal */
            .modal-content {
                border-radius: 12px;
                box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
            }
            .modal-header {
                background-color: var(--highlight-color);
                color: white;
            }

            /* Image preview in edit modal */
            #editImagePreview {
                max-height: 120px;
                margin-top: 10px;
                border-radius: 6px;
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
                <h2><i class="fas fa-book me-2"></i> Manage Books</h2>
                <button class="btn btn-add" data-bs-toggle="modal" data-bs-target="#addBookModal">
                    <i class="fas fa-plus"></i> Add Book
                </button>
            </div>

            <!-- Table -->
            <div class="table-responsive">
                <table class="table table-bordered table-striped table-hover align-middle">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Image</th>
                            <th>Title</th>
                            <th>Author</th>
                            <th>Price/Unit</th>
                            <th>Stock</th>
                            <th>Description</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            try {
                                Class.forName("com.mysql.cj.jdbc.Driver");
                                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3308/billing_system", "root", "");
                                Statement stmt = conn.createStatement();
                                ResultSet rs = stmt.executeQuery("SELECT * FROM books");

                                while (rs.next()) {
                                    int id = rs.getInt("bookId");
                                    String title = rs.getString("title").replace("'", "\\'");
                                    String author = rs.getString("author").replace("'", "\\'");
                                    String price = rs.getBigDecimal("pricePerUnit").toString();
                                    int stock = rs.getInt("quantityInStock");
                                    String desc = rs.getString("description").replace("'", "\\'");
                                    String image = rs.getString("image");  // Assuming this column exists
                        %>
                        <tr>
                            <td><%= id%></td>
                            <td>
                                <% if (image != null && !image.trim().isEmpty()) {%>
                                <img src="../uploads/books/<%= image%>" alt="Book Image" class="book-thumb" />
                                <% } else { %>
                                <span class="text-muted">No image</span>
                                <% }%>
                            </td>
                            <td><%= title%></td>
                            <td><%= author%></td>
                            <td><%= price%></td>
                            <td><%= stock%></td>
                            <td><%= desc%></td>
                            <td>
                                <div class="d-flex justify-content-center gap-2">
                                    <button class="btn btn-sm btn-edit"
                                            data-bs-toggle="modal" data-bs-target="#editBookModal"
                                            onclick="populateEditForm('<%= id%>', '<%= title%>', '<%= author%>', '<%= price%>', '<%= stock%>', '<%= desc%>', '<%= image%>')">
                                        <i class="fas fa-edit"></i> Edit
                                    </button>
                                    <a href="../BookServlet?action=delete&bookId=<%= id%>"
                                       onclick="return confirm('Are you sure you want to delete this book?');"
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
                                out.println("<tr><td colspan='8' class='text-danger'>Error loading books</td></tr>");
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Add Book Modal -->
        <div class="modal fade" id="addBookModal" tabindex="-1">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <!-- enctype for file upload -->
                    <form action="../BookServlet" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="action" value="save">
                        <div class="modal-header">
                            <h5 class="modal-title">Add New Book</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body row g-3">
                            <div class="col-md-6">
                                <label class="form-label">Title</label>
                                <input type="text" class="form-control" name="title" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Author</label>
                                <input type="text" class="form-control" name="author" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Price Per Unit</label>
                                <input type="number" step="0.01" class="form-control" name="pricePerUnit" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Stock Quantity</label>
                                <input type="number" class="form-control" name="quantityInStock" required>
                            </div>
                            <div class="col-12">
                                <label class="form-label">Description</label>
                                <textarea class="form-control" name="description" rows="3"></textarea>
                            </div>
                            <div class="col-12">
                                <label class="form-label">Book Image</label>
                                <input type="file" class="form-control" name="bookImage" accept="image/*" />
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="submit" class="btn btn-add">Add Book</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Edit Book Modal -->
        <div class="modal fade" id="editBookModal" tabindex="-1">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <form action="../BookServlet" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="action" value="edit">
                        <input type="hidden" id="editBookId" name="bookId">
                        <div class="modal-header">
                            <h5 class="modal-title">Edit Book</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body row g-3">
                            <div class="col-md-6">
                                <label class="form-label">Title</label>
                                <input type="text" class="form-control" id="editTitle" name="title" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Author</label>
                                <input type="text" class="form-control" id="editAuthor" name="author" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Price Per Unit</label>
                                <input type="number" step="0.01" class="form-control" id="editPricePerUnit" name="pricePerUnit" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Stock Quantity</label>
                                <input type="number" class="form-control" id="editQuantityInStock" name="quantityInStock" required>
                            </div>
                            <div class="col-12">
                                <label class="form-label">Description</label>
                                <textarea class="form-control" id="editDescription" name="description" rows="3"></textarea>
                            </div>
                            <div class="col-12">
                                <label class="form-label">Book Image (Upload new to replace)</label>
                                <input type="file" class="form-control" name="bookImage" accept="image/*" />
                                <!-- Preview current image -->
                                <img id="editImagePreview" src="#" alt="Current Book Image" style="display:none;" />
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="submit" class="btn btn-edit">Update Book</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <script>
            function populateEditForm(id, title, author, price, stock, desc, image) {
                document.getElementById("editBookId").value = id;
                document.getElementById("editTitle").value = title;
                document.getElementById("editAuthor").value = author;
                document.getElementById("editPricePerUnit").value = price;
                document.getElementById("editQuantityInStock").value = stock;
                document.getElementById("editDescription").value = desc;

                const imgPreview = document.getElementById("editImagePreview");
                if (image && image.trim() !== "") {
                    imgPreview.src = "uploads/books/" + image;
                    imgPreview.style.display = "block";
                } else {
                    imgPreview.style.display = "none";
                }
            }
        </script>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
