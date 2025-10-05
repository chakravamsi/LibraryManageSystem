<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Library Management System</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f6f9fc;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100vh;
            margin: 0;
        }
        h1 {
            color: #333;
        }
        .container {
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            text-align: center;
        }
        a {
            display: inline-block;
            margin: 10px;
            padding: 12px 20px;
            background-color: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 8px;
            transition: 0.3s;
        }
        a:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>📚 Library Management System</h1>
        <h3>Welcome! Choose an option below:</h3>
        <div>
            <a href="books">Manage Books</a>
            <a href="members">Manage Members</a>
            <a href="transactions?action=issue">Issue Book</a>
            <a href="<%= request.getContextPath() %>/transactions?view=issued">Return Book</a>

        </div>
    </div>
</body>
</html>
