-- Добавьте не менее 3 факультетов.
insert into faculty (id, name, foundation_year) values
  (1, 'Computer Science', 1950),
  (2, 'Physics',          1910),
  (3, 'Economics',        1965);

-- Добавьте не менее 6 студентов (так, чтобы хотя бы 2 факультета имели студентов).
insert into student (id, full_name, birth_date, faculty_id, email) values
  (1, 'Ivan Petrov',      '2001-05-14', 1, 'ivan.petrov@uni.example'),
  (2, 'Maria Sidorova',   '2000-11-02', 1, 'maria.sidorova@uni.example'),
  (3, 'Alexey Smirnov',   '2002-03-23', 2, 'alexey.smirnov@uni.example'),
  (4, 'Olga Ivanova',     '1999-07-08', 2, 'olga.ivanova@uni.example'),
  (5, 'Dmitry Kuznetsov', '2001-12-30', 3, 'dmitry.kuznetsov@uni.example'),
  (6, 'Anna Popova',      '2003-01-17', 3, 'anna.popova@uni.example');

-- Добавьте не менее 5 курсов (каждый курс принадлежит факультету).
insert into course (id, name, credits, faculty_id) values
  (1, 'Algorithms',        5, 1),
  (2, 'Databases',         4, 1),
  (3, 'Quantum Physics',   6, 2),
  (4, 'Classical Mechanics', 3, 2),
  (5, 'Microeconomics',    5, 3);

-- Добавьте записи о зачислении студентов на курсы (Enrollment) так, чтобы:
-- хотя бы один студент был записан на 2 курса,
-- хотя бы два студента учились на одном курсе.
insert into enrollment (id, student_id, course_id) values
  (1, 1, 1),   -- Ivan → Algorithms
  (2, 1, 2),   -- Ivan → Databases  (выполняем «1 студент на 2 курса»)
  (3, 2, 2),   -- Maria → Databases (вместе с Ivan «≥2 студента на одном курсе»)
  (4, 3, 3),   -- Alexey → Quantum Physics
  (5, 4, 4),   -- Olga → Classical Mechanics
  (6, 4, 3),   -- Olga → Quantum Physics (пример доп. множественной записи)
  (7, 5, 5),   -- Dmitry → Microeconomics
  (8, 6, 5);   -- Anna → Microeconomics (ещё одна пара на одном курсе)