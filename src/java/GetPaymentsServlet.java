import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import model.Payment;

@WebServlet("/GetPaymentsServlet")
public class GetPaymentsServlet extends HttpServlet {

    private static final String JDBC_URL = "jdbc:mysql://localhost:3308/billing_system";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Payment> payments = new ArrayList<>();

        String query =
            "SELECT p.payment_id, p.bookId, b.title AS book_title, " +
            "p.cardNumber, p.quantity, p.amount, p.payment_date " +
            "FROM payments p " +
            "JOIN books b ON p.bookId = b.bookId " +
            "ORDER BY p.payment_date DESC";

        try (Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Payment payment = new Payment(
                        rs.getInt("payment_id"),
                        rs.getInt("bookId"),
                        rs.getString("book_title"),
                        rs.getString("cardNumber"),
                        rs.getInt("quantity"),
                        rs.getDouble("amount"),
                        rs.getTimestamp("payment_date").toString()
                );
                payments.add(payment);
            }

            request.setAttribute("payments", payments);
            request.getRequestDispatcher("Admin/payments.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp?error=db_error");
        }
    }
}