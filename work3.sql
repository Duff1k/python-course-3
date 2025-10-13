DROP TABLE IF EXISTS Enrollment;
DROP TABLE IF EXISTS Course;
DROP TABLE IF EXISTS Student;
DROP TABLE IF EXISTS Faculty;

CREATE TABLE Faculty (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    foundation_year INT NOT NULL CHECK (foundation_year >= 1900)
);

CREATE TABLE Student (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(150) NOT NULL,
    birth_date DATE NOT NULL,
    faculty_id INT REFERENCES Faculty(id) ON DELETE SET NULL,
    email VARCHAR(100) UNIQUE
);

CREATE TABLE Course (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    credits INT NOT NULL CHECK (credits BETWEEN 1 AND 10),
    faculty_id INT REFERENCES Faculty(id) ON DELETE SET NULL
);

CREATE TABLE Enrollment (
    id SERIAL PRIMARY KEY,
    student_id INT REFERENCES Student(id) ON DELETE CASCADE,
    course_id INT REFERENCES Course(id) ON DELETE CASCADE,
    enroll_date DATE NOT NULL DEFAULT CURRENT_DATE,
    UNIQUE(student_id, course_id)
);

INSERT INTO Faculty (name, foundation_year) VALUES
('Факультет биоинженерии', 2001),
('Факультет робототехники', 1995),
('Факультет космических исследований', 1980);

INSERT INTO Student (full_name, birth_date, faculty_id, email) VALUES
('Алексей Смирнов', '2000-01-15', 1, 'smirnov.alex@example.com'),
('Екатерина Васильева', '1999-06-20', 1, 'vasilieva.ek@example.com'),
('Дмитрий Попов', '2001-03-10', 2, 'popov.dm@example.com'),
('Марина Новикова', '2000-11-05', 2, 'novikova.marina@example.com'),
('Игорь Кузьмин', '2002-04-22', 3, 'kuzmin.igor@example.com'),
('Светлана Орлова', '2001-08-30', 3, 'orlova.svetlana@example.com');

INSERT INTO Course (name, credits, faculty_id) VALUES
('Генетика и биотехнологии', 6, 1),
('Молекулярная биология', 5, 1),
('Основы робототехники', 7, 2),
('Искусственный интеллект', 6, 2),
('Астрофизика', 5, 3);

INSERT INTO Enrollment (student_id, course_id) VALUES
(1, 1),
(1, 2),  
(2, 1),
(3, 3),
(3, 4),  
(4, 3),
(5, 5),
(6, 5);  


SELECT s.full_name, f.name AS faculty_name
FROM Student s
JOIN Faculty f ON s.faculty_id = f.id
ORDER BY s.id;

SELECT c.name AS course_name, f.name AS faculty_name
FROM Course c
JOIN Faculty f ON c.faculty_id = f.id
ORDER BY c.id;

SELECT s.full_name, c.name AS course_name
FROM Enrollment e
JOIN Student s ON e.student_id = s.id
JOIN Course c ON e.course_id = c.id
ORDER BY s.id;

SELECT s.full_name, COUNT(e.course_id) AS courses_count
FROM Enrollment e
JOIN Student s ON e.student_id = s.id
GROUP BY s.id
HAVING COUNT(e.course_id) > 1;

SELECT c.name AS course_name, COUNT(e.student_id) AS students_count
FROM Enrollment e
JOIN Course c ON e.course_id = c.id
GROUP BY c.id
HAVING COUNT(e.student_id) > 2;
