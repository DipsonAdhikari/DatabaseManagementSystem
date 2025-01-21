CREATE DATABASE ECommerce;
USE ECommerce;

-- Drop tables if they already exist
DROP TABLE OrderItems;
DROP TABLE Orders;
DROP TABLE Customers;
DROP TABLE Products;

-- Create Products table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2),
    Stock INT
);

-- Create Customers table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    Address VARCHAR(200)
);

-- Create Orders table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT FOREIGN KEY REFERENCES Customers(CustomerID) ON DELETE CASCADE ON UPDATE CASCADE,
    OrderDate DATE,
    TotalAmount DECIMAL(10,2)
);

-- Create OrderItems table
CREATE TABLE OrderItems (
    OrderID INT FOREIGN KEY REFERENCES Orders(OrderID) ON DELETE CASCADE ON UPDATE CASCADE,
    ProductID INT FOREIGN KEY REFERENCES Products(ProductID),
    Quantity INT,
    SubTotal DECIMAL(10,2),
    PRIMARY KEY (OrderID, ProductID)
);

-- Insert sample data into Products
INSERT INTO Products VALUES 
(1, 'Laptop', 'Electronics', 800.00, 50),
(2, 'Smartphone', 'Electronics', 500.00, 200),
(3, 'Headphones', 'Accessories', 50.00, 150),
(4, 'Desk Chair', 'Furniture', 120.00, 30),
(5, 'Notebook', 'Stationery', 2.50, 500);

-- Insert sample data into Customers
INSERT INTO Customers VALUES 
(1, 'John', 'Doe', 'john.doe@example.com', '123 Maple St, Springfield'),
(2, 'Jane', 'Smith', 'jane.smith@example.com', '456 Oak St, Metropolis'),
(3, 'Emily', 'Johnson', 'emily.j@example.com', '789 Pine St, Gotham');

-- Insert sample data into Orders
INSERT INTO Orders VALUES 
(101, 1, '2025-01-01', 850.00),
(102, 2, '2025-01-02', 550.00),
(103, 3, '2025-01-03', 170.00);

-- Insert sample data into OrderItems
INSERT INTO OrderItems VALUES 
(101, 1, 1, 800.00),
(101, 3, 1, 50.00),
(102, 2, 1, 500.00),
(102, 3, 1, 50.00),
(103, 4, 1, 120.00),
(103, 5, 20, 50.00);

-- Complex queries

-- 1. Display all orders with customer details
SELECT o.OrderID, c.FirstName, c.LastName, o.OrderDate, o.TotalAmount
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID;

-- 2. Display all products that are out of stock
SELECT * FROM Products WHERE Stock = 0;

-- 3. Show the total number of orders placed by each customer
SELECT c.FirstName, c.LastName, COUNT(o.OrderID) AS TotalOrders
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.FirstName, c.LastName;

-- 4. Show all customers who placed orders in January 2025
SELECT DISTINCT c.FirstName, c.LastName 
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE MONTH(o.OrderDate) = 1 AND YEAR(o.OrderDate) = 2025;

-- 5. Show details of products and their total sales quantity
SELECT p.ProductName, p.Category, SUM(oi.Quantity) AS TotalSold
FROM Products p
JOIN OrderItems oi ON p.ProductID = oi.ProductID
GROUP BY p.ProductID,p.ProductName,p.Category;

-- 6. Show products that have never been sold
SELECT * 
FROM Products p
LEFT JOIN OrderItems oi ON p.ProductID = oi.ProductID
WHERE oi.ProductID IS NULL;

-- 7. Show customer names along with the total amount they spent
SELECT c.FirstName, c.LastName, SUM(o.TotalAmount) AS TotalSpent
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID,c.FirstName,c.LastName;
