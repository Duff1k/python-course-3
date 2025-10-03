-- Таблица Faculty
CREATE TABLE Faculty (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    foundation_year INT NOT NULL CHECK (foundation_year >= 1900)
);

-- Таблица Student
CREATE TABLE Student (
    id INT PRIMARY KEY,
    full_name VARCHAR(150) NOT NULL,
    birth_date DATE NOT NULL,
    faculty_id INT NOT NULL,
    email VARCHAR(100) UNIQUE,
    FOREIGN KEY (faculty_id) REFERENCES Faculty(id)
);

-- Таблица Course
CREATE TABLE Course (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    credits INT CHECK (credits BETWEEN 1 AND 10),
    faculty_id INT NOT NULL,
    FOREIGN KEY (faculty_id) REFERENCES Faculty(id)
);

-- Таблица Enrollment
CREATE TABLE Enrollment (
    id INT PRIMARY KEY,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    enroll_date DATE DEFAULT CURRENT_DATE,
    FOREIGN KEY (student_id) REFERENCES Student(id),
    FOREIGN KEY (course_id) REFERENCES Course(id),
    UNIQUE (student_id, course_id)  -- чтобы студент не записывался дважды на один курс
);

INSERT INTO Faculty (id, name, foundation_year) VALUES
(1, 'Английский', 1995),
(2, 'Математика', 1991),
(3, 'Информатика', 2001);


INSERT INTO Student (id, full_name, birth_date, faculty_id, email) VALUES
(1, 'Иванов Иван Иванович', '2003-05-12', 1, 'ivanov@example.com'),
(2, 'Игорев Игорь Сергеевич', '2004-08-23', 1, 'petrova@example.com'),
(3, 'Сидоров Сидор Алексеевич', '1999-11-30', 2, 'sidorov@example.com'),
(4, 'Маринова Мария Игоревна', '2005-02-14', 2, 'kuznetsova@example.com'),
(5, 'Артемов Артём Олегович', '1997-07-19', 3, 'volkov@example.com'),
(6, 'Нкатеринова Екатерина Дмитриевна', '2003-12-01', 1, 'morozova@example.com');

INSERT INTO Course (id, name, credits, faculty_id) VALUES
(1, 'Основы программирования', 5, 3),
(2, 'Базы данных', 6, 3),
(3, 'Теория вероятностей', 4, 2),
(4, 'Гриша Перельман - как уникальность', 5, 2),
(5, 'Лингвистика в современном мире', 7, 3);

INSERT INTO Enrollment (id, student_id, course_id, enroll_date) VALUES
(1, 1, 1, '2024-09-01'),  
(2, 1, 2, '2024-09-01'),  
(3, 2, 1, '2024-09-01'),  
(4, 3, 3, '2024-09-01'),  
(5, 4, 4, '2024-09-01'),  
(6, 5, 5, '2024-09-01'),  
(7, 6, 1, '2024-09-01');  

-- 1. Список всех студентов с названием факультета
SELECT 
    s.full_name,
    f.name AS faculty_name
FROM Student s
JOIN Faculty f ON s.faculty_id = f.id;

-- 2.  Список курсов с указанием факультета
SELECT 
    c.name AS course_name,
    f.name AS faculty_name
FROM Course c
JOIN Faculty f ON c.faculty_id = f.id;

-- 3. Список студентов и курсов, на которые они зачислены
SELECT 
    s.full_name,
    c.name AS course_name,
    e.enroll_date
FROM Enrollment e
JOIN Student s ON e.student_id = s.id
JOIN Course c ON e.course_id = c.id;

-- 4. Студенты, обучающиеся более чем на одном курсе
SELECT 
    s.full_name,
    COUNT(e.course_id) AS course_count
FROM Student s
JOIN Enrollment e ON s.id = e.student_id
GROUP BY s.id, s.full_name
HAVING COUNT(e.course_id) > 1;

-- 5. Курсы, на которых учатся более 2 студентов
SELECT 
    c.name AS course_name,
    COUNT(e.student_id) AS student_count
FROM Course c
JOIN Enrollment e ON c.id = e.course_id
GROUP BY c.id, c.name
HAVING COUNT(e.student_id) > 2;
