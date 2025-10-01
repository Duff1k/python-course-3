--Вывести список всех студентов с названием факультета, на котором они учатся.
select *
from student s
join  faculty f on s.faculty_id = f.id;

--Вывести список курсов с указанием факультета, к которому они относятся.
select c.name as courses, f.name as faculties
from course c
join faculty f on f.id = c.faculty_id;

--Вывести список студентов и курсов, на которые они зачислены.
select s.full_name as student_name,
       c.name as course_name,
       f.name as faculty_name
from enrollment e
join student s on e.student_id = s.id
join course c  on e.course_id = c.id
join faculty f on c.faculty_id = f.id;

--Найти всех студентов, которые учатся более чем на одном курсе.
select s.full_name as student_name, count(distinct e.course_id) as count_of_course
from enrollment e
join student s on e.student_id = s.id
group by s.full_name
having count(distinct e.course_id)>1;

--Найти курсы, на которых учатся более 2 студентов.
select c.name as course_name, count(distinct e.student_id) as count_of_students
from course c
join enrollment e on c.id = e.course_id
group by c.name
having count(distinct e.student_id)>2