<%@ page import="java.util.List" %>
<%@ page import="model.Book" %>
<!DOCTYPE html>
<html>
<head>
    <title>Books | Library Management</title>
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

        
        .search-box {
            width: 80%;
            margin: 0 auto 20px;
            text-align: right;
        }
        .search-box input[type=text] {
            padding: 8px 12px;
            width: 220px;
            border-radius: 6px;
            border: 1px solid #ccc;
        }
        .btn-search {
            padding: 8px 15px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            transition: 0.2s;
        }
        .btn-search:hover { background-color: #0056b3; }

        
        .add-form {
            width: 80%;
            max-width: 900px;
            margin: 0 auto 30px;
            text-align: center;
        }
        .add-form form {
            display: flex;
            justify-content: center;
            gap: 10px;
            flex-wrap: wrap;
            align-items: center;
        }
        .add-form input[type=text] {
            padding: 8px 12px;
            border-radius: 6px;
            border: 1px solid #ccc;
            font-size: 14px;
        }
        .btn-add {
            padding: 8px 18px;
            border: none;
            border-radius: 6px;
            background-color: #28a745;
            color: white;
            font-weight: 500;
            cursor: pointer;
            transition: 0.2s;
        }
        .btn-add:hover { background-color: #218838; }
        .btn-cancel {
            display: inline-block;
            color: #dc3545;
            text-decoration: none;
            font-weight: 500;
        }
        .btn-cancel:hover { text-decoration: underline; }

        
        table {
            width: 80%;
            margin: 0 auto 30px;
            border-collapse: collapse;
            border-radius: 8px;
            overflow: hidden;
            background: #fff;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
        }
        th, td {
            padding: 12px;
            border-bottom: 1px solid #eee;
            text-align: center;
        }
        th {
            background-color: #007bff;
            color: white;
        }
        tr:hover td {
            background-color: #f1f1f1;
        }
        .btn-edit {
            background-color: #ffc107;
            color: black;
            padding: 6px 12px;
            border-radius: 5px;
            text-decoration: none;
            font-weight: 500;
        }
        .btn-edit:hover { background-color: #e0a800; }
        .btn-delete {
            background-color: #dc3545;
            color: white;
            padding: 6px 12px;
            border-radius: 5px;
            border: none;
            cursor: pointer;
        }
        .btn-delete:hover { background-color: #b02a37; }

       
        .back-link {
            text-align: center;
            margin-top: 20px;
        }
        .back-link a {
            color: #007bff;
            text-decoration: none;
        }
        .back-link a:hover { text-decoration: underline; }
    </style>
</head>
<body>

<h2>Manage Books</h2>

<!-- Search Box -->
<div class="search-box">
    <form action="books" method="get">
        <input type="text" name="search" placeholder="Search by Title or Author"
               value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>" />
        <button type="submit" class="btn-search">Search</button>
    </form>
</div>

<%
    Book bookToEdit = (Book) request.getAttribute("bookToEdit");
%>

<!-- Add/Edit Book Form Horizontal -->
<div class="add-form">
    <form action="books" method="post">
        <input type="hidden" name="action" value="<%= (bookToEdit != null) ? "edit" : "add" %>" />
        <% if (bookToEdit != null) { %>
            <input type="hidden" name="bookId" value="<%= bookToEdit.getBookId() %>" />
        <% } %>

        <input type="text" name="title" placeholder="Book Title"
               value="<%= (bookToEdit != null) ? bookToEdit.getTitle() : "" %>" required />
        <input type="text" name="author" placeholder="Author"
               value="<%= (bookToEdit != null) ? bookToEdit.getAuthor() : "" %>" required />
        <button type="submit" class="btn-add"><%= (bookToEdit != null) ? "Update Book" : "Add Book" %></button>
        <% if (bookToEdit != null) { %>
            <a href="books" class="btn-cancel">Cancel Edit</a>
        <% } %>
    </form>
</div>


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
            <a href="books?editId=<%= b.getBookId() %>" class="btn-edit">Edit</a>
            <form action="books" method="post" style="display:inline-block; margin-left:5px;">
                <input type="hidden" name="action" value="delete" />
                <input type="hidden" name="bookId" value="<%= b.getBookId() %>" />
                <button type="submit" class="btn-delete" 
                        onclick="return confirm('Are you sure to delete this book?');">Delete</button>
            </form>
        </td>
    </tr>
    <% }} else { %>
    <tr><td colspan="5">No books found</td></tr>
    <% } %>
</table>

<div class="back-link">
    <a href="<%= request.getContextPath() %>/index.jsp">Back to Home</a>
</div>

</body>
</html>
