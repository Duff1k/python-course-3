-- 1. и 3. Создание таблиц со связями
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
('Факультет истории', 1995),
('Факультет менежмента', 1980),
('Факультет иностранных языков', 1975),
('Факультет художественно-графический', 1991),
('Факультет юриспреденции', 1984);

INSERT INTO student (full_name, birth_date, faculty_id, email) VALUES
('Александрова Кристина Евгеньевна', '1999-04-16', 1, 'aleksandrova@mail.ru'),
('Сахаров Леонид Федорович', '2000-08-21', 1, 'saharov@mail.ru'),
('Конева Александра Леонидовна', '2001-12-15', 1, 'korneva@mail.ru'),
('Федоров Павел Борисович', '2000-08-08', 2, 'fedorov@mail.ru'),
('Шамова Татьяна Игнатьевна', '1998-12-28', 2, 'shamova@mail.ru'),
('Калашников Егор Тимофеевич', '1997-12-11', 2, 'kalashnikov@mail.ru'),
('Хоботова Агата Александровна', '1995-12-26', 3, 'hobotova@mail.ru'),
('Альянов Игорь Константинович', '2002-10-22', 3, 'alynov@mail.ru'),
('Грачев Александр Юрьевич', '1998-12-28', 4, 'grachov@mail.ru'),
('Соколов Дамир Сергеевич', '2001-04-18', 5, 'sokolov@mail.ru');

INSERT INTO course (name, credits, faculty_id) VALUES
('История элинской цивилизация', 5, 1),
('Восхождение Карфагена', 4, 1),
('Латинские народы', 6, 1),
('Менеджмент корпораций', 5, 2),
('Менеджмент малого и среднего бизнеса', 4, 2),
('Немецкий язык', 3, 3),
('Художественный', 2, 4),
('Англиское право', 3, 5)
;


INSERT INTO enrollment (student_id, course_id, enroll_date) VALUES
-- Александрова Кристина Евгеньевна записана на 3 курса 
(1, 1, '2023-09-01'),
(1, 2, '2023-09-01'),
(1, 3, '2023-09-01'),

-- Сахаров Леонид Федорович записан на 2 курса 
(2, 1, '2023-09-01'),
(2, 2, '2023-09-01'),

-- Конева Александра Леонидовна записана на 2 курса 
(3, 1, '2023-09-01'),
(3, 3, '2023-09-01'),

-- Федоров Павел Борисович записан на 2 курса
(4, 4, '2023-09-01'),
(4, 5, '2023-09-01'),

-- Шамова Татьяна Игнатьевна записана на 1 курс
(5, 4, '2023-09-01'),

-- Калашников Егор Тимофеевич записан на 1 курс
(6, 6, '2023-09-01'),

-- Хоботова Агата Александровна записана на 1 курс
(7, 7, '2023-09-01'),

-- Альянов Игорь Константинович записан на 1 курс
(8, 8, '2023-09-01'),

-- Грачев Александр Юрьевич записан на 2 курса
(9, 4, '2023-09-01'),
(9, 5, '2023-09-01'),

-- Соколов Дамир Сергеевич записан на 1 курс
(10, 2, '2023-09-01');

-- 4. Запросы 
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

--Запрос 5: Найти курсы, на которых учатся более 2 студентов
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
