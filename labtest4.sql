-- Consider the following employee database  
employee(employee_name, street, city) 
works(employee_name, company_name, salary) 
company(company_name, city)  
manages(employee_name, manager_name) 
Figure: A-1 
Give an expression in the relational algebra to express each of the following queries: 
i)   Find the names of all employees who work for “First Bank Corporation”. 
ii) Find the names and cities of residence of all employees who work for “First   
Corporation”. 
Bank 
iii) Find the names, street address and cities of residence of all employees who work for “First 
Bank Corporation” and earn more than BDT 10,000. 

CREATE DATABASE company_db;
USE company_db;
drop table if exists employee,works,company,manages;
-- Employee Table
CREATE TABLE employee (
    employee_name VARCHAR(50),
    street VARCHAR(50),
    city VARCHAR(50)
);

-- Works Table
CREATE TABLE works (
    employee_name VARCHAR(50),
    company_name VARCHAR(50),
    salary INT
);

-- Company Table
CREATE TABLE company (
    company_name VARCHAR(50),
    city VARCHAR(50)
);

-- Manages Table
CREATE TABLE manages (
    employee_name VARCHAR(50),
    manager_name VARCHAR(50)
);
INSERT INTO employee VALUES
('Rahim', 'Dhanmondi', 'Dhaka'),
('Karim', 'Uttara', 'Dhaka'),
('Sumi', 'Kazla', 'Rajshahi'),
('Rita', 'Motijheel', 'Dhaka');

INSERT INTO works VALUES
('Rahim', 'First Bank Corporation', 12000),
('Karim', 'First Bank Corporation', 9000),
('Sumi', 'ABC Company', 15000),
('Rita', 'First Bank Corporation', 20000);

INSERT INTO company VALUES
('First Bank Corporation', 'Dhaka'),
('ABC Company', 'Rajshahi');

-- i Employees working for “First Bank Corporation”

SELECT employee_name
FROM works
WHERE company_name = 'First Bank Corporation';

-- ii) Names & cities of those employees

SELECT e.employee_name, e.city
FROM employee e
JOIN works w
ON e.employee_name = w.employee_name
WHERE w.company_name = 'First Bank Corporation';

-- iii) Names, street, city (salary > 10000)

SELECT e.employee_name, e.street, e.city
FROM employee e
JOIN works w
ON e.employee_name = w.employee_name
WHERE w.company_name = 'First Bank Corporation'
AND w.salary > 10000;
