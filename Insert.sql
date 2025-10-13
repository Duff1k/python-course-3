INSERT INTO Faculty (name, foundation_year) VALUES
('Факультет Информатики', 1980),
('Факультет Математики', 1975),
('Факультет Филологии', 1960);

INSERT INTO Student (full_name, birth_date, faculty_id, email) VALUES
('Иван Иванов', '2003-05-14', 1, 'ivanov@example.com'),
('Мария Петрова', '2002-11-22', 2, 'petrova@example.com'),
('Алексей Смирнов', '2001-03-01', 1, 'smirnov@example.com'),
('Елена Кузнецова', '2000-07-19', 3, 'kuznetsova@example.com'),
('Олег Сидоров', '2003-09-25', 2, 'sidorov@example.com'),
('Анна Новикова', '2004-01-10', 1, 'novikova@example.com');

INSERT INTO Course (name, credits, faculty_id) VALUES
('Программирование', 5, 1),
('Алгоритмы', 4, 1),
('Высшая математика', 6, 2),
('Литература XX века', 3, 3),
('Логика', 2, 2);

INSERT INTO Enrollment (student_id, course_id) VALUES
(1, 1),
(1, 2),
(2, 3),
(3, 1), 
(4, 1),
(4, 4),
(5, 3), 
(6, 2);