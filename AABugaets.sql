--
-- PostgreSQL database dump
--

\restrict L59FWYyLinNKoYAm8jG779gJ3JiBjZWiBAwneKBRaHLMSsg5Qlc8GGSWPw5UxvI

-- Dumped from database version 18.0
-- Dumped by pg_dump version 18.0

-- Started on 2025-10-13 20:46:37 MSK

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 224 (class 1259 OID 16483)
-- Name: course; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.course (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    credits integer NOT NULL,
    faculty_id integer NOT NULL,
    CONSTRAINT course_credits_check CHECK (((credits >= 1) AND (credits <= 10)))
);


ALTER TABLE public.course OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16482)
-- Name: course_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.course ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.course_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 226 (class 1259 OID 16499)
-- Name: enrollment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.enrollment (
    id integer NOT NULL,
    student_id integer NOT NULL,
    course_id integer NOT NULL,
    enroll_date date DEFAULT CURRENT_DATE NOT NULL
);


ALTER TABLE public.enrollment OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16498)
-- Name: enrollment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.enrollment ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.enrollment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 220 (class 1259 OID 16454)
-- Name: faculty; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.faculty (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    foundation_year integer NOT NULL,
    CONSTRAINT faculty_foundation_year_check CHECK ((foundation_year >= 1900))
);


ALTER TABLE public.faculty OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16453)
-- Name: faculty_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.faculty ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.faculty_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 222 (class 1259 OID 16466)
-- Name: student; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.student (
    id integer NOT NULL,
    full_name character varying(100) NOT NULL,
    birth_date date NOT NULL,
    faculty_id integer NOT NULL,
    email character varying(100)
);


ALTER TABLE public.student OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16465)
-- Name: student_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.student ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.student_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 3749 (class 0 OID 16483)
-- Dependencies: 224
-- Data for Name: course; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.course (id, name, credits, faculty_id) FROM stdin;
1	Гражданское право	6	1
2	Уголовное право	9	1
3	Квантовая механика	8	2
4	Статистическая физика	7	2
5	История Древнего мира	3	3
6	Историческая география	5	3
\.


--
-- TOC entry 3751 (class 0 OID 16499)
-- Dependencies: 226
-- Data for Name: enrollment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.enrollment (id, student_id, course_id, enroll_date) FROM stdin;
1	1	1	2025-09-01
2	1	2	2025-09-01
3	2	1	2025-09-01
4	3	6	2025-09-01
5	4	3	2025-09-01
6	5	4	2025-09-01
7	6	5	2025-09-01
8	1	1	2025-09-01
9	1	2	2025-09-01
10	2	1	2025-09-01
11	3	6	2025-09-01
12	4	3	2025-09-01
13	5	4	2025-09-01
14	5	1	2025-09-01
15	6	5	2025-09-01
\.


--
-- TOC entry 3745 (class 0 OID 16454)
-- Dependencies: 220
-- Data for Name: faculty; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.faculty (id, name, foundation_year) FROM stdin;
1	Юридический факультет	1995
2	Физический факультет	1950
3	Исторический факультет	1920
\.


--
-- TOC entry 3747 (class 0 OID 16466)
-- Dependencies: 222
-- Data for Name: student; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.student (id, full_name, birth_date, faculty_id, email) FROM stdin;
1	Иванов Иван Иванович	2000-05-15	1	ivanov.ivan@mail.ru
2	Петров Петр Петрович	2001-08-22	1	petrov.peir@mail.ru
3	Сидоров Владимир Игоревич	2000-12-10	1	sidorov.vova@gmail.com
4	Кузнецова Ксения Сергеевна	2002-03-30	2	kuznetsova.ksu@mail.ru
5	Васильев Владимир Александрович	2001-07-14	2	vasilev.vladimir@mail.ru
6	Дудкина Мария Дмитриевна	2000-11-05	3	dudkina.md@mail.ru
\.


--
-- TOC entry 3757 (class 0 OID 0)
-- Dependencies: 223
-- Name: course_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.course_id_seq', 6, true);


--
-- TOC entry 3758 (class 0 OID 0)
-- Dependencies: 225
-- Name: enrollment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.enrollment_id_seq', 15, true);


--
-- TOC entry 3759 (class 0 OID 0)
-- Dependencies: 219
-- Name: faculty_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.faculty_id_seq', 3, true);


--
-- TOC entry 3760 (class 0 OID 0)
-- Dependencies: 221
-- Name: student_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.student_id_seq', 6, true);


--
-- TOC entry 3590 (class 2606 OID 16492)
-- Name: course course_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course
    ADD CONSTRAINT course_pkey PRIMARY KEY (id);


--
-- TOC entry 3592 (class 2606 OID 16508)
-- Name: enrollment enrollment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enrollment
    ADD CONSTRAINT enrollment_pkey PRIMARY KEY (id);


--
-- TOC entry 3582 (class 2606 OID 16464)
-- Name: faculty faculty_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.faculty
    ADD CONSTRAINT faculty_name_key UNIQUE (name);


--
-- TOC entry 3584 (class 2606 OID 16462)
-- Name: faculty faculty_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.faculty
    ADD CONSTRAINT faculty_pkey PRIMARY KEY (id);


--
-- TOC entry 3586 (class 2606 OID 16476)
-- Name: student student_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student
    ADD CONSTRAINT student_email_key UNIQUE (email);


--
-- TOC entry 3588 (class 2606 OID 16474)
-- Name: student student_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student
    ADD CONSTRAINT student_pkey PRIMARY KEY (id);


--
-- TOC entry 3594 (class 2606 OID 16493)
-- Name: course course_faculty_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course
    ADD CONSTRAINT course_faculty_id_fkey FOREIGN KEY (faculty_id) REFERENCES public.faculty(id);


--
-- TOC entry 3595 (class 2606 OID 16514)
-- Name: enrollment enrollment_course_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enrollment
    ADD CONSTRAINT enrollment_course_id_fkey FOREIGN KEY (course_id) REFERENCES public.course(id);


--
-- TOC entry 3596 (class 2606 OID 16509)
-- Name: enrollment enrollment_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enrollment
    ADD CONSTRAINT enrollment_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.student(id);


--
-- TOC entry 3593 (class 2606 OID 16477)
-- Name: student student_faculty_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student
    ADD CONSTRAINT student_faculty_id_fkey FOREIGN KEY (faculty_id) REFERENCES public.faculty(id);


-- Completed on 2025-10-13 20:46:37 MSK

--
-- PostgreSQL database dump complete
--

\unrestrict L59FWYyLinNKoYAm8jG779gJ3JiBjZWiBAwneKBRaHLMSsg5Qlc8GGSWPw5UxvI

