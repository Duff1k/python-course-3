-- Создание таблицы Faculty
CREATE TABLE Faculty (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    foundation_year INTEGER NOT NULL CHECK (foundation_year >= 1900)
);

-- Создание таблицы Student
CREATE TABLE Student (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(150) NOT NULL,
    birth_date DATE NOT NULL,
    faculty_id INTEGER NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    FOREIGN KEY (faculty_id) REFERENCES Faculty(id)
);

-- Создание таблицы Course
CREATE TABLE Course (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    credits INTEGER NOT NULL CHECK (credits BETWEEN 1 AND 10),
    faculty_id INTEGER NOT NULL,
    FOREIGN KEY (faculty_id) REFERENCES Faculty(id)
);

-- Создание таблицы Enrollment
CREATE TABLE Enrollment (
    id SERIAL PRIMARY KEY,
    student_id INTEGER NOT NULL,
    course_id INTEGER NOT NULL,
    enroll_date DATE NOT NULL DEFAULT CURRENT_DATE,
    FOREIGN KEY (student_id) REFERENCES Student(id),
    FOREIGN KEY (course_id) REFERENCES Course(id)
);