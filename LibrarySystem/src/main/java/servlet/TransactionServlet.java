package servlet;

import model.Book;
import model.Member;
import util.DBUtil;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/transactions")
public class TransactionServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String view = request.getParameter("view");

        if ("issued".equals(view)) {
            loadIssuedBooks(request, response);
        } else {
            loadAvailableBooksAndMembers(request, response);
        }
    }

    private void loadAvailableBooksAndMembers(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Book> availableBooks = new ArrayList<>();
        List<Member> members = new ArrayList<>();

        try (Connection conn = DBUtil.getConnection()) {
            
            PreparedStatement psBooks = conn.prepareStatement("SELECT * FROM books WHERE availability_status = TRUE");
            ResultSet rsBooks = psBooks.executeQuery();
            while (rsBooks.next()) {
                availableBooks.add(new Book(
                        rsBooks.getInt("book_id"),
                        rsBooks.getString("title"),
                        rsBooks.getString("author"),
                        rsBooks.getBoolean("availability_status")
                ));
            }

            
            Statement stmt = conn.createStatement();
            ResultSet rsMembers = stmt.executeQuery("SELECT * FROM members");
            while (rsMembers.next()) {
                members.add(new Member(
                        rsMembers.getInt("member_id"),
                        rsMembers.getString("name"),
                        rsMembers.getString("contact")
                ));
            }

            request.setAttribute("availableBooks", availableBooks);
            request.setAttribute("members", members);

            RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/issueBook.jsp");
            dispatcher.forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error");
        }
    }

    private void loadIssuedBooks(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Book> issuedBooks = new ArrayList<>();

        try (Connection conn = DBUtil.getConnection()) {
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM books WHERE availability_status = FALSE");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                issuedBooks.add(new Book(
                        rs.getInt("book_id"),
                        rs.getString("title"),
                        rs.getString("author"),
                        rs.getBoolean("availability_status")
                ));
            }

            request.setAttribute("issuedBooks", issuedBooks);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/returnBook.jsp");
            dispatcher.forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("issue".equals(action)) {
            issueBook(request, response);
        } else if ("return".equals(action)) {
            returnBook(request, response);
        } else {
            response.sendRedirect("transactions");
        }
    }

    private void issueBook(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int bookId = Integer.parseInt(request.getParameter("bookId"));
        int memberId = Integer.parseInt(request.getParameter("memberId"));

        try (Connection conn = DBUtil.getConnection()) {
            conn.setAutoCommit(false);

            
            PreparedStatement ps1 = conn.prepareStatement(
                    "INSERT INTO book_transactions (book_id, member_id, issue_date) VALUES (?, ?, ?)"
            );
            ps1.setInt(1, bookId);
            ps1.setInt(2, memberId);
            ps1.setDate(3, Date.valueOf(LocalDate.now()));
            ps1.executeUpdate();

           
            PreparedStatement ps2 = conn.prepareStatement(
                    "UPDATE books SET availability_status = FALSE WHERE book_id = ?"
            );
            ps2.setInt(1, bookId);
            ps2.executeUpdate();

            conn.commit();

        } catch (SQLException e) {
            e.printStackTrace();
        }

        response.sendRedirect("transactions");
    }

    private void returnBook(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int bookId = Integer.parseInt(request.getParameter("bookId"));

        try (Connection conn = DBUtil.getConnection()) {
            conn.setAutoCommit(false);

            
            PreparedStatement ps1 = conn.prepareStatement(
                    "UPDATE book_transactions SET return_date = ? " +
                    "WHERE book_id = ? AND return_date IS NULL"
            );
            ps1.setDate(1, Date.valueOf(LocalDate.now()));
            ps1.setInt(2, bookId);
            ps1.executeUpdate();

            
            PreparedStatement ps2 = conn.prepareStatement(
                    "UPDATE books SET availability_status = TRUE WHERE book_id = ?"
            );
            ps2.setInt(1, bookId);
            ps2.executeUpdate();

            conn.commit();

        } catch (SQLException e) {
            e.printStackTrace();
        }

        response.sendRedirect("transactions?view=issued");
    }
}
