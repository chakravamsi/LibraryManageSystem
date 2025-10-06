package servlet;

import util.DBUtil;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/bookLog")
public class BookLogServlet extends HttpServlet {

    public static class BookLog {
        private String bookTitle;
        private String memberName;
        private String role;
        private Date issueDate;
        private Date returnDate;
        private Date dueDate;
        private double fine;

        public BookLog(String bookTitle, String memberName, String role, Date issueDate, Date returnDate, Date dueDate, double fine) {
            this.bookTitle = bookTitle;
            this.memberName = memberName;
            this.role = role;
            this.issueDate = issueDate;
            this.returnDate = returnDate;
            this.dueDate = dueDate;
            this.fine = fine;
        }

        public String getBookTitle() { return bookTitle; }
        public String getMemberName() { return memberName; }
        public String getRole() { return role; }
        public Date getIssueDate() { return issueDate; }
        public Date getReturnDate() { return returnDate; }
        public Date getDueDate() { return dueDate; }
        public double getFine() { return fine; }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<BookLog> logs = new ArrayList<>();

        try (Connection conn = DBUtil.getConnection()) {
            PreparedStatement ps = conn.prepareStatement(
                "SELECT b.title, m.name, m.role, bt.issue_date, bt.return_date " +
                "FROM book_transactions bt " +
                "JOIN books b ON bt.book_id = b.book_id " +
                "JOIN members m ON bt.member_id = m.member_id " +
                "ORDER BY bt.issue_date DESC"
            );

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                String title = rs.getString("title");
                String name = rs.getString("name");
                String role = rs.getString("role");
                Date issueDate = rs.getDate("issue_date");
                Date returnDate = rs.getDate("return_date");

                
                LocalDate issue = issueDate.toLocalDate();
                LocalDate due = role != null && role.equalsIgnoreCase("Faculty")
                        ? issue.plusDays(30)
                        : issue.plusDays(14);

                Date dueDate = Date.valueOf(due);

                  
                LocalDate compareDate = (returnDate != null)
                        ? returnDate.toLocalDate()
                        : LocalDate.now();

                long daysLate = ChronoUnit.DAYS.between(due, compareDate);
                double fine = (daysLate > 0) ? daysLate * 5.0 : 0.0;

                logs.add(new BookLog(title, name, role, issueDate, returnDate, dueDate, fine));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        request.setAttribute("logs", logs);
        request.getRequestDispatcher("/pages/bookLog.jsp").forward(request, response);
    }
}
