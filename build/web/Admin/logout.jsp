<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String message = request.getParameter("message");
    if (message == null) {
        message = "logged_out"; // Default message
    }
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <title>Logout - </title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"/>

        <style>
            body {
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                margin: 0;
                background-color: #e9f0fc;
                font-family: 'Segoe UI', sans-serif;
            }

            .logout-card {
                background-color: #ffffff;
                border-radius: 16px;
                box-shadow: 0 8px 20px rgba(0, 0, 0, 0.08);
                padding: 40px 30px;
                text-align: center;
                max-width: 420px;
                width: 100%;
                transition: all 0.3s ease-in-out;
            }

            .logout-card .icon {
                font-size: 3.5rem;
                color: #0d6efd;
                margin-bottom: 15px;
            }

            .logout-card h1 {
                font-size: 1.9rem;
                color: #0d6efd;
                font-weight: 700;
                margin-bottom: 10px;
            }

            .logout-card p {
                font-size: 1rem;
                color: #555;
                margin-bottom: 25px;
            }

            .btn-primary-blue {
                background-color: #0d6efd;
                color: #fff;
                border: none;
            }

            .btn-primary-blue:hover {
                background-color: #0b5ed7;
            }

            .btn-outline-blue {
                border: 2px solid #0d6efd;
                color: #0d6efd;
                background-color: white;
            }

            .btn-outline-blue:hover {
                background-color: #0d6efd;
                color: white;
            }

            @media (max-width: 480px) {
                .logout-card {
                    padding: 30px 20px;
                }

                .logout-card h1 {
                    font-size: 1.6rem;
                }

                .logout-card p {
                    font-size: 0.95rem;
                }
            }
        </style>
    </head>
    <body>
        <div class="logout-card">
            <i class="fas fa-check-circle icon"></i>
            <h1>Logout Successful</h1>

            <% if ("logged_out".equals(message)) { %>
            <p>You’ve been safely logged out of your account.</p>
            <% } else { %>
            <p>Your session expired due to inactivity. Please log in again to continue.</p>
            <% }%>

            <div class="d-grid gap-2 mt-3">
                <a href="<%= request.getContextPath()%>/login.jsp" class="btn btn-primary-blue">
                    <i class="fas fa-sign-in-alt me-2"></i> Log In
                </a>
                <a href="<%= request.getContextPath()%>/index.jsp" class="btn btn-outline-blue">
                    <i class="fas fa-home me-2"></i> Home
                </a>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>