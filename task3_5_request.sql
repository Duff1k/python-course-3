--5
SELECT c.name AS course
FROM course AS c
JOIN enrollment AS e ON e.course_id = c.id
GROUP BY c.id, c.name
HAVING COUNT(DISTINCT e.student_id) > 2
ORDER BY c.name;