-- Create and use the library management database
CREATE DATABASE library_management;
USE library_management;

-- Authors table: Stores information about book authors
-- Columns:
--   author_id: Unique identifier for each author
--   name: Author's full name
--   nationality: Author's country of origin
--   birth_year: Author's birth year
CREATE TABLE authors (
    author_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    nationality VARCHAR(50),
    birth_year INT
);

-- Categories table: Stores book categories/genres
-- Columns:
--   category_id: Unique identifier for each category
--   name: Category name (must be unique)
--   description: Detailed description of the category
CREATE TABLE categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL UNIQUE,
    description TEXT
);

-- Books table: Main table storing book information
-- Columns:
--   book_id: Unique identifier for each book
--   title: Book title
--   author_id: Foreign key to authors table
--   category_id: Foreign key to categories table
--   isbn: International Standard Book Number (unique)
--   publication_year: Year the book was published
--   copies_available: Number of copies available for lending
CREATE TABLE books (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(200) NOT NULL,
    author_id INT,
    category_id INT,
    isbn VARCHAR(13) UNIQUE,
    publication_year INT,
    copies_available INT DEFAULT 1,
    FOREIGN KEY (author_id) REFERENCES authors(author_id),
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

-- Members table: Stores library member information
-- Columns:
--   member_id: Unique identifier for each member
--   name: Member's full name
--   email: Member's email address (unique)
--   join_date: Date when member joined the library
--   status: Member's current status (active/suspended)
CREATE TABLE members (
    member_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    join_date DATE DEFAULT CURRENT_DATE,
    status ENUM('active', 'suspended') DEFAULT 'active'
);

-- Loans table: Tracks book borrowing records
-- Columns:
--   loan_id: Unique identifier for each loan
--   book_id: Foreign key to books table
--   member_id: Foreign key to members table
--   loan_date: Date when book was borrowed
--   due_date: Expected return date
--   return_date: Actual return date (NULL if not returned)
CREATE TABLE loans (
    loan_id INT PRIMARY KEY AUTO_INCREMENT,
    book_id INT,
    member_id INT,
    loan_date DATE NOT NULL,
    due_date DATE NOT NULL,
    return_date DATE,
    FOREIGN KEY (book_id) REFERENCES books(book_id),
    FOREIGN KEY (member_id) REFERENCES members(member_id)
);

-- Sample data insertion for testing
-- Adding example authors
INSERT INTO authors (name, nationality, birth_year) VALUES
('J.K. Rowling', 'British', 1965),
('George Orwell', 'British', 1903);

-- Adding example categories
INSERT INTO categories (name, description) VALUES
('Fiction', 'Literary works created from imagination'),
('Science Fiction', 'Fiction based on scientific discoveries');

-- Adding example books
INSERT INTO books (title, author_id, category_id, isbn) VALUES
('Harry Potter', 1, 1, '9780747532699'),
('1984', 2, 2, '9780451524935');

-- Adding example members
INSERT INTO members (name, email) VALUES
('John Doe', 'john@example.com'),
('Jane Smith', 'jane@example.com'),
('Almando Hafenaaje', 'almandocode@gmail.com');
