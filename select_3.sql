-- 3. Вывести список студентов и курсов, на которые они зачислены
SELECT 
    s.full_name as student_name,
    f.name as faculty_name,
    c.name as course_name,
    e.enroll_date
FROM Enrollment e
JOIN Student s ON e.student_id = s.id
JOIN Course c ON e.course_id = c.id
JOIN Faculty f ON s.faculty_id = f.id
ORDER BY s.full_name, c.name;