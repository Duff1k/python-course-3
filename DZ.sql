--
-- PostgreSQL database dump
--

\restrict Rp2iLbdFoQs3JuEFLmVlNWQialWu196a7Fm5pWLUfmbefu55JZs6PlaV0A2elT4

-- Dumped from database version 18.0
-- Dumped by pg_dump version 18.0

-- Started on 2025-10-09 22:01:42

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
-- TOC entry 224 (class 1259 OID 16435)
-- Name: course; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.course (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    credits integer NOT NULL,
    faculty_id integer,
    CONSTRAINT course_credits_check CHECK (((credits >= 1) AND (credits <= 10)))
);


ALTER TABLE public.course OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16434)
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
-- TOC entry 226 (class 1259 OID 16450)
-- Name: enrollment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.enrollment (
    id integer NOT NULL,
    student_id integer,
    course_id integer,
    enroll_date date DEFAULT CURRENT_DATE NOT NULL
);


ALTER TABLE public.enrollment OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16449)
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
-- TOC entry 220 (class 1259 OID 16407)
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
-- TOC entry 219 (class 1259 OID 16406)
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
-- TOC entry 222 (class 1259 OID 16419)
-- Name: student; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.student (
    id integer NOT NULL,
    full_name character varying(100) NOT NULL,
    birth_date date NOT NULL,
    faculty_id integer,
    email character varying(100)
);


ALTER TABLE public.student OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16418)
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
-- TOC entry 5042 (class 0 OID 16435)
-- Dependencies: 224
-- Data for Name: course; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.course (id, name, credits, faculty_id) FROM stdin;
1	Иностранный язык	4	2
2	Алгоритмизация и языки программирования	5	1
3	Математический анализ	6	3
4	Физика	5	3
5	Микроэкономика	4	2
\.


--
-- TOC entry 5044 (class 0 OID 16450)
-- Dependencies: 226
-- Data for Name: enrollment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.enrollment (id, student_id, course_id, enroll_date) FROM stdin;
1	1	1	2025-09-01
2	1	2	2025-09-01
3	2	1	2025-09-01
4	3	1	2025-09-01
5	4	3	2025-09-01
6	5	5	2025-09-01
7	6	5	2025-09-01
\.


--
-- TOC entry 5038 (class 0 OID 16407)
-- Dependencies: 220
-- Data for Name: faculty; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.faculty (id, name, foundation_year) FROM stdin;
1	Высшая инжиниринговая школа	2017
2	Института международных отношений	1999
3	Институт ядерной физики и технологий	2016
\.


--
-- TOC entry 5040 (class 0 OID 16419)
-- Dependencies: 222
-- Data for Name: student; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.student (id, full_name, birth_date, faculty_id, email) FROM stdin;
1	Иванов Иван Иванович	2000-05-15	1	ivanov@miphi.ru
2	Петров Петр Петрович	2002-08-20	1	petrov@miphi.ru
3	Васильев Василий Васильевич	1999-10-10	2	svasilev@miphi.ru
4	Ильин Илья Ильич	2003-03-30	2	ilin@miphi.ru
5	Николаев Николай Николаевич	2001-07-12	3	nikolaev@miphi.ru
6	Дмитриев Дмитрий Дмитриевич	2004-09-30	3	dmitriev@miphi.ru
\.


--
-- TOC entry 5050 (class 0 OID 0)
-- Dependencies: 223
-- Name: course_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.course_id_seq', 5, true);


--
-- TOC entry 5051 (class 0 OID 0)
-- Dependencies: 225
-- Name: enrollment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.enrollment_id_seq', 7, true);


--
-- TOC entry 5052 (class 0 OID 0)
-- Dependencies: 219
-- Name: faculty_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.faculty_id_seq', 3, true);


--
-- TOC entry 5053 (class 0 OID 0)
-- Dependencies: 221
-- Name: student_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.student_id_seq', 6, true);


--
-- TOC entry 4883 (class 2606 OID 16443)
-- Name: course course_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course
    ADD CONSTRAINT course_pkey PRIMARY KEY (id);


--
-- TOC entry 4885 (class 2606 OID 16457)
-- Name: enrollment enrollment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enrollment
    ADD CONSTRAINT enrollment_pkey PRIMARY KEY (id);


--
-- TOC entry 4875 (class 2606 OID 16417)
-- Name: faculty faculty_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.faculty
    ADD CONSTRAINT faculty_name_key UNIQUE (name);


--
-- TOC entry 4877 (class 2606 OID 16415)
-- Name: faculty faculty_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.faculty
    ADD CONSTRAINT faculty_pkey PRIMARY KEY (id);


--
-- TOC entry 4879 (class 2606 OID 16428)
-- Name: student student_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student
    ADD CONSTRAINT student_email_key UNIQUE (email);


--
-- TOC entry 4881 (class 2606 OID 16426)
-- Name: student student_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student
    ADD CONSTRAINT student_pkey PRIMARY KEY (id);


--
-- TOC entry 4887 (class 2606 OID 16444)
-- Name: course course_faculty_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course
    ADD CONSTRAINT course_faculty_id_fkey FOREIGN KEY (faculty_id) REFERENCES public.faculty(id);


--
-- TOC entry 4888 (class 2606 OID 16463)
-- Name: enrollment enrollment_course_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enrollment
    ADD CONSTRAINT enrollment_course_id_fkey FOREIGN KEY (course_id) REFERENCES public.course(id);


--
-- TOC entry 4889 (class 2606 OID 16458)
-- Name: enrollment enrollment_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enrollment
    ADD CONSTRAINT enrollment_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.student(id);


--
-- TOC entry 4886 (class 2606 OID 16429)
-- Name: student student_faculty_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student
    ADD CONSTRAINT student_faculty_id_fkey FOREIGN KEY (faculty_id) REFERENCES public.faculty(id);


-- Completed on 2025-10-09 22:01:43

--
-- PostgreSQL database dump complete
--

\unrestrict Rp2iLbdFoQs3JuEFLmVlNWQialWu196a7Fm5pWLUfmbefu55JZs6PlaV0A2elT4

