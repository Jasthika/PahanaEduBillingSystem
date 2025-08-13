import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Book; 

@WebServlet("/AllBooksServlet")
public class AllBooksServlet extends HttpServlet {

    private static final String JDBC_URL = "jdbc:mysql://localhost:3308/billing_system";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Book> books = new ArrayList<>();

        try {
            // ✅ Load MySQL driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            try (Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
                 PreparedStatement stmt = conn.prepareStatement(
                         "SELECT bookId, title, author, description, pricePerUnit, image FROM books ORDER BY bookId DESC"
                 );
                 ResultSet rs = stmt.executeQuery()) {

                while (rs.next()) {
                    Book book = new Book();
                    book.setBookId(rs.getInt("bookId"));
                    book.setTitle(rs.getString("title"));
                    book.setAuthor(rs.getString("author"));
                    book.setDescription(rs.getString("description"));
                    book.setPricePerUnit(rs.getDouble("pricePerUnit"));
                    book.setImage(rs.getString("image"));
                    books.add(book);
                }

            }

            // ✅ Send books list to JSP
            request.setAttribute("books", books);
            request.getRequestDispatcher("allBooks.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            // Print the exact DB error for debugging
            response.getWriter().println("<h3>Database Error:</h3><pre>" + e.getMessage() + "</pre>");
        }
    }
}
