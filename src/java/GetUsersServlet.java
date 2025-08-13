import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/GetUsersServlet")
public class GetUsersServlet extends HttpServlet {

    private static final String JDBC_URL = "jdbc:mysql://localhost:3308/billing_system";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<User> users = new ArrayList<>();

        try (Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
             PreparedStatement stmt = conn.prepareStatement("SELECT id, username, role, created_at FROM users ORDER BY created_at DESC");
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                User user = new User(
                        rs.getInt("id"),
                        rs.getString("username"),
                        rs.getString("role"),
                        rs.getString("created_at")
                );
                users.add(user);
            }

            request.setAttribute("users", users);
            request.getRequestDispatcher("Admin/user.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp?error=db_error");
        }
    }

    public static class User {
        private int id;
        private String username;
        private String role;
        private String createdAt;

        public User(int id, String username, String role, String createdAt) {
            this.id = id;
            this.username = username;
            this.role = role;
            this.createdAt = createdAt;
        }

        public int getId() { return id; }
        public String getUsername() { return username; }
        public String getRole() { return role; }
        public String getCreatedAt() { return createdAt; }
    }
}
