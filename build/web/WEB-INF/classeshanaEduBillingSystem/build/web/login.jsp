<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>Login - Pahana Edu Bookshop</title>

        <!-- Bootstrap + Icons -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet" />
        <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/js/all.min.js"></script>

        <style>
            body {
                background: #e6f0ff;
                min-height: 100vh;
                display: flex;
                align-items: center;
                justify-content: center;
            }
            .card {
                border-radius: 1rem;
                box-shadow: 0 4px 15px rgba(0,123,255,0.2);
            }
            .btn-lightblue {
                background-color: #4a90e2;
                color: white;
                font-weight: 600;
            }
            .btn-lightblue:hover {
                background-color: #357ABD;
            }
            .position-relative button {
                position: absolute;
                right: 10px;
                top: 38px;
                background: transparent;
                border: none;
            }
        </style>
    </head>
    <jsp:include page="header.jsp" />
    <body>

        <!-- ✅ Toast for Login Success -->
        <div class="position-fixed top-0 end-0 p-3" style="z-index: 9999">
            <div id="toast-success" class="toast align-items-center text-bg-success border-0" role="alert" aria-live="assertive" aria-atomic="true">
                <div class="d-flex">
                    <div class="toast-body">
                        ✅ Login successful! Welcome back.
                    </div>
                    <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
                </div>
            </div>
        </div>

        <!-- ✅ Login Form Card -->
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-5 col-lg-4">
                    <div class="card bg-white p-4">
                        <h2 class="text-center mb-4 text-primary fw-bold">Login</h2>

                        <!-- ✅ Login Form -->
                        <form action="LoginServlet" method="post" novalidate>

                            <!-- Account Number -->
                            <div class="mb-3">
                                <label for="accountNumber" class="form-label text-primary">Account Number</label>
                                <input type="text" class="form-control" id="accountNumber" name="accountNumber" placeholder="Enter your account number" required />
                            </div>

                            <!-- Password -->
                            <div class="mb-3 position-relative">
                                <label for="password" class="form-label text-primary">Password</label>
                                <input type="password" class="form-control" id="password" name="password" placeholder="Enter your password" required />
                                <button type="button" onclick="togglePassword('password', 'toggleLoginIcon')">
                                    <i id="toggleLoginIcon" class="fa-solid fa-eye-slash"></i>
                                </button>
                            </div>

                            <!-- Submit Button -->
                            <button type="submit" class="btn btn-lightblue w-100">Login</button>
                        </form>

                        <!-- Signup Link -->
                        <p class="mt-4 text-center">
                            Don't have an account?
                            <a href="signup.jsp" class="text-primary fw-semibold">Sign up here</a>
                        </p>

                        <!-- ✅ Signup Success Alert -->
                        <%
                            String signupStatus = request.getParameter("signup");
                            if ("success".equals(signupStatus)) {
                        %>
                        <div class="alert alert-success mt-3" role="alert">
                            <i class="bi bi-check-circle-fill"></i> Signup successful! Please login.
                        </div>
                        <%
                            }
                        %>

                        <!-- ✅ Login Error Alert -->
                        <%
                            String error = (String) request.getAttribute("error");
                            if (error != null) {
                        %>
                        <div class="alert alert-danger mt-3" role="alert">
                            <i class="bi bi-exclamation-circle-fill"></i> <%= error%>
                        </div>
                        <%
                            }
                        %>
                    </div>
                </div>
            </div>
        </div>

        <!-- ✅ Scripts -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

        <script>
                                    // Toggle password visibility
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

                                    // Get query param
                                    function getQueryParam(param) {
                                        return new URLSearchParams(window.location.search).get(param);
                                    }

                                    // Show toast on login success
                                    document.addEventListener("DOMContentLoaded", function () {
                                        const loginStatus = getQueryParam("login");
                                        if (loginStatus === "success") {
                                            const toastEl = document.getElementById('toast-success');
                                            const toast = new bootstrap.Toast(toastEl, {delay: 3000});
                                            toast.show();
                                        }
                                    });
        </script>
    </body>
</html>