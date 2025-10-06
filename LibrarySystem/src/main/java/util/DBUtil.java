package util;

import java.sql.*;

public class DBUtil {
    private static final String URL = "jdbc:mysql://localhost:3306/librarydb";
    private static final String USERNAME = "root";
    private static final String PASSWORD = "mysql@1205";

    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");  
        } catch (ClassNotFoundException e) {  
            e.printStackTrace();
        }
        return DriverManager.getConnection(URL, USERNAME, PASSWORD);
    }

    public static void initializeDatabase() {
        try (Connection conn = getConnection()) {
            Statement stmt = conn.createStatement();

            stmt.execute("CREATE TABLE IF NOT EXISTS admins (admin_id INT AUTO_INCREMENT PRIMARY KEY, username VARCHAR(50) UNIQUE, password VARCHAR(100))");
            stmt.execute("CREATE TABLE IF NOT EXISTS books (book_id INT AUTO_INCREMENT PRIMARY KEY, title VARCHAR(200), author VARCHAR(100), availability_status BOOLEAN DEFAULT TRUE)");
            stmt.execute("CREATE TABLE IF NOT EXISTS members (member_id INT AUTO_INCREMENT PRIMARY KEY, name VARCHAR(100), contact VARCHAR(50), password VARCHAR(100))");
            stmt.execute("CREATE TABLE IF NOT EXISTS transactions (transaction_id INT AUTO_INCREMENT PRIMARY KEY, book_id INT, member_id INT, issue_date DATE, return_date DATE, FOREIGN KEY(book_id) REFERENCES books(book_id), FOREIGN KEY(member_id) REFERENCES members(member_id))");

            PreparedStatement ps = conn.prepareStatement("INSERT IGNORE INTO admins (username, password) VALUES (?, ?)");
            ps.setString(1, "admin");
            ps.setString(2, "admin123");
            ps.executeUpdate();

            System.out.println("Database initialized successfully!");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
