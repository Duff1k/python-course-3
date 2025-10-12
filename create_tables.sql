CREATE TABLE faculty (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    foundation_year INT NOT NULL CHECK (foundation_year >= 1900)
);

CREATE TABLE student (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    full_name VARCHAR(150) NOT NULL,
    birth_date DATE NOT NULL,
    faculty_id INT,
    email VARCHAR(100) UNIQUE NOT NULL,
    FOREIGN KEY (faculty_id) REFERENCES faculty(id)
);

CREATE TABLE course (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    credits INT NOT NULL CHECK (credits BETWEEN 1 AND 10),
    faculty_id INT,
    FOREIGN KEY (faculty_id) REFERENCES faculty(id)
);

CREATE TABLE enrollment (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    student_id INT,
    course_id INT,
    enroll_date DATE NOT NULL DEFAULT CURRENT_DATE,
    FOREIGN KEY (student_id) REFERENCES student(id),
    FOREIGN KEY (course_id) REFERENCES course(id),
	UNIQUE(student_id, course_id)
);

-- DROP TABLE faculty CASCADE;
-- DROP TABLE student CASCADE;
-- DROP TABLE course CASCADE;
-- DROP TABLE enrollment CASCADE;