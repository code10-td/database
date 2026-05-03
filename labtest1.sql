-- Consider the following relational database:                                                                               
                                 classroom(building, room_number, capacity) 
                                 department(dept_name, building, budget) 
                                 section(course_id, sec_id, semester, year, building) 
                                 course(course_id, title, dept_name, credits) 
                                 instructor(ID, name, dept_name, salary) 
                                 teaches(ID, course_id, sec_id, semester, year) 
here, primary keys are underlined. Give an expression in the SQL to express each of the 
following queries: 
i. Find the department names of all instructors. 
ii. Retrieve the names of all instructors, along with their department names and department 
building name. 
iii. Find the names of all departments whose building name includes the substring 'Watson'. 
iv. Show the list of entire instructor in descending order of salary. 
v. Find the names of instructors with salary amounts between $90,000 and $100,000. 
vi. Find the set of all courses taught either in Fall 2017 or in Spring 2018, or both. 
vii. Find the average salary of instructors in the Computer Science department. 
viii. Find the average salary in each department. 
Find the average salary of instructors in those departments where the average salary is more than 
$42,000. 


CREATE DATABASE university_db;
USE university_db;
drop table if exists classroom,department,course,instructor,section,teaches;

-- Classroom Table
CREATE TABLE classroom (
    building VARCHAR(50),
    room_number VARCHAR(10),
    capacity INT,
    PRIMARY KEY (building, room_number)
);

-- Department Table
CREATE TABLE department (
    dept_name VARCHAR(50),
    building VARCHAR(50),
    budget DECIMAL(12,2),
    PRIMARY KEY (dept_name)
);

-- Course Table
CREATE TABLE course (
    course_id VARCHAR(10),
    title VARCHAR(100),
    dept_name VARCHAR(50),
    credits INT,
    PRIMARY KEY (course_id)
);

-- Instructor Table
CREATE TABLE instructor (
    ID INT,
    name VARCHAR(50),
    dept_name VARCHAR(50),
    salary INT,
    PRIMARY KEY (ID)
);

-- Section Table
CREATE TABLE section (
    course_id VARCHAR(10),
    sec_id VARCHAR(10),
    semester VARCHAR(10),
    year INT,
    building VARCHAR(50),
    PRIMARY KEY (course_id, sec_id, semester, year)
);

-- Teaches Table
CREATE TABLE teaches (
    ID INT,
    course_id VARCHAR(10),
    sec_id VARCHAR(10),
    semester VARCHAR(10),
    year INT
);

INSERT INTO department VALUES
('Computer Science', 'Watson Hall', 1000000),
('Mathematics', 'Newton Building', 800000),
('Physics', 'Watson Lab', 900000);

INSERT INTO instructor VALUES
(1, 'Rahim', 'Computer Science', 95000),
(2, 'Karim', 'Mathematics', 85000),
(3, 'Sumi', 'Physics', 70000),
(4, 'Rita', 'Computer Science', 120000),
(5, 'Anika', 'Mathematics', 40000);

INSERT INTO course VALUES
('C101', 'Database', 'Computer Science', 3),
('M101', 'Algebra', 'Mathematics', 3),
('P101', 'Quantum Physics', 'Physics', 4);

INSERT INTO teaches VALUES
(1, 'C101', '1', 'Fall', 2017),
(2, 'M101', '1', 'Spring', 2018),
(3, 'P101', '1', 'Fall', 2017),
(4, 'C101', '2', 'Spring', 2018);

-- i) Department names of all instructors
SELECT DISTINCT dept_name
FROM instructor;

-- ii) Instructor name + dept + building
SELECT i.name, i.dept_name, d.building
FROM instructor i
JOIN department d
ON i.dept_name = d.dept_name;

-- iii) Department with 'Watson' in building
SELECT dept_name
FROM department
WHERE building LIKE '%Watson%';

-- iv) Instructor list descending salary
SELECT *
FROM instructor
ORDER BY salary DESC;

-- v) Salary between 90000 and 100000
SELECT name
FROM instructor
WHERE salary BETWEEN 90000 AND 100000;

-- vi) Courses in Fall 2017 or Spring 2018
SELECT DISTINCT course_id
FROM teaches
WHERE (semester = 'Fall' AND year = 2017)
   OR (semester = 'Spring' AND year = 2018);
   
   -- vii) Avg salary (Computer Science)
   SELECT AVG(salary) AS avg_salary
FROM instructor
WHERE dept_name = 'Computer Science';

-- viii) Avg salary per department
SELECT dept_name, AVG(salary) AS avg_salary
FROM instructor
GROUP BY dept_name;

-- ix) Departments with avg salary > 42000
SELECT dept_name, AVG(salary) AS avg_salary
FROM instructor
GROUP BY dept_name
HAVING AVG(salary) > 42000;