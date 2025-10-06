# Library Management System

A comprehensive web-based library management system built with Java Servlets, JSP, and MySQL. This application streamlines library operations including book management, member management, book issuing/returning, and automated fine calculation.

## Features

### Book Management
- **Add Books**: Register new books with details like title, author 
- **Edit Books**: Update existing book information
- **Delete Books**: Remove books from the inventory
- **Search Books**: Quick search functionality to find books by title, author

### Member Management
- **Add Members**: Register new library members with personal details
- **Edit Members**: Update member information
- **Delete Members**: Remove members from the system
- **Search Members**: Find members by name, ID,role and contact information

### Book Circulation
- **Issue Books**: Assign books to members with automatic due date calculation
- **Return Books**: Process book returns with automatic fine calculation for overdue items
- **Transaction Log**: Complete history of all book issues and returns
- **Fine Management**: Automatic fine calculation based on due dates and overdue periods

## Tech Stack

- **Backend**: Java, Servlets
- **Frontend**: JSP (JavaServer Pages), HTML, CSS.
- **Database**: MySQL
- **Server**: Apache Tomcat (or any Servlet container)


### Managing Books
1. Navigate to the Books section
2. Click "Add New Book" to register a book
3. Use the search bar to find specific books
4. Click "Edit" or "Delete" to modify book records

### Managing Members
1. Go to the Members section
2. Click "Add New Member" to register a member
3. Search for members using the search functionality
4. Update or remove member records as needed

### Issuing & Returning Books
1. Navigate to the Transactions section
2. Select "Issue Book" and choose a member and available book
3. The system automatically calculates the due date
4. To return a book, select "Return Book" and choose the transaction
5. Fines are automatically calculated for overdue returns



