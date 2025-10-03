SQL TASK 7 — CREATING VIEWS

USE ECommerceDB;

CREATE TABLE Customers (
    Customer_ID INT PRIMARY KEY,
    First_Name VARCHAR(50),
    Country VARCHAR(50)
);

CREATE TABLE Orders (
    Order_ID INT PRIMARY KEY,
    Customer_ID INT,
    Product VARCHAR(100),
    Amount DECIMAL(10,2),
    Order_Date DATE,
    FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID)
);

INSERT INTO Customers VALUES
(1, 'Amit', 'India'),
(2, 'John', 'USA'),
(3, 'Priya', 'India'),
(4, 'Emily', 'UK');

INSERT INTO Orders VALUES
(101, 1, 'Laptop', 75000.00, '2025-09-01'),
(102, 2, 'Phone', 55000.00, '2025-09-05'),
(103, 1, 'Mouse', 1500.00, '2025-09-10'),
(104, 3, 'Tablet', 30000.00, '2025-09-15');

CREATE VIEW CustomerSpending AS
SELECT c.Customer_ID, c.First_Name, SUM(o.Amount) AS Total_Spent
FROM Customers c
JOIN Orders o ON c.Customer_ID = o.Customer_ID
GROUP BY c.Customer_ID, c.First_Name;

SELECT * FROM CustomerSpending
WHERE Total_Spent > 50000;

CREATE VIEW RecentOrders AS
SELECT Order_ID, Customer_ID, Product, Amount, Order_Date
FROM Orders
WHERE Order_Date > '2025-09-05';

SELECT ro.Order_ID, ro.Product, ro.Amount, c.First_Name
FROM RecentOrders ro
JOIN Customers c ON ro.Customer_ID = c.Customer_ID
WHERE c.Country = 'India';