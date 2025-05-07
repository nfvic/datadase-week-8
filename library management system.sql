-- Drop existing tables if they exist
DROP TABLE IF EXISTS Loan, Book_Author, Book, Author, Publisher, Member;

-- Publisher Table
CREATE TABLE Publisher (
    publisher_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    address VARCHAR(255)
);

-- Author Table
CREATE TABLE Author (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL
);

-- Book Table
CREATE TABLE Book (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    isbn VARCHAR(20) NOT NULL UNIQUE,
    published_year YEAR,
    publisher_id INT,
    FOREIGN KEY (publisher_id) REFERENCES Publisher(publisher_id)
);

-- Book_Author Table (Many-to-Many)
CREATE TABLE Book_Author (
    book_id INT,
    author_id INT,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES Book(book_id),
    FOREIGN KEY (author_id) REFERENCES Author(author_id)
);

-- Member Table
CREATE TABLE Member (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    membership_date DATE NOT NULL
);

-- Loan Table (1 Member : M Loans)
CREATE TABLE Loan (
    loan_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT NOT NULL,
    member_id INT NOT NULL,
    loan_date DATE NOT NULL,
    return_date DATE,
    FOREIGN KEY (book_id) REFERENCES Book(book_id),
    FOREIGN KEY (member_id) REFERENCES Member(member_id)
);

-- Sample Data

-- Publishers
INSERT INTO Publisher (name, address) VALUES 
('Penguin Random House', '1745 Broadway, New York, NY'),
('HarperCollins', '195 Broadway, New York, NY');

-- Authors
INSERT INTO Author (first_name, last_name) VALUES 
('George', 'Orwell'),
('Harper', 'Lee'),
('J.K.', 'Rowling');

-- Books
INSERT INTO Book (title, isbn, published_year, publisher_id) VALUES 
('1984', '9780451524935', 1949, 1),
('To Kill a Mockingbird', '9780061120084', 1960, 2),
('Harry Potter and the Sorcerer\'s Stone', '9780439708180', 1997, 1);

-- Book_Author Links
INSERT INTO Book_Author (book_id, author_id) VALUES
(1, 1), -- 1984 by George Orwell
(2, 2), -- To Kill a Mockingbird by Harper Lee
(3, 3); -- HP1 by J.K. Rowling

-- Members
INSERT INTO Member (first_name, last_name, email, membership_date) VALUES
('Alice', 'Johnson', 'alice.johnson@example.com', '2023-01-15'),
('Bob', 'Smith', 'bob.smith@example.com', '2023-02-10');

-- Loans
INSERT INTO Loan (book_id, member_id, loan_date, return_date) VALUES
(1, 1, '2024-04-01', '2024-04-15'),
(2, 2, '2024-04-10', NULL),
(3, 1, '2024-04-20', NULL);
