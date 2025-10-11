--3
SELECT s.full_name AS student, c.name AS course
FROM enrollment AS e
JOIN student AS s ON e.student_id = s.id
JOIN course AS c ON e.course_id = c.id
ORDER BY s.full_name, c.name;