
-- Ejercicio 1
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    city VARCHAR(50)
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Ejercicio 2
INSERT INTO Customers (customer_id, name, city) VALUES
(1, 'Alice', 'New York'),
(2, 'Bob', 'Los Angeles'),
(3, 'Charlie', 'Chicago');

INSERT INTO Orders (order_id, customer_id, order_date) VALUES
(101, 1, '2024-01-15'),
(102, 2, '2024-02-10'),
(103, 1, '2024-03-05');

-- Ejercicio 3
SELECT c.name, o.order_id, o.order_date
FROM Customers c
INNER JOIN Orders o ON c.customer_id = o.customer_id;

-- Ejercicio 4
CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10,2)
);

CREATE TABLE OrderDetails (
    order_detail_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Ejercicio 5
INSERT INTO Products (product_id, product_name, price) VALUES
(1, 'Laptop', 1200.00),
(2, 'Phone', 800.00),
(3, 'Tablet', 450.00);

INSERT INTO OrderDetails (order_detail_id, order_id, product_id, quantity) VALUES
(1, 101, 1, 1),
(2, 101, 2, 2),
(3, 102, 3, 1),
(4, 103, 2, 1);

-- Ejercicio 6
SELECT o.order_id, c.name, p.product_name, od.quantity, p.price, (od.quantity * p.price) AS total
FROM Orders o
INNER JOIN Customers c ON o.customer_id = c.customer_id
INNER JOIN OrderDetails od ON o.order_id = od.order_id
INNER JOIN Products p ON od.product_id = p.product_id;

-- Ejercicio 7
SELECT c.name, COUNT(o.order_id) AS total_orders
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.name;

-- Ejercicio 8
SELECT p.product_name, SUM(od.quantity) AS total_sold
FROM Products p
INNER JOIN OrderDetails od ON p.product_id = od.product_id
GROUP BY p.product_name
ORDER BY total_sold DESC;

-- Ejercicio 9
SELECT c.name, SUM(od.quantity * p.price) AS total_spent
FROM Customers c
INNER JOIN Orders o ON c.customer_id = o.customer_id
INNER JOIN OrderDetails od ON o.order_id = od.order_id
INNER JOIN Products p ON od.product_id = p.product_id
GROUP BY c.name
ORDER BY total_spent DESC;

-- Ejercicio 10
SELECT o.order_id, c.name, COUNT(od.product_id) AS total_products
FROM Orders o
INNER JOIN Customers c ON o.customer_id = c.customer_id
INNER JOIN OrderDetails od ON o.order_id = od.order_id
GROUP BY o.order_id, c.name;
