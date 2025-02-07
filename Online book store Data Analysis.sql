CREATE DATABASE OnlineBookstore;

DROP TABLE IF EXISTS Books;
CREATE TABLE Books(
Book_ID SERIAL PRIMARY KEY,
Title VARCHAR(100),
Author VARCHAR(100),
Genre VARCHAR(100),
Published_Year INT,
Price NUMERIC(10, 2),
Stock INT
);

DROP TABLE IF EXISTS Customers;
CREATE TABLE Customers(
Customer_ID SERIAL PRIMARY KEY,
NAME VARCHAR(100),
Email VARCHAR(100),
Phone VARCHAR(20),
City VARCHAR(50),
Country VARCHAR(150)
);

DROP TABLE IF EXISTS Orders;
CREATE TABLE Orders(
Order_ID SERIAL PRIMARY KEY,
Customer_ID INT REFERENCES Customers(Customer_ID),
Book_ID INT REFERENCES Books(Book_ID),
Order_Date DATE,
Quantity INT,
Total_Amount NUMERIC(10, 2)
);


SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;

-- 1) Retrive all books in the "Fiction" genre:
SELECT * FROM Books
WHERE genre = 'Fiction';

-- 2)fibd books published after the year 1950:
SELECT * FROM Books
WHERE published_year >1950;

-- 3)List all customers from the canada:
SELECT * FROM Customers
WHERE country = 'canada';

-- 4)Show orders placed in November 2023:
SELECT * FROM Orders
WHERE order_date BETWEEN '2023-11-01' AND '2023-11-30'

-- 5)Retrive the total stock of books avaliable:
SELECT SUM(stock) As Total_Stock
FROM Books;

-- 6)Find the detalis of the most expensive book:
SELECT * FROM Books
ORDER BY Price DESC
LIMIT 1;

-- 7)Show all customers who ordered more then 1 quantity of a book:
SELECT * FROM Orders
WHERE quantity >1;

-- 8)Retrive all orders where the total amount exceeds $20:
SELECT * FROM Orders
WHERE total_amount>20;

-- 9)List all genres avaliable in the Books table:
SELECT DISTINCT genre FROM Books;

-- 10)List the top 5 books behalf of genre:
SELECT genre
FROM Books
GROUP BY genre LIMIT 5;


-- 11)Find the book with the lowest stock:
SELECT * FROM Books
ORDER BY stock;

-- 12)Calulate the total revenue generated from all orders:
SELECT SUM(total_amount) As Revenue
FROM Orders;

-- Advance Problems:

-- 1)Retrieve the total number of books sold for each genre:
SELECT* FROM Orders;

SELECT g.Genre, SUM(q.Quantity)
FROM Books g
JOIN Orders q
ON g.book_id = q.book_id
GROUP BY Genre;

-- 2)Find the average price of books in the "Fantasy genre":
SELECT * FROM Books;

SELECT AVG(price) As average_price
FROM Books
WHERE genre = 'Fantasy';

-- 3)List customers who have placed at least 2 orders along with name:
SELECT * FROM Customers;
SELECT * FROM Orders;

SELECT o.customer_id, c.name, COUNT(o.order_id) As Order_Count
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
GROUP BY o.customer_id, c.name
HAVING COUNT(order_id) >=2;

-- 4)Find the most frequently ordered book:
SELECT b.Book_id, b.title, COUNT(o.order_id) As ORDER_COUNT
FROM orders o
JOIN books b
ON o.book_id=b.book_id
GROUP BY b.Book_id, b.title
ORDER BY ORDER_COUNT DESC LIMIT 1;

-- 5)Show the top 3 most expensive books of "Fantasy" genre:
SELECT book_id, title, price
FROM Books
WHERE genre ='Fantasy'
ORDER BY price DESC LIMIT 3;

-- 6)Retrive the total quantity of books sold by each author:
SELECT b.title, b.author, SUM(o.quantity) As total_book_sold
FROM orders o
JOIN  books b
ON b.book_id= o.book_id
GROUP BY b.book_id, b.author;

-- 7)List the cities where customers who spent over $30 are located:
SELECT DISTINCT c.city,o.total_amount
FROM orders o
JOIN customers c
ON o.customer_id=c.customer_id
WHERE o.total_amount>=30;

-- 8)Find the customers who spent the most on orders:
SELECT c.customer_id, c.name, SUM(total_amount) As Total_Spent
FROM customers c
JOIN orders o
ON c.customer_id=o.customer_id
GROUP BY c.customer_id, c.name
ORDER BY Total_Spent DESC LIMIT 1;

-- 9)Calulate the stock remaning after fulfilling all orders:
SELECT b.book_id, b.title, b.stock, COALESCE(SUM(o.quantity),0) As Orde_Quantity,
	b.stock- COALESCE(SUM(o.quantity),0) As Remaning_Quantity
FROM books b
LEFT JOIN orders o 
ON b.book_id=o.book_id
GROUP BY b.book_id ORDER BY b.book_id;