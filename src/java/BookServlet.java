import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.sql.*;

@WebServlet("/BookServlet")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class BookServlet extends HttpServlet {

    private static final String JDBC_URL = "jdbc:mysql://localhost:3308/billing_system";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "";

    // Directory where images will be saved, relative to your webapp root folder.
    // Change this if needed.
    private static final String UPLOAD_DIR = "uploads/books";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        switch (action) {
            case "save":
                saveBook(request, response);
                break;
            case "edit":
                editBook(request, response);
                break;
            default:
                response.sendRedirect("Admin/items.jsp?error=invalid_action");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if ("delete".equals(action)) {
            deleteBook(request, response);
        } else {
            response.sendRedirect("Admin/items.jsp");
        }
    }

    private void saveBook(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        String priceStr = request.getParameter("pricePerUnit");
        String quantityStr = request.getParameter("quantityInStock");
        String description = request.getParameter("description");

        double price = Double.parseDouble(priceStr);
        int quantity = Integer.parseInt(quantityStr);

        // Handle image upload
        Part imagePart = request.getPart("bookImage");
        String imageFileName = null;

        if (imagePart != null && imagePart.getSize() > 0) {
            imageFileName = extractFileName(imagePart);
            imageFileName = System.currentTimeMillis() + "_" + imageFileName; // make filename unique
            String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;

            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            File file = new File(uploadDir, imageFileName);
            try (InputStream input = imagePart.getInputStream()) {
                Files.copy(input, file.toPath());
            } catch (IOException e) {
                e.printStackTrace();
                response.sendRedirect("Admin/items.jsp?error=file_upload_failed");
                return;
            }
        }

        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);

            String sql = "INSERT INTO books (title, author, pricePerUnit, quantityInStock, description, image) VALUES (?, ?, ?, ?, ?, ?)";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, title);
            stmt.setString(2, author);
            stmt.setDouble(3, price);
            stmt.setInt(4, quantity);
            stmt.setString(5, description);
            stmt.setString(6, imageFileName);

            int rows = stmt.executeUpdate();
            if (rows > 0) {
                response.sendRedirect("Admin/items.jsp?success=saved");
            } else {
                response.sendRedirect("Admin/items.jsp?error=db_error");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("Admin/items.jsp?error=exception");
        } finally {
            closeConnection(conn, stmt, null);
        }
    }

    private void editBook(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        int bookId = Integer.parseInt(request.getParameter("bookId"));
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        double price = Double.parseDouble(request.getParameter("pricePerUnit"));
        int quantity = Integer.parseInt(request.getParameter("quantityInStock"));
        String description = request.getParameter("description");

        Connection conn = null;
        PreparedStatement stmt = null;

        // Handle image upload
        Part imagePart = request.getPart("bookImage");
        String imageFileName = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);

            if (imagePart != null && imagePart.getSize() > 0) {
                // Upload new image
                imageFileName = extractFileName(imagePart);
                imageFileName = System.currentTimeMillis() + "_" + imageFileName;
//                String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
                String uploadPath = getServletContext().getRealPath("/") + UPLOAD_DIR;

                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }

                File file = new File(uploadDir, imageFileName);
                try (InputStream input = imagePart.getInputStream()) {
                    Files.copy(input, file.toPath());
                } catch (IOException e) {
                    e.printStackTrace();
                    response.sendRedirect("Admin/items.jsp?error=file_upload_failed");
                    return;
                }

                // Update all fields including new image
                String sql = "UPDATE books SET title=?, author=?, pricePerUnit=?, quantityInStock=?, description=?, image=? WHERE bookId=?";
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, title);
                stmt.setString(2, author);
                stmt.setDouble(3, price);
                stmt.setInt(4, quantity);
                stmt.setString(5, description);
                stmt.setString(6, imageFileName);
                stmt.setInt(7, bookId);
            } else {
                // No new image uploaded, keep existing image
                String sql = "UPDATE books SET title=?, author=?, pricePerUnit=?, quantityInStock=?, description=? WHERE bookId=?";
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, title);
                stmt.setString(2, author);
                stmt.setDouble(3, price);
                stmt.setInt(4, quantity);
                stmt.setString(5, description);
                stmt.setInt(6, bookId);
            }

            int rows = stmt.executeUpdate();
            if (rows > 0) {
                response.sendRedirect("Admin/items.jsp?success=updated");
            } else {
                response.sendRedirect("Admin/items.jsp?error=db_error");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("Admin/items.jsp?error=exception");
        } finally {
            closeConnection(conn, stmt, null);
        }
    }

    private void deleteBook(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int bookId = Integer.parseInt(request.getParameter("bookId"));

        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);

            // Optional: Delete image file from disk before deleting DB record (not implemented here)
            String sql = "DELETE FROM books WHERE bookId=?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, bookId);

            int rows = stmt.executeUpdate();
            if (rows > 0) {
                response.sendRedirect("Admin/items.jsp?success=deleted");
            } else {
                response.sendRedirect("Admin/items.jsp?error=db_error");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("Admin/items.jsp?error=exception");
        } finally {
            closeConnection(conn, stmt, null);
        }
    }

    // Utility method to extract filename from Part header
    private String extractFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] items = contentDisp.split(";");
        for (String s : items) {
            if (s.trim().startsWith("filename")) {
                String filename = s.substring(s.indexOf('=') + 1).trim().replace("\"", "");
                return filename.substring(filename.lastIndexOf(File.separator) + 1);
            }
        }
        return null;
    }

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
