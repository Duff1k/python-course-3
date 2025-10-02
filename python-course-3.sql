-- Задание 1 и 3
CREATE TABLE Faculty (
	id INTEGER GENERATED ALWAYS AS IDENTITY UNIQUE PRIMARY KEY,
	name VARCHAR(255) NOT NULL UNIQUE, 
	foundation_year INT CHECK (foundation_year >= 1900) NOT NULL
);


CREATE TABLE Student (
	id INTEGER GENERATED ALWAYS AS IDENTITY UNIQUE PRIMARY KEY,
	full_name VARCHAR(255) NOT NULL, 
	birth_date DATE NOT NULL,
	faculty_id INTEGER REFERENCES Faculty(id),
	email VARCHAR(255) UNIQUE
);


CREATE TABLE Course (
	id INTEGER GENERATED ALWAYS AS IDENTITY UNIQUE PRIMARY KEY,
	name VARCHAR(255) NOT NULL, 
	credits INTEGER CHECK (credits >0 and credits <=10),
	faculty_id INTEGER REFERENCES Faculty(id)
);


CREATE TABLE Enrollment (
	id INTEGER GENERATED ALWAYS AS IDENTITY UNIQUE PRIMARY KEY,
	student_id INTEGER REFERENCES Student(id),
	course_id INTEGER REFERENCES Course(id),
	enroll_date DATE NOT NULL DEFAULT(CURRENT_DATE)
);


-- Задание 2
INSERT INTO Faculty (name, foundation_year) VALUES
	('Факультет прикладной физики', 1935),
	('Факультет программирования', 1977),
	('Факультет высшей математики', 1955),
	('Факультет материаловедения', 1960);


INSERT INTO Student (full_name, birth_date, faculty_id, email) VALUES
	('Иванов Петр Степанович', '14.10.2000', 1, 'ivanOV@mail.ru'),
	('Маврин Николай Васильевич', '21.01.1997', 2, 'MAVnw@mail.ru'),
	('Степанова Василиса Викторовна', '07.07.2001', 3, 'StepanVV@mail.ru'),
	('Васильев Алексей Александрович', '15.12.1999', 4, 'WasAA@mail.ru'),
	('Макаров Дмитрий Никитиевич', '18.06.2002', 2, 'MakDN@mail.ru'),
	('Кудрин Никита Павлович', '11.04.1999', 1, 'KudNP@mail.ru'),
	('Альтова Ольга Николаевна', '20.02.2000', 2, 'AltON@mail.ru');


INSERT INTO Course (name, credits, faculty_id) VALUES
	('Общая физика', 5, 1),
	('Лазеры', 7, 1),
	('Введение в программирование', 9, 2),
	('Python разработка', 7, 2),
	('Математический анализ', 4, 3),
	('Материаловедение металлы', 3, 4),
	('Композитные материалы', 4, 4);


INSERT INTO Enrollment (student_id, course_id, enroll_date) VALUES
	(1, 1, '07.09.2018'),
	(2, 3, '09.09.2015'),
	(3, 5, '07.09.2019'),
	(4, 6, '07.09.2018'),
	(5, 3, '07.09.2020');
		

INSERT INTO Enrollment (student_id, course_id) VALUES
	(1, 2),
	(4, 7),
	(6, 2),
	(7, 4);


-- Задание 4
--Вывести список всех студентов с названием факультета, на котором они учатся.
SELECT 
	s.full_name "Студент",
	f.name "Факультет"
From Student s
Join Faculty f on s.faculty_id = f.id; 


--Вывести список курсов с указанием факультета, к которому они относятся.
SELECT 
	c.name "Курс",
	f.name "Факультет"
From Course c
Join Faculty f on c.faculty_id = f.id; 


--Вывести список студентов и курсов, на которые они зачислены.
SELECT 
	s.full_name "Студент",
	c.name "Курс"
From Enrollment e
Join Student s on e.student_id = s.id
Join Course c on e.course_id = c.id; 


--Найти всех студентов, которые учатся более чем на одном курсе.
SELECT 
	s.full_name "Студент" 
From Enrollment e
Join Student s on e.student_id = s.id
GROUP BY s.id, s.full_name
HAVING COUNT(*)>1


--Найти курсы, на которых учатся более 2 студентов.
SELECT 
	c.name "Курс" 
From Enrollment e
Join Course c on e.course_id = c.id
GROUP BY c.id, c.name
HAVING COUNT(*)>1

