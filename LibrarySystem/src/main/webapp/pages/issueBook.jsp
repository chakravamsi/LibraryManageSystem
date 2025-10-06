<%@ page import="java.util.List" %>
<%@ page import="model.Book" %>
<%@ page import="model.Member" %>
<!DOCTYPE html>
<html>
<head>
    <title>Issue Book | Library Management</title>
    <style>
        body {
            font-family: 'Segoe UI', Arial, sans-serif;
            background: #f0f2f5;
            padding: 30px;
        }
        h2 {
            color: #333;
            text-align: center;
            margin-bottom: 25px;
        }

        
        .form-card {
            max-width: 500px;
            margin: 0 auto 30px;
            padding: 25px;
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            text-align: center;
        }

        .form-card select {
            width: 100%;
            padding: 10px 12px;
            margin: 12px 0;
            border-radius: 6px;
            border: 1px solid #ccc;
            font-size: 16px;
        }

        .btn {
            padding: 10px 18px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-weight: 500;
            transition: 0.2s;
        }

        .btn-issue { background-color: #28a745; color: white; width: 60%; margin-top: 15px; }
        .btn-issue:hover { background-color: #218838; }

        .btn-link {
            display: inline-block;
            margin: 12px 0;
            color: #007bff;
            text-decoration: none;
            transition: 0.2s;
        }
        .btn-link:hover { text-decoration: underline; }

        
        table {
            width: 80%;
            margin: 20px auto 30px;
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

       
        .back-link {
            text-align: center;
            margin-top: 20px;
        }
        .back-link a {
            color: #007bff;
            text-decoration: none;
        }
        .back-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<h2>Issue a Book</h2>


<div class="form-card">
    <form action="transactions" method="post">
        <input type="hidden" name="action" value="issue" />

        <label for="bookId">Choose Book:</label>
        <select name="bookId" id="bookId" required>
            <option value="">-- Select Book --</option>
            <%
                List<Book> availableBooks = (List<Book>) request.getAttribute("availableBooks");
                if (availableBooks != null) {
                    for (Book b : availableBooks) {
            %>
            <option value="<%= b.getBookId() %>"><%= b.getTitle() %> by <%= b.getAuthor() %></option>
            <% }} %>
        </select>

        <label for="memberId">Choose Member:</label>  
        <select name="memberId" id="memberId" required>
            <option value="">-- Select Member --</option>
            <%
                List<Member> members = (List<Member>) request.getAttribute("members");
                if (members != null) {
                    for (Member m : members) {
            %>
            <option value="<%= m.getMemberId() %>"><%= m.getName() %></option>
            <% }} %>
        </select>

        <button type="submit" class="btn btn-issue">Issue Book</button>
    </form>

    <a href="<%= request.getContextPath() %>/bookLog" class="btn-link">View Book Log</a>
</div>

<!-- Back Home Link -->
<div class="back-link">
    <a href="<%= request.getContextPath() %>/index.jsp">Back to Home</a>
</div>

</body>
</html>
