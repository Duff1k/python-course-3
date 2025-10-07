-- 2. Вывести список курсов с указанием факультета
SELECT 
    c.id,
    c.name as course_name,
    c.credits,
    f.name as faculty_name
FROM Course c
JOIN Faculty f ON c.faculty_id = f.id
ORDER BY c.id;