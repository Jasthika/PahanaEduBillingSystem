<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>Header - Pahana Edu Bookshop</title>

        <!-- ✅ Tailwind CSS CDN -->
        <script src="https://cdn.tailwindcss.com"></script>

        <!-- ✅ Font Awesome CDN for icons -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/js/all.min.js"></script>
    </head>
    <body>

        <!-- ✅ FIXED NAVBAR -->
        <nav class="fixed top-0 left-0 w-full z-50 shadow-md bg-white">
            <div class="max-w-7xl mx-auto flex justify-between items-center px-6 h-20">

                <!-- ✅ Logo goes to Home (Servlet) -->
                <a href="GetBooksServlet" class="flex items-center gap-4 text-2xl font-bold text-blue-900 hover:opacity-90 transition">
                    <img src="images/book.png" alt="Pahana Edu Bookshop Logo" class="w-12 h-12" />
                    <span>Pahana Edu Bookshop</span>
                </a>

                <!-- ✅ Navigation Links -->
                <div class="flex items-center space-x-8 text-blue-900 font-semibold">

                    <!-- ✅ Home → Servlet -->
                    <a href="GetBooksServlet" class="hover:text-blue-600 transition">Home</a>

                    <!-- ✅ About → About page -->
                    <a href="aboutus.jsp" class="hover:text-blue-600 transition">About</a>

                    <!-- ✅ Books → Servlet (so it always fetches latest books) -->
                    <a href="GetBooksServlet" class="hover:text-blue-600 transition">Books</a>

                    <!-- ✅ Contact → Contact page -->
                    <a href="contactus.jsp" class="hover:text-blue-600 transition">Contact</a>

                    <!-- ✅ Show Login or Logged-in User -->
                    <%
                        String accountNumber = (String) session.getAttribute("accountNumber");
                        if (accountNumber == null) {
                    %>
                    <!-- If NOT logged in -->
                    <a href="login.jsp" class="bg-yellow-400 hover:bg-yellow-500 text-white px-4 py-2 rounded-md transition">
                        Login
                    </a>
                    <%
                    } else {
                    %>
                    <!-- If logged in -->
                    <div class="flex items-center space-x-2">
                        <i class="fas fa-user-circle text-xl text-blue-700"></i>
                        <span class="text-sm font-medium"><%= accountNumber%></span>
                        <a href="LogoutServlet" class="text-red-500 ml-2 hover:text-red-600 transition">
                            <i class="fas fa-sign-out-alt"></i>
                        </a>
                    </div>
                    <%
                        }
                    %>
                </div>
            </div>
        </nav>

    </body>
</html>
