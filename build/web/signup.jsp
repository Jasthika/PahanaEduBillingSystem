<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>Signup - Pahana Edu Bookshop</title>

        <!-- Tailwind & Font Awesome -->
        <script src="https://cdn.tailwindcss.com"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/js/all.min.js" crossorigin="anonymous"></script>

        <style>
            body {
                background: linear-gradient(135deg, #e6f0ff, #f9fbff);
            }
            .glass-card {
                background: rgba(255, 255, 255, 0.9);
                backdrop-filter: blur(8px);
                border: 1px solid rgba(255, 255, 255, 0.3);
            }
            .form-label {
                font-size: 0.85rem;
                font-weight: 600;
                color: #1e3a8a;
                margin-bottom: 0.25rem;
            }
        </style>
    </head>
    <body class="min-h-screen flex flex-col">

        <!-- Navbar -->
        <jsp:include page="header.jsp" />

        <!-- Signup Section -->
        <div class="flex justify-center items-center flex-grow pt-24 pb-8 px-4">
            <div class="glass-card shadow-xl rounded-xl w-full max-w-2xl p-6 sm:p-8">

                <h2 class="text-2xl font-bold text-center text-blue-900 mb-4">Create Account</h2>

                <!-- Signup Form -->
                <form action="SignupServlet" method="post" novalidate class="space-y-4">

                    <!-- Row 1 -->
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                        <div>
                            <label class="form-label" for="accountNumber">Account Number</label>
                            <input type="text" id="accountNumber" name="accountNumber" placeholder="12345"
                                   class="w-full rounded-md border border-gray-300 px-3 py-2 text-sm focus:ring focus:ring-blue-100" required />
                        </div>

                        <div>
                            <label class="form-label" for="name">Full Name</label>
                            <input type="text" id="name" name="name" placeholder="John Doe"
                                   class="w-full rounded-md border border-gray-300 px-3 py-2 text-sm focus:ring focus:ring-blue-100" required />
                        </div>
                    </div>

                    <!-- Row 2 -->
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                        <div>
                            <label class="form-label" for="telephone">Telephone</label>
                            <input type="tel" id="telephone" name="telephone" placeholder="+94 71 123 4567"
                                   class="w-full rounded-md border border-gray-300 px-3 py-2 text-sm focus:ring focus:ring-blue-100" required />
                        </div>

                        <div>
                            <label class="form-label" for="password">Password</label>
                            <div class="relative">
                                <input type="password" id="password" name="password" placeholder="••••••••"
                                       class="w-full rounded-md border border-gray-300 px-3 py-2 text-sm focus:ring focus:ring-blue-100" required />
                                <i id="toggleSignupIcon" class="fa-solid fa-eye-slash absolute right-3 top-3 text-gray-400 cursor-pointer"
                                   onclick="togglePassword('password', 'toggleSignupIcon')"></i>
                            </div>
                        </div>
                    </div>

                    <!-- Address -->
                    <div>
                        <label class="form-label" for="address">Address</label>
                        <textarea id="address" name="address" rows="3" placeholder="Enter your address..."
                                  class="w-full rounded-md border border-gray-300 px-3 py-2 text-sm focus:ring focus:ring-blue-100" required></textarea>
                    </div>

                    <!-- Signup Button -->
                    <button type="submit"
                            class="w-full bg-blue-600 hover:bg-blue-700 text-white font-semibold py-2.5 rounded-md shadow-md transition duration-300">
                        <i class="fa-solid fa-user-plus mr-2"></i> Sign Up
                    </button>

                    <!-- Login Link -->
                    <p class="text-center text-gray-700 text-sm mt-2">
                        Already have an account?
                        <a href="login.jsp" class="text-blue-600 font-medium hover:underline">Login</a>
                    </p>
                </form>
            </div>
        </div>

        <!-- Toast Notification -->
        <div id="toast-success"
             class="hidden fixed top-5 right-5 bg-green-500 text-white px-4 py-2 rounded shadow-md transition-opacity duration-500">
            ✅ Signup successful! You can now log in.
        </div>

        <!-- Password toggle script -->
        <script>
            function togglePassword(fieldId, iconId) {
                const field = document.getElementById(fieldId);
                const icon = document.getElementById(iconId);
                if (field.type === "password") {
                    field.type = "text";
                    icon.classList.replace("fa-eye-slash", "fa-eye");
                } else {
                    field.type = "password";
                    icon.classList.replace("fa-eye", "fa-eye-slash");
                }
            }

            // Toast check
            const signupStatus = new URLSearchParams(window.location.search).get("signup");
            if (signupStatus === "success") {
                const toast = document.getElementById("toast-success");
                toast.classList.remove("hidden");
                toast.classList.add("opacity-100");
                setTimeout(() => {
                    toast.classList.add("opacity-0");
                    setTimeout(() => toast.classList.add("hidden"), 500);
                }, 3000);
            }
        </script>

    </body>
</html>
