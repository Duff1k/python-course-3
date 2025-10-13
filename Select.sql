SELECT s.full_name, f.name AS faculty_name
FROM Student s
JOIN Faculty f ON s.faculty_id = f.id;

SELECT c.name AS course_name, f.name AS faculty_name
FROM Course c
JOIN Faculty f ON c.faculty_id = f.id;

SELECT s.full_name, c.name AS course_name
FROM Enrollment e
JOIN Student s ON e.student_id = s.id
JOIN Course c ON e.course_id = c.id;

SELECT s.full_name, COUNT(e.course_id) AS course_count
FROM Enrollment e
JOIN Student s ON e.student_id = s.id
GROUP BY s.id
HAVING COUNT(e.course_id) > 1;

SELECT c.name AS course_name, COUNT(e.student_id) AS student_count
FROM Enrollment e
JOIN Course c ON e.course_id = c.id
GROUP BY c.id
HAVING COUNT(e.student_id) > 2;