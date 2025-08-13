<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String errorMessage = (String) request.getAttribute("error");
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Payment Failed</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background: #fcebea;
                text-align: center;
                padding: 50px;
            }
            .error-box {
                background: white;
                padding: 20px;
                border: 2px solid #dc3545;
                display: inline-block;
                border-radius: 8px;
            }
            .error-box h2 {
                color: #dc3545;
            }
            .btn {
                margin-top: 15px;
                padding: 10px 20px;
                background: #007bff;
                color: white;
                border: none;
                border-radius: 5px;
                text-decoration: none;
            }
        </style>
    </head>
    <body>

        <div class="error-box">
            <h2>❌ Payment Failed</h2>
            <p><%= errorMessage%></p>
            <a class="btn" href="index.jsp">Back to Home</a>
        </div>

    </body>
</html>
