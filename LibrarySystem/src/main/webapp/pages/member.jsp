<%@ page import="java.util.List" %>
<%@ page import="model.Member" %>
<!DOCTYPE html>
<html>
<head>
    <title>Members | Library Management</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f8f9fa; padding: 30px; }
        h2 { color: #333; text-align: center; }
        table { width: 80%; margin: 20px auto; border-collapse: collapse; }
        th, td { padding: 10px; border: 1px solid #ccc; text-align: center; }
        th { background: #28a745; color: white; }
        form { margin: 20px auto; text-align: center; }
        input[type=text] { padding: 8px; margin: 5px; }
        button { padding: 8px 15px; background-color: #28a745; border: none; color: white; border-radius: 5px; cursor: pointer; }
        button:hover { background-color: #1e7e34; }
        a { display: inline-block; margin-top: 20px; text-decoration: none; color: #28a745; }
    </style>
</head>
<body>
    <h2>Manage Members</h2>

    <!-- Add new member -->
    <form action="members" method="post">
        <input type="hidden" name="action" value="add" />
        <input type="text" name="name" placeholder="Member Name" required />
        <input type="text" name="contact" placeholder="Contact" required />
        <button type="submit">Add Member</button>
    </form>

    <!-- Search members -->
    <form action="members" method="get">
        <input type="text" name="search" placeholder="Search by Name or ID" value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>" />
        <button type="submit">Search</button>
    </form>

    <!-- Display all members -->
    <table>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Contact</th>
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
            <td>
                <form action="members" method="post" style="display:inline;">
                    <input type="hidden" name="action" value="delete" />
                    <input type="hidden" name="memberId" value="<%= m.getMemberId() %>" />
                    <button type="submit">Delete</button>
                </form>
            </td>
        </tr>
        <% }} else { %>
        <tr><td colspan="4">No members found</td></tr>
        <% } %>
    </table>

    <div style="text-align:center;">
        <a href="<%= request.getContextPath() %>/index.jsp">Back to Home</a>
    </div>
</body>
</html>
