<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String currentPage = "dashboard";
    // Example session usage for displaying username and stats
    String username = (String) session.getAttribute("username");
    int totalCustomers = 120;  // Replace with value from DB
    int totalItems = 85;
    int pendingBills = 12;
    int helpRequests = 4;
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Pahana Edu Admin Dashboard</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">

    <style>
        :root {
            --primary-color: #4f46e5;
            --highlight-color: #06b6d4;
        }

        body {
            display: flex;
            margin: 0;
            background-color: #f3f4f6;
            font-family: 'Segoe UI', sans-serif;
        }

        .sidebar {
            width: 250px;
            height: 100vh;
            background: linear-gradient(180deg, var(--primary-color), #3730a3);
            color: white;
            position: fixed;
            padding-top: 30px;
        }

        .sidebar h3 {
            text-align: center;
            font-weight: bold;
            font-size: 1.6rem;
            margin-bottom: 30px;
        }

        .sidebar a {
            display: block;
            padding: 12px 25px;
            color: white;
            font-size: 1.1rem;
            text-decoration: none;
            transition: all 0.3s ease;
        }

        .sidebar a:hover, .sidebar a.active {
            background-color: var(--highlight-color);
            color: #fff;
            font-weight: bold;
            border-radius: 0 20px 20px 0;
        }

        .main-content {
            margin-left: 250px;
            padding: 2rem;
            width: 100%;
        }

        .card {
            border-radius: 12px;
            background: #ffffff;
            border: none;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }

        .card:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 18px rgba(0, 0, 0, 0.1);
        }

        .card-icon {
            font-size: 2rem;
            color: var(--highlight-color);
        }

        .welcome {
            font-size: 1.2rem;
            color: #444;
            margin-bottom: 20px;
        }

        /* ✅ Enlarged image with responsive behavior */
        .edu-image {
            display: block;
            width: 60%;           /* Increased size from 28% to 60% */
            max-width: 800px;     /* Prevents too large on wide screens */
            height: auto;
            margin: 30px auto 10px auto;
            border-radius: 10px;
        }
    </style>
</head>
<body>

    <!-- Sidebar -->
    <div class="sidebar">
        <h3>Pahana Edu Admin</h3>

        <a href="dashboard.jsp" class="sidebar-link <%= "dashboard".equals(currentPage) ? "active" : ""%>">
            <i class="fas fa-tachometer-alt me-2"></i> Dashboard
        </a>

        <a href="customers.jsp" class="sidebar-link <%= "customers".equals(currentPage) ? "active" : ""%>">
            <i class="fas fa-users me-2"></i> Customers
        </a>

        <a href="items.jsp" class="sidebar-link <%= "items".equals(currentPage) ? "active" : ""%>">
            <i class="fas fa-book me-2"></i> Items(Books)
        </a>

        <a href="billing.jsp" class="sidebar-link <%= "billing".equals(currentPage) ? "active" : ""%>">
            <i class="fas fa-file-invoice-dollar me-2"></i> Billing
        </a>

        <!-- ✅ New Payments Section -->
        <a href="payments.jsp" class="sidebar-link <%= "payments".equals(currentPage) ? "active" : ""%>">
            <i class="fas fa-credit-card me-2"></i> Payments
        </a>

        <a href="help.jsp" class="sidebar-link <%= "help".equals(currentPage) ? "active" : ""%>">
            <i class="fas fa-question-circle me-2"></i> Help
        </a>

        <a href="logout.jsp" class="sidebar-link">
            <i class="fas fa-sign-out-alt me-2"></i> Logout
        </a>
    </div>

    <!-- Main Dashboard Content -->
    <div class="main-content">
        <h2 class="mb-4">Dashboard</h2>
        <p class="welcome">
            Welcome, <strong><%= (username != null) ? username : "Admin"%></strong>! Here is a quick overview of the system.
        </p>

        <div class="row g-4">
            <div class="col-md-3">
                <div class="card p-4">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h6 class="card-title text-muted">Total Customers</h6>
                            <h3 class="fw-bold"><%= totalCustomers%></h3>
                        </div>
                        <i class="fas fa-users card-icon"></i>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card p-4">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h6 class="card-title text-muted">Total Items</h6>
                            <h3 class="fw-bold"><%= totalItems%></h3>
                        </div>
                        <i class="fas fa-book card-icon"></i>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card p-4">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h6 class="card-title text-muted">Pending Bills</h6>
                            <h3 class="fw-bold"><%= pendingBills%></h3>
                        </div>
                        <i class="fas fa-file-invoice card-icon"></i>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card p-4">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h6 class="card-title text-muted">Help Requests</h6>
                            <h3 class="fw-bold"><%= helpRequests%></h3>
                        </div>
                        <i class="fas fa-question card-icon"></i>
                    </div>
                </div>
            </div>
        </div>

        <!-- ✅ Enlarged image -->
        <img src="<%= request.getContextPath() %>/images/bookshop.avif" alt="Bookshop Image" class="edu-image" />
    </div>

</body>
</html>
