<%@page import="jakarta.servlet.http.HttpSession"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if (session == null || session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return; // Prevent further processing if the user is not logged in
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>View All Charts</title>
    <!-- Include Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom CSS for additional styling -->
    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            background: linear-gradient(90deg, #4285F4, #EA4335, #FBBC05, #34A853);
            background-size: 400% 400%;
            animation: gradientBG 15s ease infinite;
            font-family: 'Roboto', sans-serif;
        }
        .charts-container {
            background-color: rgba(255, 255, 255, 0.9);
            padding: 2rem;
            border-radius: 1rem;
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.1);
            animation: fadeIn 1.5s ease-in-out;
            width: 100%;
            max-width: 400px;
        }
        .charts-container h2 {
            margin-bottom: 1.5rem;
            font-weight: 300;
            text-align: center;
        }
        .btn-custom {
            background-color: #4285F4;
            color: white;
            border-radius: 2rem;
            transition: background-color 0.3s;
            display: block;
            margin-bottom: 1rem;
            text-align: center;
            font-weight: bold;
            text-decoration: none;
            padding: 12px 24px;
        }
        .btn-custom:hover {
            background-color: #357ae8;
        }
        .btn-back {
            background-color: #dc3545; /* Red color */
            color: white;
            border-radius: 2rem;
            transition: background-color 0.3s;
            display: block;
            padding: 12px 24px;
            text-align: center;
            font-weight: bold;
            text-decoration: none;
            margin-top: 1.5rem;
            width: 100%;
        }
        .btn-back:hover {
            background-color: #c82333; /* Darker red on hover */
        }
        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        @keyframes gradientBG {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }
    </style>
</head>
<body>
    <div class="charts-container">
        <h2>Charts Overview</h2>
        <a href="AllDailyChart.jsp" class="btn btn-custom">View Daily Chart</a>
        <a href="AllWeeklyChart.jsp" class="btn btn-custom">View Weekly Chart</a>
        <a href="AllMonthlyChart.jsp" class="btn btn-custom">View Monthly Chart</a>
        <a href="dashboard.jsp" class="btn btn-back">Back to Dashboard</a>
    </div>

    <!-- Include Bootstrap JS and dependencies -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
