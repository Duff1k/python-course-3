CREATE TABLE faculties (
	faculty_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	name VARCHAR(100) NOT NULL UNIQUE,
	foundation_year INT NOT NULL CHECK (foundation_year > 1900)
);

CREATE TABLE students (
	student_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	full_name VARCHAR(100) NOT NULL UNIQUE,
	birth_date DATE NOT NULL,
	faculty_id INT,
	email VARCHAR(100) UNIQUE,
	FOREIGN KEY (faculty_id) REFERENCES faculties(faculty_id)
);

CREATE TABLE courses (
	course_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	name VARCHAR(100) NOT NULL,
	credits INT CHECK (credits BETWEEN 1 AND 10),
	faculty_id INT,
	FOREIGN KEY (faculty_id) REFERENCES faculties(faculty_id)
);

CREATE TABLE enrollments (
	enrollment_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	student_id INT,
	course_id INT,
	enroll_date DATE NOT NULL DEFAULT (CURRENT_DATE),
	FOREIGN KEY (student_id) REFERENCES students(student_id),
	FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

INSERT INTO faculties(name, foundation_year) VALUES
('Архитектурный факультет', 1945),
('Физический факультет', 1967),
('Биологический факультет', 1998);

INSERT INTO students(full_name, birth_date, faculty_id, email) VALUES
('Симпсон Барт Гомерович', '1980-04-01', 1, 'bart@aol.com'),
('Симпсон Лиза Гомеровна', '1981-05-09', 1, 'lisa@aol.com'),
('Симпсон Гомер Абрахамович', '1956-05-12', 2, 'ChunkyLover53@aol.com'),
('Сизлак Мо Романович', '1927-11-24', 3, 'moG@aol.com'),
('Муссолини Милхаус ВунХаутер', '1980-07-01', 2, 'mil@aol.com'),
('Фландерс Нед Недвардович', '1959-06-07', 3, 'ned@aol.com');

INSERT INTO courses(name, credits, faculty_id) VALUES
('Кибернетика', 6, 2),
('Программирование на Phyton', 4, 1),
('Ядерная физика', 2, 3),
('Машинностроение', 5, 1),
('Сопротивление материалов', 3, 2),
('Пение', 4, 3);

INSERT INTO enrollments(student_id, course_id) VALUES
(1, 2),
(1, 4),
(2, 3),
(3, 2),
(3, 1),
(5, 4),
(5, 1),
(4, 3),
(6, 2),
(6, 5);

-- Список студентов с факультетами:
SELECT s.full_name, f.name
FROM faculties f
JOIN students s ON s.faculty_id = f.faculty_id;

-- Список курсов с указанием факультета:
SELECT c.name, f.name
FROM faculties f
JOIN courses c ON c.faculty_id = f.faculty_id;

-- Список Студентов с курсами:
SELECT
	s.full_name AS student_name,
    c.name AS course_name
FROM enrollments e
JOIN students s ON s.student_id = e.student_id
JOIN courses c ON c.course_id = e.course_id;

-- Студенты, которые зачислены более, чем на один курс:
SELECT s.full_name
FROM enrollments e
JOIN students s ON s.student_id = e.student_id
GROUP BY s.full_name HAVING COUNT (e.course_id) > 1;

-- Курсы, на которых учатся более 2-х студентов:
SELECT c.name
FROM enrollments e
JOIN courses c ON c.course_id = e.course_id
GROUP BY c.name HAVING COUNT (e.student_id) > 2;