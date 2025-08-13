<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Book" %>

<%
    // ✅ Get invoice-related attributes
    Book book = (Book) request.getAttribute("book");
    double amount = (double) request.getAttribute("amount");
    String cardLast4 = (String) request.getAttribute("cardLast4");

    // If quantity was passed, otherwise default = 1
    Integer quantity = (Integer) request.getAttribute("quantity");
    if (quantity == null) {
        quantity = 1;
    }

    java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm");
    String paymentDate = sdf.format(new java.util.Date());

    // ✅ Get logged-in user details from session
    String loggedAccountNumber = (String) session.getAttribute("accountNumber");
    String loggedFullName = (String) session.getAttribute("user");
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Invoice - Payment Successful</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                background: #f8f9fa;
                padding: 40px;
            }
            .invoice-box {
                max-width: 700px;
                margin: auto;
                background: white;
                padding: 30px;
                border-radius: 10px;
                box-shadow: 0 4px 8px rgba(0,0,0,0.1);
                font-size: 15px;
                color: #555;
            }
            .invoice-box h2 {
                color: #28a745;
                text-align: center;
                font-weight: bold;
            }
            .invoice-box table {
                width: 100%;
                border-collapse: collapse;
            }
            .invoice-box table th {
                background: #007bff;
                color: white;
                text-align: center;
                padding: 10px;
            }
            .invoice-box table td {
                padding: 8px;
                border-bottom: 1px solid #ddd;
            }
            .text-right {
                text-align: right;
            }
            .text-center {
                text-align: center;
            }
            .invoice-footer {
                text-align: center;
                margin-top: 20px;
                font-size: 14px;
                color: #666;
            }
            .btn-container {
                text-align: center;
                margin-top: 20px;
            }
            .btn-custom {
                background: #007bff;
                color: white;
                padding: 10px 20px;
                border: none;
                border-radius: 6px;
                font-size: 16px;
                cursor: pointer;
                margin: 10px;
            }
            .btn-custom:hover {
                background: #0056b3;
            }
            @media print {
                .btn-container {
                    display: none;
                }
                body {
                    background: white;
                }
            }
        </style>
    </head>
    <body>

        <div class="invoice-box" id="invoiceContent">
            <h2>✅ Payment Successful</h2>
            <hr>

            <!-- ✅ Header Info -->
            <div class="row mb-3">
                <div class="col-md-6">
                    <strong>Bookshop:</strong> Pahana Edu Bookshop<br>
                    <strong>Date:</strong> <%= paymentDate%><br><br>

                    <!-- ✅ Customer name & account on one row -->
                    <strong>Customer:</strong>
                    <%= (loggedFullName != null ? loggedFullName : "Guest User")%> 
                    (<%= loggedAccountNumber != null ? loggedAccountNumber : "-"%>)
                </div>

                <div class="col-md-6 text-end">
                    <strong>Paid with Card:</strong> <%= cardLast4%><br>
                </div>
            </div>

            <!-- ✅ Invoice Table -->
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Book Title</th>
                        <th>Author</th>
                        <th class="text-center">Qty</th>
                        <th class="text-right">Price (Rs.)</th>
                        <th class="text-right">Total (Rs.)</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>1</td>
                        <td><%= book.getTitle()%></td>
                        <td><%= book.getAuthor()%></td>
                        <td class="text-center"><%= quantity%></td>
                        <td class="text-right"><%= String.format("%.2f", book.getPricePerUnit())%></td>
                        <td class="text-right"><%= String.format("%.2f", amount)%></td>
                    </tr>
                </tbody>
                <tfoot>
                    <tr>
                        <td colspan="5" class="text-end"><strong>Grand Total:</strong></td>
                        <td class="text-right"><strong><%= String.format("%.2f", amount)%></strong></td>
                    </tr>
                </tfoot>
            </table>

            <!-- ✅ Footer -->
            <div class="invoice-footer">
                <p>Thank you for your purchase! 😊</p>
            </div>
        </div>

        <!-- ✅ Action Buttons -->
        <div class="btn-container">
            <button class="btn-custom" onclick="window.print()">🖨️ Print Invoice</button>
            <a href="GetBooksServlet"><button class="btn-custom">🏠 Back to Home</button></a>
        </div>

    </body>
</html>
