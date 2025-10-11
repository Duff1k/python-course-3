--1
SELECT s.full_name  AS student, f.name AS faculty
FROM student AS s
JOIN faculty AS f ON f.id = s.faculty_id
ORDER BY s.full_name;