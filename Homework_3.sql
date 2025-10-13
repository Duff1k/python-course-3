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
('Теоретический факультет', 1950),
('Инженерный факультет', 1967),
('Факультет кибернетики и информационных систем', 1978);

INSERT INTO students(full_name, birth_date, faculty_id, email) VALUES
('Иванов Иван Иванович', '2005-12-08', 1, 'ivanovII@mail.ru'),
('Королев Алексей Алексеевич', '2003-06-17', 1, 'alexKorol@gmail.ru'),
('Полухина Эвелина Виктровна', '2004-03-12', 2, 'poluhinaEV@yandex.ru'),
('Борисова Ирина Геннадьевна', '2006-04-26', 3, 'borisovaIG@yandex.ru'),
('Баранкин Василий Васильевич', '2002-02-22', 2, 'barankinVV@mail.ru'),
('Краснова Олеся Александровна', '2004-05-15', 3, 'krasnova2004@gmail.ru');

INSERT INTO courses(name, credits, faculty_id) VALUES
('Высшая математика: линейная алгебра', 6, 1),
('Программирование на C++', 4, 3),
('Основы проектирование киберфизических систем и установок', 2, 2),
('Машинное обучение и большие данные', 5, 3),
('Теоретическая механика', 3, 1),
('Черчение и инженерная графика', 4, 2);

INSERT INTO enrollments(student_id, course_id) VALUES
(1, 1),
(1, 5),
(2, 5),
(3, 1),
(3, 6),
(5, 3),
(5, 6),
(4, 2),
(6, 1),
(6, 4);

-- Список студентов с факультетами:
SELECT s.full_name, f.name
FROM faculties f
JOIN students s ON s.faculty_id = f.faculty_id;

-- Список курсов с указанием факультета
SELECT c.name, f.name
FROM faculties f
JOIN courses c ON c.faculty_id = f.faculty_id;

-- Список Студентов и курсов, на которые они зачислены
SELECT
	s.full_name AS student_name,
    c.name AS course_name
FROM enrollments e
JOIN students s ON s.student_id = e.student_id
JOIN courses c ON c.course_id = e.course_id;

-- Студенты, которые учатся более, чем на одном курсе
SELECT s.full_name
FROM enrollments e
JOIN students s ON s.student_id = e.student_id
GROUP BY s.full_name HAVING COUNT (e.course_id) > 1;

-- Курсы, на которых более 2-х студентов
SELECT c.name
FROM enrollments e
JOIN courses c ON c.course_id = e.course_id
GROUP BY c.name HAVING COUNT (e.student_id) > 2;




