--2
SELECT c.name AS course, f.name AS faculty
FROM course AS c
JOIN faculty AS f ON c.faculty_id = f.id
ORDER BY c.name;