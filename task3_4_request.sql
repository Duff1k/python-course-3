--4
SELECT s.full_name AS student
FROM enrollment AS e
JOIN student AS s ON s.id = e.student_id
GROUP BY s.id, s.full_name
HAVING COUNT(DISTINCT e.course_id) > 1
ORDER BY s.full_name;