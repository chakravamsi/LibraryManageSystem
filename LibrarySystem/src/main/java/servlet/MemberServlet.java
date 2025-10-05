package servlet;

import model.Member;
import util.DBUtil;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/members")
public class MemberServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String search = request.getParameter("search"); // Get search query
        List<Member> members = new ArrayList<>();

        try (Connection conn = DBUtil.getConnection()) {
            PreparedStatement ps;

            if (search != null && !search.trim().isEmpty()) {
                // Search by name or ID
                ps = conn.prepareStatement(
                        "SELECT * FROM members WHERE name LIKE ? OR member_id LIKE ?");
                ps.setString(1, "%" + search.trim() + "%");
                ps.setString(2, "%" + search.trim() + "%");
            } else {
                // Get all members
                ps = conn.prepareStatement("SELECT * FROM members");
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                members.add(new Member(
                        rs.getInt("member_id"),
                        rs.getString("name"),
                        rs.getString("contact")
                ));
            }

            request.setAttribute("members", members);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/member.jsp");
            dispatcher.forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("add".equals(action)) {
            addMember(request, response);
        } else if ("delete".equals(action)) {
            deleteMember(request, response);
        } else {
            response.sendRedirect("members");
        }
    }

    private void addMember(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String name = request.getParameter("name");
        String contact = request.getParameter("contact");

        try (Connection conn = DBUtil.getConnection()) {
            PreparedStatement ps = conn.prepareStatement(
                    "INSERT INTO members (name, contact) VALUES (?, ?)");
            ps.setString(1, name);
            ps.setString(2, contact);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        response.sendRedirect("members");
    }

    private void deleteMember(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int memberId = Integer.parseInt(request.getParameter("memberId"));

        try (Connection conn = DBUtil.getConnection()) {
            PreparedStatement ps = conn.prepareStatement(
                    "DELETE FROM members WHERE member_id = ?");
            ps.setInt(1, memberId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        response.sendRedirect("members");
    }
}
