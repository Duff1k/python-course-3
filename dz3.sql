
CREATE TABLE Faculty (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE,
    foundation_year INTEGER NOT NULL CHECK (foundation_year >= 1900)
);

CREATE TABLE Student (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(500) NOT NULL,
    birth_date DATE NOT NULL,
    faculty_id INTEGER NOT NULL,
    email VARCHAR(255) UNIQUE,
    FOREIGN KEY (faculty_id) REFERENCES Faculty(id)
);

CREATE TABLE Course (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    credits INTEGER NOT NULL CHECK (credits >= 1 AND credits <= 10),
    faculty_id INTEGER NOT NULL,
    FOREIGN KEY (faculty_id) REFERENCES Faculty(id)
);

CREATE TABLE Enrollment (
    id SERIAL PRIMARY KEY,
    student_id INTEGER NOT NULL,
    course_id INTEGER NOT NULL,
    enroll_date DATE NOT NULL DEFAULT CURRENT_DATE,
    FOREIGN KEY (student_id) REFERENCES Student(id),
    FOREIGN KEY (course_id) REFERENCES Course(id),
    UNIQUE(student_id, course_id)
);

INSERT INTO Faculty (name, foundation_year) VALUES
('Факультет искусств и дизайна', 1985),
('Факультет биотехнологий', 1992),
('Факультет международных отношений', 1978);

INSERT INTO Student (full_name, birth_date, faculty_id, email) VALUES
('Смирнов Алексей Викторович', '2000-08-12', 1, 'smirnov.art@mail.ru'),
('Орлова Дарья Игоревна', '2001-12-03', 1, 'orlova.daria@mail.ru'),
('Лебедев Максим Андреевич', '2002-04-25', 2, 'lebedev.bio@mail.ru'),
('Громова Екатерина Павловна', '1999-11-17', 2, 'gromova.kate@mail.ru'),
('Васнецов Илья Сергеевич', '2000-07-30', 3, 'vasnecov.diplo@mail.ru'),
('Зайцева Виктория Олеговна', '2001-02-14', 3, 'zaitseva.vika@mail.ru');

INSERT INTO Course (name, credits, faculty_id) VALUES
('История искусств', 5, 1),
('Цифровой дизайн', 7, 1),
('Генная инженерия', 8, 2),
('Биоинформатика', 6, 2),
('Международное право', 5, 3),
('Дипломатический протокол', 4, 3);

INSERT INTO Enrollment (student_id, course_id, enroll_date) VALUES
(1, 1, '2025-09-01'),
(1, 2, '2025-09-01'),
(2, 1, '2025-09-02'),
(3, 3, '2025-09-01'),
(3, 4, '2025-09-03'),
(4, 3, '2025-09-02'),
(4, 4, '2025-09-02'),
(5, 5, '2025-09-01'),
(6, 5, '2025-09-02'),
(6, 6, '2025-09-02');

SELECT 
    s.full_name AS "ФИО студента",
    f.name AS "Факультет",
    s.birth_date AS "Дата рождения"
FROM Student s
JOIN Faculty f ON s.faculty_id = f.id;

SELECT 
    c.name AS "Название курса",
    c.credits AS "Кредиты",
    f.name AS "Факультет"
FROM Course c
JOIN Faculty f ON c.faculty_id = f.id
ORDER BY f.name, c.credits DESC;

SELECT 
    s.full_name AS "ФИО студента",
    c.name AS "Название курса",
    f.name AS "Факультет курса",
    e.enroll_date AS "Дата зачисления"
FROM Enrollment e
JOIN Student s ON e.student_id = s.id
JOIN Course c ON e.course_id = c.id
JOIN Faculty f ON c.faculty_id = f.id
ORDER BY s.full_name, e.enroll_date;

SELECT 
    s.full_name AS "ФИО студента",
    COUNT(e.course_id) AS "Количество курсов",
    f.name AS "Факультет"
FROM Student s
JOIN Enrollment e ON s.id = e.student_id
JOIN Faculty f ON s.faculty_id = f.id
GROUP BY s.id, s.full_name, f.name
HAVING COUNT(e.course_id) > 1
ORDER BY COUNT(e.course_id) DESC;

SELECT 
    c.name AS "Название курса",
    COUNT(e.student_id) AS "Количество студентов",
    f.name AS "Факультет"
FROM Course c
JOIN Enrollment e ON c.id = e.course_id
JOIN Faculty f ON c.faculty_id = f.id
GROUP BY c.id, c.name, f.name
HAVING COUNT(e.student_id) >= 2
ORDER BY COUNT(e.student_id) DESC;