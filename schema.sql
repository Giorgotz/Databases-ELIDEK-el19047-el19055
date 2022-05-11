--
-- PostgreSQL database dump
--

SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS 'Standard public schema';


--
-- Name: plpgsql; Type: PROCEDURAL LANGUAGE; Schema: -; Owner: postgres
--

CREATE OR REPLACE PROCEDURAL LANGUAGE plpgsql;


ALTER PROCEDURAL LANGUAGE plpgsql OWNER TO postgres;

SET search_path = public, pg_catalog;

CREATE TABLE program (
    title varchar(50) NOT NULL,
    department varchar(20) NOT NULL
);

ALTER TABLE public.program OWNER TO postgres;

CREATE SEQUENCE manager_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;

ALTER TABLE public.manager_id_seq OWNER TO postgres;


CREATE TABLE manager (
    manager_id integer DEFAULT nextval('manager_id_seq'::regclass) NOT NULL,
    manager_name varchar(20) NOT NULL,
    manager_surname varchar(20) NOT NULL
);

ALTER TABLE public.manager OWNER TO postgres;

CREATE TABLE organisation (
    org_name varchar(50) NOT NULL,
    abbreviation varchar(8) NOT NULL,
    street varchar(20) NOT NULL,
    street_number integer,
    postal_code varchar(5) NOT NULL,
    city varchar(20) NOT NULL,
    category varchar(20) NOT NULL
);

ALTER TABLE public.organisation OWNER TO postgres;

CREATE TABLE scientific_field (
    sf_subject varchar(20) NOT NULL
);

ALTER TABLE public.scientific_field OWNER TO postgres;


CREATE TABLE telephone_number (
    t_number char(10) NOT NULL,
    org_name varchar(50) NOT NULL
);

ALTER TABLE public.telephone_number OWNER TO postgres;

CREATE TABLE research_center (
    org_name varchar(50) NOT NULL,
    public_funds decimal(10,2) DEFAULT 0.00 NOT NULL,
    private_funds decimal(10,2) DEFAULT 0.00 NOT NULL
);

ALTER TABLE public.research_center OWNER TO postgres;

CREATE TABLE university (
    org_name varchar(50) NOT NULL,
    public_funds decimal(10,2) DEFAULT 0.00 NOT NULL
);

ALTER TABLE public.university OWNER TO postgres;

CREATE TABLE corporation (
    org_name varchar(50) NOT NULL,
    private_funds decimal(10,2) DEFAULT 0.00 NOT NULL
);

ALTER TABLE public.corporation OWNER TO postgres;

CREATE TYPE gender_enum AS ENUM (
    'F',
    'M',
    'U'
);

ALTER TYPE public.gender_enum OWNER TO postgres;

CREATE SEQUENCE researcher_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER TABLE public.researcher_id_seq OWNER TO postgres;

CREATE TABLE researcher (
    researcher_id integer DEFAULT nextval('researcher_id_seq'::regclass)NOT NULL,
    researcher_name varchar(20) NOT NULL,
    researcher_surname varchar(20) NOT NULL,
    gender gender_enum DEFAULT 'U'::gender_enum ,
    date_of_birth date NOT NULL,
    org_name varchar(50) NOT NULL,
    contract_date date NOT NULL
);

ALTER TABLE public.researcher OWNER TO postgres;


CREATE SEQUENCE project_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;

ALTER TABLE public.project_id_seq OWNER TO postgres;

CREATE TABLE project (
    project_id integer DEFAULT nextval('project_id_seq'::regclass) NOT NULL,
    project_title varchar(50) NOT NULL,
    summary text NOT NULL,
    funding decimal(10,2) DEFAULT 0.00 NOT NULL,
    starting_date date NOT NULL,
    final_date date NOT NULL,
    duration date,
    -- final-initial
    program_title varchar(50) NOT NULL,
    manager_id integer NOT NULL,
    organisation_name varchar(50) NOT NULL,
    assessor_id integer NOT NULL,
    score integer NOT NULL,
    assessment_date date NOT NULL
);

ALTER TABLE public.project OWNER TO postgres;

CREATE TABLE scientific_field_of (
    sf_subject varchar(20) NOT NULL,
    project_id integer NOT NULL
);

ALTER TABLE public.scientific_field_of OWNER TO postgres;

CREATE TABLE researcher_on_project (
    researcher_id integer NOT NULL,
    project_id integer NOT NULL
);

ALTER TABLE public.researcher_on_project OWNER TO postgres;

CREATE TABLE report (
    project_id integer NOT NULL,
    report_title varchar(50) NOT NULL,
    report_summary text NULL,
    due_date date NOT NULL
);

ALTER TABLE public.report OWNER TO postgres;