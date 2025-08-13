<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!-- Font Awesome -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />

<section id="contact" class="bg-gradient-to-b from-blue-50 via-white to-blue-100 py-20 px-6">
    <div class="container mx-auto max-w-7xl">

        <!-- Section Header -->
        <div class="text-center mb-5">


            <h2 class="text-4xl md:text-5xl font-bold text-blue-900 mb-4">
                Contact <span class="bg-gradient-to-r from-blue-700 to-indigo-800 bg-clip-text text-transparent">Pahana Edu</span>
            </h2>
            <p class="text-lg text-blue-800 max-w-3xl mx-auto leading-relaxed">
                Have questions about our books or need help finding something specific? 
                We're here to help! Visit our store or get in touch with us.
            </p>
        </div>

        <!-- Grid Layout -->
        <div class="grid md:grid-cols-2 gap-12">

            <!-- Contact Info Cards -->
            <div class="space-y-8">

                <!-- Cards -->
                <div class="grid grid-cols-1 sm:grid-cols-2 gap-6">

                    <!-- Visit Us -->
                    <div class="bg-white shadow-md rounded-2xl p-6 hover:shadow-xl hover:-translate-y-1 transition duration-300">
                        <div class="w-12 h-12 rounded-2xl bg-blue-100 flex items-center justify-center mb-4">
                            <i class="fas fa-map-marker-alt text-blue-700 text-lg"></i>
                        </div>
                        <h3 class="text-xl font-semibold text-blue-900 mb-2">Visit Our Store</h3>
                        <p class="text-blue-700 text-sm leading-relaxed">
                            No. 123, Galle Road,<br> Colombo 03, Sri Lanka
                        </p>
                    </div>

                    <!-- Call Us -->
                    <div class="bg-white shadow-md rounded-2xl p-6 hover:shadow-xl hover:-translate-y-1 transition duration-300">
                        <div class="w-12 h-12 rounded-2xl bg-indigo-100 flex items-center justify-center mb-4">
                            <i class="fas fa-phone text-indigo-600 text-lg"></i>
                        </div>
                        <h3 class="text-xl font-semibold text-blue-900 mb-2">Call Us</h3>
                        <p class="text-blue-700 text-sm leading-relaxed">
                            +94 77 123 4569 <br> +94 11 234 5678
                        </p>
                    </div>

                    <!-- Email -->
                    <div class="bg-white shadow-md rounded-2xl p-6 hover:shadow-xl hover:-translate-y-1 transition duration-300">
                        <div class="w-12 h-12 rounded-2xl bg-green-100 flex items-center justify-center mb-4">
                            <i class="fas fa-envelope text-green-600 text-lg"></i>
                        </div>
                        <h3 class="text-xl font-semibold text-blue-900 mb-2">Email</h3>
                        <p class="text-blue-700 text-sm leading-relaxed">
                            pahanaedubookshop@gmail.com
                        </p>
                    </div>

                    <!-- Hours -->
                    <div class="bg-white shadow-md rounded-2xl p-6 hover:shadow-xl hover:-translate-y-1 transition duration-300">
                        <div class="w-12 h-12 rounded-2xl bg-pink-100 flex items-center justify-center mb-4">
                            <i class="fas fa-clock text-pink-600 text-lg"></i>
                        </div>
                        <h3 class="text-xl font-semibold text-blue-900 mb-2">Opening Hours</h3>
                        <p class="text-blue-700 text-sm leading-relaxed">
                            Mon - Sat: 8:00 AM - 6:00 PM <br> Sunday: Closed
                        </p>
                    </div>

                </div>

                <!-- Map Placeholder -->
                <div class="bg-white shadow-md rounded-xl p-6 text-center">
                    <h3 class="text-lg font-semibold text-blue-900 mb-4">Find Us on the Map</h3>



                    <p class="text-blue-700 text-sm leading-relaxed">
                        📍 Pahana Edu Bookshop, No. 123 Galle Road, Colombo 03, Sri Lanka
                    </p>
                </div>


            </div>

            <!-- Contact Form -->
            <div class="bg-white p-8 shadow-lg rounded-xl">
                <h3 class="text-2xl font-bold text-blue-900 mb-4">Send us a Message</h3>
                <p class="text-blue-700 mb-6">We'll get back to you as soon as possible.</p>

                <form action="#" method="post" class="space-y-6">
                    <div>
                        <label class="block text-blue-800 font-semibold mb-2">Your Name</label>
                        <input type="text" name="name" required 
                               class="w-full px-4 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-400" />
                    </div>
                    <div>
                        <label class="block text-blue-800 font-semibold mb-2">Email Address</label>
                        <input type="email" name="email" required 
                               class="w-full px-4 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-400" />
                    </div>
                    <div>
                        <label class="block text-blue-800 font-semibold mb-2">Your Message</label>
                        <textarea name="message" rows="5" required 
                                  class="w-full px-4 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-400"></textarea>
                    </div>
                    <button type="submit" 
                            class="w-full bg-gradient-to-r from-blue-600 to-blue-700 text-white font-bold py-3 px-6 rounded-md hover:from-blue-700 hover:to-blue-800 transition">
                        <i class="fas fa-paper-plane mr-2"></i> Send Message
                    </button>
                </form>
            </div>

        </div>


    </div>

    <!-- Quick Contact Buttons -->
    <div class="mt-16 text-center">
        <h3 class="text-2xl font-bold text-blue-900 mb-8">Need Immediate Assistance?</h3>
        <div class="flex flex-col sm:flex-row gap-4 justify-center">
            <a href="tel:+94771234569" 
               class="px-6 py-3 rounded-lg border border-blue-700 text-blue-700 font-medium hover:bg-blue-700 hover:text-white transition shadow-md">
                <i class="fas fa-phone mr-2"></i> Call Now: +94 77 123 4569
            </a>
            <a href="mailto:pahanaedubookshop@gmail.com" 
               class="px-6 py-3 rounded-lg bg-yellow-400 text-blue-900 font-semibold hover:bg-yellow-300 transition shadow-md">
                <i class="fas fa-envelope mr-2"></i> Email: pahanaedubookshop@gmail.com
            </a>
        </div>
    </div>

</div>
</section>
