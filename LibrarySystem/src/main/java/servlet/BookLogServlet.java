package servlet;

import util.DBUtil;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/bookLog")
public class BookLogServlet extends HttpServlet {

    public static class BookLog {
        private String bookTitle;
        private String memberName;
        private Date issueDate;
        private Date returnDate;

        public BookLog(String bookTitle, String memberName, Date issueDate, Date returnDate) {
            this.bookTitle = bookTitle;
            this.memberName = memberName;
            this.issueDate = issueDate;
            this.returnDate = returnDate;
        }

        public String getBookTitle() { return bookTitle; }
        public String getMemberName() { return memberName; }
        public Date getIssueDate() { return issueDate; }
        public Date getReturnDate() { return returnDate; }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<BookLog> logs = new ArrayList<>();

        try (Connection conn = DBUtil.getConnection()) {
            PreparedStatement ps = conn.prepareStatement(
                "SELECT b.title, m.name, bt.issue_date, bt.return_date " +
                "FROM book_transactions bt " +
                "JOIN books b ON bt.book_id = b.book_id " +
                "JOIN members m ON bt.member_id = m.member_id " +
                "ORDER BY bt.issue_date DESC"
            );
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                logs.add(new BookLog(
                    rs.getString("title"),
                    rs.getString("name"),
                    rs.getDate("issue_date"),
                    rs.getDate("return_date")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        request.setAttribute("logs", logs);
        request.getRequestDispatcher("/pages/bookLog.jsp").forward(request, response);
    }
}
