<%@page import="jakarta.servlet.http.HttpSession"%>
<%@page import="jakarta.servlet.http.HttpServletRequest"%>
<%@page import="jakarta.servlet.http.HttpServletResponse"%>
<%
    if (session == null || session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    } else {
        String role = (String) session.getAttribute("role");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Dashboard</title>
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
        .container {
            background-color: rgba(255, 255, 255, 0.9);
            padding: 2rem;
            border-radius: 1rem;
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.1);
            animation: fadeIn 1.5s ease-in-out;
            width: 100%;
            max-width: 400px; /* Adjusted max-width to match the login page */
        }
        h2 {
            margin-bottom: 1.5rem;
            font-weight: 300;
            text-align: center;
            color: #333;
        }
        .btn-custom {
            background-color: #4285F4;
            color: white;
            border-radius: 2rem;
            transition: background-color 0.3s;
            display: block;
            padding: 10px 20px;
            text-align: center;
            font-weight: bold;
            text-decoration: none;
            margin: 10px 0;
        }
        .btn-custom:hover {
            background-color: #357ae8;
        }
        .logout-button {
            background-color: #dc3545;
            color: #fff;
            font-weight: bold;
            display: block;
            padding: 10px 20px;
            border-radius: 2rem;
            transition: background-color 0.3s;
            text-align: center;
            text-decoration: none;
            margin: 10px 0;
        }
        .logout-button:hover {
            background-color: #c82333;
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
    <div class="container">
        <h2>Welcome, <%= session.getAttribute("username") %></h2>
        <%
            if ("Admin".equals(role)) {
        %>
        <a href="adminPage.jsp" class="btn-custom">Admin Page</a>
        <%
            } else {
        %>
        <a href="taskPage.jsp" class="btn-custom">Task Management</a>
        <a href="associaterPage.jsp" class="btn-custom">View Associate</a>
        <%
            }
        %>
        <a href="LogoutServlet" class="logout-button">Logout</a>
    </div>
    <!-- Include Bootstrap JS and dependencies -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
<%
    }
%>
