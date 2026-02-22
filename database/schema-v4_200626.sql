--
-- PostgreSQL database dump
--

\restrict d7XIyOSW159NacGkYjFS22DjP7tvaBEj1PTh0cgIt8aqqJVjXE0eLvrr76ZsF45

-- Dumped from database version 17.7
-- Dumped by pg_dump version 17.7

-- Started on 2026-02-20 10:07:40

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
-- TOC entry 277 (class 1259 OID 25137)
-- Name: academic_rule; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.academic_rule (
    id integer NOT NULL,
    key text NOT NULL,
    value text NOT NULL,
    description text,
    updated_by integer,
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.academic_rule OWNER TO postgres;

--
-- TOC entry 276 (class 1259 OID 25136)
-- Name: academic_rule_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.academic_rule_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.academic_rule_id_seq OWNER TO postgres;

--
-- TOC entry 5483 (class 0 OID 0)
-- Dependencies: 276
-- Name: academic_rule_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.academic_rule_id_seq OWNED BY public.academic_rule.id;


--
-- TOC entry 230 (class 1259 OID 16864)
-- Name: calendar; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.calendar (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    simulator_unit_id integer,
    role character varying(10) NOT NULL
);


ALTER TABLE public.calendar OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 16863)
-- Name: calendar_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.calendar_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.calendar_id_seq OWNER TO postgres;

--
-- TOC entry 5484 (class 0 OID 0)
-- Dependencies: 229
-- Name: calendar_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.calendar_id_seq OWNED BY public.calendar.id;


--
-- TOC entry 261 (class 1259 OID 24989)
-- Name: course_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.course_session (
    id integer NOT NULL,
    program_course_id integer NOT NULL,
    phase_session_template_id integer NOT NULL,
    session_sequence integer NOT NULL,
    session_date date,
    start_time time without time zone,
    end_time time without time zone,
    instructor_id integer,
    reservation_id integer,
    status character varying(50) DEFAULT 'SCHEDULED'::character varying,
    enrollment_module_id integer,
    session_category character varying(20),
    sequence_number integer,
    academic_status character varying(20) DEFAULT 'SCHEDULED'::character varying,
    enrollment_id integer
);


ALTER TABLE public.course_session OWNER TO postgres;

