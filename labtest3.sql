-- Consider the following employee database  
employee(employee_name, street, city) 
works(employee_name, company_name, salary) 
company(company_name, city) 
manages(employee_name, manager_name) 
Figure: A-1 
Consider the employee database of Figure A-1, where the primary keys are underlined. Give an 
expression in SQL for each of the following queries. 
i) Find the company that has the most employees. 
ii) Find those companies whose companies earn a higher salary, on average, than the average salary at 
“First Bank Corporation”. 

CREATE DATABASE employee_db;
USE employee_db;

-- Employee Table
CREATE TABLE employee (
    employee_name VARCHAR(50),
    street VARCHAR(50),
    city VARCHAR(50),
    PRIMARY KEY (employee_name)
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
    city VARCHAR(50),
    PRIMARY KEY (company_name)
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
('Rita', 'Motijheel', 'Dhaka'),
('Anika', 'Banani', 'Dhaka');

INSERT INTO company VALUES
('First Bank Corporation', 'Dhaka'),
('ABC Ltd', 'Rajshahi'),
('XYZ Group', 'Chittagong');

INSERT INTO works VALUES
('Rahim', 'First Bank Corporation', 12000),
('Karim', 'First Bank Corporation', 15000),
('Sumi', 'ABC Ltd', 20000),
('Rita', 'ABC Ltd', 22000),
('Anika', 'XYZ Group', 18000),
('Karim', 'ABC Ltd', 25000);
-- i)Company with most employees
SELECT company_name
FROM works
GROUP BY company_name
HAVING COUNT(employee_name) = (
    SELECT MAX(emp_count)
    FROM (
        SELECT COUNT(employee_name) AS emp_count
        FROM works
        GROUP BY company_name
    ) AS temp
);

-- ii)Companies with avg salary > First Bank Corporation

SELECT company_name
FROM works
GROUP BY company_name
HAVING AVG(salary) > (
    SELECT AVG(salary)
    FROM works
    WHERE company_name = 'First Bank Corporation'
);