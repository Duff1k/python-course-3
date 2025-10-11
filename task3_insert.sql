INSERT INTO faculty (id, name, foundation_year) VALUES
  (1, 'Факультет компьютерных наук', 1957),
  (2, 'Математический факультет', 1930),
  (3, 'Физический факультет', 1912);

INSERT INTO student (id, full_name, birth_date, faculty_id, email) VALUES
  (100, 'Анна Петрова', DATE '2003-03-14', 1, 'anna.petrova@example.edu'),
  (101, 'Иван Сидоров', DATE '2002-11-05', 1, 'ivan.sidorov@example.edu'),
  (102, 'Мария Иванова', DATE '2001-07-22', 2, 'maria.ivanova@example.edu'),
  (103, 'Дмитрий Смирнов', DATE '2002-02-10', 2, 'dmitry.smirnov@example.edu'),
  (104, 'Елена Кузнецова', DATE '2003-09-02', 3, 'elena.kuznetsova@example.edu'),
  (105, 'Олег Орлов', DATE '2001-12-18', 3, 'oleg.orlov@example.edu');

INSERT INTO course (id, name, credits, faculty_id) VALUES
  (200, 'Алгоритмы', 6, 1),
  (201, 'Базы данных', 5, 1),
  (202, 'Математический анализ', 6, 2),
  (203, 'Линейная алгебра', 5, 2),
  (204, 'Квантовая механика', 7, 3);

INSERT INTO enrollment (id, student_id, course_id, enroll_date) VALUES
  (1000, 100, 200, CURRENT_DATE),
  (1001, 100, 201, CURRENT_DATE),
  (1002, 101, 200, CURRENT_DATE),
  (1003, 102, 202, CURRENT_DATE),
  (1004, 103, 203, CURRENT_DATE),
  (1005, 104, 204, CURRENT_DATE),
  (1006, 105, 204, CURRENT_DATE),
  (1007, 102, 200, CURRENT_DATE);