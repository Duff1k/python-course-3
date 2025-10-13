CREATE TABLE Faculty (
	id INTEGER GENERATED ALWAYS AS IDENTITY UNIQUE PRIMARY KEY,
	name VARCHAR(200) NOT NULL UNIQUE, 
	foundation_year INT CHECK (foundation_year >= 1900) NOT NULL
);


CREATE TABLE Student (
	id INTEGER GENERATED ALWAYS AS IDENTITY UNIQUE PRIMARY KEY,
	full_name VARCHAR(200) NOT NULL, 
	birth_date DATE NOT NULL,
	faculty_id INTEGER REFERENCES Faculty(id),
	email VARCHAR(200) UNIQUE
);


CREATE TABLE Course (
	id INTEGER GENERATED ALWAYS AS IDENTITY UNIQUE PRIMARY KEY,
	name VARCHAR(200) NOT NULL, 
	credits INTEGER CHECK (credits >0 and credits <=10),
	faculty_id INTEGER REFERENCES Faculty(id)
);


CREATE TABLE Enrollment (
	id INTEGER GENERATED ALWAYS AS IDENTITY UNIQUE PRIMARY KEY,
	student_id INTEGER REFERENCES Student(id),
	course_id INTEGER REFERENCES Course(id),
	enroll_date DATE NOT NULL DEFAULT(CURRENT_DATE)
);


INSERT INTO Faculty (name, foundation_year) VALUES
	('Факультет биоинженерии', 2001),
	('Факультет робототехники', 1995),
	('Факультет космических исследований', 1980);


INSERT INTO Student (full_name, birth_date, faculty_id, email) VALUES
	('Алексей Смирнов', '2000-01-15', 1, 'smirnov.alex@example.com'),
	('Екатерина Васильева', '1999-06-20', 1, 'vasilieva.ek@example.com'),
	('Дмитрий Попов', '2001-03-10', 2, 'popov.dm@example.com'),
	('Марина Новикова', '2000-11-05', 2, 'novikova.marina@example.com'),
	('Игорь Кузьмин', '2002-04-22', 3, 'kuzmin.igor@example.com'),
	('Светлана Орлова', '2001-08-30', 3, 'orlova.svetlana@example.com');


INSERT INTO Course (name, credits, faculty_id) VALUES
	('Генетика и биотехнологии', 6, 1),
	('Молекулярная биология', 5, 1),
	('Основы робототехники', 7, 2),
	('Искусственный интеллект', 6, 2),
	('Астрофизика', 5, 3);
		

INSERT INTO Enrollment (student_id, course_id) VALUES
	(1, 1),
	(1, 2),  
	(2, 1),
	(3, 3),
	(3, 4),  
	(4, 3),
	(5, 5),
	(6, 5);  


SELECT 
	s.full_name "Студент",
	f.name "Факультет"
From Student s
Join Faculty f on s.faculty_id = f.id; 


SELECT 
	c.name "Курс",
	f.name "Факультет"
From Course c
Join Faculty f on c.faculty_id = f.id; 


SELECT 
	s.full_name "Студент",
	c.name "Курс"
From Enrollment e
Join Student s on e.student_id = s.id
Join Course c on e.course_id = c.id; 


SELECT 
	s.full_name "Студент" 
From Enrollment e
Join Student s on e.student_id = s.id
GROUP BY s.id, s.full_name
HAVING COUNT(*)>1


SELECT 
	c.name "Курс" 
From Enrollment e
Join Course c on e.course_id = c.id
GROUP BY c.id, c.name
HAVING COUNT(*)>1

