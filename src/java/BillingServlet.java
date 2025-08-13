import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.*;

@WebServlet("/BillingServlet")
public class BillingServlet extends HttpServlet {

    private static final String JDBC_URL = "jdbc:mysql://localhost:3308/billing_system";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("save".equals(action)) {
            saveBill(request, response);
        } else {
            response.sendRedirect("Admin/billing.jsp?error=invalid_action");
        }
    }

    private void saveBill(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String customerIdStr = request.getParameter("customerId");
        String totalAmountStr = request.getParameter("totalAmount");

        if (customerIdStr == null || totalAmountStr == null) {
            response.sendRedirect("Admin/billing.jsp?error=missing_data");
            return;
        }

        int customerId;
        double totalAmount;
        try {
            customerId = Integer.parseInt(customerIdStr);
            totalAmount = Double.parseDouble(totalAmountStr);
        } catch (NumberFormatException e) {
            response.sendRedirect("Admin/billing.jsp?error=invalid_number_format");
            return;
        }

        String[] bookIds = request.getParameterValues("bookId");
        String[] quantities = request.getParameterValues("quantity");

        if (bookIds == null || quantities == null || bookIds.length != quantities.length || bookIds.length == 0) {
            response.sendRedirect("Admin/billing.jsp?error=invalid_books");
            return;
        }

        Connection conn = null;
        PreparedStatement billStmt = null;
        PreparedStatement detailStmt = null;
        ResultSet generatedKeys = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
            conn.setAutoCommit(false); // start transaction

            // Insert into bills table
            String insertBillSQL = "INSERT INTO bills (customerId, totalAmount, billDate) VALUES (?, ?, NOW())";
            billStmt = conn.prepareStatement(insertBillSQL, Statement.RETURN_GENERATED_KEYS);
            billStmt.setInt(1, customerId);
            billStmt.setDouble(2, totalAmount);
            int affectedRows = billStmt.executeUpdate();

            if (affectedRows == 0) {
                throw new SQLException("Creating bill failed, no rows affected.");
            }

            generatedKeys = billStmt.getGeneratedKeys();
            if (!generatedKeys.next()) {
                throw new SQLException("Creating bill failed, no ID obtained.");
            }

            int billId = generatedKeys.getInt(1);

            // Insert into bill_details table
            String insertDetailSQL = "INSERT INTO bill_details (billId, bookId, quantity) VALUES (?, ?, ?)";
            detailStmt = conn.prepareStatement(insertDetailSQL);

            for (int i = 0; i < bookIds.length; i++) {
                int bookId = Integer.parseInt(bookIds[i]);
                int qty = Integer.parseInt(quantities[i]);

                detailStmt.setInt(1, billId);
                detailStmt.setInt(2, bookId);
                detailStmt.setInt(3, qty);
                detailStmt.addBatch();
            }
            detailStmt.executeBatch();

            conn.commit();

            response.sendRedirect("Admin/billing.jsp?success=Bill generated successfully");
        } catch (Exception e) {
            e.printStackTrace();
            if (conn != null) {
                try { conn.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
            }
            response.sendRedirect("Admin/billing.jsp?error=exception_occurred");
        } finally {
            try {
                if (generatedKeys != null) generatedKeys.close();
                if (billStmt != null) billStmt.close();
                if (detailStmt != null) detailStmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
