CREATE TABLE Faculty (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE,
    foundation_year INTEGER NOT NULL CHECK (foundation_year >= 1900)
);
CREATE TABLE Student (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(255) NOT NULL,
    birth_date DATE NOT NULL,
    faculty_id INTEGER NOT NULL,
    email VARCHAR(255) UNIQUE,
    FOREIGN KEY (faculty_id) REFERENCES Faculty(id)
);
CREATE TABLE Course (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    credits INTEGER CHECK (credits >= 1 AND credits <= 10),
    faculty_id INTEGER NOT NULL,
    FOREIGN KEY (faculty_id) REFERENCES Faculty(id)
);
CREATE TABLE Enrollment (
    id SERIAL PRIMARY KEY,
    student_id INTEGER NOT NULL,
    course_id INTEGER NOT NULL,
    enroll_date DATE DEFAULT CURRENT_DATE,
    FOREIGN KEY (student_id) REFERENCES Student(id),
    FOREIGN KEY (course_id) REFERENCES Course(id),
    UNIQUE (student_id, course_id)
);

INSERT INTO Faculty (name, foundation_year) VALUES
('Факультет системного анализа', 1995),
('Факультет экономики', 1980),
('Факультет физики', 1990);
INSERT INTO Student (full_name, birth_date, faculty_id, email) VALUES
('Польдин Александр Витальевич', '2002-03-15', 1, 'poldin@mail.ru'),
('Петров Петр Петрович', '1999-07-20', 1, 'petrov@mail.ru'),
('Сидорова Мария Алексеевна', '2001-03-10', 2, 'sidorova@mail.ru'),
('Кузнецов Алексей Николаевич', '2000-11-25', 2, 'kuznetsov@mail.ru'),
('Волкова Екатерина Дмитриевна', '2002-01-30', 1, 'volkova@mail.ru'),
('Смирнов Никита Андреевич', '1998-09-12', 3, 'smirnov@mail.ru');
INSERT INTO Course (name, credits, faculty_id) VALUES
('Алгоритмизация и программирование', 4, 1),
('ОТС и коллективные методы решений', 5, 1),
('Макроэкономика', 3, 2),
('Физика', 2, 3),
('Математика', 4, 2);
INSERT INTO Enrollment (student_id, course_id, enroll_date) VALUES
(1, 1, '2025-09-01'),
(1, 2, '2025-09-02'),
(2, 1, '2025-09-01'),
(3, 3, '2025-09-03'),
(4, 3, '2025-09-03'),
(4, 5, '2025-09-04'),
(5, 1, '2025-09-01'),
(6, 4, '2025-09-05');

SELECT s.full_name, f.name AS faculty_name
FROM Student s
JOIN Faculty f on s.faculty_id = f.id;

SELECT c.name as course_name, f.name AS faculty_name
FROM Course c
JOIN Faculty f on c.faculty_id = f.id;

SELECT s.full_name, c.name AS course_name
FROM Student s
JOIN Enrollment e on s.id = e.student_id
JOIN Course c on e.course_id = c.id;

SELECT s.full_name
FROM Student s
JOIN Enrollment e on s.id = e.student_id
GROUP BY s.id
HAVING COUNT(e.course_id) > 1;

SELECT c.name as course_name
FROM Course c
JOIN Enrollment e on c.id = e.course_id
GROUP BY c.id
HAVING COUNT(e.student_id) > 2;