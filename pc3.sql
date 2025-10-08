CREATE TABLE Faculty (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    foundation_year INT NOT NULL CHECK (foundation_year >= 1900)
);

CREATE TABLE Student (
    id INT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    birth_date DATE NOT NULL,
    faculty_id INT NOT NULL,
    email VARCHAR(200) UNIQUE,
    FOREIGN KEY (faculty_id) REFERENCES Faculty(id)
);

CREATE TABLE Course (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    credits INT CHECK (credits BETWEEN 1 AND 10),
    faculty_id INT NOT NULL,
    FOREIGN KEY (faculty_id) REFERENCES Faculty(id)
);

CREATE TABLE Enrollment (
    id INT PRIMARY KEY,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    enroll_date DATE DEFAULT CURRENT_DATE,
    FOREIGN KEY (student_id) REFERENCES Student(id),
    FOREIGN KEY (course_id) REFERENCES Course(id),
	UNIQUE (student_id, course_id)
);

INSERT INTO Faculty (id, name, foundation_year) VALUES
(1, 'Биомеханика', 1989),
(2, 'Прикладная математика', 1961),
(3, 'Информатика', 1990);

INSERT INTO Student (id, full_name, birth_date, faculty_id, email) VALUES
(1, 'Глебов Глеб Глебович', '2001-01-12', 1, 'gleb@example.com'),
(2, 'Максимов Максим Максимович', '2003-08-14', 1, 'max@example.com'),
(3, 'Березова Елена Игоревна', '2001-10-01', 2, 'ber@example.com'),
(4, 'Александров Александр Александрович', '2002-02-23', 2, 'alex@example.com'),
(5, 'Смирнова Анна Олеговна', '2004-01-11', 3, 'smir@example.com'),
(6, 'Ляшина Светлана Игоревна', '2002-08-15', 1, 'lyash@example.com');

INSERT INTO Course (id, name, credits, faculty_id) VALUES
(1, 'Курсы C++', 2, 3),
(2, 'Архитектура ИС', 5, 3),
(3, 'Биороботы', 4, 1),
(4, 'Матстат для аналитиков', 3, 2),
(5, 'Теория групп', 2, 2);

INSERT INTO Enrollment (id, student_id, course_id, enroll_date) VALUES
(1, 1, 1, '2024-10-11'),  
(2, 1, 2, '2024-10-11'),  
(3, 2, 1, '2024-10-11'),  
(4, 3, 3, '2024-09-01'),  
(5, 4, 4, '2024-09-01'),  
(6, 4, 5, '2024-09-18'),
(7, 5, 5, '2024-09-18'),
(8, 6, 1, '2024-10-11');  

SELECT 
    s.full_name,
    f.name AS faculty_name
FROM Student s
JOIN Faculty f ON s.faculty_id = f.id;

SELECT 
    c.name AS course_name,
    f.name AS faculty_name
FROM Course c
JOIN Faculty f ON c.faculty_id = f.id;

SELECT 
    s.full_name,
    c.name AS course_name,
    e.enroll_date
FROM Enrollment e
JOIN Student s ON e.student_id = s.id
JOIN Course c ON e.course_id = c.id;

SELECT 
    s.full_name,
    COUNT(e.course_id) AS course_count
FROM Student s
JOIN Enrollment e ON s.id = e.student_id
GROUP BY s.id, s.full_name
HAVING COUNT(e.course_id) > 1;

SELECT 
    c.name AS course_name,
    COUNT(e.student_id) AS student_count
FROM Course c
JOIN Enrollment e ON c.id = e.course_id
GROUP BY c.id, c.name
HAVING COUNT(e.student_id) > 2;

