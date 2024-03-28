--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2 (Debian 16.2-1.pgdg120+2)
-- Dumped by pg_dump version 16.2 (Debian 16.2-1.pgdg120+2)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
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
-- Name: Person; Type: TABLE; Schema: public; Owner: earth04
--

CREATE TABLE public."Person" (
    id integer NOT NULL,
    full_name character varying(100) NOT NULL,
    group_number character varying(100) NOT NULL
);


ALTER TABLE public."Person" OWNER TO earth04;

--
-- Data for Name: Person; Type: TABLE DATA; Schema: public; Owner: earth04
--

COPY public."Person" (id, full_name, group_number) FROM stdin;
1	Маринин В.П	БИСО-01-19
\.


--
-- Name: Person person_pkey; Type: CONSTRAINT; Schema: public; Owner: earth04
--

ALTER TABLE ONLY public."Person"
    ADD CONSTRAINT person_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

