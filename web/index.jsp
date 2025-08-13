<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>Pahana Edu Bookshop</title>

        <!-- Tailwind CSS -->
        <script src="https://cdn.tailwindcss.com"></script>

        <!-- Font Awesome -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/js/all.min.js"></script>

        <style>
            @keyframes customBounce {
                0%, 100% {
                    transform: translateY(0);
                }
                50% {
                    transform: translateY(-8px);
                }
            }

            .animate-custom-bounce {
                animation: customBounce 1.5s infinite;
            }

            html {
                scroll-behavior: smooth;
            }
        </style>
    </head>
    <body class="bg-white text-gray-800">

        <!-- Header -->
        <header class="bg-white fixed top-0 left-0 w-full z-50 shadow-md">
            <div class="max-w-7xl mx-auto flex justify-between items-center px-6 h-20">
                <div class="flex items-center space-x-4">
                    <img src="images/book.png" alt="Logo" class="w-12 h-12" />
                    <h1 class="text-xl font-bold text-blue-900">Pahana Edu Bookshop</h1>
                </div>
                <nav class="flex items-center space-x-8 text-blue-900 font-semibold">
                    <a href="#home" class="hover:text-blue-600">Home</a>
                    <a href="#about" class="hover:text-blue-600">About</a>
                    <a href="#books" class="hover:text-blue-600">Books</a>
                    <a href="#contact" class="hover:text-blue-600">Contact</a>
                    <%
                        String accountNumber = (String) session.getAttribute("accountNumber");
                        if (accountNumber == null) {
                    %>
                    <a href="login.jsp" class="bg-yellow-400 hover:bg-yellow-500 text-white px-4 py-2 rounded-md transition">
                        Login
                    </a>
                    <%
                    } else {
                    %>
                    <div class="flex items-center space-x-2">
                        <i class="fas fa-user-circle text-xl"></i>
                        <span><%= accountNumber%></span>
                        <a href="LogoutServlet" class="text-red-500 ml-2 hover:text-red-600">
                            <i class="fas fa-sign-out-alt"></i>
                        </a>
                    </div>
                    <%
                        }
                    %>
                </nav>
            </div>
        </header>

        <!-- Home Section (Hero) -->
        <section id="home" class="pt-20 pb-10 bg-[#1f4ed8] text-white min-h-[80vh]">
            <div class="max-w-7xl mx-auto px-6 lg:px-12 grid lg:grid-cols-2 gap-12 items-center">
                <!-- Left Content -->
                <div class="space-y-6">
                    <div class="inline-flex items-center space-x-2 bg-white/10 px-4 py-2 rounded-full">
                        <i class="fas fa-star text-yellow-300"></i>
                        <span class="text-sm font-semibold">Colombo's Premier Educational Bookstore</span>
                    </div>

                    <h1 class="text-5xl font-bold leading-tight mb-2">
                        Welcome to <span class="text-yellow-400">Pahana Edu</span><br /> Bookshop
                    </h1>

                    <p class="text-lg text-blue-100">
                        Your trusted learning partner in Colombo. Discover our extensive collection of academic, educational, and children's books at unbeatable prices.
                    </p>

                    <div class="flex gap-4 flex-wrap">
                        <a href="#books" class="bg-yellow-400 hover:bg-yellow-500 text-white px-6 py-3 rounded-xl font-semibold shadow-md flex items-center gap-2 transition">
                            <i class="fas fa-book-open"></i> Explore Books
                        </a>
                        <a href="#about" class="bg-white text-blue-900 px-6 py-3 rounded-xl hover:bg-blue-100 transition">
                            Learn More
                        </a>
                    </div>

                    <div class="grid grid-cols-3 gap-6 pt-6 text-center">
                        <div>
                            <div class="text-3xl font-bold text-white">1000+</div>
                            <div class="text-sm text-blue-200">Books Available</div>
                        </div>
                        <div>
                            <div class="text-3xl font-bold text-white">500+</div>
                            <div class="text-sm text-blue-200">Happy Students</div>
                        </div>
                        <div>
                            <div class="text-3xl font-bold text-white">15+</div>
                            <div class="text-sm text-blue-200">Years Experience</div>
                        </div>
                    </div>
                </div>

                <!-- Right Image & Floating Cards -->
                <div class="relative">
                    <img src="images/bookshop.avif" alt="Bookshop Interior" class="rounded-2xl shadow-lg" />

                    <!-- Floating Card 1 -->
                    <div class="absolute -top-6 left-0 bg-white shadow-lg rounded-xl p-4 flex items-center gap-3 animate-custom-bounce">
                        <div class="bg-blue-700 text-white rounded-full w-12 h-12 flex items-center justify-center">
                            <i class="fas fa-book"></i>
                        </div>
                        <div>
                            <p class="font-semibold text-blue-900">Academic Excellence</p>
                            <p class="text-sm text-blue-600">Quality Education Materials</p>
                        </div>
                    </div>

                    <!-- Floating Card 2 -->
                    <div class="absolute -bottom-6 right-0 bg-white shadow-lg rounded-xl p-4 flex items-center gap-3 animate-custom-bounce" style="animation-delay: 1s;">
                        <div class="bg-yellow-400 text-white rounded-full w-12 h-12 flex items-center justify-center">
                            <i class="fas fa-users"></i>
                        </div>
                        <div>
                            <p class="font-semibold text-blue-900">Community Focused</p>
                            <p class="text-sm text-blue-600">Supporting Local Students</p>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- About -->
        <div id="about" style="padding-top: 70px; margin-top: -70px;"></div>
        <jsp:include page="aboutus.jsp" />

        <!-- Books -->
        <div id="books" style="margin-top: -70px;"></div>
        <jsp:include page="books.jsp" />


        <!-- Contact -->
        <div id="contact" style="padding-top: 70px; margin-top: -70px;"></div>
        <jsp:include page="contactus.jsp" />

        <!-- Footer -->
        <jsp:include page="footer.jsp" />

        <!-- Smooth Scroll with Header Offset -->
        <script>
            document.querySelectorAll('a[href^="#"]').forEach(anchor => {
                anchor.addEventListener('click', function (e) {
                    e.preventDefault();
                    const targetId = this.getAttribute('href').substring(1);
                    const targetElement = document.getElementById(targetId);
                    if (targetElement) {
                        const headerHeight = 80;
                        const offsetPosition = targetElement.offsetTop - headerHeight;

                        window.scrollTo({
                            top: offsetPosition,
                            behavior: "smooth"
                        });
                    }
                });
            });
        </script>
    </body>
</html>
