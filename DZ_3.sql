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
('Факультет информатики и математики', 1965),
('Факультет филологии', 1948),
('Факультет экономики и управления', 1971);

INSERT INTO Student (full_name, birth_date, faculty_id, email) VALUES
('Иванов Иван Иванович', '2002-05-15', 1, 'ivanov@university.ru'),
('Петрова Мария Александровна', '2001-11-23', 1, 'petrova@university.ru'),
('Сидоров Петр Владимирович', '2003-03-08', 2, 'sidorov@university.ru'),
('Козлова Елена Сергеевна', '2002-09-12', 2, 'kozlova@university.ru'),
('Морозов Андрей Дмитриевич', '2001-07-30', 3, 'morozov@university.ru'),
('Волкова Анна Николаевна', '2003-01-18', 3, 'volkova@university.ru');

INSERT INTO Course (name, credits, faculty_id) VALUES
('Основы программирования', 6, 1),
('Дискретная математика', 5, 1),
('Русский язык и литература', 4, 2),
('История русской литературы', 5, 2),
('Микроэкономика', 6, 3);

INSERT INTO Enrollment (student_id, course_id) VALUES
(1, 1), (1, 2), (2, 1), (3, 3), (3, 4), (4, 3), (5, 5), (6, 5);

-- 1. Связь Faculty ↔ Student (One-to-Many)
ALTER TABLE Student
  ADD CONSTRAINT fk_student_faculty
  FOREIGN KEY (faculty_id)
    REFERENCES Faculty(id)
    ON UPDATE CASCADE
    ON DELETE RESTRICT;

-- 2. Связь Faculty ↔ Course (One-to-Many)
ALTER TABLE Course
  ADD CONSTRAINT fk_course_faculty
  FOREIGN KEY (faculty_id)
    REFERENCES Faculty(id)
    ON UPDATE CASCADE
    ON DELETE RESTRICT;

-- 3. Связь Student ↔ Course через Enrollment (Many-to-Many)
-- 3.1. Связь Enrollment.student_id → Student(id)
ALTER TABLE Enrollment
  ADD CONSTRAINT fk_enrollment_student
  FOREIGN KEY (student_id)
    REFERENCES Student(id)
    ON UPDATE CASCADE
    ON DELETE CASCADE;

-- 3.2. Связь Enrollment.course_id → Course(id)
ALTER TABLE Enrollment
  ADD CONSTRAINT fk_enrollment_course
  FOREIGN KEY (course_id)
    REFERENCES Course(id)
    ON UPDATE CASCADE
    ON DELETE CASCADE;

SELECT 
    s.full_name AS "ФИО студента",
    f.name AS "Название факультета"
FROM Student s
JOIN Faculty f ON s.faculty_id = f.id
;

SELECT 
    c.name AS "Название курса",
    c.credits AS "Кредиты",
    f.name AS "Факультет"
FROM Course c
JOIN Faculty f ON c.faculty_id = f.id
;

SELECT 
    s.full_name AS "ФИО студента",
    c.name AS "Название курса",
    e.enroll_date AS "Дата зачисления"
FROM Enrollment e
JOIN Student s ON e.student_id = s.id
JOIN Course c ON e.course_id = c.id
;

SELECT 
    s.full_name AS "ФИО студента",
    COUNT(e.course_id) AS "Количество курсов"
FROM Student s
JOIN Enrollment e ON s.id = e.student_id
GROUP BY s.id, s.full_name
HAVING COUNT(e.course_id) > 1
;

SELECT 
    c.name AS "Название курса",
    COUNT(e.student_id) AS "Количество студентов"
FROM Course c
JOIN Enrollment e ON c.id = e.course_id
GROUP BY c.id, c.name
HAVING COUNT(e.student_id) > 2
;