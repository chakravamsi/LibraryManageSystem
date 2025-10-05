<%@ page import="java.util.List" %>
<%@ page import="model.Book" %>
<!DOCTYPE html>
<html>
<head>
    <title>Books | Library Management</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f8f9fa; padding: 30px; }
        h2 { color: #333; text-align: center; }
        table { width: 80%; margin: 20px auto; border-collapse: collapse; }
        th, td { padding: 10px; border: 1px solid #ccc; text-align: center; }
        th { background: #007bff; color: white; }
        form { margin: 20px auto; text-align: center; }
        input[type=text] { padding: 8px; margin: 5px; }
        button { padding: 8px 15px; background-color: #007bff; border: none; color: white; border-radius: 5px; cursor: pointer; }
        button:hover { background-color: #0056b3; }
        a { display: inline-block; margin-top: 20px; text-decoration: none; color: #007bff; }
    </style>
</head>
<body>
    <h2>Manage Books</h2>

    <!-- Add new book -->
    <form action="books" method="post">
        <input type="hidden" name="action" value="add" />
        <input type="text" name="title" placeholder="Book Title" required />
        <input type="text" name="author" placeholder="Author" required />
        <button type="submit">Add Book</button>
    </form>

    <!-- Search books -->
    <form action="books" method="get">
        <input type="text" name="search" placeholder="Search by Title or Author" value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>" />
        <button type="submit">Search</button>
    </form>

    <!-- Display all books -->
    <table>
        <tr>
            <th>ID</th>
            <th>Title</th>
            <th>Author</th>
            <th>Status</th>
            <th>Action</th>
        </tr>
        <%
            List<Book> books = (List<Book>) request.getAttribute("books");
            if (books != null && !books.isEmpty()) {
                for (Book b : books) {
        %>
        <tr>
            <td><%= b.getBookId() %></td>
            <td><%= b.getTitle() %></td>
            <td><%= b.getAuthor() %></td>
            <td><%= b.getAvailabilityText() %></td>
            <td>
                <form action="books" method="post" style="display:inline;">
                    <input type="hidden" name="action" value="delete" />
                    <input type="hidden" name="bookId" value="<%= b.getBookId() %>" />
                    <button type="submit">Delete</button>
                </form>
            </td>
        </tr>
        <% }} else { %>
        <tr><td colspan="5">No books found</td></tr>
        <% } %>
    </table>

    <div style="text-align:center;">
        <a href="<%= request.getContextPath() %>/index.jsp">Back to Home</a>
    </div>
</body>
</html>
