<%@page import="jakarta.servlet.http.HttpSession"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if (session == null || session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return; // Prevent further processing if the user is not logged in
    }

    String username = (String) session.getAttribute("username");
    int userId = 0;
    String dbUrl = "jdbc:mysql://localhost:3306/EmployeeTaskTracker";
    String dbUser = "root";
    String dbPass = "root";

    // Query to get user_id from username
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection(dbUrl, dbUser, dbPass);
        PreparedStatement ps = con.prepareStatement("SELECT user_id FROM Users WHERE username=?");
        ps.setString(1, username);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            userId = rs.getInt("user_id");
        }
        rs.close();
        ps.close();
        con.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>View My Tasks</title>
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
        .tasks-container {
            background-color: rgba(255, 255, 255, 0.9);
            padding: 2rem;
            border-radius: 1rem;
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.1);
            animation: fadeIn 1.5s ease-in-out;
            width: 100%;
            max-width: 800px;
        }
        .tasks-header {
            margin-bottom: 1.5rem;
            font-weight: 300;
            text-align: center;
        }
        .tasks-table-wrapper {
            overflow-x: auto; /* Enable horizontal scrolling */
            width: 100%;
            -webkit-overflow-scrolling: touch; /* Smooth scrolling on iOS */
        }
        .tasks-table {
            overflow-y: auto; /* Enable vertical scrolling */
            max-height: 60vh; /* Adjust based on available space */
            display: block; /* Make it a block element to allow scrolling */
            width: 100%; /* Ensure the table fits within the container */
        }
        table {
            width: 100%;
            border-collapse: collapse;
            table-layout: fixed; /* Fixed table layout to control width */
        }
        table thead {
            position: sticky;
            top: 0; /* Sticky header */
            background-color: #f8f9fa;
            z-index: 1; /* Ensure the header is above the body */
        }
        table th, table td {
            border: 1px solid #dee2e6;
            padding: 1rem; /* Increased padding */
            text-align: left;
            box-sizing: border-box; /* Include padding in width */
        }
        table th {
            background-color: #f8f9fa;
            font-weight: 400;
        }
        .btn-edit, .btn-delete {
            font-size: 0.8rem; /* Smaller font size */
            padding: 0.5rem 1rem; /* Adjusted padding */
            border-radius: 2rem;
            transition: background-color 0.3s;
            color: white;
            text-decoration: none;
        }
        .btn-edit {
            background-color: #34A853; /* Green for Edit */
        }
        .btn-delete {
            background-color: #EA4335; /* Red for Delete */
        }
        .btn-edit:hover {
            background-color: #2c6c2f; /* Darker green on hover */
        }
        .btn-delete:hover {
            background-color: #d32f2f; /* Darker red on hover */
        }
        .btn-back {
            background-color: #4285F4; /* Blue for Back */
            color: white;
            border-radius: 2rem;
            transition: background-color 0.3s;
            display: block;
            margin-top: 1rem;
            text-align: center;
            font-weight: bold;
            text-decoration: none;
            padding: 12px 24px;
            width: 100%;
        }
        .btn-back:hover {
            background-color: #357ae8; /* Darker blue on hover */
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
    <div class="tasks-container">
        <div class="tasks-header">
            <h2>My Tasks</h2>
        </div>
        <div class="tasks-table-wrapper">
            <div class="tasks-table">
                <table>
                    <thead>
                        <tr>
                            <th>Project</th>
                            <th>Date</th>
                            <th>Start Time</th>
                            <th>End Time</th>
                            <th>Category</th>
                            <th>Description</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            try {
                                Connection con = DriverManager.getConnection(dbUrl, dbUser, dbPass);
                                PreparedStatement ps = con.prepareStatement("SELECT * FROM Tasks WHERE employee_id=?");
                                ps.setInt(1, userId); // Use userId instead of hardcoded value
                                ResultSet rs = ps.executeQuery();
                                while (rs.next()) {
                        %>
                        <tr>
                            <td><%= rs.getString("project") %></td>
                            <td><%= rs.getDate("date") %></td>
                            <td><%= rs.getTime("start_time") %></td>
                            <td><%= rs.getTime("end_time") %></td>
                            <td><%= rs.getString("category") %></td>
                            <td><%= rs.getString("description") %></td>
                            <td>
                                <a href="EditTaskServlet?taskId=<%= rs.getInt("task_id") %>" class="btn btn-edit">Edit</a>
                                <a href="DeleteTaskServlet?taskId=<%= rs.getInt("task_id") %>" class="btn btn-delete">Delete</a>
                            </td>
                        </tr>
                        <%
                                }
                                rs.close();
                                ps.close();
                                con.close();
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
        <a href="dashboard.jsp" class="btn btn-back">Back to Dashboard</a>
    </div>

    <!-- Include Bootstrap JS and dependencies -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
