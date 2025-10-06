<%@ page import="java.util.List" %>
<%@ page import="servlet.BookLogServlet.BookLog" %>
<!DOCTYPE html>
<html>
<head>
    <title>Book Log | Library Management</title>
    <style>
        body {
            font-family: 'Segoe UI', Arial, sans-serif;
            background: #f0f2f5;
            padding: 30px;
        }
        h2 {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
        }

       
        table {
            width: 90%;
            margin: 20px auto 30px;
            border-collapse: collapse;
            background: #fff;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            border-radius: 8px;
            overflow: hidden;
        }
        th, td {
            padding: 12px;
            border-bottom: 1px solid #eee;
            text-align: center;
        }
        th {
            background-color: #6c757d;
            color: white;
        }
        tr:nth-child(even) td {
            background-color: #f9f9f9;
        }
        tr:hover td {
            background-color: #e9ecef;
        }

        
        a {
            display: inline-block;
            margin-top: 20px;
            text-decoration: none;
            color: #007bff;
            font-weight: 500;
        }
        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <h2>Book Issue / Return Log</h2>

    <table>
        <tr>
            <th>Book Title</th>
            <th>Member Name</th>
            <th>Role</th>
            <th>Issue Date</th>
            <th>Due Date</th>
            <th>Return Date</th>
            <th>Fine </th>
        </tr>

        <%
            List<BookLog> logs = (List<BookLog>) request.getAttribute("logs");
            if (logs != null && !logs.isEmpty()) {
                for (BookLog log : logs) {
        %>
        <tr>
            <td><%= log.getBookTitle() %></td>
            <td><%= log.getMemberName() %></td>
            <td><%= log.getRole() != null ? log.getRole() : "-" %></td>
            <td><%= log.getIssueDate() %></td>
            <td><%= log.getDueDate() %></td>
            <td><%= log.getReturnDate() != null ? log.getReturnDate() : "Not Returned" %></td>
            <td><%= log.getFine() > 0 ? log.getFine() : "0" %></td>
        </tr>
        <% }} else { %>
        <tr><td colspan="7">No logs found</td></tr>
        <% } %>
    </table>

    <div style="text-align:center;">
        <a href="<%= request.getContextPath() %>/index.jsp">Back to Home</a>
    </div>
</body>
</html>
