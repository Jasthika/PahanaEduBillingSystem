import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.*;

@WebServlet("/CustomersServlet")
public class CustomersServlet extends HttpServlet {

    private static final String JDBC_URL = "jdbc:mysql://localhost:3308/billing_system";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        switch (action) {
            case "save":
                saveCustomer(request, response);
                break;
            case "edit":
                editCustomer(request, response);
                break;
            default:
                response.sendRedirect("Admin/customers.jsp?error=invalid_action");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("delete".equals(action)) {
            deleteCustomer(request, response);
        } else {
            response.sendRedirect("Admin/customers.jsp");
        }
    }

    // ✅ SAVE CUSTOMER (with password)
    private void saveCustomer(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String accountNumber = request.getParameter("accountNumber");
        String name = request.getParameter("name");
        String address = request.getParameter("address");
        String telephone = request.getParameter("telephone");
        String password = request.getParameter("password");  // ✅ NEW: Get password

        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);

            // ✅ Now insert password too
            String query = "INSERT INTO customer_accounts (accountNumber, name, address, telephone, password) "
                    + "VALUES (?, ?, ?, ?, ?)";
            stmt = conn.prepareStatement(query);
            stmt.setString(1, accountNumber);
            stmt.setString(2, name);
            stmt.setString(3, address);
            stmt.setString(4, telephone);
            stmt.setString(5, password);

            int rows = stmt.executeUpdate();
            if (rows > 0) {
                response.sendRedirect("Admin/customers.jsp?success=saved");
            } else {
                response.sendRedirect("Admin/customers.jsp?error=db_error");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("Admin/customers.jsp?error=exception");
        } finally {
            closeConnection(conn, stmt, null);
        }
    }

    // ✅ EDIT CUSTOMER (with password)
    private void editCustomer(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int customerId = Integer.parseInt(request.getParameter("customerId"));
        String accountNumber = request.getParameter("accountNumber");
        String name = request.getParameter("name");
        String address = request.getParameter("address");
        String telephone = request.getParameter("telephone");
        String password = request.getParameter("password"); // ✅ NEW: Get updated password
        Connection conn = null;
        PreparedStatement stmt = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
            // ✅ Update password as well
            String query = "UPDATE customer_accounts SET accountNumber=?, name=?, address=?, telephone=?, "
                    + "password=? WHERE customerId=?";
            stmt = conn.prepareStatement(query);
            stmt.setString(1, accountNumber);
            stmt.setString(2, name);
            stmt.setString(3, address);
            stmt.setString(4, telephone);
            stmt.setString(5, password);
            stmt.setInt(6, customerId);

            int rows = stmt.executeUpdate();
            if (rows > 0) {
                response.sendRedirect("Admin/customers.jsp?success=updated");
            } else {
                response.sendRedirect("Admin/customers.jsp?error=db_error");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("Admin/customers.jsp?error=exception");
        } finally {
            closeConnection(conn, stmt, null);
        }
    }

    // ✅ DELETE CUSTOMER (no changes)
    private void deleteCustomer(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int customerId = Integer.parseInt(request.getParameter("customerId"));

        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);

            String query = "DELETE FROM customer_accounts WHERE customerId=?";
            stmt = conn.prepareStatement(query);
            stmt.setInt(1, customerId);

            int rows = stmt.executeUpdate();
            if (rows > 0) {
                response.sendRedirect("Admin/customers.jsp?success=deleted");
            } else {
                response.sendRedirect("Admin/customers.jsp?error=db_error");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("Admin/customers.jsp?error=exception");
        } finally {
            closeConnection(conn, stmt, null);
        }
    }

    // ✅ Close DB Resources
    private void closeConnection(Connection conn, PreparedStatement stmt, ResultSet rs) {
        try {
            if (rs != null) {
                rs.close();
            }
            if (stmt != null) {
                stmt.close();
            }
            if (conn != null) {
                conn.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
