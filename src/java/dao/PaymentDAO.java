package dao;

import java.sql.*;

public class PaymentDAO {

    private static final String JDBC_URL = "jdbc:mysql://localhost:3308/billing_system";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "";

    private static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
    }

    public static boolean savePayment(int bookId, String cardLast4, int quantity, double amount) {
        String sql = "INSERT INTO payments (bookId, cardNumber, quantity, amount) VALUES (?, ?, ?, ?)";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, bookId);
            stmt.setString(2, cardLast4);
            stmt.setInt(3, quantity);
            stmt.setDouble(4, amount);

            int rows = stmt.executeUpdate();
            return rows > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
