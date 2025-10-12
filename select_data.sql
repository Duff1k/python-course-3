SELECT s.full_name, f.name FROM faculty f JOIN student s ON s.faculty_id = f.id;

SELECT c.name, f.name FROM faculty f JOIN course c ON c.faculty_id = f.id;

SELECT s.full_name, c.name FROM enrollment e 
JOIN course c ON e.course_id = c.id JOIN student s ON e.student_id = s.id ;

SELECT s.full_name, COUNT(*) as course_count FROM enrollment e
JOIN student s ON e.student_id = s.id GROUP BY s.full_name HAVING COUNT(*) > 1;

SELECT c.name, COUNT(*) as student_count FROM enrollment e
JOIN course c ON e.course_id = c.id GROUP BY c.name HAVING COUNT(*) > 2;

