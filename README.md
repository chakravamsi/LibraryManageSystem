# Library Management System

## Project Overview

The Library Management System is a web-based application that helps manage a library efficiently. It allows the admin to handle book inventory, member records, issue and return books, and track all transactions with issue/return dates. The system provides an intuitive interface for smooth library operations.

## Features

* **Manage Books**: Add, delete, view, and search books by title or author.
* **Manage Members**: Add, delete, view, and search members by name or ID.
* **Issue Books**: Issue available books to members and update availability status.
* **Return Books**: Return issued books and update availability.
* **Book Transactions Log**: Maintains a record of all issued and returned books with dates.
* **Dashboard**: View total books, total members, and books currently issued.

## Tech Stack

* **Backend**: Java, Servlets, JSP
* **Database**: MySQL
* **Frontend**: JSP, HTML, CSS
* **Tools**: Eclipse/IntelliJ IDEA, MySQL Workbench

## Database Design

### Tables

1. **books**

   * `book_id` (INT, PK)
   * `title` (VARCHAR)
   * `author` (VARCHAR)
   * `availability_status` (BOOLEAN)

2. **members**

   * `member_id` (INT, PK)
   * `name` (VARCHAR)
   * `contact` (VARCHAR)

3. **book_transactions**

   * `transaction_id` (INT, PK)
   * `book_id` (INT, FK → books)
   * `member_id` (INT, FK → members)
   * `issue_date` (DATE)
   * `return_date` (DATE, NULL if not returned)

## How to Run

1. Clone this repository.
2. Import it into your IDE (Eclipse/IntelliJ IDEA) as a **Dynamic Web Project**.
3. Configure **Tomcat server** and **MySQL database connection** (`DBUtil.java`).
4. Create the database schema and tables in MySQL:

```sql
CREATE DATABASE librarydb;
USE librarydb;

-- Books table
CREATE TABLE books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255),
    author VARCHAR(255),
    availability_status BOOLEAN DEFAULT TRUE
);

-- Members table
CREATE TABLE members (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    contact VARCHAR(100)
);

-- Book transactions table
CREATE TABLE book_transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT NOT NULL,
    member_id INT NOT NULL,
    issue_date DATE NOT NULL,
    return_date DATE,
    FOREIGN KEY (book_id) REFERENCES books(book_id),
    FOREIGN KEY (member_id) REFERENCES members(member_id)
);
```

5. Run the project on the **Tomcat server**.
6. Access the application at: `http://localhost:8080/LibraryManagementSystem/index.jsp`


