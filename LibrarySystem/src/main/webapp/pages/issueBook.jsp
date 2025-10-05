<%@ page import="java.util.List" %>
<%@ page import="model.Book" %>
<%@ page import="model.Member" %>
<!DOCTYPE html>
<html>
<head>
    <title>Issue Book | Library Management</title>
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
        form {
            width: 50%;
            margin: 30px auto;
            padding: 20px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            text-align: center;
        }
        select, button {
            padding: 8px;
            margin: 10px;
        }
        button {
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        button:hover {
            background-color: #0056b3;
        }
        a {
            text-decoration: none;
            color: #007bff;
            display: block;
            text-align: center;
            margin-top: 20px;
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
            background: #007bff;
            color: white;
        }
    </style>
</head>
<body>
    <h2> Issue a Book</h2>

    <form action="transactions" method="post">
        <input type="hidden" name="action" value="issue" />
        <label>Choose Book:</label>
        <select name="bookId" required>
            <option value="">-- Select Book --</option>
            <%
                List<Book> availableBooks = (List<Book>) request.getAttribute("availableBooks");
                if (availableBooks != null) {
                    for (Book b : availableBooks) {
            %>
            <option value="<%= b.getBookId() %>"><%= b.getTitle() %> by <%= b.getAuthor() %></option>
            <% }} %>
        </select>
        <br/>
        <label>Choose Member:</label>
        <select name="memberId" required>
            <option value="">-- Select Member --</option>
            <%
                List<Member> members = (List<Member>) request.getAttribute("members");
                if (members != null) {
                    for (Member m : members) {
            %>
            <option value="<%= m.getMemberId() %>"><%= m.getName() %></option>
            <% }} %>
        </select>
        <br/>
        <button type="submit">Issue Book</button>
    </form>
    <div style="text-align:center; margin-bottom:20px;">
    	<a href="<%= request.getContextPath() %>/bookLog"> View Book Log</a>
	</div>
    

    <div style="text-align:center;">
        <a href="<%= request.getContextPath() %>/index.jsp"> Back to Home</a>

    </div>
</body>
</html>
