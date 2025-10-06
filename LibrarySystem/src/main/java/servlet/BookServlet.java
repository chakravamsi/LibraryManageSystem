package servlet;

import model.Book;
import util.DBUtil;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;   
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/books")
public class BookServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String search = request.getParameter("search");
        String editId = request.getParameter("editId");
        List<Book> books = new ArrayList<>();

        try (Connection conn = DBUtil.getConnection()) {

            
            if (editId != null) {
                PreparedStatement ps = conn.prepareStatement("SELECT * FROM books WHERE book_id = ?");
                ps.setInt(1, Integer.parseInt(editId));
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    Book bookToEdit = new Book(
                            rs.getInt("book_id"),
                            rs.getString("title"),
                            rs.getString("author"),
                            rs.getBoolean("availability_status")
                    );
                    request.setAttribute("bookToEdit", bookToEdit);
                }
            }

           
            PreparedStatement ps;
            if (search != null && !search.trim().isEmpty()) {
                ps = conn.prepareStatement(
                        "SELECT * FROM books WHERE title LIKE ? OR author LIKE ?");
                ps.setString(1, "%" + search.trim() + "%");
                ps.setString(2, "%" + search.trim() + "%");
            } else {
                ps = conn.prepareStatement("SELECT * FROM books");
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                books.add(new Book(
                        rs.getInt("book_id"),
                        rs.getString("title"),
                        rs.getString("author"),
                        rs.getBoolean("availability_status")
                ));
            }

            request.setAttribute("books", books);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/book.jsp");
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
            addBook(request, response);
        } else if ("delete".equals(action)) {
            deleteBook(request, response);
        } else if ("edit".equals(action)) {
            editBook(request, response);
        } else {
            response.sendRedirect("books");
        }
    }

    private void addBook(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String title = request.getParameter("title");
        String author = request.getParameter("author");

        try (Connection conn = DBUtil.getConnection()) {
            PreparedStatement ps = conn.prepareStatement(
                    "INSERT INTO books (title, author) VALUES (?, ?)");
            ps.setString(1, title);
            ps.setString(2, author);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        response.sendRedirect("books");
    }

    private void deleteBook(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int bookId = Integer.parseInt(request.getParameter("bookId"));

        try (Connection conn = DBUtil.getConnection()) {
            PreparedStatement ps = conn.prepareStatement(
                    "DELETE FROM books WHERE book_id = ?");
            ps.setInt(1, bookId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        response.sendRedirect("books");
    }

    private void editBook(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int bookId = Integer.parseInt(request.getParameter("bookId"));
        String title = request.getParameter("title");
        String author = request.getParameter("author");

        try (Connection conn = DBUtil.getConnection()) {
            PreparedStatement ps = conn.prepareStatement(
                    "UPDATE books SET title = ?, author = ? WHERE book_id = ?");
            ps.setString(1, title);
            ps.setString(2, author);
            ps.setInt(3, bookId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        response.sendRedirect("books");
    }
}
