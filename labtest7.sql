
-- Consider the following employee database where primary keys are underlined. Give an SQL DDL 
definition of this database then write SQL expression for each of the queries given bellow. 
employee (employee_name, street, city) 
works (employee_name, company_name, salary) 
company (company_name, city) 
manages (employee_name, manager_name) 
Fig: Employee database. 
i. 
Find the names and cities of all employees who work in abc bank ltd. 
Find the names, street address and cities of all employees who work in abc bank ltd and earn more than 
BDT 50000. 
-- 🔹 Create Database
CREATE DATABASE IF NOT EXISTS employee_db;
USE employee_db;

-- 🔹 Drop tables if already exist (safe run)
DROP TABLE IF EXISTS manages;
DROP TABLE IF EXISTS works;
DROP TABLE IF EXISTS company;
DROP TABLE IF EXISTS employee;

---------------------------------------------------
-- 🔹 Create Tables (DDL)

CREATE TABLE employee (
    employee_name VARCHAR(50) PRIMARY KEY,
    street VARCHAR(100),
    city VARCHAR(50)
);

CREATE TABLE company (
    company_name VARCHAR(100) PRIMARY KEY,
    city VARCHAR(50)
);

CREATE TABLE works (
    employee_name VARCHAR(50),
    company_name VARCHAR(100),
    salary INT,
    PRIMARY KEY (employee_name, company_name),
    FOREIGN KEY (employee_name) REFERENCES employee(employee_name),
    FOREIGN KEY (company_name) REFERENCES company(company_name)
);

CREATE TABLE manages (
    employee_name VARCHAR(50),
    manager_name VARCHAR(50),
    PRIMARY KEY (employee_name),
    FOREIGN KEY (employee_name) REFERENCES employee(employee_name)
);

---------------------------------------------------
-- 🔹 Insert Sample Data

INSERT INTO employee VALUES
('Rahim', 'Street1', 'Pabna'),
('Karim', 'Street2', 'Natore'),
('Sakib', 'Street3', 'Dhaka'),
('Rafi', 'Street4', 'Rajshahi'),
('Naim', 'Street5', 'Natore');

INSERT INTO company VALUES
('abc bank ltd', 'Dhaka'),
('Square', 'Dhaka'),
('Beximco', 'Chittagong');

INSERT INTO works VALUES
('Rahim', 'abc bank ltd', 60000),
('Karim', 'abc bank ltd', 45000),
('Sakib', 'Square', 80000),
('Rafi', 'abc bank ltd', 70000),
('Naim', 'Beximco', 50000);

INSERT INTO manages VALUES
('Rahim', 'Manager1'),
('Karim', 'Manager2'),
('Sakib', 'Manager1'),
('Rafi', 'Manager3'),
('Naim', 'Manager2');

---------------------------------------------------
-- 🔥 QUERIES

-- 🔸 i. Find names and cities of all employees who work in abc bank ltd
SELECT e.employee_name, e.city
FROM employee e
JOIN works w ON e.employee_name = w.employee_name
WHERE w.company_name = 'abc bank ltd';

---------------------------------------------------
-- 🔸 ii. Names, street, city of employees who work in abc bank ltd and earn > 50000
SELECT e.employee_name, e.street, e.city
FROM employee e
JOIN works w ON e.employee_name = w.employee_name
WHERE w.company_name = 'abc bank ltd'
AND w.salary > 50000;