--
-- TOC entry 275 (class 1259 OID 25111)
-- Name: course_session_event; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.course_session_event (
    id integer NOT NULL,
    course_session_id integer NOT NULL,
    event_type character varying(30) NOT NULL,
    notes text,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.course_session_event OWNER TO postgres;

--
-- TOC entry 274 (class 1259 OID 25110)
-- Name: course_session_event_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.course_session_event_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.course_session_event_id_seq OWNER TO postgres;

--
-- TOC entry 5485 (class 0 OID 0)
-- Dependencies: 274
-- Name: course_session_event_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.course_session_event_id_seq OWNED BY public.course_session_event.id;


--
-- TOC entry 260 (class 1259 OID 24988)
-- Name: course_session_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.course_session_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.course_session_id_seq OWNER TO postgres;

--
-- TOC entry 5486 (class 0 OID 0)
-- Dependencies: 260
-- Name: course_session_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.course_session_id_seq OWNED BY public.course_session.id;


--
-- TOC entry 287 (class 1259 OID 33040)
-- Name: document_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.document_type (
    id integer NOT NULL,
    code character varying(10) NOT NULL,
    name character varying(100) NOT NULL,
    active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.document_type OWNER TO postgres;

--
-- TOC entry 286 (class 1259 OID 33039)
-- Name: document_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.document_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.document_type_id_seq OWNER TO postgres;

--
-- TOC entry 5487 (class 0 OID 0)
-- Dependencies: 286
-- Name: document_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.document_type_id_seq OWNED BY public.document_type.id;


--
-- TOC entry 281 (class 1259 OID 32969)
-- Name: enrollment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.enrollment (
    id integer NOT NULL,
    student_id integer NOT NULL,
    program_id integer NOT NULL,
    program_version_id integer,
    structure_type character varying(30) NOT NULL,
    start_date date DEFAULT CURRENT_DATE NOT NULL,
    status character varying(20) DEFAULT 'ACTIVE'::character varying NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.enrollment OWNER TO postgres;

--
-- TOC entry 285 (class 1259 OID 33015)
-- Name: enrollment_balance; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.enrollment_balance (
    id integer NOT NULL,
    enrollment_id integer NOT NULL,
    balance_type character varying(30) NOT NULL,
    aircraft_type character varying(20),
    tariff_type character varying(20),
    total_allocated numeric(10,2) NOT NULL,
    total_used numeric(10,2) DEFAULT 0 NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.enrollment_balance OWNER TO postgres;

--
-- TOC entry 284 (class 1259 OID 33014)
-- Name: enrollment_balance_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.enrollment_balance_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.enrollment_balance_id_seq OWNER TO postgres;

--
-- TOC entry 5488 (class 0 OID 0)
-- Dependencies: 284
-- Name: enrollment_balance_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.enrollment_balance_id_seq OWNED BY public.enrollment_balance.id;


--
-- TOC entry 280 (class 1259 OID 32968)
-- Name: enrollment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.enrollment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.enrollment_id_seq OWNER TO postgres;

--
-- TOC entry 5489 (class 0 OID 0)
-- Dependencies: 280
-- Name: enrollment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.enrollment_id_seq OWNED BY public.enrollment.id;


--
-- TOC entry 283 (class 1259 OID 32994)
-- Name: enrollment_module; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.enrollment_module (
    id integer NOT NULL,
    enrollment_id integer NOT NULL,
    program_module_id integer NOT NULL,
    sequence_order integer NOT NULL,
    status character varying(20) DEFAULT 'PENDING'::character varying NOT NULL,
    is_levelation boolean DEFAULT false NOT NULL,
    is_repetition boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.enrollment_module OWNER TO postgres;

--
-- TOC entry 282 (class 1259 OID 32993)
-- Name: enrollment_module_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.enrollment_module_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.enrollment_module_id_seq OWNER TO postgres;

--
-- TOC entry 5490 (class 0 OID 0)
-- Dependencies: 282
-- Name: enrollment_module_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.enrollment_module_id_seq OWNED BY public.enrollment_module.id;


--
-- TOC entry 243 (class 1259 OID 24833)
-- Name: instructor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.instructor (
    id integer NOT NULL,
    user_account_id integer NOT NULL,
    instructor_type character varying(20) NOT NULL,
    ranking integer,
    status character varying(20) DEFAULT 'ACTIVO'::character varying NOT NULL,
    hire_date date,
    active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now(),
    contract_type character varying(20),
    can_teach_theory boolean DEFAULT false,
    can_teach_virtual boolean DEFAULT false,
    can_teach_b1900 boolean DEFAULT false,
    can_teach_a320 boolean DEFAULT false,
    monthly_hour_limit numeric(5,2),
    daily_hour_limit numeric(4,2)
);


ALTER TABLE public.instructor OWNER TO postgres;

--
-- TOC entry 271 (class 1259 OID 25078)
-- Name: instructor_daily_availability; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.instructor_daily_availability (
    id integer NOT NULL,
    instructor_id integer NOT NULL,
    available_date date NOT NULL,
    availability_type character varying(20) NOT NULL,
    start_time time without time zone,
    end_time time without time zone,
    modality character varying(20),
    created_at timestamp without time zone DEFAULT now(),
    monthly_availability_id integer
);


ALTER TABLE public.instructor_daily_availability OWNER TO postgres;

--
-- TOC entry 270 (class 1259 OID 25077)
-- Name: instructor_daily_availability_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.instructor_daily_availability_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.instructor_daily_availability_id_seq OWNER TO postgres;

--
-- TOC entry 5491 (class 0 OID 0)
-- Dependencies: 270
-- Name: instructor_daily_availability_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.instructor_daily_availability_id_seq OWNED BY public.instructor_daily_availability.id;


--
-- TOC entry 242 (class 1259 OID 24832)
-- Name: instructor_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.instructor_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.instructor_id_seq OWNER TO postgres;

--
-- TOC entry 5492 (class 0 OID 0)
-- Dependencies: 242
-- Name: instructor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.instructor_id_seq OWNED BY public.instructor.id;


--
-- TOC entry 297 (class 1259 OID 33192)
-- Name: instructor_monthly_availability; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.instructor_monthly_availability (
    id integer NOT NULL,
    instructor_id integer NOT NULL,
    year integer NOT NULL,
    month integer NOT NULL,
    status character varying(20) DEFAULT 'DRAFT'::character varying,
    approved_by integer,
    approved_at timestamp without time zone
);


ALTER TABLE public.instructor_monthly_availability OWNER TO postgres;

--
-- TOC entry 296 (class 1259 OID 33191)
-- Name: instructor_monthly_availability_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.instructor_monthly_availability_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.instructor_monthly_availability_id_seq OWNER TO postgres;

--
-- TOC entry 5493 (class 0 OID 0)
-- Dependencies: 296
-- Name: instructor_monthly_availability_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.instructor_monthly_availability_id_seq OWNED BY public.instructor_monthly_availability.id;


--
-- TOC entry 248 (class 1259 OID 24875)
-- Name: instructor_parking_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.instructor_parking_group (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    active boolean DEFAULT true
);


ALTER TABLE public.instructor_parking_group OWNER TO postgres;

--
-- TOC entry 247 (class 1259 OID 24874)
-- Name: instructor_parking_group_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.instructor_parking_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.instructor_parking_group_id_seq OWNER TO postgres;

--
-- TOC entry 5494 (class 0 OID 0)
-- Dependencies: 247
-- Name: instructor_parking_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.instructor_parking_group_id_seq OWNED BY public.instructor_parking_group.id;


--
-- TOC entry 249 (class 1259 OID 24882)
-- Name: instructor_parking_group_member; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.instructor_parking_group_member (
    instructor_id integer NOT NULL,
    parking_group_id integer NOT NULL
);


ALTER TABLE public.instructor_parking_group_member OWNER TO postgres;

--
-- TOC entry 246 (class 1259 OID 24858)
-- Name: instructor_qualification; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.instructor_qualification (
    instructor_id integer NOT NULL,
    qualification_id integer NOT NULL,
    enabled boolean DEFAULT true
);


ALTER TABLE public.instructor_qualification OWNER TO postgres;

--
-- TOC entry 301 (class 1259 OID 33252)
-- Name: instructor_rank_history; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.instructor_rank_history (
    id integer NOT NULL,
    instructor_id integer,
    previous_rank integer,
    new_rank integer,
    changed_at timestamp without time zone DEFAULT now(),
    reason text
);


ALTER TABLE public.instructor_rank_history OWNER TO postgres;

--
-- TOC entry 300 (class 1259 OID 33251)
-- Name: instructor_rank_history_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.instructor_rank_history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.instructor_rank_history_id_seq OWNER TO postgres;

--
-- TOC entry 5495 (class 0 OID 0)
-- Dependencies: 300
-- Name: instructor_rank_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.instructor_rank_history_id_seq OWNED BY public.instructor_rank_history.id;


--
-- TOC entry 273 (class 1259 OID 25093)
-- Name: instructor_work_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.instructor_work_log (
    id integer NOT NULL,
    instructor_id integer NOT NULL,
    session_date date NOT NULL,
    start_time time without time zone NOT NULL,
    end_time time without time zone NOT NULL,
    hours numeric(4,2) NOT NULL,
    course_session_id integer,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.instructor_work_log OWNER TO postgres;

--
-- TOC entry 272 (class 1259 OID 25092)
-- Name: instructor_work_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.instructor_work_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.instructor_work_log_id_seq OWNER TO postgres;

--
-- TOC entry 5496 (class 0 OID 0)
-- Dependencies: 272
-- Name: instructor_work_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.instructor_work_log_id_seq OWNED BY public.instructor_work_log.id;


--
-- TOC entry 265 (class 1259 OID 25034)
-- Name: package_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.package_type (
    id integer NOT NULL,
    code character varying(50) NOT NULL,
    description text
);


ALTER TABLE public.package_type OWNER TO postgres;

--
-- TOC entry 264 (class 1259 OID 25033)
-- Name: package_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.package_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.package_type_id_seq OWNER TO postgres;

--
-- TOC entry 5497 (class 0 OID 0)
-- Dependencies: 264
-- Name: package_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.package_type_id_seq OWNED BY public.package_type.id;


--
-- TOC entry 269 (class 1259 OID 25065)
-- Name: package_usage_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.package_usage_log (
    id integer NOT NULL,
    student_package_id integer NOT NULL,
    course_session_id integer,
    instructor_id integer,
    usage_type character varying(20),
    hours_used numeric(4,2) NOT NULL,
    used_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.package_usage_log OWNER TO postgres;

--
-- TOC entry 268 (class 1259 OID 25064)
-- Name: package_usage_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.package_usage_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.package_usage_log_id_seq OWNER TO postgres;

--
-- TOC entry 5498 (class 0 OID 0)
-- Dependencies: 268
-- Name: package_usage_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.package_usage_log_id_seq OWNED BY public.package_usage_log.id;


--
-- TOC entry 255 (class 1259 OID 24943)
-- Name: phase_session_template; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.phase_session_template (
    id integer NOT NULL,
    session_number integer NOT NULL,
    name character varying(150),
    session_type character varying(20) NOT NULL,
    duration_hours numeric(4,2) NOT NULL,
    program_module_id integer,
    session_category character varying(20),
    delivery_mode character varying(20),
    is_mandatory boolean DEFAULT true,
    requires_payment_if_remedial boolean DEFAULT true,
    aircraft_type character varying(20),
    requires_previous_completion boolean DEFAULT true,
    sequence_group character varying(50),
    phase_type character varying(20),
    program_structure_version_id integer,
    unlocks_next boolean DEFAULT true
);


ALTER TABLE public.phase_session_template OWNER TO postgres;

--
-- TOC entry 254 (class 1259 OID 24942)
-- Name: phase_session_template_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.phase_session_template_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.phase_session_template_id_seq OWNER TO postgres;

--
-- TOC entry 5499 (class 0 OID 0)
-- Dependencies: 254
-- Name: phase_session_template_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.phase_session_template_id_seq OWNED BY public.phase_session_template.id;


--
-- TOC entry 218 (class 1259 OID 16804)
-- Name: program; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.program (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    structure_type character varying(30),
    priority_level integer DEFAULT 3,
    time_limit_months integer,
    base_program_id integer
);


ALTER TABLE public.program OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 16900)
-- Name: program_alias; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.program_alias (
    id integer NOT NULL,
    raw_name text NOT NULL,
    program_id integer NOT NULL
);


ALTER TABLE public.program_alias OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 16899)
-- Name: program_alias_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.program_alias_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.program_alias_id_seq OWNER TO postgres;

--
-- TOC entry 5500 (class 0 OID 0)
-- Dependencies: 233
-- Name: program_alias_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.program_alias_id_seq OWNED BY public.program_alias.id;


--
-- TOC entry 257 (class 1259 OID 24955)
-- Name: program_course; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.program_course (
    id integer NOT NULL,
    program_version_id integer NOT NULL,
    schedule_mode character varying(20) NOT NULL,
    start_date date NOT NULL,
    max_students integer DEFAULT 6,
    active boolean DEFAULT true
);


ALTER TABLE public.program_course OWNER TO postgres;

--
-- TOC entry 256 (class 1259 OID 24954)
-- Name: program_course_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.program_course_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.program_course_id_seq OWNER TO postgres;

--
-- TOC entry 5501 (class 0 OID 0)
-- Dependencies: 256
-- Name: program_course_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.program_course_id_seq OWNED BY public.program_course.id;


--
-- TOC entry 217 (class 1259 OID 16803)
-- Name: program_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.program_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.program_id_seq OWNER TO postgres;

--
-- TOC entry 5502 (class 0 OID 0)
-- Dependencies: 217
-- Name: program_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.program_id_seq OWNED BY public.program.id;


--
-- TOC entry 253 (class 1259 OID 24917)
-- Name: program_module; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.program_module (
    id integer NOT NULL,
    program_id integer NOT NULL,
    code character varying(50) NOT NULL,
    name character varying(100) NOT NULL,
    sequence_order integer NOT NULL,
    phase_id integer,
    module_type character varying(30) DEFAULT 'SIMULATOR'::character varying NOT NULL,
    duration_hours numeric(5,2)
);


ALTER TABLE public.program_module OWNER TO postgres;

--
-- TOC entry 252 (class 1259 OID 24916)
-- Name: program_module_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.program_module_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.program_module_id_seq OWNER TO postgres;

--
-- TOC entry 5503 (class 0 OID 0)
-- Dependencies: 252
-- Name: program_module_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.program_module_id_seq OWNED BY public.program_module.id;


--
-- TOC entry 289 (class 1259 OID 33106)
-- Name: program_phase; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.program_phase (
    id integer NOT NULL,
    program_id integer NOT NULL,
    name character varying(100) NOT NULL,
    sequence_order integer NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.program_phase OWNER TO postgres;

--
-- TOC entry 288 (class 1259 OID 33105)
-- Name: program_phase_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.program_phase_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.program_phase_id_seq OWNER TO postgres;

--
-- TOC entry 5504 (class 0 OID 0)
-- Dependencies: 288
-- Name: program_phase_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.program_phase_id_seq OWNED BY public.program_phase.id;


--
-- TOC entry 291 (class 1259 OID 33120)
-- Name: program_requirement; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.program_requirement (
    id integer NOT NULL,
    program_id integer NOT NULL,
    requirement_type character varying(30) NOT NULL,
    minimum_required numeric(10,2) NOT NULL,
    is_mandatory boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.program_requirement OWNER TO postgres;

--
-- TOC entry 290 (class 1259 OID 33119)
-- Name: program_requirement_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.program_requirement_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.program_requirement_id_seq OWNER TO postgres;

--
-- TOC entry 5505 (class 0 OID 0)
-- Dependencies: 290
-- Name: program_requirement_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.program_requirement_id_seq OWNED BY public.program_requirement.id;


--
-- TOC entry 299 (class 1259 OID 33215)
-- Name: program_structure_version; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.program_structure_version (
    id integer NOT NULL,
    program_version_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    is_active boolean DEFAULT true
);


ALTER TABLE public.program_structure_version OWNER TO postgres;

--
-- TOC entry 298 (class 1259 OID 33214)
-- Name: program_structure_version_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.program_structure_version_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.program_structure_version_id_seq OWNER TO postgres;

--
-- TOC entry 5506 (class 0 OID 0)
-- Dependencies: 298
-- Name: program_structure_version_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.program_structure_version_id_seq OWNED BY public.program_structure_version.id;


--
-- TOC entry 251 (class 1259 OID 24900)
-- Name: program_version; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.program_version (
    id integer NOT NULL,
    program_id integer NOT NULL,
    code character varying(20) NOT NULL,
    active boolean DEFAULT true
);


ALTER TABLE public.program_version OWNER TO postgres;

--
-- TOC entry 250 (class 1259 OID 24899)
-- Name: program_version_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.program_version_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.program_version_id_seq OWNER TO postgres;

--
-- TOC entry 5507 (class 0 OID 0)
-- Dependencies: 250
-- Name: program_version_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.program_version_id_seq OWNED BY public.program_version.id;


--
-- TOC entry 220 (class 1259 OID 16811)
-- Name: programming_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.programming_group (
    id integer NOT NULL,
    group_name character varying(50) NOT NULL,
    access_start_time time without time zone NOT NULL,
    access_end_time time without time zone NOT NULL
);


ALTER TABLE public.programming_group OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16810)
-- Name: programming_group_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.programming_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.programming_group_id_seq OWNER TO postgres;

--
-- TOC entry 5508 (class 0 OID 0)
-- Dependencies: 219
-- Name: programming_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.programming_group_id_seq OWNED BY public.programming_group.id;


--
-- TOC entry 245 (class 1259 OID 24850)
-- Name: qualification; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.qualification (
    id integer NOT NULL,
    code character varying(30) NOT NULL,
    description character varying(150)
);


ALTER TABLE public.qualification OWNER TO postgres;

--
-- TOC entry 244 (class 1259 OID 24849)
-- Name: qualification_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.qualification_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.qualification_id_seq OWNER TO postgres;

--
-- TOC entry 5509 (class 0 OID 0)
-- Dependencies: 244
-- Name: qualification_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.qualification_id_seq OWNED BY public.qualification.id;


--
-- TOC entry 232 (class 1259 OID 16876)
-- Name: reservation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reservation (
    id integer NOT NULL,
    student_id integer,
    calendar_id integer,
    simulator_turn_id integer,
    reservation_date date NOT NULL,
    start_time time without time zone NOT NULL,
    end_time time without time zone NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    simulator_unit_id integer,
    supersaas_booking_id bigint,
    cancelled_at timestamp without time zone,
    cancelled_by character varying(50),
    cancellation_reason text,
    course_session_id integer,
    reprogram_status character varying(20),
    pair_link_id integer,
    attendance_status character varying(30) DEFAULT 'SCHEDULED'::character varying,
    instructor_marked_at timestamp without time zone,
    instructor_marked_by integer,
    actual_arrival_time timestamp without time zone,
    simulator_role character varying(10),
    CONSTRAINT reservation_attendance_status_chk CHECK (((attendance_status)::text = ANY ((ARRAY['SCHEDULED'::character varying, 'ATTENDED'::character varying, 'NO_SHOW'::character varying, 'LATE_WITH_NOTICE'::character varying, 'CANCELLED_EARLY'::character varying, 'CANCELLED_LATE'::character varying, 'REPROGRAM_PENDING'::character varying, 'VIEWED'::character varying])::text[]))),
    CONSTRAINT reservation_reprogram_status_chk CHECK (((reprogram_status)::text = ANY ((ARRAY['PENDING'::character varying, 'DONE'::character varying])::text[])))
);


ALTER TABLE public.reservation OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 16875)
-- Name: reservation_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.reservation_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.reservation_id_seq OWNER TO postgres;

--
-- TOC entry 5510 (class 0 OID 0)
-- Dependencies: 231
-- Name: reservation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.reservation_id_seq OWNED BY public.reservation.id;


--
-- TOC entry 240 (class 1259 OID 24808)
-- Name: role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.role (
    id integer NOT NULL,
    code character varying(30) NOT NULL,
    description character varying(150)
);


ALTER TABLE public.role OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 24807)
-- Name: role_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.role_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.role_id_seq OWNER TO postgres;

--
-- TOC entry 5511 (class 0 OID 0)
-- Dependencies: 239
-- Name: role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.role_id_seq OWNED BY public.role.id;


--
-- TOC entry 228 (class 1259 OID 16857)
-- Name: simulator_turn; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.simulator_turn (
    id integer NOT NULL,
    turn_code character varying(10) NOT NULL,
    start_time time without time zone NOT NULL,
    end_time time without time zone NOT NULL
);


ALTER TABLE public.simulator_turn OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16856)
-- Name: simulator_turn_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.simulator_turn_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.simulator_turn_id_seq OWNER TO postgres;

--
-- TOC entry 5512 (class 0 OID 0)
-- Dependencies: 227
-- Name: simulator_turn_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.simulator_turn_id_seq OWNED BY public.simulator_turn.id;


--
-- TOC entry 226 (class 1259 OID 16850)
-- Name: simulator_unit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.simulator_unit (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    aircraft character varying(20) NOT NULL
);


ALTER TABLE public.simulator_unit OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16849)
-- Name: simulator_unit_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.simulator_unit_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.simulator_unit_id_seq OWNER TO postgres;

--
-- TOC entry 5513 (class 0 OID 0)
-- Dependencies: 225
-- Name: simulator_unit_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.simulator_unit_id_seq OWNED BY public.simulator_unit.id;


--
-- TOC entry 222 (class 1259 OID 16818)
-- Name: student; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.student (
    id integer NOT NULL,
    student_code character varying(50) NOT NULL,
    full_name character varying(100) NOT NULL,
    pf_remaining integer NOT NULL,
    status character varying(20) NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    observer_remaining integer DEFAULT 0,
    user_account_id integer
);


ALTER TABLE public.student OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 24777)
-- Name: student_certification; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.student_certification (
    id integer NOT NULL,
    student_id integer NOT NULL,
    certification_code character varying(50) NOT NULL,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.student_certification OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 24776)
-- Name: student_certification_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.student_certification_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.student_certification_id_seq OWNER TO postgres;

--
-- TOC entry 5514 (class 0 OID 0)
-- Dependencies: 235
-- Name: student_certification_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.student_certification_id_seq OWNED BY public.student_certification.id;


--
-- TOC entry 259 (class 1259 OID 24969)
-- Name: student_course; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.student_course (
    id integer NOT NULL,
    student_id integer NOT NULL,
    program_course_id integer NOT NULL,
    enrolled_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.student_course OWNER TO postgres;

--
-- TOC entry 258 (class 1259 OID 24968)
-- Name: student_course_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.student_course_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.student_course_id_seq OWNER TO postgres;

--
-- TOC entry 5515 (class 0 OID 0)
-- Dependencies: 258
-- Name: student_course_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.student_course_id_seq OWNED BY public.student_course.id;


--
-- TOC entry 305 (class 1259 OID 33303)
-- Name: student_exception_request; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.student_exception_request (
    id integer NOT NULL,
    reservation_id integer NOT NULL,
    student_id integer NOT NULL,
    exception_type character varying(30) NOT NULL,
    reason text,
    document_url text,
    status character varying(20) DEFAULT 'PENDING'::character varying,
    reviewed_by integer,
    reviewed_at timestamp without time zone,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.student_exception_request OWNER TO postgres;

--
-- TOC entry 304 (class 1259 OID 33302)
-- Name: student_exception_request_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.student_exception_request_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.student_exception_request_id_seq OWNER TO postgres;

--
-- TOC entry 5516 (class 0 OID 0)
-- Dependencies: 304
-- Name: student_exception_request_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.student_exception_request_id_seq OWNED BY public.student_exception_request.id;


--
-- TOC entry 221 (class 1259 OID 16817)
-- Name: student_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.student_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.student_id_seq OWNER TO postgres;

--
-- TOC entry 5517 (class 0 OID 0)
-- Dependencies: 221
-- Name: student_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.student_id_seq OWNED BY public.student.id;


--
-- TOC entry 307 (class 1259 OID 33329)
-- Name: student_infraction; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.student_infraction (
    id integer NOT NULL,
    student_id integer NOT NULL,
    reservation_id integer,
    infraction_type character varying(30) NOT NULL,
    session_category character varying(20),
    aircraft_type character varying(20),
    amount numeric(10,2) NOT NULL,
    status character varying(20) DEFAULT 'PENDING'::character varying,
    created_at timestamp without time zone DEFAULT now(),
    paid_at timestamp without time zone
);


ALTER TABLE public.student_infraction OWNER TO postgres;

--
-- TOC entry 306 (class 1259 OID 33328)
-- Name: student_infraction_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.student_infraction_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.student_infraction_id_seq OWNER TO postgres;

--
-- TOC entry 5518 (class 0 OID 0)
-- Dependencies: 306
-- Name: student_infraction_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.student_infraction_id_seq OWNED BY public.student_infraction.id;


--
-- TOC entry 267 (class 1259 OID 25046)
-- Name: student_package; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.student_package (
    id integer NOT NULL,
    student_id integer NOT NULL,
    package_type_id integer NOT NULL,
    aircraft character varying(10),
    tariff_type character varying(20),
    total_sessions integer,
    remaining_sessions integer,
    total_hours numeric(5,2),
    remaining_hours numeric(5,2),
    active boolean DEFAULT true,
    purchased_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.student_package OWNER TO postgres;

--
-- TOC entry 266 (class 1259 OID 25045)
-- Name: student_package_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.student_package_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.student_package_id_seq OWNER TO postgres;

--
-- TOC entry 5519 (class 0 OID 0)
-- Dependencies: 266
-- Name: student_package_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.student_package_id_seq OWNED BY public.student_package.id;


--
-- TOC entry 303 (class 1259 OID 33269)
-- Name: student_pair_link; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.student_pair_link (
    id integer NOT NULL,
    enrollment_id_1 integer NOT NULL,
    enrollment_id_2 integer NOT NULL,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.student_pair_link OWNER TO postgres;

--
-- TOC entry 302 (class 1259 OID 33268)
-- Name: student_pair_link_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.student_pair_link_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.student_pair_link_id_seq OWNER TO postgres;

--
-- TOC entry 5520 (class 0 OID 0)
-- Dependencies: 302
-- Name: student_pair_link_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.student_pair_link_id_seq OWNED BY public.student_pair_link.id;


--
-- TOC entry 293 (class 1259 OID 33137)
-- Name: student_phase_progress; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.student_phase_progress (
    id integer NOT NULL,
    student_id integer NOT NULL,
    enrollment_id integer NOT NULL,
    phase_session_template_id integer NOT NULL,
    status character varying(20) NOT NULL,
    completed_at timestamp without time zone,
    course_session_id integer,
    instructor_id integer,
    grade numeric(4,2),
    evaluation_notes text,
    blocked boolean DEFAULT false
);


ALTER TABLE public.student_phase_progress OWNER TO postgres;

--
-- TOC entry 292 (class 1259 OID 33136)
-- Name: student_phase_progress_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.student_phase_progress_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.student_phase_progress_id_seq OWNER TO postgres;

--
-- TOC entry 5521 (class 0 OID 0)
-- Dependencies: 292
-- Name: student_phase_progress_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.student_phase_progress_id_seq OWNED BY public.student_phase_progress.id;


--
-- TOC entry 224 (class 1259 OID 16833)
-- Name: student_programming_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.student_programming_group (
    id integer NOT NULL,
    student_id integer,
    programming_group_id integer
);


ALTER TABLE public.student_programming_group OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16832)
-- Name: student_programming_group_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.student_programming_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.student_programming_group_id_seq OWNER TO postgres;

--
-- TOC entry 5522 (class 0 OID 0)
-- Dependencies: 223
-- Name: student_programming_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.student_programming_group_id_seq OWNED BY public.student_programming_group.id;


--
-- TOC entry 295 (class 1259 OID 33166)
-- Name: student_remedial_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.student_remedial_session (
    id integer NOT NULL,
    student_id integer NOT NULL,
    original_course_session_id integer NOT NULL,
    remedial_type character varying(20) NOT NULL,
    requires_payment boolean DEFAULT true,
    payment_required boolean DEFAULT true,
    payment_status character varying(20) DEFAULT 'PENDING'::character varying,
    created_at timestamp without time zone DEFAULT now(),
    phase_session_template_id integer,
    inserted_sequence_number integer
);


ALTER TABLE public.student_remedial_session OWNER TO postgres;

--
-- TOC entry 294 (class 1259 OID 33165)
-- Name: student_remedial_session_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.student_remedial_session_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.student_remedial_session_id_seq OWNER TO postgres;

--
-- TOC entry 5523 (class 0 OID 0)
-- Dependencies: 294
-- Name: student_remedial_session_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.student_remedial_session_id_seq OWNED BY public.student_remedial_session.id;


--
-- TOC entry 279 (class 1259 OID 25154)
-- Name: student_rule_override; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.student_rule_override (
    id integer NOT NULL,
    student_id integer NOT NULL,
    rule_key text NOT NULL,
    value text NOT NULL,
    valid_from date,
    valid_to date,
    reason text,
    created_by integer,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.student_rule_override OWNER TO postgres;

--
-- TOC entry 278 (class 1259 OID 25153)
-- Name: student_rule_override_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.student_rule_override_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.student_rule_override_id_seq OWNER TO postgres;

--
-- TOC entry 5524 (class 0 OID 0)
-- Dependencies: 278
-- Name: student_rule_override_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.student_rule_override_id_seq OWNED BY public.student_rule_override.id;


--
-- TOC entry 263 (class 1259 OID 25012)
-- Name: student_session_attendance; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.student_session_attendance (
    id integer NOT NULL,
    student_id integer NOT NULL,
    course_session_id integer NOT NULL,
    attendance_status character varying(20) NOT NULL,
    marked_by integer,
    marked_at timestamp without time zone DEFAULT now(),
    notes text
);


ALTER TABLE public.student_session_attendance OWNER TO postgres;

--
-- TOC entry 262 (class 1259 OID 25011)
-- Name: student_session_attendance_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.student_session_attendance_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.student_session_attendance_id_seq OWNER TO postgres;

--
-- TOC entry 5525 (class 0 OID 0)
-- Dependencies: 262
-- Name: student_session_attendance_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.student_session_attendance_id_seq OWNED BY public.student_session_attendance.id;


--
-- TOC entry 238 (class 1259 OID 24793)
-- Name: user_account; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_account (
    id integer NOT NULL,
    document_number character varying(20) NOT NULL,
    first_name character varying(80) NOT NULL,
    last_name character varying(80) NOT NULL,
    email character varying(150),
    password_hash text,
    active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now(),
    document_type_id integer NOT NULL
);


ALTER TABLE public.user_account OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 24792)
-- Name: user_account_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_account_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_account_id_seq OWNER TO postgres;

--
-- TOC entry 5526 (class 0 OID 0)
-- Dependencies: 237
-- Name: user_account_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_account_id_seq OWNED BY public.user_account.id;


--
-- TOC entry 241 (class 1259 OID 24816)
-- Name: user_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_role (
    user_account_id integer NOT NULL,
    role_id integer NOT NULL,
    assigned_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.user_role OWNER TO postgres;

--
-- TOC entry 4986 (class 2604 OID 25140)
-- Name: academic_rule id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.academic_rule ALTER COLUMN id SET DEFAULT nextval('public.academic_rule_id_seq'::regclass);


--
-- TOC entry 4931 (class 2604 OID 16867)
-- Name: calendar id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.calendar ALTER COLUMN id SET DEFAULT nextval('public.calendar_id_seq'::regclass);


--
-- TOC entry 4969 (class 2604 OID 24992)
-- Name: course_session id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course_session ALTER COLUMN id SET DEFAULT nextval('public.course_session_id_seq'::regclass);


--
-- TOC entry 4984 (class 2604 OID 25114)
-- Name: course_session_event id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course_session_event ALTER COLUMN id SET DEFAULT nextval('public.course_session_event_id_seq'::regclass);


--
-- TOC entry 5002 (class 2604 OID 33043)
-- Name: document_type id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.document_type ALTER COLUMN id SET DEFAULT nextval('public.document_type_id_seq'::regclass);


--
-- TOC entry 4990 (class 2604 OID 32972)
-- Name: enrollment id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enrollment ALTER COLUMN id SET DEFAULT nextval('public.enrollment_id_seq'::regclass);


--
-- TOC entry 4999 (class 2604 OID 33018)
-- Name: enrollment_balance id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enrollment_balance ALTER COLUMN id SET DEFAULT nextval('public.enrollment_balance_id_seq'::regclass);


--
-- TOC entry 4994 (class 2604 OID 32997)
-- Name: enrollment_module id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enrollment_module ALTER COLUMN id SET DEFAULT nextval('public.enrollment_module_id_seq'::regclass);


--
-- TOC entry 4943 (class 2604 OID 24836)
-- Name: instructor id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.instructor ALTER COLUMN id SET DEFAULT nextval('public.instructor_id_seq'::regclass);


--
-- TOC entry 4980 (class 2604 OID 25081)
-- Name: instructor_daily_availability id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.instructor_daily_availability ALTER COLUMN id SET DEFAULT nextval('public.instructor_daily_availability_id_seq'::regclass);


--
-- TOC entry 5017 (class 2604 OID 33195)
-- Name: instructor_monthly_availability id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.instructor_monthly_availability ALTER COLUMN id SET DEFAULT nextval('public.instructor_monthly_availability_id_seq'::regclass);


--
-- TOC entry 4953 (class 2604 OID 24878)
-- Name: instructor_parking_group id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.instructor_parking_group ALTER COLUMN id SET DEFAULT nextval('public.instructor_parking_group_id_seq'::regclass);


--
-- TOC entry 5022 (class 2604 OID 33255)
-- Name: instructor_rank_history id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.instructor_rank_history ALTER COLUMN id SET DEFAULT nextval('public.instructor_rank_history_id_seq'::regclass);


--
-- TOC entry 4982 (class 2604 OID 25096)
-- Name: instructor_work_log id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.instructor_work_log ALTER COLUMN id SET DEFAULT nextval('public.instructor_work_log_id_seq'::regclass);


--
-- TOC entry 4974 (class 2604 OID 25037)
-- Name: package_type id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.package_type ALTER COLUMN id SET DEFAULT nextval('public.package_type_id_seq'::regclass);


--
-- TOC entry 4978 (class 2604 OID 25068)
-- Name: package_usage_log id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.package_usage_log ALTER COLUMN id SET DEFAULT nextval('public.package_usage_log_id_seq'::regclass);


--
-- TOC entry 4959 (class 2604 OID 24946)
-- Name: phase_session_template id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.phase_session_template ALTER COLUMN id SET DEFAULT nextval('public.phase_session_template_id_seq'::regclass);


--
-- TOC entry 4922 (class 2604 OID 16807)
-- Name: program id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.program ALTER COLUMN id SET DEFAULT nextval('public.program_id_seq'::regclass);


--
-- TOC entry 4935 (class 2604 OID 16903)
-- Name: program_alias id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.program_alias ALTER COLUMN id SET DEFAULT nextval('public.program_alias_id_seq'::regclass);


--
-- TOC entry 4964 (class 2604 OID 24958)
-- Name: program_course id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.program_course ALTER COLUMN id SET DEFAULT nextval('public.program_course_id_seq'::regclass);


--
-- TOC entry 4957 (class 2604 OID 24920)
-- Name: program_module id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.program_module ALTER COLUMN id SET DEFAULT nextval('public.program_module_id_seq'::regclass);


--
-- TOC entry 5005 (class 2604 OID 33109)
-- Name: program_phase id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.program_phase ALTER COLUMN id SET DEFAULT nextval('public.program_phase_id_seq'::regclass);


--
-- TOC entry 5007 (class 2604 OID 33123)
-- Name: program_requirement id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.program_requirement ALTER COLUMN id SET DEFAULT nextval('public.program_requirement_id_seq'::regclass);


--
-- TOC entry 5019 (class 2604 OID 33218)
-- Name: program_structure_version id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.program_structure_version ALTER COLUMN id SET DEFAULT nextval('public.program_structure_version_id_seq'::regclass);


--
-- TOC entry 4955 (class 2604 OID 24903)
-- Name: program_version id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.program_version ALTER COLUMN id SET DEFAULT nextval('public.program_version_id_seq'::regclass);


--
-- TOC entry 4924 (class 2604 OID 16814)
-- Name: programming_group id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.programming_group ALTER COLUMN id SET DEFAULT nextval('public.programming_group_id_seq'::regclass);


--
-- TOC entry 4951 (class 2604 OID 24853)
-- Name: qualification id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.qualification ALTER COLUMN id SET DEFAULT nextval('public.qualification_id_seq'::regclass);


--
-- TOC entry 4932 (class 2604 OID 16879)
-- Name: reservation id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservation ALTER COLUMN id SET DEFAULT nextval('public.reservation_id_seq'::regclass);


--
-- TOC entry 4941 (class 2604 OID 24811)
-- Name: role id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role ALTER COLUMN id SET DEFAULT nextval('public.role_id_seq'::regclass);


--
-- TOC entry 4930 (class 2604 OID 16860)
-- Name: simulator_turn id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.simulator_turn ALTER COLUMN id SET DEFAULT nextval('public.simulator_turn_id_seq'::regclass);


--
-- TOC entry 4929 (class 2604 OID 16853)
-- Name: simulator_unit id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.simulator_unit ALTER COLUMN id SET DEFAULT nextval('public.simulator_unit_id_seq'::regclass);


--
-- TOC entry 4925 (class 2604 OID 16821)
-- Name: student id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student ALTER COLUMN id SET DEFAULT nextval('public.student_id_seq'::regclass);


--
-- TOC entry 4936 (class 2604 OID 24780)
-- Name: student_certification id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_certification ALTER COLUMN id SET DEFAULT nextval('public.student_certification_id_seq'::regclass);


--
-- TOC entry 4967 (class 2604 OID 24972)
-- Name: student_course id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_course ALTER COLUMN id SET DEFAULT nextval('public.student_course_id_seq'::regclass);


--
-- TOC entry 5027 (class 2604 OID 33306)
-- Name: student_exception_request id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_exception_request ALTER COLUMN id SET DEFAULT nextval('public.student_exception_request_id_seq'::regclass);


--
-- TOC entry 5030 (class 2604 OID 33332)
-- Name: student_infraction id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_infraction ALTER COLUMN id SET DEFAULT nextval('public.student_infraction_id_seq'::regclass);


--
-- TOC entry 4975 (class 2604 OID 25049)
-- Name: student_package id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_package ALTER COLUMN id SET DEFAULT nextval('public.student_package_id_seq'::regclass);


--
-- TOC entry 5024 (class 2604 OID 33272)
-- Name: student_pair_link id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_pair_link ALTER COLUMN id SET DEFAULT nextval('public.student_pair_link_id_seq'::regclass);


--
-- TOC entry 5010 (class 2604 OID 33140)
-- Name: student_phase_progress id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_phase_progress ALTER COLUMN id SET DEFAULT nextval('public.student_phase_progress_id_seq'::regclass);


--
-- TOC entry 4928 (class 2604 OID 16836)
-- Name: student_programming_group id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_programming_group ALTER COLUMN id SET DEFAULT nextval('public.student_programming_group_id_seq'::regclass);


--
-- TOC entry 5012 (class 2604 OID 33169)
-- Name: student_remedial_session id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_remedial_session ALTER COLUMN id SET DEFAULT nextval('public.student_remedial_session_id_seq'::regclass);


--
-- TOC entry 4988 (class 2604 OID 25157)
-- Name: student_rule_override id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_rule_override ALTER COLUMN id SET DEFAULT nextval('public.student_rule_override_id_seq'::regclass);


--
-- TOC entry 4972 (class 2604 OID 25015)
-- Name: student_session_attendance id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_session_attendance ALTER COLUMN id SET DEFAULT nextval('public.student_session_attendance_id_seq'::regclass);


--
-- TOC entry 4938 (class 2604 OID 24796)
-- Name: user_account id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_account ALTER COLUMN id SET DEFAULT nextval('public.user_account_id_seq'::regclass);


--
-- TOC entry 5447 (class 0 OID 25137)
-- Dependencies: 277
-- Data for Name: academic_rule; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.academic_rule (id, key, value, description, updated_by, updated_at) FROM stdin;
2	PROGRAMMING_DATE_ENFORCED	true	Aplica la restricción de fecha de programación a estudiantes	\N	2026-01-11 22:33:26.815158
3	MAX_DAILY_SIM_RESERVATIONS	3	Máximo de reservas diarias por estudiante	\N	2026-01-11 22:33:26.815158
1	PROGRAMMING_START_DATE	2019-12-19	Fecha desde la cual los estudiantes pueden reservar simulador	\N	2026-01-11 22:33:26.815158
6	MAX_DAILY_HOURS	12.5	\N	\N	2026-02-19 00:13:03.82583
7	MAX_MONTHLY_HOURS	240	\N	\N	2026-02-19 00:13:03.82583
8	MIN_REST_HOURS	8	\N	\N	2026-02-19 00:13:03.82583
9	EXTENDED_REST_IF_OVER_10	10	\N	\N	2026-02-19 00:13:03.82583
\.


--
-- TOC entry 5400 (class 0 OID 16864)
-- Dependencies: 230
-- Data for Name: calendar; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.calendar (id, name, simulator_unit_id, role) FROM stdin;
1	B1900 SIM 1 PF	2	PF
2	B1900 SIM 2 PF	3	PF
3	B1900 SIM 1 PM	2	PM
4	B1900 SIM 2 PM	3	PM
5	A320 SIM PF	4	PF
6	A320 SIM PM	4	PM
\.


--
-- TOC entry 5431 (class 0 OID 24989)
-- Dependencies: 261
-- Data for Name: course_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.course_session (id, program_course_id, phase_session_template_id, session_sequence, session_date, start_time, end_time, instructor_id, reservation_id, status, enrollment_module_id, session_category, sequence_number, academic_status, enrollment_id) FROM stdin;
\.


--
-- TOC entry 5445 (class 0 OID 25111)
-- Dependencies: 275
-- Data for Name: course_session_event; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.course_session_event (id, course_session_id, event_type, notes, created_at) FROM stdin;
\.


--
-- TOC entry 5457 (class 0 OID 33040)
-- Dependencies: 287
-- Data for Name: document_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.document_type (id, code, name, active, created_at) FROM stdin;
1	CC	Cédula de Ciudadanía	t	2026-02-14 18:27:24.54686
2	TI	Tarjeta de Identidad	t	2026-02-14 18:27:24.54686
3	CE	Cédula de Extranjería	t	2026-02-14 18:27:24.54686
4	PP	Pasaporte	t	2026-02-14 18:27:24.54686
\.


--
-- TOC entry 5451 (class 0 OID 32969)
-- Dependencies: 281
-- Data for Name: enrollment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.enrollment (id, student_id, program_id, program_version_id, structure_type, start_date, status, created_at) FROM stdin;
\.


--
-- TOC entry 5455 (class 0 OID 33015)
-- Dependencies: 285
-- Data for Name: enrollment_balance; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.enrollment_balance (id, enrollment_id, balance_type, aircraft_type, tariff_type, total_allocated, total_used, created_at) FROM stdin;
\.


--
-- TOC entry 5453 (class 0 OID 32994)
-- Dependencies: 283
-- Data for Name: enrollment_module; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.enrollment_module (id, enrollment_id, program_module_id, sequence_order, status, is_levelation, is_repetition, created_at) FROM stdin;
\.


--
-- TOC entry 5413 (class 0 OID 24833)
-- Dependencies: 243
-- Data for Name: instructor; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.instructor (id, user_account_id, instructor_type, ranking, status, hire_date, active, created_at, contract_type, can_teach_theory, can_teach_virtual, can_teach_b1900, can_teach_a320, monthly_hour_limit, daily_hour_limit) FROM stdin;
2	7	LINEA	2	ACTIVE	2026-01-30	t	2026-01-30 20:20:53.609892	\N	f	f	f	f	\N	\N
1	6	LINEA	1	ACTIVE	2026-01-30	t	2026-01-30 20:06:47.927654	\N	f	f	f	f	\N	\N
\.


--
-- TOC entry 5441 (class 0 OID 25078)
-- Dependencies: 271
-- Data for Name: instructor_daily_availability; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.instructor_daily_availability (id, instructor_id, available_date, availability_type, start_time, end_time, modality, created_at, monthly_availability_id) FROM stdin;
\.


--
-- TOC entry 5467 (class 0 OID 33192)
-- Dependencies: 297
-- Data for Name: instructor_monthly_availability; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.instructor_monthly_availability (id, instructor_id, year, month, status, approved_by, approved_at) FROM stdin;
\.


--
-- TOC entry 5418 (class 0 OID 24875)
-- Dependencies: 248
-- Data for Name: instructor_parking_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.instructor_parking_group (id, name, active) FROM stdin;
\.


--
-- TOC entry 5419 (class 0 OID 24882)
-- Dependencies: 249
-- Data for Name: instructor_parking_group_member; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.instructor_parking_group_member (instructor_id, parking_group_id) FROM stdin;
\.


--
-- TOC entry 5416 (class 0 OID 24858)
-- Dependencies: 246
-- Data for Name: instructor_qualification; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.instructor_qualification (instructor_id, qualification_id, enabled) FROM stdin;
\.


--
-- TOC entry 5471 (class 0 OID 33252)
-- Dependencies: 301
-- Data for Name: instructor_rank_history; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.instructor_rank_history (id, instructor_id, previous_rank, new_rank, changed_at, reason) FROM stdin;
\.


--
-- TOC entry 5443 (class 0 OID 25093)
-- Dependencies: 273
-- Data for Name: instructor_work_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.instructor_work_log (id, instructor_id, session_date, start_time, end_time, hours, course_session_id, created_at) FROM stdin;
\.


--
-- TOC entry 5435 (class 0 OID 25034)
-- Dependencies: 265
-- Data for Name: package_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.package_type (id, code, description) FROM stdin;
\.


--
-- TOC entry 5439 (class 0 OID 25065)
-- Dependencies: 269
-- Data for Name: package_usage_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.package_usage_log (id, student_package_id, course_session_id, instructor_id, usage_type, hours_used, used_at) FROM stdin;
\.


--
-- TOC entry 5425 (class 0 OID 24943)
-- Dependencies: 255
-- Data for Name: phase_session_template; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.phase_session_template (id, session_number, name, session_type, duration_hours, program_module_id, session_category, delivery_mode, is_mandatory, requires_payment_if_remedial, aircraft_type, requires_previous_completion, sequence_group, phase_type, program_structure_version_id, unlocks_next) FROM stdin;
3	1	Clase 1 Jet	THEORY	4.00	2	\N	\N	t	t	\N	t	\N	\N	\N	t
4	1	PF Jet 1	PF	2.50	3	\N	\N	t	t	\N	t	\N	\N	\N	t
5	2	PF Jet 2	PF	2.50	3	\N	\N	t	t	\N	t	\N	\N	\N	t
\.


--
-- TOC entry 5388 (class 0 OID 16804)
-- Dependencies: 218
-- Data for Name: program; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.program (id, name, structure_type, priority_level, time_limit_months, base_program_id) FROM stdin;
1	Introduccion A320	\N	3	\N	\N
2	Transicion Aerolinea	\N	3	\N	\N
3	Transicion Linea Jet	\N	3	\N	\N
4	A320 Refresher	\N	3	\N	\N
5	Paquete Sesiones Sim	\N	3	\N	\N
6	Repaso Rapido	\N	3	\N	\N
\.


--
-- TOC entry 5404 (class 0 OID 16900)
-- Dependencies: 234
-- Data for Name: program_alias; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.program_alias (id, raw_name, program_id) FROM stdin;
1	Transici¢n Aerol¡nea Completo	2
2	Transici¢n Aerol¡nea Completo Virtual	2
3	Transici¢n Aerol¡nea Completo Presencial	2
4	Transici¢n Aerol¡nea Hibrido	2
5	Transici¢n Aerol¡nea Hibrido Virtual	2
6	Transici¢n Aerol¡nea Hibrido Presencial	2
7	Transici¢n Aerol¡nea Ligero	2
8	Transici¢n Aerol¡nea Ligero Virtual	2
9	Transici¢n Aerol¡nea Ligero Presencial	2
10	Transicion Completo Personalizado	2
11	Transici¢n Aerol¡nea Completo Virtual	2
12	Transici¢n Linea-Jet Presencial	3
13	Transici¢n Linea-Jet Virtual	3
14	Transici¢n Linea Jet Presencial	3
15	Transici¢n Linea Jet Virtual	3
16	Introducci¢n Airbus A-320	1
17	Introduccion Airbus A320	1
18	Introducci¢n Airbus A320	1
19	Airbus A320 Refresher	4
20	A320 Refresher	4
21	Paquete de horas simulador 2 Horas (Regular)	5
22	Paquete de horas simulador 10 Horas (Regular)	5
23	Paquete de horas simulador 20 Horas (Regular)	5
24	Paquete de 2 sesi¢nes simulador B1900D	5
25	Paquete de 3 sesi¢nes simulador B1900D	5
26	Paquete de 4 sesiones simulador B1900D	5
27	Paquete de 5 sesiones simulador B1900D	5
28	Paquete de 5 sesiones simulador A320	5
29	Paquete de 6 sesiones simulador B1900D	5
30	Paquete de 10 sesiones simulador A320	5
31	Paquete de 10 sesiones simulador B1900D	5
32	Repaso R pido Tierra 4 Horas	6
33	Repaso R pido Tierra 8 Horas	6
34	Repaso R pido Tierra 10 Horas	6
35	Combinaci¢n Repaso R pido + Horas de Simulador (Regular)	6
\.


--
-- TOC entry 5427 (class 0 OID 24955)
-- Dependencies: 257
-- Data for Name: program_course; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.program_course (id, program_version_id, schedule_mode, start_date, max_students, active) FROM stdin;
1	1	FLEXIBLE	2026-01-01	20	t
\.


--
-- TOC entry 5423 (class 0 OID 24917)
-- Dependencies: 253
-- Data for Name: program_module; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.program_module (id, program_id, code, name, sequence_order, phase_id, module_type, duration_hours) FROM stdin;
1	1	MOD-DEMO	Módulo Único Demo	1	\N	SIMULATOR	\N
2	3	JET-GS	Ground School Jet	1	1	THEORY	20.00
3	3	JET-SIM-1	Simulador Jet Fase 1	1	2	SIMULATOR	2.50
\.


--
-- TOC entry 5459 (class 0 OID 33106)
-- Dependencies: 289
-- Data for Name: program_phase; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.program_phase (id, program_id, name, sequence_order, created_at) FROM stdin;
1	3	Fase Tierra	1	2026-02-17 16:23:27.631447
2	3	Fase Simulador	2	2026-02-17 16:23:27.631447
\.


--
-- TOC entry 5461 (class 0 OID 33120)
-- Dependencies: 291
-- Data for Name: program_requirement; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.program_requirement (id, program_id, requirement_type, minimum_required, is_mandatory, created_at) FROM stdin;
1	3	PF_COUNT	10.00	t	2026-02-17 16:37:36.358764
2	3	PM_COUNT	10.00	t	2026-02-17 16:37:36.358764
3	3	OBS_COUNT	2.00	t	2026-02-17 16:37:36.358764
4	3	THEORY_HOURS	20.00	t	2026-02-17 16:37:36.358764
\.


--
-- TOC entry 5469 (class 0 OID 33215)
-- Dependencies: 299
-- Data for Name: program_structure_version; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.program_structure_version (id, program_version_id, created_at, is_active) FROM stdin;
\.


--
-- TOC entry 5421 (class 0 OID 24900)
-- Dependencies: 251
-- Data for Name: program_version; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.program_version (id, program_id, code, active) FROM stdin;
1	1	A320-I	t
\.


--
-- TOC entry 5390 (class 0 OID 16811)
-- Dependencies: 220
-- Data for Name: programming_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.programming_group (id, group_name, access_start_time, access_end_time) FROM stdin;
1	Grupo 1	00:00:00	23:59:00
2	Grupo 2	00:00:00	23:59:00
3	Grupo 3	00:00:00	23:59:00
\.


--
-- TOC entry 5415 (class 0 OID 24850)
-- Dependencies: 245
-- Data for Name: qualification; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.qualification (id, code, description) FROM stdin;
1	TIERRA_V	Instrucción tierra virtual
2	TIERRA_P	Instrucción tierra presencial
3	B1900	Simulador B1900
4	A320	Simulador A320
5	ADMIN	Actividad administrativa
\.


--
-- TOC entry 5402 (class 0 OID 16876)
-- Dependencies: 232
-- Data for Name: reservation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.reservation (id, student_id, calendar_id, simulator_turn_id, reservation_date, start_time, end_time, created_at, simulator_unit_id, supersaas_booking_id, cancelled_at, cancelled_by, cancellation_reason, course_session_id, reprogram_status, pair_link_id, attendance_status, instructor_marked_at, instructor_marked_by, actual_arrival_time, simulator_role) FROM stdin;
35	1	1	2	2026-02-18	05:20:00	07:50:00	2026-02-17 13:08:55.135664	2	113817527	\N	\N	\N	\N	\N	\N	SCHEDULED	\N	\N	\N	\N
\.


--
-- TOC entry 5410 (class 0 OID 24808)
-- Dependencies: 240
-- Data for Name: role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.role (id, code, description) FROM stdin;
1	ADMIN	Administrador del sistema
2	DIRECTOR	Director académico
3	PROGRAMADOR	Gestión de programación y horarios
4	INSTRUCTOR	Instructor del sistema
5	STUDENT	Estudiante
\.


--
-- TOC entry 5398 (class 0 OID 16857)
-- Dependencies: 228
-- Data for Name: simulator_turn; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.simulator_turn (id, turn_code, start_time, end_time) FROM stdin;
2	T1	05:20:00	07:50:00
3	T2	08:00:00	10:30:00
4	T3	10:40:00	13:10:00
5	T4	13:20:00	15:50:00
6	T5	16:00:00	18:30:00
7	T6	18:40:00	21:10:00
\.


--
-- TOC entry 5396 (class 0 OID 16850)
-- Dependencies: 226
-- Data for Name: simulator_unit; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.simulator_unit (id, name, aircraft) FROM stdin;
2	B1900 SIM 1	B1900
3	B1900 SIM 2	B1900
4	A320 SIM	A320
\.


--
-- TOC entry 5392 (class 0 OID 16818)
-- Dependencies: 222
-- Data for Name: student; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.student (id, student_code, full_name, pf_remaining, status, created_at, observer_remaining, user_account_id) FROM stdin;
2	STU-002	Maria Gomez	0	ACTIVO	2025-12-23 22:29:01.63162	0	\N
3	STU-003	Carlos Ruiz	12	ACTIVO	2025-12-23 22:29:01.63162	0	\N
4	STU-004	Ana Torres	4	ACTIVO	2025-12-23 22:29:01.63162	0	\N
5	STU-005	Luis Martinez	6	ACTIVO	2025-12-23 22:29:01.63162	0	\N
6	STU-006	Sofia Ramirez	3	ACTIVO	2025-12-23 22:29:01.63162	0	\N
7	STU-007	Pedro Lopez	0	ACTIVO	2025-12-23 22:29:01.63162	0	\N
8	STU-008	Laura Castro	0	ACTIVO	2025-12-23 22:29:01.63162	0	\N
1	STU-001	Juan Perez	9	ACTIVO	2025-12-23 22:29:01.63162	0	2
\.


--
-- TOC entry 5406 (class 0 OID 24777)
-- Dependencies: 236
-- Data for Name: student_certification; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.student_certification (id, student_id, certification_code, created_at) FROM stdin;
1	1	EGRESADO_TRANSICION_AEROLINEA	2025-12-24 18:51:44.573298
2	3	EGRESADO_INTRO_A320	2025-12-24 18:51:44.587994
3	7	EGRESADO_REPASO_RAPIDO	2025-12-24 18:51:44.591992
\.


--
-- TOC entry 5429 (class 0 OID 24969)
-- Dependencies: 259
-- Data for Name: student_course; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.student_course (id, student_id, program_course_id, enrolled_at) FROM stdin;
\.


--
-- TOC entry 5475 (class 0 OID 33303)
-- Dependencies: 305
-- Data for Name: student_exception_request; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.student_exception_request (id, reservation_id, student_id, exception_type, reason, document_url, status, reviewed_by, reviewed_at, created_at) FROM stdin;
\.


--
-- TOC entry 5477 (class 0 OID 33329)
-- Dependencies: 307
-- Data for Name: student_infraction; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.student_infraction (id, student_id, reservation_id, infraction_type, session_category, aircraft_type, amount, status, created_at, paid_at) FROM stdin;
\.


--
-- TOC entry 5437 (class 0 OID 25046)
-- Dependencies: 267
-- Data for Name: student_package; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.student_package (id, student_id, package_type_id, aircraft, tariff_type, total_sessions, remaining_sessions, total_hours, remaining_hours, active, purchased_at) FROM stdin;
\.


--
-- TOC entry 5473 (class 0 OID 33269)
-- Dependencies: 303
-- Data for Name: student_pair_link; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.student_pair_link (id, enrollment_id_1, enrollment_id_2, is_active, created_at) FROM stdin;
\.


--
-- TOC entry 5463 (class 0 OID 33137)
-- Dependencies: 293
-- Data for Name: student_phase_progress; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.student_phase_progress (id, student_id, enrollment_id, phase_session_template_id, status, completed_at, course_session_id, instructor_id, grade, evaluation_notes, blocked) FROM stdin;
\.


--
-- TOC entry 5394 (class 0 OID 16833)
-- Dependencies: 224
-- Data for Name: student_programming_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.student_programming_group (id, student_id, programming_group_id) FROM stdin;
1	1	1
2	4	1
3	3	2
4	6	2
5	5	3
6	7	3
\.


--
-- TOC entry 5465 (class 0 OID 33166)
-- Dependencies: 295
-- Data for Name: student_remedial_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.student_remedial_session (id, student_id, original_course_session_id, remedial_type, requires_payment, payment_required, payment_status, created_at, phase_session_template_id, inserted_sequence_number) FROM stdin;
\.


--
-- TOC entry 5449 (class 0 OID 25154)
-- Dependencies: 279
-- Data for Name: student_rule_override; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.student_rule_override (id, student_id, rule_key, value, valid_from, valid_to, reason, created_by, created_at) FROM stdin;
\.


--
-- TOC entry 5433 (class 0 OID 25012)
-- Dependencies: 263
-- Data for Name: student_session_attendance; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.student_session_attendance (id, student_id, course_session_id, attendance_status, marked_by, marked_at, notes) FROM stdin;
\.


--
-- TOC entry 5408 (class 0 OID 24793)
-- Dependencies: 238
-- Data for Name: user_account; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_account (id, document_number, first_name, last_name, email, password_hash, active, created_at, document_type_id) FROM stdin;
7	1021235658	Sofia	Cabrales	scabrales@gmail.com	$2b$10$WEuV7lXKDSOgec5pKIhG9.qqtKdJJIPBHYivM9OOh.4XziTnYFyhK	t	2026-01-30 20:20:13.279261	1
6	1016236236	Daniela	Matiz	danmat@gmail.com	$2b$10$kBsgg7naE3MDIxVwPkG0i.fJc7HAMo5Vt3/h172u11Une9PVKJKkS	t	2026-01-30 19:49:52.998845	1
5	77777777	Programador	Prueba	programador@prueba.com	$2b$10$wCuWITQ.aHFxf0kTCIhNIugjTO1/XVFaDDMZthBFiW1tSjXwImfQ6	t	2026-01-11 23:21:17.58242	1
4	88888888	Director	Prueba	director@prueba.com	$2b$10$wCuWITQ.aHFxf0kTCIhNIugjTO1/XVFaDDMZthBFiW1tSjXwImfQ6	t	2026-01-11 23:16:34.894012	1
3	99999999	Admin	Prueba	admin@prueba.com	$2b$10$wCuWITQ.aHFxf0kTCIhNIugjTO1/XVFaDDMZthBFiW1tSjXwImfQ6	t	2026-01-11 22:48:35.447468	1
2	123456789	Usuario	Prueba	usuario@prueba.com	$2b$10$wCuWITQ.aHFxf0kTCIhNIugjTO1/XVFaDDMZthBFiW1tSjXwImfQ6	t	2026-01-04 19:52:25.678696	1
8	123456	Test	User	test@test.com	xxx	t	2026-02-14 20:53:11.585532	1
12	999999999	Prueba	Final	prueba@test.com	$2b$10$vKgDcLfLjoKm.eu0p6pn8.ziaTV2vfSMRWsxnGVwRtU6CB4abeyai	t	2026-02-15 14:17:23.591587	2
\.


--
-- TOC entry 5411 (class 0 OID 24816)
-- Dependencies: 241
-- Data for Name: user_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_role (user_account_id, role_id, assigned_at) FROM stdin;
2	5	2026-01-04 20:05:57.696999
3	1	2026-01-11 22:52:36.934491
4	2	2026-01-11 23:18:21.894262
5	3	2026-01-11 23:22:40.966179
6	4	2026-01-30 19:49:53.016813
7	4	2026-01-30 20:20:13.281245
12	4	2026-02-15 14:17:23.597386
\.


--
-- TOC entry 5527 (class 0 OID 0)
-- Dependencies: 276
-- Name: academic_rule_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.academic_rule_id_seq', 9, true);


--
-- TOC entry 5528 (class 0 OID 0)
-- Dependencies: 229
-- Name: calendar_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.calendar_id_seq', 6, true);


--
-- TOC entry 5529 (class 0 OID 0)
-- Dependencies: 274
-- Name: course_session_event_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.course_session_event_id_seq', 1, false);


--
-- TOC entry 5530 (class 0 OID 0)
-- Dependencies: 260
-- Name: course_session_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.course_session_id_seq', 2, true);


--
-- TOC entry 5531 (class 0 OID 0)
-- Dependencies: 286
-- Name: document_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.document_type_id_seq', 4, true);


--
-- TOC entry 5532 (class 0 OID 0)
-- Dependencies: 284
-- Name: enrollment_balance_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.enrollment_balance_id_seq', 1, false);


--
-- TOC entry 5533 (class 0 OID 0)
-- Dependencies: 280
-- Name: enrollment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.enrollment_id_seq', 1, false);


--
-- TOC entry 5534 (class 0 OID 0)
-- Dependencies: 282
-- Name: enrollment_module_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.enrollment_module_id_seq', 1, false);


--
-- TOC entry 5535 (class 0 OID 0)
-- Dependencies: 270
-- Name: instructor_daily_availability_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.instructor_daily_availability_id_seq', 1, false);


--
-- TOC entry 5536 (class 0 OID 0)
-- Dependencies: 242
-- Name: instructor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.instructor_id_seq', 2, true);


--
-- TOC entry 5537 (class 0 OID 0)
-- Dependencies: 296
-- Name: instructor_monthly_availability_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.instructor_monthly_availability_id_seq', 1, false);


--
-- TOC entry 5538 (class 0 OID 0)
-- Dependencies: 247
-- Name: instructor_parking_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.instructor_parking_group_id_seq', 1, false);


--
-- TOC entry 5539 (class 0 OID 0)
-- Dependencies: 300
-- Name: instructor_rank_history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.instructor_rank_history_id_seq', 1, false);


--
-- TOC entry 5540 (class 0 OID 0)
-- Dependencies: 272
-- Name: instructor_work_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.instructor_work_log_id_seq', 1, false);


--
-- TOC entry 5541 (class 0 OID 0)
-- Dependencies: 264
-- Name: package_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.package_type_id_seq', 1, false);


--
-- TOC entry 5542 (class 0 OID 0)
-- Dependencies: 268
-- Name: package_usage_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.package_usage_log_id_seq', 1, false);


--
-- TOC entry 5543 (class 0 OID 0)
-- Dependencies: 254
-- Name: phase_session_template_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.phase_session_template_id_seq', 5, true);


--
-- TOC entry 5544 (class 0 OID 0)
-- Dependencies: 233
-- Name: program_alias_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.program_alias_id_seq', 35, true);


--
-- TOC entry 5545 (class 0 OID 0)
-- Dependencies: 256
-- Name: program_course_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.program_course_id_seq', 1, true);


--
-- TOC entry 5546 (class 0 OID 0)
-- Dependencies: 217
-- Name: program_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.program_id_seq', 6, true);


--
-- TOC entry 5547 (class 0 OID 0)
-- Dependencies: 252
-- Name: program_module_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.program_module_id_seq', 3, true);


--
-- TOC entry 5548 (class 0 OID 0)
-- Dependencies: 288
-- Name: program_phase_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.program_phase_id_seq', 2, true);


--
-- TOC entry 5549 (class 0 OID 0)
-- Dependencies: 290
-- Name: program_requirement_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.program_requirement_id_seq', 4, true);


--
-- TOC entry 5550 (class 0 OID 0)
-- Dependencies: 298
-- Name: program_structure_version_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.program_structure_version_id_seq', 1, false);


--
-- TOC entry 5551 (class 0 OID 0)
-- Dependencies: 250
-- Name: program_version_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.program_version_id_seq', 1, true);


--
-- TOC entry 5552 (class 0 OID 0)
-- Dependencies: 219
-- Name: programming_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.programming_group_id_seq', 1, false);


--
-- TOC entry 5553 (class 0 OID 0)
-- Dependencies: 244
-- Name: qualification_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.qualification_id_seq', 5, true);


--
-- TOC entry 5554 (class 0 OID 0)
-- Dependencies: 231
-- Name: reservation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.reservation_id_seq', 35, true);


--
-- TOC entry 5555 (class 0 OID 0)
-- Dependencies: 239
-- Name: role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.role_id_seq', 5, true);


--
-- TOC entry 5556 (class 0 OID 0)
-- Dependencies: 227
-- Name: simulator_turn_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.simulator_turn_id_seq', 7, true);


--
-- TOC entry 5557 (class 0 OID 0)
-- Dependencies: 225
-- Name: simulator_unit_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.simulator_unit_id_seq', 4, true);


--
-- TOC entry 5558 (class 0 OID 0)
-- Dependencies: 235
-- Name: student_certification_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.student_certification_id_seq', 3, true);


--
-- TOC entry 5559 (class 0 OID 0)
-- Dependencies: 258
-- Name: student_course_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.student_course_id_seq', 1, false);


--
-- TOC entry 5560 (class 0 OID 0)
-- Dependencies: 304
-- Name: student_exception_request_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.student_exception_request_id_seq', 1, false);


--
-- TOC entry 5561 (class 0 OID 0)
-- Dependencies: 221
-- Name: student_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.student_id_seq', 8, true);


--
-- TOC entry 5562 (class 0 OID 0)
-- Dependencies: 306
-- Name: student_infraction_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.student_infraction_id_seq', 1, false);


--
-- TOC entry 5563 (class 0 OID 0)
-- Dependencies: 266
-- Name: student_package_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.student_package_id_seq', 1, false);


--
-- TOC entry 5564 (class 0 OID 0)
-- Dependencies: 302
-- Name: student_pair_link_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.student_pair_link_id_seq', 1, false);


--
-- TOC entry 5565 (class 0 OID 0)
-- Dependencies: 292
-- Name: student_phase_progress_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.student_phase_progress_id_seq', 1, false);


--
-- TOC entry 5566 (class 0 OID 0)
-- Dependencies: 223
-- Name: student_programming_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.student_programming_group_id_seq', 6, true);


--
-- TOC entry 5567 (class 0 OID 0)
-- Dependencies: 294
-- Name: student_remedial_session_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.student_remedial_session_id_seq', 1, false);


--
-- TOC entry 5568 (class 0 OID 0)
-- Dependencies: 278
-- Name: student_rule_override_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.student_rule_override_id_seq', 1, false);


--
-- TOC entry 5569 (class 0 OID 0)
-- Dependencies: 262
-- Name: student_session_attendance_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.student_session_attendance_id_seq', 1, false);


--
-- TOC entry 5570 (class 0 OID 0)
-- Dependencies: 237
-- Name: user_account_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_account_id_seq', 12, true);


--
-- TOC entry 5127 (class 2606 OID 25147)
-- Name: academic_rule academic_rule_key_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.academic_rule
    ADD CONSTRAINT academic_rule_key_key UNIQUE (key);


--
-- TOC entry 5129 (class 2606 OID 25145)
-- Name: academic_rule academic_rule_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.academic_rule
    ADD CONSTRAINT academic_rule_pkey PRIMARY KEY (id);


--
-- TOC entry 5107 (class 2606 OID 25022)
-- Name: student_session_attendance attendance_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_session_attendance
    ADD CONSTRAINT attendance_unique UNIQUE (student_id, course_session_id);


--
-- TOC entry 5050 (class 2606 OID 16869)
-- Name: calendar calendar_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.calendar
    ADD CONSTRAINT calendar_pkey PRIMARY KEY (id);


--
-- TOC entry 5125 (class 2606 OID 25119)
-- Name: course_session_event course_session_event_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course_session_event
    ADD CONSTRAINT course_session_event_pkey PRIMARY KEY (id);


--
-- TOC entry 5105 (class 2606 OID 24995)
-- Name: course_session course_session_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course_session
    ADD CONSTRAINT course_session_pkey PRIMARY KEY (id);


--
-- TOC entry 5141 (class 2606 OID 33049)
-- Name: document_type document_type_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.document_type
    ADD CONSTRAINT document_type_code_key UNIQUE (code);


--
-- TOC entry 5143 (class 2606 OID 33047)
-- Name: document_type document_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.document_type
    ADD CONSTRAINT document_type_pkey PRIMARY KEY (id);


--
-- TOC entry 5139 (class 2606 OID 33022)
-- Name: enrollment_balance enrollment_balance_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enrollment_balance
    ADD CONSTRAINT enrollment_balance_pkey PRIMARY KEY (id);


--
-- TOC entry 5137 (class 2606 OID 33003)
-- Name: enrollment_module enrollment_module_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enrollment_module
    ADD CONSTRAINT enrollment_module_pkey PRIMARY KEY (id);


--
-- TOC entry 5135 (class 2606 OID 32977)
-- Name: enrollment enrollment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enrollment
    ADD CONSTRAINT enrollment_pkey PRIMARY KEY (id);


--
-- TOC entry 5119 (class 2606 OID 25084)
-- Name: instructor_daily_availability instructor_daily_availability_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.instructor_daily_availability
    ADD CONSTRAINT instructor_daily_availability_pkey PRIMARY KEY (id);


--
-- TOC entry 5155 (class 2606 OID 33198)
-- Name: instructor_monthly_availability instructor_monthly_availability_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.instructor_monthly_availability
    ADD CONSTRAINT instructor_monthly_availability_pkey PRIMARY KEY (id);


--
-- TOC entry 5087 (class 2606 OID 24886)
-- Name: instructor_parking_group_member instructor_parking_group_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.instructor_parking_group_member
    ADD CONSTRAINT instructor_parking_group_pk PRIMARY KEY (instructor_id);


--
-- TOC entry 5085 (class 2606 OID 24881)
-- Name: instructor_parking_group instructor_parking_group_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.instructor_parking_group
    ADD CONSTRAINT instructor_parking_group_pkey PRIMARY KEY (id);


--
-- TOC entry 5075 (class 2606 OID 24841)
-- Name: instructor instructor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.instructor
    ADD CONSTRAINT instructor_pkey PRIMARY KEY (id);


--
-- TOC entry 5083 (class 2606 OID 24863)
-- Name: instructor_qualification instructor_qualification_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.instructor_qualification
    ADD CONSTRAINT instructor_qualification_pk PRIMARY KEY (instructor_id, qualification_id);


--
-- TOC entry 5159 (class 2606 OID 33260)
-- Name: instructor_rank_history instructor_rank_history_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.instructor_rank_history
    ADD CONSTRAINT instructor_rank_history_pkey PRIMARY KEY (id);


--
-- TOC entry 5077 (class 2606 OID 24843)
-- Name: instructor instructor_user_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.instructor
    ADD CONSTRAINT instructor_user_unique UNIQUE (user_account_id);


--
-- TOC entry 5123 (class 2606 OID 25099)
-- Name: instructor_work_log instructor_work_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.instructor_work_log
    ADD CONSTRAINT instructor_work_log_pkey PRIMARY KEY (id);


--
-- TOC entry 5111 (class 2606 OID 25043)
-- Name: package_type package_type_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.package_type
    ADD CONSTRAINT package_type_code_key UNIQUE (code);


--
-- TOC entry 5113 (class 2606 OID 25041)
-- Name: package_type package_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.package_type
    ADD CONSTRAINT package_type_pkey PRIMARY KEY (id);


--
-- TOC entry 5117 (class 2606 OID 25071)
-- Name: package_usage_log package_usage_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.package_usage_log
    ADD CONSTRAINT package_usage_log_pkey PRIMARY KEY (id);


--
-- TOC entry 5097 (class 2606 OID 24948)
-- Name: phase_session_template phase_session_template_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.phase_session_template
    ADD CONSTRAINT phase_session_template_pkey PRIMARY KEY (id);


--
-- TOC entry 5057 (class 2606 OID 16907)
-- Name: program_alias program_alias_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.program_alias
    ADD CONSTRAINT program_alias_pkey PRIMARY KEY (id);


--
-- TOC entry 5099 (class 2606 OID 24962)
-- Name: program_course program_course_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.program_course
    ADD CONSTRAINT program_course_pkey PRIMARY KEY (id);


--
-- TOC entry 5093 (class 2606 OID 24922)
-- Name: program_module program_module_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.program_module
    ADD CONSTRAINT program_module_pkey PRIMARY KEY (id);


--
-- TOC entry 5095 (class 2606 OID 24924)
-- Name: program_module program_module_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.program_module
    ADD CONSTRAINT program_module_unique UNIQUE (program_id, code);


--
-- TOC entry 5145 (class 2606 OID 33112)
-- Name: program_phase program_phase_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.program_phase
    ADD CONSTRAINT program_phase_pkey PRIMARY KEY (id);


--
-- TOC entry 5036 (class 2606 OID 16809)
-- Name: program program_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.program
    ADD CONSTRAINT program_pkey PRIMARY KEY (id);


--
-- TOC entry 5147 (class 2606 OID 33127)
-- Name: program_requirement program_requirement_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.program_requirement
    ADD CONSTRAINT program_requirement_pkey PRIMARY KEY (id);


--
-- TOC entry 5157 (class 2606 OID 33222)
-- Name: program_structure_version program_structure_version_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.program_structure_version
    ADD CONSTRAINT program_structure_version_pkey PRIMARY KEY (id);


--
-- TOC entry 5089 (class 2606 OID 24908)
-- Name: program_version program_version_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.program_version
    ADD CONSTRAINT program_version_pkey PRIMARY KEY (id);


--
-- TOC entry 5091 (class 2606 OID 24910)
-- Name: program_version program_version_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.program_version
    ADD CONSTRAINT program_version_unique UNIQUE (program_id, code);


--
-- TOC entry 5038 (class 2606 OID 16816)
-- Name: programming_group programming_group_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.programming_group
    ADD CONSTRAINT programming_group_pkey PRIMARY KEY (id);


--
-- TOC entry 5079 (class 2606 OID 24857)
-- Name: qualification qualification_code_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.qualification
    ADD CONSTRAINT qualification_code_unique UNIQUE (code);


--
-- TOC entry 5081 (class 2606 OID 24855)
-- Name: qualification qualification_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.qualification
    ADD CONSTRAINT qualification_pkey PRIMARY KEY (id);


--
-- TOC entry 5053 (class 2606 OID 16882)
-- Name: reservation reservation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservation
    ADD CONSTRAINT reservation_pkey PRIMARY KEY (id);


--
-- TOC entry 5055 (class 2606 OID 25176)
-- Name: reservation reservation_supersaas_booking_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservation
    ADD CONSTRAINT reservation_supersaas_booking_id_key UNIQUE (supersaas_booking_id);


--
-- TOC entry 5069 (class 2606 OID 24815)
-- Name: role role_code_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role
    ADD CONSTRAINT role_code_unique UNIQUE (code);


--
-- TOC entry 5071 (class 2606 OID 24813)
-- Name: role role_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role
    ADD CONSTRAINT role_pkey PRIMARY KEY (id);


--
-- TOC entry 5048 (class 2606 OID 16862)
-- Name: simulator_turn simulator_turn_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.simulator_turn
    ADD CONSTRAINT simulator_turn_pkey PRIMARY KEY (id);


--
-- TOC entry 5046 (class 2606 OID 16855)
-- Name: simulator_unit simulator_unit_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.simulator_unit
    ADD CONSTRAINT simulator_unit_pkey PRIMARY KEY (id);


--
-- TOC entry 5060 (class 2606 OID 24783)
-- Name: student_certification student_certification_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_certification
    ADD CONSTRAINT student_certification_pkey PRIMARY KEY (id);


--
-- TOC entry 5062 (class 2606 OID 24785)
-- Name: student_certification student_certification_student_id_certification_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_certification
    ADD CONSTRAINT student_certification_student_id_certification_code_key UNIQUE (student_id, certification_code);


--
-- TOC entry 5101 (class 2606 OID 24975)
-- Name: student_course student_course_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_course
    ADD CONSTRAINT student_course_pkey PRIMARY KEY (id);


--
-- TOC entry 5103 (class 2606 OID 24977)
-- Name: student_course student_course_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_course
    ADD CONSTRAINT student_course_unique UNIQUE (student_id, program_course_id);


--
-- TOC entry 5165 (class 2606 OID 33312)
-- Name: student_exception_request student_exception_request_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_exception_request
    ADD CONSTRAINT student_exception_request_pkey PRIMARY KEY (id);


--
-- TOC entry 5167 (class 2606 OID 33336)
-- Name: student_infraction student_infraction_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_infraction
    ADD CONSTRAINT student_infraction_pkey PRIMARY KEY (id);


--
-- TOC entry 5115 (class 2606 OID 25053)
-- Name: student_package student_package_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_package
    ADD CONSTRAINT student_package_pkey PRIMARY KEY (id);


--
-- TOC entry 5161 (class 2606 OID 33278)
-- Name: student_pair_link student_pair_link_enrollment_id_1_enrollment_id_2_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_pair_link
    ADD CONSTRAINT student_pair_link_enrollment_id_1_enrollment_id_2_key UNIQUE (enrollment_id_1, enrollment_id_2);


--
-- TOC entry 5163 (class 2606 OID 33276)
-- Name: student_pair_link student_pair_link_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_pair_link
    ADD CONSTRAINT student_pair_link_pkey PRIMARY KEY (id);


--
-- TOC entry 5149 (class 2606 OID 33142)
-- Name: student_phase_progress student_phase_progress_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_phase_progress
    ADD CONSTRAINT student_phase_progress_pkey PRIMARY KEY (id);


--
-- TOC entry 5151 (class 2606 OID 33144)
-- Name: student_phase_progress student_phase_progress_student_id_phase_session_template_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_phase_progress
    ADD CONSTRAINT student_phase_progress_student_id_phase_session_template_id_key UNIQUE (student_id, phase_session_template_id);


--
-- TOC entry 5040 (class 2606 OID 16824)
-- Name: student student_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student
    ADD CONSTRAINT student_pkey PRIMARY KEY (id);


--
-- TOC entry 5044 (class 2606 OID 16838)
-- Name: student_programming_group student_programming_group_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_programming_group
    ADD CONSTRAINT student_programming_group_pkey PRIMARY KEY (id);


--
-- TOC entry 5153 (class 2606 OID 33175)
-- Name: student_remedial_session student_remedial_session_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_remedial_session
    ADD CONSTRAINT student_remedial_session_pkey PRIMARY KEY (id);


--
-- TOC entry 5131 (class 2606 OID 25162)
-- Name: student_rule_override student_rule_override_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_rule_override
    ADD CONSTRAINT student_rule_override_pkey PRIMARY KEY (id);


--
-- TOC entry 5133 (class 2606 OID 25164)
-- Name: student_rule_override student_rule_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_rule_override
    ADD CONSTRAINT student_rule_unique UNIQUE (student_id, rule_key);


--
-- TOC entry 5109 (class 2606 OID 25020)
-- Name: student_session_attendance student_session_attendance_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_session_attendance
    ADD CONSTRAINT student_session_attendance_pkey PRIMARY KEY (id);


--
-- TOC entry 5042 (class 2606 OID 16826)
-- Name: student student_student_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student
    ADD CONSTRAINT student_student_code_key UNIQUE (student_code);


--
-- TOC entry 5121 (class 2606 OID 25086)
-- Name: instructor_daily_availability unique_instructor_day; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.instructor_daily_availability
    ADD CONSTRAINT unique_instructor_day UNIQUE (instructor_id, available_date);


--
-- TOC entry 5064 (class 2606 OID 24802)
-- Name: user_account user_account_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_account
    ADD CONSTRAINT user_account_pkey PRIMARY KEY (id);


--
-- TOC entry 5067 (class 2606 OID 24806)
-- Name: user_account user_email_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_account
    ADD CONSTRAINT user_email_unique UNIQUE (email);


--
-- TOC entry 5073 (class 2606 OID 24821)
-- Name: user_role user_role_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_role
    ADD CONSTRAINT user_role_pk PRIMARY KEY (user_account_id, role_id);


--
-- TOC entry 5051 (class 1259 OID 33294)
-- Name: idx_reservation_pair_link; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_reservation_pair_link ON public.reservation USING btree (pair_link_id);


--
-- TOC entry 5058 (class 1259 OID 24791)
-- Name: idx_student_cert_student; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_student_cert_student ON public.student_certification USING btree (student_id);


--
-- TOC entry 5065 (class 1259 OID 33055)
-- Name: user_document_unique_new; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX user_document_unique_new ON public.user_account USING btree (document_type_id, document_number);


--
-- TOC entry 5212 (class 2606 OID 25148)
-- Name: academic_rule academic_rule_updated_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.academic_rule
    ADD CONSTRAINT academic_rule_updated_by_fkey FOREIGN KEY (updated_by) REFERENCES public.user_account(id);


--
-- TOC entry 5172 (class 2606 OID 16870)
-- Name: calendar calendar_simulator_unit_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.calendar
    ADD CONSTRAINT calendar_simulator_unit_id_fkey FOREIGN KEY (simulator_unit_id) REFERENCES public.simulator_unit(id);


--
-- TOC entry 5197 (class 2606 OID 33241)
-- Name: course_session course_session_enrollment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course_session
    ADD CONSTRAINT course_session_enrollment_id_fkey FOREIGN KEY (enrollment_id) REFERENCES public.enrollment(id);


--
-- TOC entry 5198 (class 2606 OID 33034)
-- Name: course_session course_session_enrollment_module_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course_session
    ADD CONSTRAINT course_session_enrollment_module_id_fkey FOREIGN KEY (enrollment_module_id) REFERENCES public.enrollment_module(id);


--
-- TOC entry 5211 (class 2606 OID 25120)
-- Name: course_session_event course_session_event_course_session_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course_session_event
    ADD CONSTRAINT course_session_event_course_session_id_fkey FOREIGN KEY (course_session_id) REFERENCES public.course_session(id) ON DELETE CASCADE;


--
-- TOC entry 5199 (class 2606 OID 25006)
-- Name: course_session course_session_instructor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course_session
    ADD CONSTRAINT course_session_instructor_id_fkey FOREIGN KEY (instructor_id) REFERENCES public.instructor(id) ON DELETE SET NULL;


--
-- TOC entry 5200 (class 2606 OID 25001)
-- Name: course_session course_session_phase_session_template_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course_session
    ADD CONSTRAINT course_session_phase_session_template_id_fkey FOREIGN KEY (phase_session_template_id) REFERENCES public.phase_session_template(id) ON DELETE RESTRICT;


--
-- TOC entry 5201 (class 2606 OID 24996)
-- Name: course_session course_session_program_course_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course_session
    ADD CONSTRAINT course_session_program_course_id_fkey FOREIGN KEY (program_course_id) REFERENCES public.program_course(id) ON DELETE CASCADE;


--
-- TOC entry 5220 (class 2606 OID 33023)
-- Name: enrollment_balance enrollment_balance_enrollment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enrollment_balance
    ADD CONSTRAINT enrollment_balance_enrollment_id_fkey FOREIGN KEY (enrollment_id) REFERENCES public.enrollment(id) ON DELETE CASCADE;


--
-- TOC entry 5218 (class 2606 OID 33004)
-- Name: enrollment_module enrollment_module_enrollment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enrollment_module
    ADD CONSTRAINT enrollment_module_enrollment_id_fkey FOREIGN KEY (enrollment_id) REFERENCES public.enrollment(id) ON DELETE CASCADE;


--
-- TOC entry 5219 (class 2606 OID 33009)
-- Name: enrollment_module enrollment_module_program_module_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enrollment_module
    ADD CONSTRAINT enrollment_module_program_module_id_fkey FOREIGN KEY (program_module_id) REFERENCES public.program_module(id);


--
-- TOC entry 5215 (class 2606 OID 32983)
-- Name: enrollment enrollment_program_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enrollment
    ADD CONSTRAINT enrollment_program_id_fkey FOREIGN KEY (program_id) REFERENCES public.program(id);


--
-- TOC entry 5216 (class 2606 OID 32988)
-- Name: enrollment enrollment_program_version_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enrollment
    ADD CONSTRAINT enrollment_program_version_id_fkey FOREIGN KEY (program_version_id) REFERENCES public.program_version(id);


--
-- TOC entry 5217 (class 2606 OID 32978)
-- Name: enrollment enrollment_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enrollment
    ADD CONSTRAINT enrollment_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.student(id);


--
-- TOC entry 5182 (class 2606 OID 33050)
-- Name: user_account fk_user_document_type; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_account
    ADD CONSTRAINT fk_user_document_type FOREIGN KEY (document_type_id) REFERENCES public.document_type(id);


--
-- TOC entry 5207 (class 2606 OID 25087)
-- Name: instructor_daily_availability instructor_daily_availability_instructor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.instructor_daily_availability
    ADD CONSTRAINT instructor_daily_availability_instructor_id_fkey FOREIGN KEY (instructor_id) REFERENCES public.instructor(id) ON DELETE CASCADE;


--
-- TOC entry 5208 (class 2606 OID 33209)
-- Name: instructor_daily_availability instructor_daily_availability_monthly_availability_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.instructor_daily_availability
    ADD CONSTRAINT instructor_daily_availability_monthly_availability_id_fkey FOREIGN KEY (monthly_availability_id) REFERENCES public.instructor_monthly_availability(id);


--
-- TOC entry 5231 (class 2606 OID 33204)
-- Name: instructor_monthly_availability instructor_monthly_availability_approved_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.instructor_monthly_availability
    ADD CONSTRAINT instructor_monthly_availability_approved_by_fkey FOREIGN KEY (approved_by) REFERENCES public.user_account(id);


--
-- TOC entry 5232 (class 2606 OID 33199)
-- Name: instructor_monthly_availability instructor_monthly_availability_instructor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.instructor_monthly_availability
    ADD CONSTRAINT instructor_monthly_availability_instructor_id_fkey FOREIGN KEY (instructor_id) REFERENCES public.instructor(id) ON DELETE CASCADE;


--
-- TOC entry 5188 (class 2606 OID 24892)
-- Name: instructor_parking_group_member instructor_parking_group_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.instructor_parking_group_member
    ADD CONSTRAINT instructor_parking_group_fk FOREIGN KEY (parking_group_id) REFERENCES public.instructor_parking_group(id) ON DELETE RESTRICT;


--
-- TOC entry 5189 (class 2606 OID 24887)
-- Name: instructor_parking_group_member instructor_parking_group_instructor_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.instructor_parking_group_member
    ADD CONSTRAINT instructor_parking_group_instructor_fk FOREIGN KEY (instructor_id) REFERENCES public.instructor(id) ON DELETE CASCADE;


--
-- TOC entry 5186 (class 2606 OID 24864)
-- Name: instructor_qualification instructor_qualification_instructor_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.instructor_qualification
    ADD CONSTRAINT instructor_qualification_instructor_fk FOREIGN KEY (instructor_id) REFERENCES public.instructor(id) ON DELETE CASCADE;


--
-- TOC entry 5187 (class 2606 OID 24869)
-- Name: instructor_qualification instructor_qualification_qualification_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.instructor_qualification
    ADD CONSTRAINT instructor_qualification_qualification_fk FOREIGN KEY (qualification_id) REFERENCES public.qualification(id) ON DELETE CASCADE;


--
-- TOC entry 5234 (class 2606 OID 33261)
-- Name: instructor_rank_history instructor_rank_history_instructor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.instructor_rank_history
    ADD CONSTRAINT instructor_rank_history_instructor_id_fkey FOREIGN KEY (instructor_id) REFERENCES public.instructor(id);


--
-- TOC entry 5185 (class 2606 OID 24844)
-- Name: instructor instructor_user_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.instructor
    ADD CONSTRAINT instructor_user_fk FOREIGN KEY (user_account_id) REFERENCES public.user_account(id) ON DELETE RESTRICT;


--
-- TOC entry 5209 (class 2606 OID 25105)
-- Name: instructor_work_log instructor_work_log_course_session_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.instructor_work_log
    ADD CONSTRAINT instructor_work_log_course_session_id_fkey FOREIGN KEY (course_session_id) REFERENCES public.course_session(id) ON DELETE SET NULL;


--
-- TOC entry 5210 (class 2606 OID 25100)
-- Name: instructor_work_log instructor_work_log_instructor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.instructor_work_log
    ADD CONSTRAINT instructor_work_log_instructor_id_fkey FOREIGN KEY (instructor_id) REFERENCES public.instructor(id) ON DELETE CASCADE;


--
-- TOC entry 5206 (class 2606 OID 25072)
-- Name: package_usage_log package_usage_log_student_package_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.package_usage_log
    ADD CONSTRAINT package_usage_log_student_package_id_fkey FOREIGN KEY (student_package_id) REFERENCES public.student_package(id) ON DELETE CASCADE;


--
-- TOC entry 5192 (class 2606 OID 33080)
-- Name: phase_session_template phase_session_template_module_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.phase_session_template
    ADD CONSTRAINT phase_session_template_module_fk FOREIGN KEY (program_module_id) REFERENCES public.program_module(id) ON DELETE CASCADE;


--
-- TOC entry 5193 (class 2606 OID 33228)
-- Name: phase_session_template phase_session_template_program_structure_version_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.phase_session_template
    ADD CONSTRAINT phase_session_template_program_structure_version_id_fkey FOREIGN KEY (program_structure_version_id) REFERENCES public.program_structure_version(id);


--
-- TOC entry 5180 (class 2606 OID 16908)
-- Name: program_alias program_alias_program_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.program_alias
    ADD CONSTRAINT program_alias_program_id_fkey FOREIGN KEY (program_id) REFERENCES public.program(id);


--
-- TOC entry 5168 (class 2606 OID 33029)
-- Name: program program_base_program_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.program
    ADD CONSTRAINT program_base_program_id_fkey FOREIGN KEY (base_program_id) REFERENCES public.program(id);


--
-- TOC entry 5194 (class 2606 OID 24963)
-- Name: program_course program_course_program_version_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.program_course
    ADD CONSTRAINT program_course_program_version_id_fkey FOREIGN KEY (program_version_id) REFERENCES public.program_version(id) ON DELETE RESTRICT;


--
-- TOC entry 5191 (class 2606 OID 24925)
-- Name: program_module program_module_program_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.program_module
    ADD CONSTRAINT program_module_program_id_fkey FOREIGN KEY (program_id) REFERENCES public.program(id) ON DELETE CASCADE;


--
-- TOC entry 5221 (class 2606 OID 33113)
-- Name: program_phase program_phase_program_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.program_phase
    ADD CONSTRAINT program_phase_program_id_fkey FOREIGN KEY (program_id) REFERENCES public.program(id) ON DELETE CASCADE;


--
-- TOC entry 5222 (class 2606 OID 33128)
-- Name: program_requirement program_requirement_program_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.program_requirement
    ADD CONSTRAINT program_requirement_program_id_fkey FOREIGN KEY (program_id) REFERENCES public.program(id) ON DELETE CASCADE;


--
-- TOC entry 5233 (class 2606 OID 33223)
-- Name: program_structure_version program_structure_version_program_version_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.program_structure_version
    ADD CONSTRAINT program_structure_version_program_version_id_fkey FOREIGN KEY (program_version_id) REFERENCES public.program_version(id);


--
-- TOC entry 5190 (class 2606 OID 24911)
-- Name: program_version program_version_program_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.program_version
    ADD CONSTRAINT program_version_program_id_fkey FOREIGN KEY (program_id) REFERENCES public.program(id) ON DELETE CASCADE;


--
-- TOC entry 5173 (class 2606 OID 16888)
-- Name: reservation reservation_calendar_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservation
    ADD CONSTRAINT reservation_calendar_id_fkey FOREIGN KEY (calendar_id) REFERENCES public.calendar(id);


--
-- TOC entry 5174 (class 2606 OID 25180)
-- Name: reservation reservation_course_session_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservation
    ADD CONSTRAINT reservation_course_session_id_fkey FOREIGN KEY (course_session_id) REFERENCES public.course_session(id) ON DELETE SET NULL;


--
-- TOC entry 5175 (class 2606 OID 33297)
-- Name: reservation reservation_instructor_marked_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservation
    ADD CONSTRAINT reservation_instructor_marked_by_fkey FOREIGN KEY (instructor_marked_by) REFERENCES public.instructor(id);


--
-- TOC entry 5176 (class 2606 OID 33289)
-- Name: reservation reservation_pair_link_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservation
    ADD CONSTRAINT reservation_pair_link_id_fkey FOREIGN KEY (pair_link_id) REFERENCES public.student_pair_link(id) ON DELETE SET NULL;


--
-- TOC entry 5177 (class 2606 OID 16893)
-- Name: reservation reservation_simulator_turn_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservation
    ADD CONSTRAINT reservation_simulator_turn_id_fkey FOREIGN KEY (simulator_turn_id) REFERENCES public.simulator_turn(id);


--
-- TOC entry 5178 (class 2606 OID 25130)
-- Name: reservation reservation_simulator_unit_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservation
    ADD CONSTRAINT reservation_simulator_unit_id_fkey FOREIGN KEY (simulator_unit_id) REFERENCES public.simulator_unit(id);


--
-- TOC entry 5179 (class 2606 OID 16883)
-- Name: reservation reservation_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservation
    ADD CONSTRAINT reservation_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.student(id);


--
-- TOC entry 5181 (class 2606 OID 24786)
-- Name: student_certification student_certification_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_certification
    ADD CONSTRAINT student_certification_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.student(id) ON DELETE CASCADE;


--
-- TOC entry 5195 (class 2606 OID 24983)
-- Name: student_course student_course_program_course_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_course
    ADD CONSTRAINT student_course_program_course_id_fkey FOREIGN KEY (program_course_id) REFERENCES public.program_course(id) ON DELETE CASCADE;


--
-- TOC entry 5196 (class 2606 OID 24978)
-- Name: student_course student_course_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_course
    ADD CONSTRAINT student_course_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.student(id) ON DELETE CASCADE;


--
-- TOC entry 5237 (class 2606 OID 33313)
-- Name: student_exception_request student_exception_request_reservation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_exception_request
    ADD CONSTRAINT student_exception_request_reservation_id_fkey FOREIGN KEY (reservation_id) REFERENCES public.reservation(id) ON DELETE CASCADE;


--
-- TOC entry 5238 (class 2606 OID 33323)
-- Name: student_exception_request student_exception_request_reviewed_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_exception_request
    ADD CONSTRAINT student_exception_request_reviewed_by_fkey FOREIGN KEY (reviewed_by) REFERENCES public.user_account(id);


--
-- TOC entry 5239 (class 2606 OID 33318)
-- Name: student_exception_request student_exception_request_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_exception_request
    ADD CONSTRAINT student_exception_request_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.student(id) ON DELETE CASCADE;


--
-- TOC entry 5240 (class 2606 OID 33342)
-- Name: student_infraction student_infraction_reservation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_infraction
    ADD CONSTRAINT student_infraction_reservation_id_fkey FOREIGN KEY (reservation_id) REFERENCES public.reservation(id) ON DELETE SET NULL;


--
-- TOC entry 5241 (class 2606 OID 33337)
-- Name: student_infraction student_infraction_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_infraction
    ADD CONSTRAINT student_infraction_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.student(id) ON DELETE CASCADE;


--
-- TOC entry 5204 (class 2606 OID 25059)
-- Name: student_package student_package_package_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_package
    ADD CONSTRAINT student_package_package_type_id_fkey FOREIGN KEY (package_type_id) REFERENCES public.package_type(id) ON DELETE RESTRICT;


--
-- TOC entry 5205 (class 2606 OID 25054)
-- Name: student_package student_package_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_package
    ADD CONSTRAINT student_package_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.student(id) ON DELETE CASCADE;


--
-- TOC entry 5235 (class 2606 OID 33279)
-- Name: student_pair_link student_pair_link_enrollment_id_1_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_pair_link
    ADD CONSTRAINT student_pair_link_enrollment_id_1_fkey FOREIGN KEY (enrollment_id_1) REFERENCES public.enrollment(id) ON DELETE CASCADE;


--
-- TOC entry 5236 (class 2606 OID 33284)
-- Name: student_pair_link student_pair_link_enrollment_id_2_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_pair_link
    ADD CONSTRAINT student_pair_link_enrollment_id_2_fkey FOREIGN KEY (enrollment_id_2) REFERENCES public.enrollment(id) ON DELETE CASCADE;


--
-- TOC entry 5223 (class 2606 OID 33160)
-- Name: student_phase_progress student_phase_progress_course_session_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_phase_progress
    ADD CONSTRAINT student_phase_progress_course_session_id_fkey FOREIGN KEY (course_session_id) REFERENCES public.course_session(id);


--
-- TOC entry 5224 (class 2606 OID 33150)
-- Name: student_phase_progress student_phase_progress_enrollment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_phase_progress
    ADD CONSTRAINT student_phase_progress_enrollment_id_fkey FOREIGN KEY (enrollment_id) REFERENCES public.enrollment(id) ON DELETE CASCADE;


--
-- TOC entry 5225 (class 2606 OID 33233)
-- Name: student_phase_progress student_phase_progress_instructor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_phase_progress
    ADD CONSTRAINT student_phase_progress_instructor_id_fkey FOREIGN KEY (instructor_id) REFERENCES public.instructor(id);


--
-- TOC entry 5226 (class 2606 OID 33155)
-- Name: student_phase_progress student_phase_progress_phase_session_template_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_phase_progress
    ADD CONSTRAINT student_phase_progress_phase_session_template_id_fkey FOREIGN KEY (phase_session_template_id) REFERENCES public.phase_session_template(id);


--
-- TOC entry 5227 (class 2606 OID 33145)
-- Name: student_phase_progress student_phase_progress_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_phase_progress
    ADD CONSTRAINT student_phase_progress_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.student(id) ON DELETE CASCADE;


--
-- TOC entry 5170 (class 2606 OID 16844)
-- Name: student_programming_group student_programming_group_programming_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_programming_group
    ADD CONSTRAINT student_programming_group_programming_group_id_fkey FOREIGN KEY (programming_group_id) REFERENCES public.programming_group(id);


--
-- TOC entry 5171 (class 2606 OID 16839)
-- Name: student_programming_group student_programming_group_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_programming_group
    ADD CONSTRAINT student_programming_group_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.student(id);


--
-- TOC entry 5228 (class 2606 OID 33181)
-- Name: student_remedial_session student_remedial_session_original_course_session_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_remedial_session
    ADD CONSTRAINT student_remedial_session_original_course_session_id_fkey FOREIGN KEY (original_course_session_id) REFERENCES public.course_session(id);


--
-- TOC entry 5229 (class 2606 OID 33246)
-- Name: student_remedial_session student_remedial_session_phase_session_template_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_remedial_session
    ADD CONSTRAINT student_remedial_session_phase_session_template_id_fkey FOREIGN KEY (phase_session_template_id) REFERENCES public.phase_session_template(id);


--
-- TOC entry 5230 (class 2606 OID 33176)
-- Name: student_remedial_session student_remedial_session_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_remedial_session
    ADD CONSTRAINT student_remedial_session_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.student(id) ON DELETE CASCADE;


--
-- TOC entry 5213 (class 2606 OID 25170)
-- Name: student_rule_override student_rule_override_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_rule_override
    ADD CONSTRAINT student_rule_override_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.user_account(id);


--
-- TOC entry 5214 (class 2606 OID 25165)
-- Name: student_rule_override student_rule_override_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_rule_override
    ADD CONSTRAINT student_rule_override_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.student(id) ON DELETE CASCADE;


--
-- TOC entry 5202 (class 2606 OID 25028)
-- Name: student_session_attendance student_session_attendance_course_session_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_session_attendance
    ADD CONSTRAINT student_session_attendance_course_session_id_fkey FOREIGN KEY (course_session_id) REFERENCES public.course_session(id) ON DELETE CASCADE;


--
-- TOC entry 5203 (class 2606 OID 25023)
-- Name: student_session_attendance student_session_attendance_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_session_attendance
    ADD CONSTRAINT student_session_attendance_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.student(id) ON DELETE CASCADE;


--
-- TOC entry 5169 (class 2606 OID 25125)
-- Name: student student_user_account_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student
    ADD CONSTRAINT student_user_account_fk FOREIGN KEY (user_account_id) REFERENCES public.user_account(id);


--
-- TOC entry 5183 (class 2606 OID 24827)
-- Name: user_role user_role_role_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_role
    ADD CONSTRAINT user_role_role_fk FOREIGN KEY (role_id) REFERENCES public.role(id) ON DELETE CASCADE;


--
-- TOC entry 5184 (class 2606 OID 24822)
-- Name: user_role user_role_user_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_role
    ADD CONSTRAINT user_role_user_fk FOREIGN KEY (user_account_id) REFERENCES public.user_account(id) ON DELETE CASCADE;


-- Completed on 2026-02-20 10:07:40

--
-- PostgreSQL database dump complete
--

\unrestrict d7XIyOSW159NacGkYjFS22DjP7tvaBEj1PTh0cgIt8aqqJVjXE0eLvrr76ZsF45

