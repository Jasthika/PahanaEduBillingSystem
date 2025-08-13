package dao;
import model.Book;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookDAO {

    private static final String JDBC_URL = "jdbc:mysql://localhost:3308/billing_system"; 
    private static final String JDBC_USER = "root";    
    private static final String JDBC_PASSWORD = "";    
    // ✅ Utility method to get a DB connection
    private static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
    }
    // ✅ Fetch all books
    public static List<Book> getAllBooks() {
        List<Book> books = new ArrayList<>();
        String sql = "SELECT * FROM books";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Book book = new Book();
                book.setBookId(rs.getInt("bookId"));                
                book.setTitle(rs.getString("title"));
                book.setAuthor(rs.getString("author"));
                book.setPricePerUnit(rs.getDouble("pricePerUnit")); 
                book.setDescription(rs.getString("description"));
                book.setImage(rs.getString("image"));
                books.add(book);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return books;
    }

    // ✅ Fetch a single book by ID
    public static Book getBookById(int id) {
        String sql = "SELECT * FROM books WHERE bookId = ?";
        Book book = null;

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    book = new Book();
                    book.setBookId(rs.getInt("bookId"));                 
                    book.setTitle(rs.getString("title"));
                    book.setAuthor(rs.getString("author"));
                    book.setPricePerUnit(rs.getDouble("pricePerUnit"));  
                    book.setDescription(rs.getString("description"));
                    book.setImage(rs.getString("image"));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return book;
    }
}
