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
    <title>View All Tasks</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
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
        }
        h2 {
            margin-bottom: 1.5rem;
            font-weight: 300;
            text-align: center;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        th, td {
            padding: 10px;
            text-align: left;
            border: 1px solid #ddd;
        }
        th {
            background-color: #4285F4;
            color: #fff;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        tr:hover {
            background-color: #e2e2e2;
        }
        a {
            text-decoration: none;
            padding: 5px 10px;
            border-radius: 4px;
            transition: background-color 0.3s, color 0.3s;
        }
        .btn-edit {
            background-color: #34A853; /* Green color */
            color: white;
        }
        .btn-edit:hover {
            background-color: #2c8f4f; /* Darker green on hover */
        }
        .btn-delete {
            background-color: #dc3545; /* Red color */
            color: white;
        }
        .btn-delete:hover {
            background-color: #c82333; /* Darker red on hover */
        }
        .btn-back {
            background-color: #dc3545; /* Red color */
            color: white;
            text-align: center;
            display: block;
            margin-top: 20px;
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
    <div class="container">
        <h2>All Tasks for <%= username %></h2>
        <table>
            <tr>
                <th>Project</th>
                <th>Date</th>
                <th>Start Time</th>
                <th>End Time</th>
                <th>Category</th>
                <th>Description</th>
                <th>Actions</th>
            </tr>
            <%
                try {
                    Connection con = DriverManager.getConnection(dbUrl, dbUser, dbPass);
                    PreparedStatement ps = con.prepareStatement("SELECT * FROM Tasks");
                    
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
        </table>
        <a href="dashboard.jsp" class="btn btn-back">Back to Dashboard</a>
    </div>
</body>
</html>
