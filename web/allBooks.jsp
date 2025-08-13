<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Book" %>

<%
    List<Book> books = (List<Book>) request.getAttribute("books");
    if (books == null)
        books = new java.util.ArrayList<>();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>All Books - Pahana Edu Bookshop</title>

    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>

    <!-- FontAwesome CDN -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/js/all.min.js" crossorigin="anonymous"></script>

    <!-- Custom Styles -->
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, sans-serif;
            background-color: #f4f7ff;
        }

        .star-rating {
            color: #facc15;
        }

        .line-clamp-2 {
            overflow: hidden;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
        }
    </style>
</head>
<body class="py-10 px-4 bg-gray-50">

    <div class="max-w-7xl mx-auto">
        <h2 class="text-3xl font-bold text-blue-900 text-center mb-2">📚 All Books</h2>
        <p class="text-center text-slate-600 mb-8">
            Browse our collection of educational resources carefully curated for every learner.
        </p>

        <!-- Books Grid -->
        <div class="grid gap-6 grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4">
            <% if (!books.isEmpty()) {
                for (Book book : books) {
            %>
            <div class="bg-white rounded-2xl shadow-md hover:shadow-xl transition-all duration-200 overflow-hidden flex flex-col">
                <!-- Image -->
                <div class="relative bg-gray-100 flex items-center justify-center h-40 p-3">
                    <img src="uploads/books/<%= book.getImage() %>" 
                         alt="<%= book.getTitle() %>" 
                         class="max-h-full max-w-full object-contain" />
                    <div class="absolute top-2 right-2 bg-white px-2 py-0.5 rounded-full flex items-center text-xs font-semibold shadow star-rating">
                        <i class="fa-solid fa-star mr-1"></i> 4.5
                    </div>
                </div>

                <!-- Book Details -->
                <div class="p-4 flex flex-col justify-between flex-grow">
                    <div>
                        <h3 class="text-blue-800 font-semibold text-lg mb-1">
                            <%= book.getTitle() %>
                        </h3>
                        <p class="text-sm text-slate-500 italic">by <%= book.getAuthor() %></p>
                        <p class="text-slate-600 text-sm mt-2 line-clamp-2">
                            <%= book.getDescription() %>
                        </p>
                    </div>
                    <div class="flex justify-between items-center mt-4">
                        <span class="text-blue-700 font-bold text-base">
                            Rs. <%= book.getPricePerUnit() %>
                        </span>
                        <a href="payment.jsp?bookId=<%= book.getBookId() %>" 
                           class="bg-blue-600 hover:bg-blue-700 text-white px-4 py-1.5 rounded-full text-sm font-medium transition">
                            Pay Now
                        </a>
                    </div>
                </div>
            </div>
            <% }
            } else { %>
            <p class="text-center text-slate-500 col-span-full">No books available at the moment.</p>
            <% } %>
        </div>
    </div>

</body>
</html>
