CREATE TABLE Faculty (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    foundation_year INTEGER NOT NULL CHECK (foundation_year >= 1900)
);

CREATE TABLE Student (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    birth_date DATE NOT NULL,
    faculty_id INTEGER REFERENCES Faculty(id),
    email VARCHAR(100) UNIQUE
);

CREATE TABLE Course (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    credits INTEGER NOT NULL CHECK (credits BETWEEN 1 AND 10),
    faculty_id INTEGER REFERENCES Faculty(id)
);


CREATE TABLE Enrollment (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    student_id INTEGER REFERENCES Student(id),
    course_id INTEGER REFERENCES Course(id),
    enroll_date DATE NOT NULL DEFAULT CURRENT_DATE
);


INSERT INTO Faculty (name, foundation_year)
VALUES
    ('Высшая инжиниринговая школа', 2017),
    ('Института международных отношений', 1999),
    ('Институт ядерной физики и технологий', 2016);

INSERT INTO Student (full_name, birth_date, faculty_id, email)
VALUES
    ('Иванов Иван Иванович', '2000-05-15', 1, 'ivanov@miphi.ru'),
    ('Петров Петр Петрович', '2002-08-20', 1, 'petrov@miphi.ru'),
    ('Васильев Василий Васильевич', '1999-10-10', 2, 'svasilev@miphi.ru'),
    ('Ильин Илья Ильич', '2003-03-30', 2, 'ilin@miphi.ru'),
    ('Николаев Николай Николаевич', '2001-07-12', 3, 'nikolaev@miphi.ru'),
    ('Дмитриев Дмитрий Дмитриевич', '2004-09-30', 3, 'dmitriev@miphi.ru');

INSERT INTO Course (name, credits, faculty_id)
VALUES
    ('Иностранный язык', 4, 2),
    ('Алгоритмизация и языки программирования', 5, 1),
    ('Математический анализ', 6, 3),
    ('Физика', 5, 3),
    ('Микроэкономика', 4, 2);

INSERT INTO Enrollment (student_id, course_id, enroll_date)
VALUES    
    (1, 1, '2025-09-01'),
    (1, 2, '2025-09-01'),    
    (2, 1, '2025-09-01'),
    (3, 1, '2025-09-01'),    
    (4, 3, '2025-09-01'),
    (5, 5, '2025-09-01'),
    (6, 5, '2025-09-01');


SELECT s.id AS student_id, s.full_name AS student_name, f.name AS faculty_name FROM student s
JOIN Faculty f ON s.faculty_id = f.id;

SELECT c.id AS course_id, c.name AS course_name, f.name AS faculty_name FROM course c
JOIN Faculty f ON c.faculty_id = f.id;

SELECT s.id AS student_id, s.full_name AS student_name, c.name AS course_name FROM student s
JOIN enrollment e ON s.id = e.student_id
JOIN course c ON e.course_id = c.id;


SELECT s.id AS student_id, s.full_name AS student_name, COUNT(e.course_id) AS course_count FROM student s
JOIN enrollment e ON s.id = e.student_id
GROUP BY s.id, s.full_name
HAVING COUNT(e.course_id) > 1;

SELECT c.id AS course_id, c.name AS course_name, COUNT(e.student_id) AS student_count FROM course c
JOIN enrollment e ON c.id = e.course_id
GROUP BY c.id, c.name
HAVING COUNT(e.student_id) > 2;
