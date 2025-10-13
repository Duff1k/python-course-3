CREATE TABLE Faculty (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL,
    foundation_year INT NOT NULL CHECK (foundation_year >= 1900)
);

CREATE TABLE Student (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    birth_date DATE NOT NULL,
    faculty_id INT REFERENCES Faculty(id),
    email VARCHAR(100) UNIQUE
);

CREATE TABLE Course (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    credits INT NOT NULL CHECK (credits >= 1 AND credits <= 10),
    faculty_id INT REFERENCES Faculty(id)
);

CREATE TABLE Enrollment (
    id SERIAL PRIMARY KEY,
    student_id INT REFERENCES Student(id),
    course_id INT REFERENCES Course(id),
    enroll_date DATE NOT NULL DEFAULT CURRENT_DATE
);