<%@ page import="java.util.List" %>
<%@ page import="servlet.BookLogServlet.BookLog" %>
<!DOCTYPE html>
<html>
<head>
    <title>Book Log | Library Management</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f8f9fa; padding: 30px; }
        h2 { text-align: center; color: #333; }
        table { width: 90%; margin: 20px auto; border-collapse: collapse; }
        th, td { padding: 10px; border: 1px solid #ccc; text-align: center; }
        th { background-color: #6c757d; color: white; }
        a { display: inline-block; margin-top: 20px; text-decoration: none; color: #007bff; }
    </style>
</head>
<body>
    <h2> Book Issue/Return Log</h2>
    <table>
        <tr>
            <th>Book Title</th>
            <th>Member Name</th>
            <th>Issue Date</th>
            <th>Return Date</th>
        </tr>
        <%
            List<BookLog> logs = (List<BookLog>) request.getAttribute("logs");
            if (logs != null && !logs.isEmpty()) {
                for (BookLog log : logs) {
        %>
        <tr>
            <td><%= log.getBookTitle() %></td>
            <td><%= log.getMemberName() %></td>
            <td><%= log.getIssueDate() %></td>
            <td><%= log.getReturnDate() != null ? log.getReturnDate() : "Not Returned" %></td>
        </tr>
        <% }} else { %>
        <tr><td colspan="4">No logs found</td></tr>
        <% } %>
    </table>

    <div style="text-align:center;">
        <a href="<%= request.getContextPath() %>/index.jsp">Back to Home</a>
    </div>
</body>
</html>
