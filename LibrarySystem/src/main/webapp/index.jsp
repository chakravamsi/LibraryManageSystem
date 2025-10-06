<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Library Management System</title>
    <style>
        body {
            font-family: 'Segoe UI', Arial, sans-serif;
            background: linear-gradient(135deg, #74ebd5, #acb6e5);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .container {
            background: white;
            padding: 40px 60px;
            border-radius: 16px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.15);
            text-align: center;
            max-width: 600px;
            width: 100%;
        }

        h1 {
            color: #333;
            margin-bottom: 10px;
            font-size: 2.5em;
        }

        h3 {
            color: #555;
            margin-bottom: 30px;
            font-weight: normal;
        }

        .options {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
        }

        .card {
            background-color: #007bff;
            color: white;
            padding: 20px;
            border-radius: 12px;
            font-size: 1.1em;
            text-decoration: none;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: 0.3s;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }

        .card:hover {
            background-color: #0056b3;
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(0,0,0,0.2);
        }

        .card span {
            margin-left: 10px;
            font-size: 1.5em;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>📚 Library Management</h1>
        <h3>Welcome! Choose an option:</h3>
        <div class="options">
            <a href="books" class="card">Manage Books <span>📖</span></a>
            <a href="members" class="card">Manage Members <span>👥</span></a>
            <a href="transactions?action=issue" class="card">Issue Book <span>📝</span></a>
            <a href="<%= request.getContextPath() %>/transactions?view=issued" class="card">Return Book <span>↩️</span></a>
        </div>
    </div>
</body>
</html>
