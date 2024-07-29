<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.http.HttpSession"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
    <title>Task Management</title>
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
            max-width: 900px;
            margin: auto;
            position: relative;
            top: 20px; /* Adjust this value as needed */
        }
        .container h2, .container h3 {
            margin-bottom: 1.5rem;
            font-weight: 300;
        }
        .btn-custom {
            background-color: #4285F4;
            color: white;
            border-radius: 2rem;
            transition: background-color 0.3s;
        }
        .btn-custom:hover {
            background-color: #357ae8;
        }
        .btn-edit {
            background-color: #28a745;
            color: white;
            transition: background-color 0.3s;
        }
        .btn-edit:hover {
            background-color: #218838;
        }
        .btn-delete {
            background-color: #dc3545;
            color: white;
            transition: background-color 0.3s;
        }
        .btn-delete:hover {
            background-color: #c82333;
        }
        .btn-back {
            background-color: #dc3545; /* Red color */
            color: white;
            border-radius: 2rem;
            transition: background-color 0.3s;
        }
        .btn-back:hover {
            background-color: #c82333; /* Darker red on hover */
        }
        table {
            width: 100%;
            margin-top: 1.5rem;
            border-collapse: collapse;
        }
        th, td {
            padding: 0.75rem;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #4285F4;
            color: white;
        }
        a {
            color: #4285F4;
            text-decoration: none;
            font-weight: 500;
        }
        a:hover {
            text-decoration: underline;
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
    <%
        // Session and Database Setup
        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        String username = (String) session.getAttribute("username");
        int userId = 0;
        String dbUrl = "jdbc:mysql://localhost:3306/EmployeeTaskTracker";
        String dbUser = "root";
        String dbPass = "root";
        
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
        } catch (Exception e) {
            e.printStackTrace();
        }
    %>
    <div class="container">
        <h2 class="text-center">Task Management for <%= username %></h2>
        <form action="TaskServlet" method="get">
            <input type="hidden" name="userId" value="<%= userId %>">
            <div class="form-group">
                <label for="project">Project:</label>
                <input type="text" id="project" name="project" class="form-control">
            </div>
            <div class="form-group">
                <label for="date">Date:</label>
                <input type="date" id="date" name="date" class="form-control">
            </div>
            <div class="form-group">
                <label for="startTime">Start Time:</label>
                <input type="time" id="startTime" name="startTime" class="form-control">
            </div>
            <div class="form-group">
                <label for="endTime">End Time:</label>
                <input type="time" id="endTime" name="endTime" class="form-control">
            </div>
            <div class="form-group">
                <label for="category">Category:</label>
                <input type="text" id="category" name="category" class="form-control">
            </div>
            <div class="form-group">
                <label for="description">Description:</label>
                <textarea id="description" name="description" class="form-control"></textarea>
            </div>
            <button type="submit" class="btn btn-custom btn-block">Add Task</button>
        </form>
        <h3>Your Tasks</h3>
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
                        ps.setInt(1, userId);
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
                        <a href="EditTaskServlet?taskId=<%= rs.getInt("task_id") %>" class="btn btn-edit btn-sm">Edit</a>
                        <a href="DeleteTaskServlet?taskId=<%= rs.getInt("task_id") %>" class="btn btn-delete btn-sm">Delete</a>
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
        <a href="dashboard.jsp" class="btn btn-back btn-block mt-3">Back to Dashboard</a>
    </div>

    <!-- Include Bootstrap JS and dependencies -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
