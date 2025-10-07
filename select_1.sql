-- 1. Вывести список всех студентов с названием факультета
SELECT 
    s.id,
    s.full_name,
    s.birth_date,
    s.email,
    f.name as faculty_name
FROM Student s
JOIN Faculty f ON s.faculty_id = f.id
ORDER BY s.id;