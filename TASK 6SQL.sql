--- Create CUSTOMER table
CREATE TABLE CUSTOMER (
    CustomerID INT PRIMARY KEY ,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    Phone VARCHAR(20),
    Address VARCHAR(255)
);

-- Create PRODUCT table
CREATE TABLE PRODUCT (
    ProductID INT PRIMARY KEY ,
    ProductName VARCHAR(100),
    Price DECIMAL(10, 2),
    StockQuantity INT
);

-- Create ORDER table
CREATE TABLE `ORDER` (
    OrderID INT PRIMARY KEY ,
    CustomerID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10, 2),
    FOREIGN KEY (CustomerID) REFERENCES CUSTOMER(CustomerID)
);

-- Create ORDER_PRODUCT table to manage the many-to-many relationship between ORDER and PRODUCT
CREATE TABLE ORDER_PRODUCT (
    OrderID INT,
    ProductID INT,
    Quantity INT,
    PRIMARY KEY (OrderID, ProductID),
    FOREIGN KEY (OrderID) REFERENCES `ORDER`(OrderID),
    FOREIGN KEY (ProductID) REFERENCES PRODUCT(ProductID)
);
-- Insert values into CUSTOMER
INSERT INTO CUSTOMER (FirstName, LastName, Email, Phone, Address)
VALUES 
('John', 'Doe', 'john.doe@example.com', '555-1234', '123 Elm St'),
('Jane', 'Smith', 'jane.smith@example.com', '555-5678', '456 Oak St');

-- Insert values into PRODUCT
INSERT INTO PRODUCT (ProductName, Price, StockQuantity)
VALUES 
('Widget', 19.99, 100),
('Gadget', 29.99, 50);

-- Insert values into ORDER
INSERT INTO `ORDER` (CustomerID, OrderDate, TotalAmount)
VALUES 
(1, '2024-09-13', 49.98),
(2, '2024-09-14', 29.99);

-- Insert values into ORDER_PRODUCT
INSERT INTO ORDER_PRODUCT (OrderID, ProductID, Quantity)
VALUES 
(1, 1, 2),  -- John Doe ordered 2 Widgets
(2, 2, 1);  -- Jane Smith ordered 1 Gadget ;


SELECT *FROM CUSTOMER;
SELECT *FROM  ORDER_PRODUCT;
SELECT *FROM PRODUCT;
--TOTAL  NUMBER OF ORDERS;
SELECT COUNT(*) AS total_orders from ORDER_PRODUCT;

SELECT * FROM  ORDER_PRODUCT LIMIT 10;
--- Total Number of Orders
SELECT COUNT(*) AS TotalOrders
FROM `ORDER`;
--Average Order Value
SELECT AVG(TotalAmount) AS AverageOrderValue
FROM `ORDER`;
 --Top Products by Sales
SELECT p.ProductName, SUM(op.Quantity) AS TotalQuantitySold
FROM ORDER_PRODUCT op
JOIN PRODUCT p ON op.ProductID = p.ProductID
GROUP BY p.ProductName
ORDER BY TotalQuantitySold DESC;
--Total Revenue
SELECT SUM(TotalAmount) AS TotalRevenue
FROM `ORDER`;
--- Most Frequently Bought Product
SELECT p.ProductName, COUNT(*) AS NumberOfTimesBought
FROM ORDER_PRODUCT op
JOIN PRODUCT p ON op.ProductID = p.ProductID
GROUP BY p.ProductName
ORDER BY NumberOfTimesBought DESC;

-- Peak Order Time (MySQL)
SELECT HOUR(OrderDate) AS HourOfDay, COUNT(*) AS NumberOfOrders
FROM `ORDER`
GROUP BY HourOfDay
ORDER BY NumberOfOrders DESC;