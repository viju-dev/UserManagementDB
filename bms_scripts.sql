-- creating database
CREATE DATABASE bms;

-- using database
USE bms;

-- creating Authors table in database
CREATE TABLE Authors (
	AuthorId INT PRIMARY KEY,
	Name VARCHAR(100),
	Info TEXT
);

-- creating Books table  in database
CREATE TABLE Books (
	BookId INT PRIMARY KEY,
	Title VARCHAR(100),
	AuthorId INT,
	Price DECIMAL(5,2),
	FOREIGN KEY (AuthorId) REFERENCES Authors(AuthorId)
);
-- creating Customers table  in database
CREATE TABLE Customers (
	CustomerId INT PRIMARY KEY,
	Name VARCHAR(100),
	Email VARCHAR(100),
	Address VARCHAR(200)
);

-- creating Orders table  in database
CREATE TABLE Orders (
	OrderId INT PRIMARY KEY,
	CustomerId INT,
	BookId INT,
	Quantity INT,
	OrderDate DATE,
	FOREIGN KEY (CustomerId) REFERENCES Customers(CustomerId),
	FOREIGN KEY (BookId) REFERENCES Books(BookId)
);


-- inserting dummy data in database

-- For Authors

INSERT INTO Authors (AuthorID, Name, Info) VALUES (1, 'Shital Patil', 'Shital patil is an Indian Author best Known for her well-regarded Advices');
INSERT INTO Authors (AuthorID, Name, Info) VALUES (2, 'Nisha Redekar', 'Nisha redekar is the Author know for her money-saving expertise');
INSERT INTO Authors (AuthorID, Name, Info) VALUES (3, 'Vijay Dorugade', 'Vijay Dorugade is the very popular author in youngsters know for his money making ideas');

-- For Books

INSERT INTO Books (BookID, Title, AuthorID, Price) VALUES (1, 'Free Advices', 1, 25.50);
INSERT INTO Books (BookID, Title, AuthorID, Price) VALUES (2, 'How to save every bit of money', 2, 11.125);
INSERT INTO Books (BookID, Title, AuthorID, Price) VALUES (3, 'How to earn lots of money', 2, 21);

-- For Customers

INSERT INTO Customers (CustomerID, Name, Email, Address) VALUES (1, 'Vijay Dorugade', 'Vijay@gmail.com', 'Manas Paradise, Kalyan');
INSERT INTO Customers (CustomerID, Name, Email, Address) VALUES (2, 'Shrikant Rane', 'Shrikant@gmail.com','Mauli Aarambh, Dombivli');
INSERT INTO Customers (CustomerID, Name, Email, Address) VALUES (3, 'Sarthak Harer', 'Sarthak@gmail.com','Sorab Chawl, Mumbai');


-- For Orders

INSERT INTO Orders (OrderID, CustomerID, BookID, Quantity, OrderDate) VALUES (1, 1, 2, 2, '2024-01-01');
INSERT INTO Orders (OrderID, CustomerID, BookID, Quantity, OrderDate) VALUES (2, 2, 2, 3, '2024-01-03');
INSERT INTO Orders (OrderID, CustomerID, BookID, Quantity, OrderDate) VALUES (3, 3, 3, 12, '2024-01-25');

-- to get list of top-selling books
SELECT Books.Title, SUM(Orders.Quantity) as TotalSold
FROM Orders
JOIN Books ON Orders.BookId = Books.BookId
GROUP BY Books.Title
ORDER BY TotalSold DESC;

-- to calculate total sales revenue for a given period
SELECT SUM(Books.Price * Orders.Quantity) as TotalRevenue
FROM Orders
JOIN Books ON Orders.BookID = Books.BookID
WHERE Orders.OrderDate BETWEEN '2024-01-01' AND '2024-12-31';


-- to get total revenue of top-selling books for a given period
SELECT Books.Title, SUM(Books.Price * Orders.Quantity) as TotalRevenue
FROM Orders
JOIN Books ON Orders.BookId = Books.BookId
WHERE Orders.OrderDate BETWEEN '2024-01-01' AND '2024-12-31'
GROUP BY Books.Title
ORDER BY TotalRevenue DESC;
