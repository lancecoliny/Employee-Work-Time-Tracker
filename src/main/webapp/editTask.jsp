<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% 
    ResultSet task = (ResultSet) request.getAttribute("task");
    if (task != null) {
%>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Task</title>
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
        .edit-container {
            background-color: rgba(255, 255, 255, 0.9);
            padding: 2rem;
            border-radius: 1rem;
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.1);
            animation: fadeIn 1.5s ease-in-out;
            width: 100%;
            max-width: 400px; /* Adjust width to match the login page */
        }
        .edit-container h2 {
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
        .btn-back {
            background-color: #dc3545; /* Red color */
            color: white;
            border-radius: 2rem;
            transition: background-color 0.3s;
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
    <div class="edit-container">
        <h2 class="text-center">Edit Task</h2>
        <form action="EditTaskServlet" method="post">
            <input type="hidden" name="taskId" value="<%= task.getInt("task_id") %>">
            <div class="form-group">
                <label for="project">Project:</label>
                <input type="text" id="project" name="project" class="form-control" value="<%= task.getString("project") %>">
            </div>
            <div class="form-group">
                <label for="date">Date:</label>
                <input type="date" id="date" name="date" class="form-control" value="<%= task.getDate("date") %>">
            </div>
            <div class="form-group">
                <label for="startTime">Start Time:</label>
                <input type="time" id="startTime" name="startTime" class="form-control" value="<%= task.getTime("start_time") %>">
            </div>
            <div class="form-group">
                <label for="endTime">End Time:</label>
                <input type="time" id="endTime" name="endTime" class="form-control" value="<%= task.getTime("end_time") %>">
            </div>
            <div class="form-group">
                <label for="category">Category:</label>
                <input type="text" id="category" name="category" class="form-control" value="<%= task.getString("category") %>">
            </div>
            <div class="form-group">
                <label for="description">Description:</label>
                <textarea id="description" name="description" class="form-control"><%= task.getString("description") %></textarea>
            </div>
            <button type="submit" class="btn btn-custom btn-block">Update Task</button>
        </form>
        <a href="taskPage.jsp" class="btn btn-back btn-block mt-3">Back to Task Management</a>
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
