-- 10.	Discussion-3 — Stored Procedures with Parameters and Control Structures in MySQL Using CustomerAndSuppliers, Items and Transactions Database.

-- 🔹 Database create
CREATE DATABASE IF NOT EXISTS CustomerSystem;
USE CustomerSystem;

-- 🔹 Tables
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    city VARCHAR(50)
);

CREATE TABLE Items (
    item_id INT PRIMARY KEY AUTO_INCREMENT,
    item_name VARCHAR(100),
    price INT,
    stock INT
);

CREATE TABLE Transactions (
    transaction_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    item_id INT,
    quantity INT,
    total INT
);

---------------------------------------------------
-- 🔹 Sample Data
INSERT INTO Customers(name, city)
VALUES ('Rahim','Pabna'), ('Karim','Natore');

INSERT INTO Items(item_name, price, stock)
VALUES ('Laptop',50000,10), ('Mobile',20000,20);

---------------------------------------------------
-- 🔥 1. Procedure: Transaction add (simple)

DELIMITER $$

CREATE PROCEDURE AddSale(
    IN cid INT,
    IN iid INT,
    IN qty INT
)
BEGIN
    DECLARE p INT;

    -- price বের করা
    SELECT price INTO p
    FROM Items
    WHERE item_id = iid;

    -- insert transaction
    INSERT INTO Transactions(customer_id, item_id, quantity, total)
    VALUES (cid, iid, qty, p * qty);

END $$

DELIMITER ;

---------------------------------------------------
-- 🔥 2. Procedure: Stock check (IF use)

DELIMITER $$

CREATE PROCEDURE CheckStock(IN iid INT)
BEGIN
    DECLARE s INT;

    SELECT stock INTO s
    FROM Items
    WHERE item_id = iid;

    IF s > 10 THEN
        SELECT 'High Stock';
    ELSE
        SELECT 'Low Stock';
    END IF;

END $$

DELIMITER ;

-- -------------------------------------------------
-- 🔥 3. Procedure call examples

CALL AddSale(1,1,2);
CALL CheckStock(1);