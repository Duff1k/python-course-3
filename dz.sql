
CREATE TABLE Faculty (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    foundation_year INTEGER NOT NULL CHECK (foundation_year >= 1900)
);


CREATE TABLE Student (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    birth_date DATE NOT NULL,
    faculty_id INTEGER NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    FOREIGN KEY (faculty_id) REFERENCES Faculty(id) ON DELETE CASCADE
);


CREATE TABLE Course (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    credits INTEGER NOT NULL CHECK (credits BETWEEN 1 AND 10),
    faculty_id INTEGER NOT NULL,
    FOREIGN KEY (faculty_id) REFERENCES Faculty(id) ON DELETE CASCADE
);


CREATE TABLE Enrollment (
    id SERIAL PRIMARY KEY,
    student_id INTEGER NOT NULL,
    course_id INTEGER NOT NULL,
    enroll_date DATE NOT NULL DEFAULT CURRENT_DATE,
    FOREIGN KEY (student_id) REFERENCES Student(id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES Course(id) ON DELETE CASCADE,
    UNIQUE(student_id, course_id) -- предотвращает дублирование записей
);


INSERT INTO Faculty (name, foundation_year) VALUES
('Факультет информатики', 1995),
('Экономический факультет', 1980),
('Филологический факультет', 1975);


INSERT INTO Student (full_name, birth_date, faculty_id, email) VALUES
('Иванов Алексей Петрович', '2000-05-15', 1, 'ivanov@university.ru'),
('Петрова Мария Сергеевна', '2001-03-20', 1, 'petrova@university.ru'),
('Сидоров Дмитрий Иванович', '2000-11-10', 1, 'sidorov@university.ru'),
('Козлова Анна Владимировна', '2001-07-25', 2, 'kozlova@university.ru'),
('Николаев Павел Олегович', '2000-12-30', 2, 'nikolaev@university.ru'),
('Федорова Елена Дмитриевна', '2001-09-05', 3, 'fedorova@university.ru');


INSERT INTO Course (name, credits, faculty_id) VALUES
('Программирование на Python', 5, 1),
('Базы данных', 6, 1),
('Веб-разработка', 4, 1),
('Микроэкономика', 5, 2),
('Бухгалтерский учет', 6, 2),
('История литературы', 4, 3);


INSERT INTO Enrollment (student_id, course_id, enroll_date) VALUES

(1, 1, '2023-09-01'),
(1, 2, '2023-09-01'),


(2, 1, '2023-09-01'),
(3, 1, '2023-09-01'),


(2, 3, '2023-09-01'),
(4, 4, '2023-09-01'),
(4, 5, '2023-09-01'),
(5, 4, '2023-09-01'),
(6, 6, '2023-09-01');


SELECT
    s.id,
    s.full_name,
    s.birth_date,
    s.email,
    f.name as faculty_name
FROM Student s
JOIN Faculty f ON s.faculty_id = f.id
ORDER BY s.id;


SELECT
    c.id,
    c.name as course_name,
    c.credits,
    f.name as faculty_name
FROM Course c
JOIN Faculty f ON c.faculty_id = f.id
ORDER BY c.id;


SELECT
    s.full_name as student_name,
    f.name as faculty_name,
    c.name as course_name,
    e.enroll_date
FROM Enrollment e
JOIN Student s ON e.student_id = s.id
JOIN Course c ON e.course_id = c.id
JOIN Faculty f ON s.faculty_id = f.id
ORDER BY s.full_name, c.name;


SELECT
    s.id,
    s.full_name,
    COUNT(e.course_id) as course_count
FROM Student s
JOIN Enrollment e ON s.id = e.student_id
GROUP BY s.id, s.full_name
HAVING COUNT(e.course_id) > 1
ORDER BY course_count DESC;


SELECT
    c.id,
    c.name as course_name,
    COUNT(e.student_id) as student_count
FROM Course c
JOIN Enrollment e ON c.id = e.course_id
GROUP BY c.id, c.name
HAVING COUNT(e.student_id) > 2
ORDER BY student_count DESC;