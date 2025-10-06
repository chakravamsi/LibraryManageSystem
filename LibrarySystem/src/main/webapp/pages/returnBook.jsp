<%@ page import="java.util.List" %>
<%@ page import="model.Book" %>
<!DOCTYPE html>
<html>
<head>
    <title>Return Book | Library Management</title>
    <style>  
        body {
            font-family: 'Segoe UI', Arial, sans-serif;
            background: #f0f2f5;
            padding: 30px;
        }
        h2 {
            color: #333;
            text-align: center;
            margin-bottom: 20px;
        }

      
        table {
            width: 80%;
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
            background-color: #dc3545;
            color: white;
        }
        tr:hover td {
            background-color: #f9e6e6;
        }

       
        .btn-return {
            padding: 6px 14px;
            background-color: #dc3545;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: 0.2s;
        }
        .btn-return:hover {
            background-color: #c82333;
        }

        a {
            display: inline-block;
            text-align: center;
            text-decoration: none;
            color: #007bff;
            margin-top: 15px;
            font-weight: 500;
        }
        a:hover {
            text-decoration: underline;
        }

       
        .links {
            text-align: center;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>

<h2>Return a Book</h2>

<table>
    <tr>
        <th>Book ID</th>
        <th>Title</th>
        <th>Author</th>
        <th>Status</th>
        <th>Action</th>
    </tr>
    <%
        List<Book> issuedBooks = (List<Book>) request.getAttribute("issuedBooks");
        if (issuedBooks != null && !issuedBooks.isEmpty()) {
            for (Book b : issuedBooks) {
    %>
    <tr>
        <td><%= b.getBookId() %></td>
        <td><%= b.getTitle() %></td>
        <td><%= b.getAuthor() %></td>
        <td><%= b.getAvailabilityText() %></td>
        <td>
            <form action="transactions" method="post" style="display:inline;">
                <input type="hidden" name="action" value="return" />
                <input type="hidden" name="bookId" value="<%= b.getBookId() %>" />
                <button type="submit" class="btn-return">Return</button>
            </form>
        </td>
    </tr>
    <% }} else { %>
    <tr><td colspan="5">No issued books found.</td></tr>
    <% } %>
</table>

<div class="links">
    <a href="<%= request.getContextPath() %>/bookLog">View Book Log</a>
    <br/>
    <a href="<%= request.getContextPath() %>/index.jsp">Back to Home</a>
</div>

</body>
</html>
