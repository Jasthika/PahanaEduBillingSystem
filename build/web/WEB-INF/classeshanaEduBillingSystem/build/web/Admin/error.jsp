<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <title>Error - Pahana Edu Admin</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
        <style>
            body {
                background-color: #f8f9fa;
                height: 100vh;
                display: flex;
                justify-content: center;
                align-items: center;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }
            .error-container {
                text-align: center;
                padding: 40px;
                background: white;
                border-radius: 12px;
                box-shadow: 0 10px 30px rgba(0,0,0,0.1);
                max-width: 400px;
            }
            h1 {
                color: #dc3545; /* Bootstrap danger color */
                font-size: 4rem;
                margin-bottom: 20px;
            }
            p {
                font-size: 1.2rem;
                color: #555;
            }
            a.btn-primary {
                margin-top: 25px;
                padding: 10px 25px;
                font-size: 1.1rem;
            }
        </style>
    </head>
    <body>
        <div class="error-container">
            <h1>Oops!</h1>
            <p>Something went wrong while processing your request.</p>
            <p>Please try again later or contact the administrator.</p>
            <a href="dashboard.jsp" class="btn btn-primary">Go to Dashboard</a>
        </div>
    </body>
</html>
