<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Book" %>

<%
    List<Book> books = (List<Book>) request.getAttribute("books");
    if (books == null) {
        books = new java.util.ArrayList<>();
    }
    int maxDisplay = 6;
    List<Book> displayBooks = books.subList(0, Math.min(maxDisplay, books.size()));
%>

<section id="books" class="py-20 bg-gray-50">
    <div class="container mx-auto px-4 sm:px-6 lg:px-8">

        <!-- Header -->
        <div class="text-center mb-8">
            <h2 class="text-4xl lg:text-5xl font-bold text-blue-900 mb-3">
                Discover Your Next 
                <span class="bg-gradient-to-r from-blue-500 to-purple-500 bg-clip-text text-transparent">
                    Great Read
                </span>
            </h2>
            <p class="text-lg text-gray-600 max-w-3xl mx-auto leading-relaxed">
                From academic textbooks to engaging children's stories, find exactly what you need 
                to fuel your learning journey. All books are carefully selected for quality and relevance.
            </p>
        </div>

        <!-- Books Grid -->
        <div id="booksGrid" class="grid md:grid-cols-2 lg:grid-cols-3 gap-8">
            <% if (displayBooks.size() > 0) {
                    for (Book book : displayBooks) {
            %>
            <div class="group overflow-hidden bg-white border border-gray-200 rounded-xl shadow-md hover:shadow-xl transition-all duration-300 hover:-translate-y-2 book-card">

                <!-- Book Image -->
                <div class="relative bg-gray-50">
                    <img src="uploads/books/<%= book.getImage()%>" 
                         alt="<%= book.getTitle()%>" 
                         class="w-full h-48 object-contain p-3 group-hover:scale-105 transition-transform duration-300" />

                    <div class="absolute top-3 right-3 bg-white/80 backdrop-blur-sm px-2 py-1 rounded-lg text-sm text-blue-800 flex items-center space-x-1 shadow">
                        <i class="fas fa-star text-yellow-500"></i>
                        <span>4.5</span>
                    </div>
                </div>

                <!-- Book Info -->
                <div class="p-6 space-y-2 text-left">
                    <h3 class="text-lg font-semibold text-blue-900 group-hover:text-blue-600 transition-colors">
                        <%= book.getTitle()%>
                    </h3>
                    <p class="text-gray-500 text-sm">by <%= book.getAuthor()%></p>
                    <p class="text-gray-600 text-sm line-clamp-2"><%= book.getDescription()%></p>

                    <div class="flex items-center justify-between mt-4">
                        <span class="text-2xl font-bold text-blue-800">
                            Rs. <%= book.getPricePerUnit()%>
                        </span>
                        <a href="payment.jsp?bookId=<%= book.getBookId()%>" 
                           class="bg-blue-700 hover:bg-blue-800 text-white text-sm px-5 py-2 rounded-lg shadow-md transition">
                            Pay Now
                        </a>
                    </div>
                </div>
            </div>
            <% }
            } else { %>
            <div class="col-span-full text-center py-12">
                <i class="fas fa-book-open text-gray-400 text-5xl mb-4"></i>
                <h3 class="text-xl font-semibold text-gray-500 mb-2">No books found</h3>
                <p class="text-gray-400">Try adjusting your search terms.</p>
            </div>
            <% } %>
        </div>

        <!-- Show More -->
        <% if (books.size() > maxDisplay) {%>
        <div class="mt-10 text-center">
            <a href="<%= request.getContextPath()%>/AllBooksServlet"
               class="bg-gray-200 hover:bg-gray-300 text-blue-900 font-semibold py-2 px-6 rounded-full transition">
                Show More
            </a>
        </div>
        <% }%>

    </div>
</section>

<!-- JS Filter -->
<script>
    function filterBooks() {
        const searchValue = document.getElementById("bookSearch").value.toLowerCase();
        const cards = document.querySelectorAll(".book-card");

        cards.forEach(card => {
            const title = card.querySelector("h3").textContent.toLowerCase();
            const author = card.querySelector("p").textContent.toLowerCase();

            if (title.includes(searchValue) || author.includes(searchValue)) {
                card.style.display = "block";
            } else {
                card.style.display = "none";
            }
        });
    }
</script>
