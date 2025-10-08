-- 1. Создание таблиц
CREATE TABLE faculty (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    foundation_year INTEGER NOT NULL CHECK (foundation_year >= 1900)
);

CREATE TABLE student (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(200) NOT NULL,
    birth_date DATE NOT NULL,
    faculty_id INTEGER NOT NULL,
    email VARCHAR(100) UNIQUE,
    FOREIGN KEY (faculty_id) REFERENCES faculty(id) ON DELETE CASCADE
);

CREATE TABLE course (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    credits INTEGER NOT NULL CHECK (credits BETWEEN 1 AND 10),
    faculty_id INTEGER NOT NULL,
    FOREIGN KEY (faculty_id) REFERENCES faculty(id) ON DELETE CASCADE
);

CREATE TABLE enrollment (
    id SERIAL PRIMARY KEY,
    student_id INTEGER NOT NULL,
    course_id INTEGER NOT NULL,
    enroll_date DATE NOT NULL DEFAULT CURRENT_DATE,
    FOREIGN KEY (student_id) REFERENCES student(id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES course(id) ON DELETE CASCADE,
    UNIQUE(student_id, course_id)
);

-- 2. Заполнение таблиц
INSERT INTO faculty (name, foundation_year) VALUES
('Факультет информатики', 1995),
('Экономический факультет', 1980),
('Факультет иностранных языков', 1975);

INSERT INTO student (full_name, birth_date, faculty_id, email) VALUES
('Иванов Петр Сергеевич', '2000-05-15', 1, 'ivanov@university.ru'),
('Петрова Мария Ивановна', '2001-03-20', 1, 'petrova@university.ru'),
('Сидоров Алексей Владимирович', '2000-11-10', 1, 'sidorov@university.ru'),
('Козлова Анна Дмитриевна', '2001-07-03', 2, 'kozlova@university.ru'),
('Смирнов Дмитрий Петрович', '2000-12-25', 2, 'smirnov@university.ru'),
('Фролова Екатерина Сергеевна', '2001-09-14', 3, 'frolova@university.ru');

INSERT INTO course (name, credits, faculty_id) VALUES
('Базы данных', 5, 1),
('Программирование на Python', 4, 1),
('Веб-разработка', 6, 1),
('Микроэкономика', 5, 2),
('Бухгалтерский учет', 4, 2),
('Английский язык', 3, 3);

INSERT INTO enrollment (student_id, course_id, enroll_date) VALUES
-- Иванов Петр записан на 3 курса 
(1, 1, '2023-09-01'),
(1, 2, '2023-09-01'),
(1, 3, '2023-09-01'),

-- Петрова Мария записана на 2 курса 
(2, 1, '2023-09-01'),
(2, 3, '2023-09-01'),

-- Сидоров Алексей записан на 2 курса 
(3, 1, '2023-09-01'),
(3, 2, '2023-09-01'),

-- Козлова Анна записана на 2 курса
(4, 4, '2023-09-01'),
(4, 5, '2023-09-01'),

-- Смирнов Дмитрий записан на 1 курс
(5, 4, '2023-09-01'),

-- Фролова Екатерина записана на 1 курс
(6, 6, '2023-09-01');

-- 3. Запросы 
-- Запрос 1: Вывести список всех студентов с названием факультета
SELECT 
    s.full_name AS "ФИО студента",
    s.birth_date AS "Дата рождения",
    s.email AS "Email",
    f.name AS "Факультет"
FROM student s
JOIN faculty f ON s.faculty_id = f.id
ORDER BY f.name, s.full_name;

-- Запрос 2: Вывести список курсов с указанием факультета
SELECT 
    c.name AS "Название курса",
    f.name AS "Факультет"
FROM course c
JOIN faculty f ON c.faculty_id = f.id
ORDER BY f.name, c.name;

-- Запрос 3: Вывести список студентов и курсов, на которые они зачислены
SELECT 
    s.full_name AS "Студент",
    f.name AS "Факультет",
    c.name AS "Курс",
    e.enroll_date AS "Дата зачисления"
FROM enrollment e
JOIN student s ON e.student_id = s.id
JOIN course c ON e.course_id = c.id
JOIN faculty f ON s.faculty_id = f.id
ORDER BY s.full_name, c.name;

-- Запрос 4: Найти всех студентов, которые учатся более чем на одном курсе
SELECT 
    s.full_name AS "Студент",
    f.name AS "Факультет",
    COUNT(e.course_id) AS "Количество курсов"
FROM student s
JOIN faculty f ON s.faculty_id = f.id
JOIN enrollment e ON s.id = e.student_id
GROUP BY s.id, s.full_name, f.name
HAVING COUNT(e.course_id) > 1
ORDER BY COUNT(e.course_id) DESC;

-- Запрос 5: Найти курсы, на которых учатся более 2 студентов
SELECT 
    c.name AS "Курс",
    f.name AS "Факультет",
    COUNT(e.student_id) AS "Количество студентов"
FROM course c
JOIN faculty f ON c.faculty_id = f.id
JOIN enrollment e ON c.id = e.course_id
GROUP BY c.id, c.name, f.name
HAVING COUNT(e.student_id) > 2
ORDER BY COUNT(e.student_id) DESC;
