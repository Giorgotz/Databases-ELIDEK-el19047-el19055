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
    title varchar(50) NOT NULL PRIMARY KEY,
    department varchar(70) NOT NULL
);

ALTER TABLE public.program OWNER TO postgres;

CREATE SEQUENCE manager_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;

ALTER TABLE public.manager_id_seq OWNER TO postgres;


CREATE TABLE manager (
    manager_id integer DEFAULT nextval('manager_id_seq'::regclass) NOT NULL PRIMARY KEY,
    manager_name varchar(20) NOT NULL,
    manager_surname varchar(20) NOT NULL
);

ALTER TABLE public.manager OWNER TO postgres;

CREATE TABLE organisation (
    org_name varchar(55) NOT NULL PRIMARY KEY,
    abbreviation varchar(8) NOT NULL,
    street varchar(35) NOT NULL,
    street_number integer,
    postal_code varchar(5) NOT NULL,
    city varchar(20) NOT NULL,
    category varchar(20) NOT NULL
);

ALTER TABLE public.organisation OWNER TO postgres;

CREATE TABLE scientific_field (
    sf_subject varchar(25) NOT NULL PRIMARY KEY
);

ALTER TABLE public.scientific_field OWNER TO postgres;


CREATE TABLE telephone_number (
    t_number char(10) NOT NULL,
    org_name varchar(55) NOT NULL,
    PRIMARY KEY (t_number)
);

ALTER TABLE public.telephone_number OWNER TO postgres;

CREATE TABLE research_center (
    org_name varchar(55) NOT NULL REFERENCES organisation(org_name),
    private_funds decimal(10,2) DEFAULT 0.00 NOT NULL,
    public_funds decimal(10,2) DEFAULT 0.00 NOT NULL,
    PRIMARY KEY (org_name)
);

ALTER TABLE public.research_center OWNER TO postgres;

CREATE TABLE university (
    org_name varchar(55) NOT NULL REFERENCES organisation(org_name),
    public_funds decimal(10,2) DEFAULT 0.00 NOT NULL,
    PRIMARY KEY (org_name)
);

ALTER TABLE public.university OWNER TO postgres;

CREATE TABLE corporation (
    org_name varchar(55) NOT NULL REFERENCES organisation(org_name),
    private_funds decimal(10,2) DEFAULT 0.00 NOT NULL,
    PRIMARY KEY (org_name)
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
    researcher_id integer DEFAULT nextval('researcher_id_seq'::regclass)NOT NULL PRIMARY KEY,
    researcher_name varchar(20) NOT NULL,
    researcher_surname varchar(20) NOT NULL,
    gender gender_enum DEFAULT 'U'::gender_enum NOT NULL,
    date_of_birth date NOT NULL,
    org_name varchar(55) NOT NULL REFERENCES organisation(org_name),
    contract_date date NOT NULL CHECK(date_of_birth + 18 * 365 + 4 < contract_date and contract_date < current_date)
);

ALTER TABLE public.researcher OWNER TO postgres;


CREATE SEQUENCE project_id_seq

    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;

ALTER TABLE public.project_id_seq OWNER TO postgres;

CREATE TABLE project (
    project_id integer DEFAULT nextval('project_id_seq'::regclass) PRIMARY KEY,
    project_title varchar(50) NOT NULL,
    summary text NOT NULL,
    funding decimal(10,2) DEFAULT 0.00 NOT NULL,
    starting_date date NOT NULL,
    final_date date NOT NULL check (final_date - starting_date> 0),
    duration integer check ((final_date - starting_date = 365 * duration or final_date - starting_date = 365 * duration + 1) and duration >=1 and duration <=4),
    -- final-initial
    program_title varchar(50) NOT NULL,
    manager_id integer NOT NULL REFERENCES manager(manager_id),
    org_name varchar(55) NOT NULL REFERENCES organisation(org_name),
    assessor_id integer NOT NULL REFERENCES researcher(researcher_id),
    score integer NOT NULL,
    assessment_date date NOT NULL
);

ALTER TABLE public.project OWNER TO postgres;

CREATE TABLE scientific_field_of (
    sf_subject varchar(25) NOT NULL REFERENCES scientific_field(sf_subject),
    project_id integer NOT NULL REFERENCES project(project_id),
    PRIMARY KEY (sf_subject, project_id)
);

ALTER TABLE public.scientific_field_of OWNER TO postgres;

CREATE TABLE researcher_on_project (
    researcher_id integer NOT NULL REFERENCES researcher(researcher_id),
    project_id integer NOT NULL REFERENCES project(project_id),
    PRIMARY KEY (researcher_id,project_id)
);

ALTER TABLE public.researcher_on_project OWNER TO postgres;

CREATE TABLE report (
    project_id integer NOT NULL,
    report_title varchar(50) NOT NULL,
    report_summary text NOT NULL,
    due_date date NOT NULL,
    PRIMARY KEY (project_id,report_title)
);

ALTER TABLE public.report OWNER TO postgres;

ALTER TABLE public.telephone_number ADD
    CONSTRAINT fk_tel FOREIGN KEY (org_name) REFERENCES organisation(org_name);
