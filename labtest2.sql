-- Consider the following relational database:                                                                               
                                 classroom(building, room_number, capacity) 
                                 student(ID, name, dept_name, tot_cred) 
                                 department(dept_name, building, budget) 
                                 takes(ID, course_id, sec_id, semester, year, grade) 
                                 section(course_id, sec_id, semester, year, building) 
                                 course(course_id, title, dept_name, credits) 
                                 instructor(ID, name, dept_name, salary) 
                                 teaches(ID, course_id, sec_id, semester, year) 
here, primary keys are underlined. Give an expression in the SQL to express each of the following 
queries: 
i. Retrieve the number of instructors in each department. 
ii. Find the names of all departments whose building name beginning with 'Waz'. 
iii. Find those departments where the average salary of the instructors is more than $42,000. 
iv. Show the list of entire instructor in ascending order of salary. 
v. Delete all instructors with a salary between $13,000 and $15,000. 
vi. List the names of students along with the titles of courses that they have taken. 
vii. Find all students who have not taken a course. 
Find all Physics courses offered in the Fall 2017 semester in the Watson building by defined a view 
physics_fall_2017. 

CREATE DATABASE university_db3;
USE university_db3;

-- Classroom
CREATE TABLE classroom (
    building VARCHAR(50),
    room_number VARCHAR(10),
    capacity INT,
    PRIMARY KEY (building, room_number)
);

-- Department
CREATE TABLE department (
    dept_name VARCHAR(50) PRIMARY KEY,
    building VARCHAR(50),
    budget DECIMAL(12,2)
);

-- Student
CREATE TABLE student (
    ID INT PRIMARY KEY,
    name VARCHAR(50),
    dept_name VARCHAR(50),
    tot_cred INT
);

-- Course
CREATE TABLE course (
    course_id VARCHAR(10) PRIMARY KEY,
    title VARCHAR(100),
    dept_name VARCHAR(50),
    credits INT
);

-- Instructor
CREATE TABLE instructor (
    ID INT PRIMARY KEY,
    name VARCHAR(50),
    dept_name VARCHAR(50),
    salary INT
);

-- Section
CREATE TABLE section (
    course_id VARCHAR(10),
    sec_id VARCHAR(10),
    semester VARCHAR(10),
    year INT,
    building VARCHAR(50),
    PRIMARY KEY (course_id, sec_id, semester, year)
);

-- Takes
CREATE TABLE takes (
    ID INT,
    course_id VARCHAR(10),
    sec_id VARCHAR(10),
    semester VARCHAR(10),
    year INT,
    grade VARCHAR(5)
);

-- Teaches
CREATE TABLE teaches (
    ID INT,
    course_id VARCHAR(10),
    sec_id VARCHAR(10),
    semester VARCHAR(10),
    year INT
);
INSERT INTO department VALUES
('Computer Science', 'Wazir Hall', 1000000),
('Physics', 'Watson Building', 800000),
('Mathematics', 'Newton Block', 700000);

INSERT INTO instructor VALUES
(1, 'Rahim', 'Computer Science', 50000),
(2, 'Karim', 'Physics', 45000),
(3, 'Sumi', 'Mathematics', 30000),
(4, 'Rita', 'Computer Science', 60000),
(5, 'Anika', 'Physics', 14000);

INSERT INTO student VALUES
(101, 'Asha', 'Computer Science', 30),
(102, 'Bina', 'Physics', 20),
(103, 'Cathy', 'Mathematics', 25);

INSERT INTO course VALUES
('C101', 'Database', 'Computer Science', 3),
('P101', 'Mechanics', 'Physics', 4),
('P102', 'Optics', 'Physics', 3),
('M101', 'Algebra', 'Mathematics', 3);

INSERT INTO section VALUES
('P101', '1', 'Fall', 2017, 'Watson Building'),
('P102', '1', 'Fall', 2017, 'Watson Building'),
('C101', '1', 'Spring', 2018, 'Wazir Hall');

INSERT INTO takes VALUES
(101, 'C101', '1', 'Spring', 2018, 'A'),
(102, 'P101', '1', 'Fall', 2017, 'B');

INSERT INTO teaches VALUES
(2, 'P101', '1', 'Fall', 2017),
(2, 'P102', '1', 'Fall', 2017),
(1, 'C101', '1', 'Spring', 2018);

-- i) Number of instructors in each department
SELECT dept_name, COUNT(*) AS total_instructors
FROM instructor
GROUP BY dept_name;

-- ii) Find the names of all departments whose building name beginning with 'Waz'. 
SELECT dept_name
FROM department
WHERE building LIKE 'Waz%';

-- iii) Avg salary > 42000 in which department
SELECT dept_name, AVG(salary) AS avg_salary
FROM instructor
GROUP BY dept_name
HAVING AVG(salary) > 42000;

-- iv) Instructor list ascending salary
SELECT *
FROM instructor
ORDER BY salary ASC;

-- v) Delete all instructors with a salary between $13,000 and $15,000. 
set sql_safe_updates=0;
DELETE FROM instructor
WHERE salary BETWEEN 13000 AND 15000;

-- vi) Student name + course title
SELECT s.name, c.title
FROM student s
JOIN takes t ON s.ID = t.ID
JOIN course c ON t.course_id = c.course_id;

-- vii. all students who have not taken a course. 
SELECT name
FROM student
WHERE ID NOT IN (
    SELECT ID FROM takes
);

-- viii) View: Physics courses in Fall 2017 at Watson building
CREATE VIEW physics_fall_2017 AS
SELECT c.course_id, c.title
FROM course c
JOIN section s ON c.course_id = s.course_id
WHERE c.dept_name = 'Physics'
AND s.semester = 'Fall'
AND s.year = 2017
AND s.building = 'Watson Building';
SELECT * FROM physics_fall_2017;
