<%@page import="jakarta.servlet.http.HttpSession"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if (session == null || session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
    } else {
        String username = (String) session.getAttribute("username");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Monthly Tasks/Hours Bar Chart</title>
    <!-- Include Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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
            max-width: 800px;
            text-align: center;
        }
        h2 {
            margin-bottom: 1.5rem;
            font-weight: 300;
            color: #333;
        }
        canvas {
            width: 100% !important; /* Ensure canvas uses full width of container */
            height: 400px !important; /* Fixed height */
            background-color: #fff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            margin-top: 15px;
        }
        .btn-custom {
            background-color: #4285F4;
            color: white;
            border-radius: 2rem;
            transition: background-color 0.3s;
            display: inline-block;
            padding: 7px 14px;
            text-align: center;
            font-weight: bold;
            text-decoration: none;
            margin-top: 20px;
        }
        .btn-custom:hover {
            background-color: #357ae8;
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
        <h2>Monthly Tasks/Hours Bar Chart for <%= username %></h2>
        <canvas id="monthlyChart"></canvas>
        <a href="dashboard.jsp" class="btn-custom">Back to Dashboard</a>
    </div>

    <!-- Include Bootstrap JS and dependencies -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script>
        fetch('MonthlyChartServlet')
        .then(response => response.json())
        .then(data => {
            const ctx = document.getElementById('monthlyChart').getContext('2d');
            new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: data.labels,
                    datasets: [{
                        label: 'Tasks/Hours',
                        data: data.data,
                        backgroundColor: 'rgba(75, 192, 192, 0.7)', // Darker teal color
                        borderColor: 'rgba(75, 192, 192, 1)', // Brighter teal border
                        borderWidth: 2 // Thicker border for better visibility
                    }]
                },
                options: {
                    responsive: true, // Make chart responsive
                    scales: {
                        x: {
                            grid: {
                                color: 'rgba(0, 0, 0, 0.5)' // Semi-transparent black grid lines
                            },
                            ticks: {
                                color: '#000', // Black labels
                                font: {
                                    size: 14 // Increased font size
                                }
                            }
                        },
                        y: {
                            grid: {
                                color: 'rgba(0, 0, 0, 0.5)' // Semi-transparent black grid lines
                            },
                            ticks: {
                                color: '#000', // Black labels
                                font: {
                                    size: 14 // Increased font size
                                },
                                beginAtZero: true
                            }
                        }
                    },
                    plugins: {
                        legend: {
                            labels: {
                                color: '#000', // Black legend text
                                font: {
                                    size: 14 // Increased font size
                                }
                            }
                        },
                        tooltip: {
                            backgroundColor: 'rgba(0, 0, 0, 0.8)', // Darker tooltip background
                            titleColor: '#fff', // White title text
                            bodyColor: '#fff' // White body text
                        }
                    }
                }
            });
        })
        .catch(error => {
            console.error("Error fetching data:", error); // Debugging log
        });
    </script>
</body>
</html>
<%
    }
%>
