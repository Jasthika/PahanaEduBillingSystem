package model;

public class Payment {
    private int paymentId;
    private int bookId;
    private String bookTitle;
    private String cardNumber;
    private int quantity;
    private double amount;
    private String paymentDate;

    public Payment(int paymentId, int bookId, String bookTitle, String cardNumber,
                   int quantity, double amount, String paymentDate) {
        this.paymentId = paymentId;
        this.bookId = bookId;
        this.bookTitle = bookTitle;
        this.cardNumber = cardNumber;
        this.quantity = quantity;
        this.amount = amount;
        this.paymentDate = paymentDate;
    }

    public int getPaymentId() { return paymentId; }
    public int getBookId() { return bookId; }
    public String getBookTitle() { return bookTitle; }
    public String getCardNumber() { return cardNumber; }
    public int getQuantity() { return quantity; }
    public double getAmount() { return amount; }
    public String getPaymentDate() { return paymentDate; }
}
