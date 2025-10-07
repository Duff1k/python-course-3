-- 4. Найти всех студентов, которые учатся более чем на одном курсе
SELECT 
    s.id,
    s.full_name,
    COUNT(e.course_id) as courses_count
FROM Student s
JOIN Enrollment e ON s.id = e.student_id
GROUP BY s.id, s.full_name
HAVING COUNT(e.course_id) > 1
ORDER BY courses_count DESC;