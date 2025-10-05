<%@ page import="java.util.List" %>
<%@ page import="model.Book" %>
<!DOCTYPE html>
<html>
<head>
    <title>Return Book | Library Management</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f8f9fa;
            padding: 30px;
        }
        h2 {
            color: #333;
            text-align: center;
        }
        table {
            width: 80%;
            margin: 20px auto;
            border-collapse: collapse;
        }
        th, td {
            padding: 10px;
            border: 1px solid #ccc;
            text-align: center;
        }
        th {
            background: #dc3545;
            color: white;
        }
        button {
            padding: 6px 12px;
            background-color: #dc3545;
            border: none;
            color: white;
            border-radius: 5px;
            cursor: pointer;
        }
        button:hover {
            background-color: #c82333;
        }
        a {
            display: block;
            text-align: center;
            text-decoration: none;
            color: #dc3545;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <h2> Return a Book</h2>

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
                    <button type="submit">Return</button>
                </form>
            </td>
        </tr>
        <% }} else { %>
        <tr><td colspan="5">No issued books found.</td></tr>
        <% } %>
    </table>
    
    <div style="text-align:center; margin-bottom:20px;">
    	<a href="<%= request.getContextPath() %>/bookLog"> View Book Log</a>
	</div>
    

    <div style="text-align:center;">
        <a href="<%= request.getContextPath() %>/index.jsp"> Back to Home</a>

    </div>
</body>
</html>
