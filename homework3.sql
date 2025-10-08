-- Задание 1: Создание таблиц
CREATE TABLE Faculty (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE, 
    foundation_year INTEGER NOT NULL CHECK (foundation_year >= 1900)
);

CREATE TABLE Student (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    full_name VARCHAR(255) NOT NULL, 
    birth_date DATE NOT NULL,
    faculty_id INTEGER NOT NULL REFERENCES Faculty(id) ON DELETE CASCADE,
    email VARCHAR(255) UNIQUE
);

CREATE TABLE Course (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(255) NOT NULL, 
    credits INTEGER NOT NULL CHECK (credits BETWEEN 1 AND 10),
    faculty_id INTEGER NOT NULL REFERENCES Faculty(id) ON DELETE CASCADE
);

CREATE TABLE Enrollment (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    student_id INTEGER NOT NULL REFERENCES Student(id) ON DELETE CASCADE,
    course_id INTEGER NOT NULL REFERENCES Course(id) ON DELETE CASCADE,
    enroll_date DATE NOT NULL DEFAULT CURRENT_DATE,
    UNIQUE(student_id, course_id)
);

-- Задание 2: Добавление данных
-- Добавление факультетов
INSERT INTO Faculty (name, foundation_year) VALUES
('Факультет информатики и вычислительной техники', 1965),
('Экономический факультет', 1950),
('Факультет иностранных языков', 1972);

-- Добавление студентов
INSERT INTO Student (full_name, birth_date, faculty_id, email) VALUES
('Иванов Алексей Сергеевич', '2000-05-15', 1, 'ivanov.alex@email.com'),
('Петрова Мария Дмитриевна', '2001-03-22', 1, 'petrova.maria@email.com'),
('Сидоров Дмитрий Иванович', '2000-11-08', 1, 'sidorov.dmitry@email.com'),
('Козлова Анна Викторовна', '2001-07-30', 2, 'kozlova.anna@email.com'),
('Николаев Павел Андреевич', '2000-12-14', 2, 'nikolaev.pavel@email.com'),
('Фролова Екатерина Олеговна', '2001-02-19', 3, 'frolova.ekaterina@email.com');

-- Добавление курсов
INSERT INTO Course (name, credits, faculty_id) VALUES
('Программирование на Python', 5, 1),
('Базы данных', 6, 1),
('Веб-разработка', 4, 1),
('Микроэкономика', 5, 2),
('Бухгалтерский учет', 6, 2),
('Английский язык для начинающих', 3, 3);

-- Добавление записей о зачислениях
INSERT INTO Enrollment (student_id, course_id, enroll_date) VALUES
-- Студент 1 (Иванов) записан на 2 курса
(1, 1, '2025-09-01'),
(1, 2, '2025-09-01'),

-- Студенты 2 и 3 (Петрова и Сидоров) учатся на одном курсе (курс 1)
(2, 1, '2025-09-01'),
(3, 1, '2025-09-01'),

-- Студент 2 (Петрова) также записан на другой курс
(2, 3, '2025-09-01'),

-- Студенты с экономического факультета
(4, 4, '2025-09-01'),
(5, 4, '2025-09-01'),
(5, 5, '2025-09-01'),

-- Студент с факультета иностранных языков
(6, 6, '2025-09-01');

-- Задание 4: Запросы
-- 1. Вывести список всех студентов с названием факультета
SELECT 
    s.full_name "Студент",
    f.name "Факультет"
FROM Student s
JOIN Faculty f ON s.faculty_id = f.id;

-- 2. Вывести список курсов с указанием факультета
SELECT 
    c.name "Курс",
    f.name "Факультет"
FROM Course c
JOIN Faculty f ON c.faculty_id = f.id;

-- 3. Вывести список студентов и курсов, на которые они зачислены
SELECT 
    s.full_name "Студент",
    c.name "Курс"
FROM Enrollment e
JOIN Student s ON e.student_id = s.id
JOIN Course c ON e.course_id = c.id;

-- 4. Найти всех студентов, которые учатся более чем на одном курсе
SELECT 
    s.full_name "Студент",
    COUNT(e.course_id) as "Количество курсов"
FROM Enrollment e
JOIN Student s ON e.student_id = s.id
GROUP BY s.id, s.full_name
HAVING COUNT(e.course_id) > 1;

-- 5. Найти курсы, на которых учатся более 2 студентов
SELECT 
    c.name "Курс",
    COUNT(e.student_id) as "Количество студентов"
FROM Enrollment e
JOIN Course c ON e.course_id = c.id
GROUP BY c.id, c.name
HAVING COUNT(e.student_id) > 2;