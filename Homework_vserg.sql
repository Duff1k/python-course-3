CREATE TABLE Faculty (
	faculty_id INT PRIMARY KEY,
	faculty_name VARCHAR(50) NOT NULL UNIQUE,
	foundation_year INT NOT NULL CHECK (foundation_year>=1900)
);

CREATE TABLE Student (
	student_id INT PRIMARY KEY,
	full_name VARCHAR(100) NOT NULL,
	birth_date DATE NOT NULL,
	faculty_id INT REFERENCES Faculty(faculty_id),
 email VARCHAR(50) UNIQUE
);

CREATE TABLE Course (
	course_id INT PRIMARY KEY,
	course_name VARCHAR(100) NOT NULL,
	credits INT NOT NULL CHECK (credits BETWEEN 1 AND 10),
 	faculty_id INT REFERENCES Faculty(faculty_id)
);

CREATE TABLE Enrollment (
	id INT PRIMARY KEY,
	student_id INT REFERENCES Student(student_id),
    course_id INT REFERENCES Course(course_id),
    enroll_date DATE NOT NULL DEFAULT CURRENT_DATE 
);

INSERT INTO Faculty (faculty_id, faculty_name, foundation_year) VALUES 
 	(1, 'Faculty of Philosophy', 1990),
	(2, 'Faculty of Oriental Studies', 1902),
	(3, 'Faculty of Linguistics', 1922);

INSERT INTO Student (student_id, full_name, birth_date, faculty_id, email) VALUES 
	(1, 'Lee Oswald', '1939-10-18', 2, 'oswaldl@uni.com'),
	(2, 'Freddie Mercury', '1946-09-05', 2, 'mercuryf@uni.com'),
	(3, 'David Bowie', '1947-01-18', 3, 'bowied@uni.com'),
	(4, 'Morrison Jim', '1943-12-08', 1, 'morrisonj@uni.com'),
	(5, 'Ozzy Osbourne', '1948-12-03', 2, 'osbourneo@uni.com'),
	(6, 'Joe Cocker', '1944-03-20', 3, 'cockerj@uni.com');

INSERT INTO Course (course_id, course_name, credits, faculty_id) VALUES
 	(1, 'Logic', 5, 1),
	(2, 'Metaphysics', 7, 1),
	(3, 'Chinese art', 8, 2),
 	(4, 'Semantics', 3, 3),
	(5, 'Syntax', 9, 3);

INSERT INTO Enrollment (id, student_id, course_id, enroll_date) VALUES
	(1, 1, 1, '1950-09-01'),
	(2, 1, 2, '1951-09-01'),
	(3, 2, 1, '1950-09-01'),
	(4, 3, 3, '1952-09-01'),
	(5, 4, 3, '1953-09-01'),
	(6, 5, 2, '1953-09-01'),
	(7, 6, 1, '1960-09-01');

--Запрос 1. Вывести список всех студентов с названием факультета, на котором они учатся.
SELECT s.student_id, s.full_name, f.faculty_name 
FROM Student s 
JOIN Faculty f ON s.faculty_id = f.faculty_id;

--Запрос 2.Вывести список курсов с указанием факультета, к которому они относятся.
SELECT c.course_id, c.course_name, f.faculty_name 
FROM Course c 
JOIN Faculty f ON c.faculty_id=f.faculty_id;

--Запрос 3. Вывести список студентов и курсов, на которые они зачислены.
SELECT s.full_name AS student_name, c.course_name 
FROM Enrollment e
JOIN Student s ON e.student_id=s.student_id
JOIN Course c ON e.course_id=c.course_id
ORDER BY s.full_name;

--Запрос 4. Найти всех студентов, которые учатся более чем на одном курсе.
SELECT s.full_name AS student_name, COUNT(e.course_id) AS course_count
FROM Student s
JOIN Enrollment e ON s.student_id=e.student_id 
GROUP BY student_name
HAVING COUNT(e.course_id) > 1;

--Запрос 5. Найти курсы, на которых учатся более 2 студентов.
SELECT c.course_name, COUNT(e.student_id)
FROM Course c
JOIN Enrollment e ON c.course_id=e.course_id
GROUP BY course_name
HAVING COUNT(e.student_id) > 2;




