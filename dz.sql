
CREATE TABLE Faculty (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    foundation_year INTEGER NOT NULL CHECK (foundation_year >= 1900)
);


CREATE TABLE Student (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    birth_date DATE NOT NULL,
    faculty_id INTEGER NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    FOREIGN KEY (faculty_id) REFERENCES Faculty(id) ON DELETE CASCADE
);


CREATE TABLE Course (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    credits INTEGER NOT NULL CHECK (credits BETWEEN 1 AND 10),
    faculty_id INTEGER NOT NULL,
    FOREIGN KEY (faculty_id) REFERENCES Faculty(id) ON DELETE CASCADE
);


CREATE TABLE Enrollment (
    id SERIAL PRIMARY KEY,
    student_id INTEGER NOT NULL,
    course_id INTEGER NOT NULL,
    enroll_date DATE NOT NULL DEFAULT CURRENT_DATE,
    FOREIGN KEY (student_id) REFERENCES Student(id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES Course(id) ON DELETE CASCADE,
    UNIQUE(student_id, course_id) -- предотвращает дублирование записей
);


INSERT INTO Faculty (name, foundation_year) VALUES
('Факультет информатики', 1995),
('Экономический факультет', 1980),
('Филологический факультет', 1975);


INSERT INTO Student (full_name, birth_date, faculty_id, email) VALUES
('Иванов Алексей Петрович', '2000-05-15', 1, 'ivanov@university.ru'),
('Петрова Мария Сергеевна', '2001-03-20', 1, 'petrova@university.ru'),
('Сидоров Дмитрий Иванович', '2000-11-10', 1, 'sidorov@university.ru'),
('Козлова Анна Владимировна', '2001-07-25', 2, 'kozlova@university.ru'),
('Николаев Павел Олегович', '2000-12-30', 2, 'nikolaev@university.ru'),
('Федорова Елена Дмитриевна', '2001-09-05', 3, 'fedorova@university.ru');


INSERT INTO Course (name, credits, faculty_id) VALUES
('Программирование на Python', 5, 1),
('Базы данных', 6, 1),
('Веб-разработка', 4, 1),
('Микроэкономика', 5, 2),
('Бухгалтерский учет', 6, 2),
('История литературы', 4, 3);


INSERT INTO Enrollment (student_id, course_id, enroll_date) VALUES

(1, 1, '2023-09-01'),
(1, 2, '2023-09-01'),


(2, 1, '2023-09-01'),
(3, 1, '2023-09-01'),


(2, 3, '2023-09-01'),
(4, 4, '2023-09-01'),
(4, 5, '2023-09-01'),
(5, 4, '2023-09-01'),
(6, 6, '2023-09-01');