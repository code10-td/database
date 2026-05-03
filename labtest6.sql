Consider the following employee database:                                                                               
employee (person_name, street, city) 
works (person_name, company_name, salary) 
company (company_name, city) 
Give an expression in the relational algebra to express each of the following queries: 
i. 
ii. 
Find the name of each employee who lives in city “Pabna”. 
Find the name of each employee who lives in “Pabna” and whose salary is greater than $100,000. 
iii. 
Find the name of each employee in square company with a salary between $90,000 and $100,000. 
iv. Show the name of all employees who lives in city either “Pabna” or “Natore”. 
Find the name of each employee who earns more than the employee whose name is Rahim. 

-- 🔹 Create Database
CREATE DATABASE employee_db;

-- 🔹 Use Database
USE employee_db;
DROP TABLE IF EXISTS employee;
DROP TABLE IF EXISTS works;
DROP TABLE IF EXISTS company;
-- 🔹 Create Tables
CREATE TABLE employee (
    person_name VARCHAR(50),
    street VARCHAR(50),
    city VARCHAR(50)
);

CREATE TABLE works (
    person_name VARCHAR(50),
    company_name VARCHAR(50),
    salary INT
);

CREATE TABLE company (
    company_name VARCHAR(50),
    city VARCHAR(50)
);

-- 🔹 Insert Sample Data
INSERT INTO employee VALUES
('Rahim', 'Street1', 'Pabna'),
('Karim', 'Street2', 'Natore'),
('Sakib', 'Street3', 'Pabna'),
('Rafi', 'Street4', 'Dhaka'),
('Naim', 'Street5', 'Natore');

INSERT INTO works VALUES
('Rahim', 'Square', 80000),
('Karim', 'Square', 95000),
('Sakib', 'Beximco', 120000),
('Rafi', 'Square', 100000),
('Naim', 'Beximco', 110000);

INSERT INTO company VALUES
('Square', 'Dhaka'),
('Beximco', 'Dhaka');
select*from employee;
select*from works;
select*from company;
---------------------------------------------------
-- 🔸 i. Pabna শহরে থাকে এমন employee
SELECT person_name
FROM employee
WHERE city = 'Pabna';

---------------------------------------------------
-- 🔸 ii. Pabna তে থাকে এবং salary > 100000
SELECT e.person_name
FROM employee e
JOIN works w ON e.person_name = w.person_name
WHERE e.city = 'Pabna'
AND w.salary > 100000;

---------------------------------------------------
-- 🔸 iii. Square company + salary 90000–100000
SELECT person_name
FROM works
WHERE company_name = 'Square'
AND salary BETWEEN 90000 AND 100000;

---------------------------------------------------
-- 🔸 iv. Pabna অথবা Natore শহরের employee
SELECT person_name
FROM employee
WHERE city = 'Pabna' OR city = 'Natore';

---------------------------------------------------
-- 🔸 v. Rahim এর salary থেকে বেশি আয় করে এমন employee
SELECT person_name
FROM works
WHERE salary > (
    SELECT salary
    FROM works
    WHERE person_name = 'Rahim'
);