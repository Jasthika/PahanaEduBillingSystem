<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<footer class="bg-gradient-to-b from-blue-900 via-blue-800 to-blue-900 text-white">
    <div class="container mx-auto px-6">
        <!-- Main Footer Content -->
        <div class="py-16 grid lg:grid-cols-4 md:grid-cols-2 gap-8">

            <!-- Brand Section -->
            <div class="space-y-4">
                <div class="flex items-center space-x-3">
                    <img src="images/book.png" alt="Pahana Edu Bookshop" class="w-12 h-12 rounded-lg" />
                    <div>
                        <h3 class="text-xl font-bold">Pahana Edu Bookshop</h3>
                        <p class="text-blue-200 text-sm">Your Learning Partner</p>
                    </div>
                </div>
                <p class="text-blue-200 text-sm leading-relaxed">
                    Empowering education in Colombo for over 15 years. We provide quality 
                    books and educational materials to support your learning journey.
                </p>
                <!-- Social Media -->
                <div class="flex space-x-2">
                    <a href="#" class="p-2 rounded-md bg-white/10 hover:bg-white/20 transition">
                        <i class="fab fa-facebook-f"></i>
                    </a>
                    <a href="#" class="p-2 rounded-md bg-white/10 hover:bg-white/20 transition">
                        <i class="fab fa-instagram"></i>
                    </a>
                    <a href="#" class="p-2 rounded-md bg-white/10 hover:bg-white/20 transition">
                        <i class="fab fa-twitter"></i>
                    </a>
                </div>
            </div>

            <!-- Quick Links -->
            <div class="space-y-4">
                <h4 class="text-lg font-semibold text-yellow-300">Quick Links</h4>
                <ul class="space-y-2 text-blue-200 text-sm">
                    <li><a href="index.jsp" class="hover:text-yellow-300 transition">Home</a></li>
                    <li><a href="aboutus.jsp" class="hover:text-yellow-300 transition">About Us</a></li>
                    <li><a href="books.jsp" class="hover:text-yellow-300 transition">Books</a></li>
                    <li><a href="contactus.jsp" class="hover:text-yellow-300 transition">Contact</a></li>
                </ul>
            </div>

            <!-- Book Categories -->
            <div class="space-y-4">
                <h4 class="text-lg font-semibold text-yellow-300">Book Categories</h4>
                <ul class="space-y-2 text-blue-200 text-sm">
                    <li><a href="books.jsp" class="hover:text-yellow-300 transition">Academic Books</a></li>
                    <li><a href="books.jsp" class="hover:text-yellow-300 transition">Children's Books</a></li>
                    <li><a href="books.jsp" class="hover:text-yellow-300 transition">Educational Materials</a></li>
                    <li><a href="books.jsp" class="hover:text-yellow-300 transition">Reference Books</a></li>
                </ul>
            </div>

            <!-- Contact Info -->
            <div class="space-y-4">
                <h4 class="text-lg font-semibold text-yellow-300">Contact Info</h4>
                <div class="space-y-2 text-sm text-blue-200">
                    <p>📍 123 Education Street, Colombo 07, Sri Lanka</p>
                    <p>📞 +94 11 234 5678 | +94 77 123 4567</p>
                    <p>📧 info@pahanaedu.lk | orders@pahanaedu.lk</p>
                </div>
            </div>
        </div>

        <!-- Newsletter Section -->
        <div class="border-t border-white/20 py-8 text-center space-y-4">
            <h3 class="text-xl font-semibold">Stay Updated with Our Latest Books</h3>
            <p class="text-blue-200 text-sm">Get notified about new arrivals and special offers</p>

            <div class="flex flex-col sm:flex-row gap-3 justify-center max-w-md mx-auto">
                <input type="email" placeholder="Enter your email"
                       class="flex-1 px-4 py-2 rounded-lg bg-white/10 border border-white/20 text-white placeholder-blue-300 focus:outline-none focus:border-yellow-300">
                <button class="px-5 py-2 rounded-lg bg-yellow-400 text-blue-900 font-semibold hover:bg-yellow-300 transition">
                    Subscribe
                </button>
            </div>
        </div>

        <!-- Bottom Footer -->
        <div class="border-t border-white/20 py-6 flex flex-col md:flex-row justify-between items-center text-sm text-blue-200 gap-4">
            <div class="flex items-center space-x-1">
                <span>&copy; <%= java.time.Year.now()%> Pahana Edu Bookshop. Made with</span>
                <span class="text-yellow-400">❤</span>
                <span>for education in Colombo.</span>
            </div>
            <div class="flex space-x-6">
                <a href="#" class="hover:text-yellow-300 transition">Privacy Policy</a>
                <a href="#" class="hover:text-yellow-300 transition">Terms of Service</a>
                <a href="#" class="hover:text-yellow-300 transition">Sitemap</a>
            </div>
        </div>
    </div>
</footer>

<!-- Font Awesome for icons -->
<script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
