# 📚 Online Bookstore SQL Queries  

This repository contains **PostgreSQL** SQL queries for managing and analyzing data in an **Online Bookstore**. These queries cover **basic operations, data retrieval, and advanced analytics** related to books, customers, and orders.  

## 🛠️ Database Management System  
The queries are designed for **PostgreSQL**.  

## 📂 Database Schema  
The database consists of the following tables:  

1. **Books** – Stores book details like title, author, genre, price, stock, and published year.  
2. **Customers** – Stores customer information including name, email, phone, and location.  
3. **Orders** – Stores order details such as order date, book ID, customer ID, quantity, and total amount.  

---

## 🔍 Specific Problems Addressed  
This SQL script solves real-world **bookstore management problems**, such as:  

- 🔹 **Finding books** by genre, author, or price.  
- 🔹 **Tracking inventory** to identify books with the lowest stock.  
- 🔹 **Filtering orders** by date, total amount, or quantity.  
- 🔹 **Identifying best-selling books** and frequently ordered items.  
- 🔹 **Calculating revenue** and customer spending behavior.  
- 🔹 **Determining stock levels** after fulfilling orders.  
- 🔹 **Listing top customers** who placed the most or highest-value orders.  

---

## 📌 SQL Queries Overview  

### 📖 **Basic Queries**  
1. **Retrieve all books in the "Fiction" genre**  
   ```sql
   SELECT * FROM Books WHERE genre = 'Fiction';
   ```
2. **Find books published after the year 1950**  
   ```sql
   SELECT * FROM Books WHERE published_year > 1950;
   ```
3. **List all customers from Canada**  
   ```sql
   SELECT * FROM Customers WHERE country = 'Canada';
   ```
4. **Show orders placed in November 2023**  
   ```sql
   SELECT * FROM Orders WHERE order_date BETWEEN '2023-11-01' AND '2023-11-30';
   ```
5. **Retrieve the total stock of books available**  
   ```sql
   SELECT SUM(stock) AS Total_Stock FROM Books;
   ```

### 🚀 **Advanced Queries**  
1. **Retrieve the total number of books sold for each genre**  
   ```sql
   SELECT b.genre, SUM(o.quantity) 
   FROM Books b
   JOIN Orders o ON b.book_id = o.book_id
   GROUP BY b.genre;
   ```
2. **Find the most frequently ordered book**  
   ```sql
   SELECT b.book_id, b.title, COUNT(o.order_id) AS Order_Count
   FROM Orders o
   JOIN Books b ON o.book_id = b.book_id
   GROUP BY b.book_id, b.title
   ORDER BY Order_Count DESC LIMIT 1;
   ```
3. **Calculate the stock remaining after fulfilling all orders**  
   ```sql
   SELECT b.book_id, b.title, b.stock, COALESCE(SUM(o.quantity), 0) AS Ordered_Quantity,
          b.stock - COALESCE(SUM(o.quantity), 0) AS Remaining_Quantity
   FROM Books b
   LEFT JOIN Orders o ON b.book_id = o.book_id
   GROUP BY b.book_id
   ORDER BY b.book_id;
   ```

---

## 🔧 How to Use  
1. **Set up PostgreSQL** on your system.  
2. **Run the SQL script** in your database client.  
3. **Modify queries as needed** to fit your dataset.  

---

## 📢 Contributing  
If you have suggestions, optimizations, or additional queries, feel free to **open a pull request**! 🚀  

---

## 🎯 Conclusion  
This SQL script provides an efficient way to manage and analyze an **Online Bookstore database**. It helps bookstore owners track **inventory, sales, revenue, and customer behavior** effectively. Whether you're a developer, data analyst, or business owner, these queries can help you **gain valuable insights** into your bookstore operations.  
