import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.*;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    private static final String JDBC_URL = "jdbc:mysql://localhost:3308/billing_system";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accountNumber = request.getParameter("accountNumber");
        String password = request.getParameter("password");

        String adminAccount = "admin";
        String adminPassword = "admin";

        try {
            // ✅ Admin login
            if (accountNumber.equals(adminAccount) && password.equals(adminPassword)) {
                HttpSession session = request.getSession();
                session.setAttribute("user", adminAccount);
                session.setAttribute("role", "admin");
                response.sendRedirect("Admin/dashboard.jsp");
                return;
            }

            // ✅ DB connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);

            String query = "SELECT * FROM customer_accounts WHERE accountNumber = ? AND password = ?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, accountNumber);
            stmt.setString(2, password);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                // ✅ Success → create session
                HttpSession session = request.getSession();
                session.setAttribute("user", rs.getString("name"));
                session.setAttribute("accountNumber", rs.getString("accountNumber"));
                session.setAttribute("role", "customer");

                // ✅ Redirect to GetBooksServlet (will forward to index.jsp)
                response.sendRedirect(request.getContextPath() + "/GetBooksServlet");

            } else {
                // ❌ Invalid login → forward back with error
                request.setAttribute("error", "Invalid Account Number or Password!");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }

            rs.close();
            stmt.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Something went wrong! Please try again.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
