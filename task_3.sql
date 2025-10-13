-- 1. Создание таблиц
-- факультеты
CREATE TABLE faculty(
 faculty_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY, 
 name TEXT NOT NULL UNIQUE,
 foundation_year INTEGER NOT NULL CHECK(foundation_year>=1900)
);
-- студенты
CREATE TABLE student(
 student_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
 full_name TEXT NOT NULL,
 birth_date DATE NOT NULL, 
 faculty_id INTEGER REFERENCES faculty(faculty_id),
 email VARCHAR(30) UNIQUE
);
-- курсы
CREATE TABLE course(
 course_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
 name VARCHAR(30) NOT NULL,
 credits INTEGER NOT NULL CHECK(credits BETWEEN 1 and 10),
 faculty_id INTEGER REFERENCES faculty(faculty_id)
 );
-- записи о зачислениях
CREATE TABLE enrollment(
 enroll_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
 student_id INTEGER REFERENCES student(student_id),
 course_id INTEGER REFERENCES course(course_id),
 enroll_date DATE NOT NULL DEFAULT CURRENT_DATE
);
-- 2. Заполнение таблиц
INSERT INTO faculty (name, foundation_year) VALUES 
('Кибернетики', 1969), 
('Математики', 1954), 
('Биологии', 1989);

INSERT INTO student (full_name, birth_date, faculty_id, email) VALUES
('Иванов Иван Иванович', '2003-04-15', 1, 'ivanov@example.com'),
('Петров Пётр Петрович', '2002-11-02', 1, 'petrov@example.com'),
('Сидорова Анна Сергеевна', '2004-06-23', 2, 'sidorova@example.com'),
('Кузнецов Даниил Олегович', '2001-09-10', 2, 'kuznetsov@example.com'),
('Маркова Екатерина Игоревна', '2003-01-29', 3, 'markova@example.com'),
('Егорова Мария Андреевна', '2002-03-08', 1, 'egorova@example.com');

INSERT INTO course (name, credits, faculty_id) VALUES
('Базы данных', 6, 1),  
('Алгоритмы и структуры', 5, 1), 
('Математический анализ', 7, 2), 
('Линейная алгебра', 5, 2),
('Общая биология', 4, 3);

INSERT INTO enrollment (student_id, course_id, enroll_date) VALUES
(1, 1, '2020-09-04'),
(1, 2, '2020-10-01'),
(2, 1, '2019-09-06'),
(3, 3, '2022-11-09'),
(3, 4, '2023-10-15'),
(4, 3, '2019-09-01'),
(4, 2, '2021-10-28'),
(5, 5, '2022-04-25'),
(5, 4, '2023-05-08'),
(6, 1, '2024-02-07'),
(6, 4, '2025-03-08');

-- 4. Запросы
-- Вывести список всех студентов с названием факультета, на котором они учатся.
SELECT s.full_name, f.name
FROM student s JOIN faculty f ON s.faculty_id=f.faculty_id;
-- Вывести список курсов с указанием факультета, к которому они относятся.
SELECT c.name, f.name
FROM course c JOIN faculty f ON c.faculty_id=f.faculty_id;
-- Вывести список студентов и курсов, на которые они зачислены.
SELECT s.full_name, c.name
FROM student s 
JOIN enrollment e ON s.student_id =e.student_id 
JOIN course c ON c.course_id=e.course_id;
-- Найти всех студентов, которые учатся более чем на одном курсе.
SELECT s.full_name
FROM student s JOIN enrollment e ON s.student_id=e.student_id
GROUP BY s.full_name
HAVING COUNT(e.course_id)>1;
-- Найти курсы, на которых учатся более 2 студентов.
SELECT c.name
FROM course c JOIN enrollment e ON c.course_id=e.course_id
GROUP BY c.name
HAVING COUNT(e.student_id)>2;