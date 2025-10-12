-- TRUNCATE TABLE enrollment, student, course, faculty RESTART IDENTITY CASCADE;

INSERT INTO faculty (name, foundation_year) VALUES
('Факультет истории', 1990),
('Экономический факультет', 1963),
('Факультет физики', 1978);

INSERT INTO student (full_name, birth_date, faculty_id, email) VALUES
('Круглов Алексей Сергеевич', '2000-05-15', 1, 'kruglov2000@yandex.ru'),
('Петрова Ева Владимировна', '2001-03-22', 1, 'petrova123@mail.ru'),
('Морозов Дмитрий Иванович', '2003-11-30', 2, 'morozov_dmitry@mail.ru'),
('Козлова Анна Петровна', '1996-07-10', 2, 'anna1996@mail.ru'),
('Николаев Андрей Викторович', '2000-12-05', 2, 'andreynikolaev@yandex.ru'),
('Фролова Александра Олеговна', '1999-09-18', 3, 'frolovaao@mail.ru');

INSERT INTO course (name, credits, faculty_id) VALUES
('История России', 5, 1),
('Финансы', 6, 2),
('Бухгалтерский учет', 3, 2),
('Микроэкономика', 5, 2),
('Квантовая физика', 8, 3),
('Физика твердого тела', 3, 3);

INSERT INTO enrollment (student_id, course_id, enroll_date) VALUES
(1, 1, DEFAULT),
(2, 1, '2025-09-11'),
(3, 2, DEFAULT),
(3, 3, '2025-09-02'),
(4, 3, '2024-12-20'),
(5, 2, '2025-09-01'),
(5, 3, '2024-12-21'),
(5, 4, '2025-09-07'),
(6, 5, '2025-10-01'),
(6, 6, '2025-10-05');