import dao.BookDAO;
import dao.PaymentDAO;
import model.Book;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/ProcessPaymentServlet")
public class ProcessPaymentServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String bookIdParam = request.getParameter("bookId");
        String quantityParam = request.getParameter("quantity");  // get quantity
        String cardNumber = request.getParameter("cardNumber");
        String expiry = request.getParameter("expiry");
        String cvv = request.getParameter("cvv");

        if (bookIdParam == null || bookIdParam.trim().isEmpty()) {
            request.setAttribute("error", "Invalid payment request. Book not specified.");
            request.getRequestDispatcher("paymentError.jsp").forward(request, response);
            return;
        }

        int bookId;
        try {
            bookId = Integer.parseInt(bookIdParam);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid book ID.");
            request.getRequestDispatcher("paymentError.jsp").forward(request, response);
            return;
        }

        Book book = BookDAO.getBookById(bookId);
        if (book == null) {
            request.setAttribute("error", "Book not found. Payment failed.");
            request.getRequestDispatcher("paymentError.jsp").forward(request, response);
            return;
        }

        // Validate quantity
        int quantity = 1; // default
        try {
            quantity = Integer.parseInt(quantityParam);
            if (quantity < 1) quantity = 1; // enforce minimum
        } catch (Exception e) {
            quantity = 1; // fallback default
        }

        // Validate card details (basic)
        boolean paymentValid = cardNumber != null && cardNumber.matches("\\d{16}")
                && expiry != null && expiry.matches("(0[1-9]|1[0-2])/\\d{2}")
                && cvv != null && cvv.matches("\\d{3}");

        if (!paymentValid) {
            request.setAttribute("error", "Payment failed! Invalid card details.");
            request.getRequestDispatcher("paymentError.jsp").forward(request, response);
            return;
        }

        // Simulate payment success
        String cardLast4 = "****" + cardNumber.substring(cardNumber.length() - 4);
        double amount = book.getPricePerUnit() * quantity;  // total price = unit price * quantity

        // Save payment (update your DAO method if needed to include quantity)
        boolean saved = PaymentDAO.savePayment(bookId, cardLast4, quantity, amount);

        if (saved) {
            // Pass data to success JSP
            request.setAttribute("book", book);
            request.setAttribute("quantity", quantity);
            request.setAttribute("amount", amount);
            request.setAttribute("cardLast4", cardLast4);
            request.getRequestDispatcher("paymentSuccess.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Payment failed! Could not save transaction.");
            request.getRequestDispatcher("paymentError.jsp").forward(request, response);
        }
    }
}
