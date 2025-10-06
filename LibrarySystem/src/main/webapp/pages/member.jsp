<%@ page import="java.util.List" %>
<%@ page import="model.Member" %>
<!DOCTYPE html>
<html>
<head>
    <title>Members | Library Management</title>
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
            max-width: 1000px;
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
        .add-form input[type=text], .add-form select {
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
            background-color: #28a745;
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

<h2>Manage Members</h2>

<!-- Search Box -->
<div class="search-box">
    <form action="members" method="get">
        <input type="text" name="search" placeholder="Search by Name or ID"
               value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>" />
        <button type="submit" class="btn-search">Search</button>
    </form>
</div>

<%
    Member memberToEdit = (Member) request.getAttribute("memberToEdit");
%>


<div class="add-form">
    <form action="members" method="post">
        <input type="hidden" name="action" value="<%= (memberToEdit != null) ? "edit" : "add" %>" />
        <% if (memberToEdit != null) { %>
            <input type="hidden" name="memberId" value="<%= memberToEdit.getMemberId() %>" />
        <% } %>

        <input type="text" name="name" placeholder="Member Name"
               value="<%= (memberToEdit != null) ? memberToEdit.getName() : "" %>" required />
        <input type="text" name="contact" placeholder="Contact"
               value="<%= (memberToEdit != null) ? memberToEdit.getContact() : "" %>" required />
        <select name="role" required>
            <option value="">Select Role</option>
            <option value="Student" <%= (memberToEdit != null && "Student".equals(memberToEdit.getRole())) ? "selected" : "" %>>Student</option>
            <option value="Faculty" <%= (memberToEdit != null && "Faculty".equals(memberToEdit.getRole())) ? "selected" : "" %>>Faculty</option>
        </select>

        <button type="submit" class="btn-add"><%= (memberToEdit != null) ? "Update Member" : "Add Member" %></button>
        <% if (memberToEdit != null) { %>
            <a href="members" class="btn-cancel">Cancel Edit</a>
        <% } %>
    </form>
</div>


<table>
    <tr>
        <th>ID</th>
        <th>Name</th>
        <th>Contact</th>
        <th>Role</th>
        <th>Action</th>
    </tr>
    <%
        List<Member> members = (List<Member>) request.getAttribute("members");
        if (members != null && !members.isEmpty()) {
            for (Member m : members) {
    %>
    <tr>
        <td><%= m.getMemberId() %></td>
        <td><%= m.getName() %></td>
        <td><%= m.getContact() %></td>
        <td><%= m.getRole() %></td>
        <td>
            <a href="members?editId=<%= m.getMemberId() %>" class="btn-edit">Edit</a>
            <form action="members" method="post" style="display:inline-block; margin-left:5px;">
                <input type="hidden" name="action" value="delete" />
                <input type="hidden" name="memberId" value="<%= m.getMemberId() %>" />
                <button type="submit" class="btn-delete">Delete</button>  
            </form>
        </td>
    </tr>
    <% }} else { %>
    <tr><td colspan="5">No members found</td></tr>
    <% } %>
</table>

<div class="back-link">
    <a href="<%= request.getContextPath() %>/index.jsp">Back to Home</a>
</div>

</body>
</html>
