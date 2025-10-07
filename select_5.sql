-- 5. Найти курсы, на которых учатся более 2 студентов
SELECT 
    c.id,
    c.name as course_name,
    COUNT(e.student_id) as students_count
FROM Course c
JOIN Enrollment e ON c.id = e.course_id
GROUP BY c.id, c.name
HAVING COUNT(e.student_id) > 2
ORDER BY students_count DESC;