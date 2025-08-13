<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.text.SimpleDateFormat" %>

<%
    String billIdParam = request.getParameter("billId");
    int billId = (billIdParam != null) ? Integer.parseInt(billIdParam) : 0;

    String customerName = "";
    String accountNumber = "";
    String billDate = "";
    double totalAmount = 0.0;

    // Bill items class
    class BillItem {

        String title;
        double price;
        int quantity;
        double amount;
    }
    java.util.List<BillItem> billItems = new java.util.ArrayList<>();

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3308/billing_system", "root", "");

        // Fetch bill & customer info
        String sqlBill = "SELECT b.billDate, b.totalAmount, c.name, c.accountNumber "
                + "FROM bills b JOIN customer_accounts c ON b.customerId = c.customerId "
                + "WHERE b.billId=?";
        PreparedStatement psBill = conn.prepareStatement(sqlBill);
        psBill.setInt(1, billId);
        ResultSet rsBill = psBill.executeQuery();
        if (rsBill.next()) {
            customerName = rsBill.getString("name");
            accountNumber = rsBill.getString("accountNumber");
            java.sql.Timestamp ts = rsBill.getTimestamp("billDate");
            billDate = new SimpleDateFormat("yyyy-MM-dd HH:mm").format(ts);
            totalAmount = rsBill.getDouble("totalAmount");
        }
        rsBill.close();
        psBill.close();

        // Fetch purchased books from bill_details joined with books
        String sqlItems = "SELECT bd.quantity, bk.pricePerUnit, (bd.quantity * bk.pricePerUnit) AS amount, bk.title "
                + "FROM bill_details bd JOIN books bk ON bd.bookId = bk.bookId WHERE bd.billId=?";
        PreparedStatement psItems = conn.prepareStatement(sqlItems);
        psItems.setInt(1, billId);
        ResultSet rsItems = psItems.executeQuery();
        while (rsItems.next()) {
            BillItem item = new BillItem();
            item.title = rsItems.getString("title");
            item.price = rsItems.getDouble("pricePerUnit");
            item.quantity = rsItems.getInt("quantity");
            item.amount = rsItems.getDouble("amount");
            billItems.add(item);
        }
        rsItems.close();
        psItems.close();

        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Bill #<%= billId%></title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                background: #fff;
                padding: 20px;
            }
            .invoice-box {
                max-width: 800px;
                margin: auto;
                border: 1px solid #eee;
                padding: 30px;
                font-size: 14px;
                line-height: 1.5;
                color: #555;
            }
            .invoice-box table {
                width: 100%;
                line-height: inherit;
                text-align: left;
            }
            .invoice-box table td {
                padding: 5px;
                vertical-align: top;
            }
            .invoice-box table th {
                background: #007bff;
                color: white;
                text-align: center;
            }
            .text-right {
                text-align: right;
            }
            .print-btn {
                display: block;
                margin: 20px auto;
            }
            @media print {
                .print-btn {
                    display: none;
                }
                body {
                    background: white;
                }
            }
        </style>
    </head>
    <body>

        <div class="invoice-box">
            <h2 class="text-center">Pahana Edu Bookshop</h2>
            <p class="text-center">Invoice for Bill #<%= billId%></p>

            <hr>

            <div class="row">
                <div class="col-md-6">
                    <strong>Customer Name:</strong> <%= customerName%><br>
                    <strong>Account No:</strong> <%= accountNumber%>
                </div>
                <div class="col-md-6 text-end">
                    <strong>Date:</strong> <%= billDate%>
                </div>
            </div>

            <hr>

            <table class="table table-bordered mt-3">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Book Title</th>
                        <th class="text-right">Price/Unit (Rs.)</th>
                        <th class="text-center">Qty</th>
                        <th class="text-right">Amount (Rs.)</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        int idx = 1;
                        for (BillItem item : billItems) {
                    %>
                    <tr>
                        <td><%= idx++%></td>
                        <td><%= item.title%></td>
                        <td class="text-right"><%= String.format("%.2f", item.price)%></td>
                        <td class="text-center"><%= item.quantity%></td>
                        <td class="text-right"><%= String.format("%.2f", item.amount)%></td>
                    </tr>
                    <% }%>
                </tbody>
                <tfoot>
                    <tr>
                        <td colspan="4" class="text-end"><strong>Total:</strong></td>
                        <td class="text-right"><strong><%= String.format("%.2f", totalAmount)%></strong></td>
                    </tr>
                </tfoot>
            </table>

            <p class="text-center mt-4">Thank you for your purchase!</p>
        </div>

        <!-- Print Button -->
        <button class="btn btn-primary print-btn" onclick="window.print()">
            <i class="fas fa-print"></i> Print Invoice
        </button>

        <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/js/all.min.js"></script>
    </body>
</html>
