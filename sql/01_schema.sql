create table faculty
(
    id  SERIAL primary key,
    name text unique not null,
    foundation_year int not null check (foundation_year >= 1900)
);


create table student
(
      id  SERIAL primary key,
      full_name text not null,
      birth_date date not null,
      faculty_id int references faculty(id),
      email varchar(255) unique not null
);


create table course
(
    id serial primary key,
    name varchar(100) not null,
    credits int check (credits between 1 and 10),
    faculty_id int not null  references faculty(id)
);


create table enrollment
(
    id serial primary key,
    student_id int not null references student(id),
    course_id int not null references course(id),
    enroll_date date not null default CURRENT_DATE,
    unique (student_id, course_id)
);