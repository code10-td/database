-- Consider the following relational database:                                                                        
department(dept_name, building, budget) 
section(course_id, sec_id, semester, year, building) 
course(course_id, title, dept_name, credits) 
instructor(ID, name, dept_name, salary) 
teaches(ID, course_id, sec_id, semester, year) 
Give an expression in the relational algebra to express each of the following queries: 
i. 
ii. 
iii. 
iv. 
Find all instructors with salary greater than $90,000. 
Find the set of all courses taught in both the Fall 2017 and the Spring 2018 semesters. 
Find the ID and name of those instructors who earn more than the instructor whose ID is 12121. 
Find the name of an instructor who has taught course. 
Find the names of all instructors except the Physics department. 


CREATE DATABASE university_db2;
USE university_db2;
drop table if exists department,course,instructor,selection,teaches;
-- Department Table
CREATE TABLE department (
    dept_name VARCHAR(50) PRIMARY KEY,
    building VARCHAR(50),
    budget DECIMAL(12,2)
);

-- Course Table
CREATE TABLE course (
    course_id VARCHAR(10) PRIMARY KEY,
    title VARCHAR(100),
    dept_name VARCHAR(50),
    credits INT
);

-- Instructor Table
CREATE TABLE instructor (
    ID INT PRIMARY KEY,
    name VARCHAR(50),
    dept_name VARCHAR(50),
    salary INT
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
('Physics', 'Newton Lab', 800000),
('Mathematics', 'Euler Building', 700000);

INSERT INTO instructor VALUES
(12121, 'Rahim', 'Computer Science', 80000),
(12122, 'Karim', 'Physics', 95000),
(12123, 'Sumi', 'Mathematics', 110000),
(12124, 'Rita', 'Computer Science', 120000),
(12125, 'Anika', 'Physics', 70000);

INSERT INTO course VALUES
('C101', 'Database', 'Computer Science', 3),
('P101', 'Mechanics', 'Physics', 4),
('M101', 'Algebra', 'Mathematics', 3);

INSERT INTO teaches VALUES
(12121, 'C101', '1', 'Fall', 2017),
(12122, 'P101', '1', 'Fall', 2017),
(12123, 'M101', '1', 'Spring', 2018),
(12124, 'C101', '2', 'Spring', 2018),
(12122, 'P101', '2', 'Spring', 2018);
-- i) salary > 90000
SELECT *
FROM instructor
WHERE salary > 90000;

-- ii) Courses taught in BOTH Fall 2017 & Spring 2018
SELECT DISTINCT t1.course_id
FROM teaches t1
JOIN teaches t2
ON t1.course_id = t2.course_id
WHERE t1.semester = 'Fall' AND t1.year = 2017
AND t2.semester = 'Spring' AND t2.year = 2018;

-- iii) Instructor whose salary > instructor (ID = 12121)
SELECT ID, name
FROM instructor
WHERE salary > (
    SELECT salary
    FROM instructor
    WHERE ID = 12121
);
-- iv) Instructors who taught any course
SELECT DISTINCT i.name
FROM instructor i
JOIN teaches t
ON i.ID = t.ID;

-- v) All instructors except Physics department
SELECT name
FROM instructor
WHERE dept_name <> 'Physics';