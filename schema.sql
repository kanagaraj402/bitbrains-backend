--
-- PostgreSQL database dump
--

\restrict UchlTz6XJccMTiuXlTTm6VawvpRpYmAeHzyIKnQFh0YYm2reTTPrYOcnFKH1dYF

-- Dumped from database version 16.13 (Ubuntu 16.13-0ubuntu0.24.04.1)
-- Dumped by pg_dump version 16.13 (Ubuntu 16.13-0ubuntu0.24.04.1)

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
-- Name: admins; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.admins (
    id integer NOT NULL,
    name character varying(150) NOT NULL,
    email character varying(150) NOT NULL,
    password_hash text NOT NULL,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.admins OWNER TO postgres;

--
-- Name: admins_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.admins_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.admins_id_seq OWNER TO postgres;

--
-- Name: admins_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.admins_id_seq OWNED BY public.admins.id;


--
-- Name: company_info; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.company_info (
    id integer DEFAULT 1 NOT NULL,
    company_name character varying(150) DEFAULT 'BitBrains Technology'::character varying,
    tagline character varying(255) DEFAULT 'We engineer IT to perfection.'::character varying,
    phone character varying(30) DEFAULT '+91 90030 87970'::character varying,
    whatsapp character varying(30) DEFAULT '+91 90030 87970'::character varying,
    email character varying(150) DEFAULT 'admin@bitbrainstech.com'::character varying,
    skype character varying(100) DEFAULT 'bitbrainstech'::character varying,
    address text DEFAULT 'BitBrains Technology, Block 2, Rathinam Tech Zone, Eachanari, Coimbatore, Tamil Nadu, India 641021.'::text,
    about_text text DEFAULT 'We are a leading professional team of skilled developers and architects with a common vision to achieve customer satisfaction.'::text,
    updated_at timestamp without time zone DEFAULT now(),
    CONSTRAINT single_row CHECK ((id = 1))
);


ALTER TABLE public.company_info OWNER TO postgres;

--
-- Name: contacts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contacts (
    id integer NOT NULL,
    name character varying(150) NOT NULL,
    email character varying(150) NOT NULL,
    phone character varying(30),
    subject character varying(200),
    message text NOT NULL,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.contacts OWNER TO postgres;

--
-- Name: contacts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.contacts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.contacts_id_seq OWNER TO postgres;

--
-- Name: contacts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.contacts_id_seq OWNED BY public.contacts.id;


--
-- Name: portfolio; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.portfolio (
    id integer NOT NULL,
    title character varying(150) NOT NULL,
    slug character varying(150) NOT NULL,
    client_name character varying(150),
    description text,
    image_url character varying(255),
    project_url character varying(255),
    sort_order integer DEFAULT 0,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.portfolio OWNER TO postgres;

--
-- Name: portfolio_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.portfolio_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.portfolio_id_seq OWNER TO postgres;

--
-- Name: portfolio_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.portfolio_id_seq OWNED BY public.portfolio.id;


--
-- Name: products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products (
    id integer NOT NULL,
    name character varying(150) NOT NULL,
    slug character varying(150) NOT NULL,
    description text,
    icon_url character varying(255),
    sort_order integer DEFAULT 0,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.products OWNER TO postgres;

--
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.products_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.products_id_seq OWNER TO postgres;

--
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.products_id_seq OWNED BY public.products.id;


--
-- Name: services; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.services (
    id integer NOT NULL,
    title character varying(150) NOT NULL,
    slug character varying(150) NOT NULL,
    summary text,
    full_description text,
    image_url character varying(255),
    sort_order integer DEFAULT 0,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.services OWNER TO postgres;

--
-- Name: services_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.services_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.services_id_seq OWNER TO postgres;

--
-- Name: services_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.services_id_seq OWNED BY public.services.id;


--
-- Name: technologies; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.technologies (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    icon_url character varying(255),
    sort_order integer DEFAULT 0,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.technologies OWNER TO postgres;

--
-- Name: technologies_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.technologies_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.technologies_id_seq OWNER TO postgres;

--
-- Name: technologies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.technologies_id_seq OWNED BY public.technologies.id;


--
-- Name: admins id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admins ALTER COLUMN id SET DEFAULT nextval('public.admins_id_seq'::regclass);


--
-- Name: contacts id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contacts ALTER COLUMN id SET DEFAULT nextval('public.contacts_id_seq'::regclass);


--
-- Name: portfolio id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.portfolio ALTER COLUMN id SET DEFAULT nextval('public.portfolio_id_seq'::regclass);


--
-- Name: products id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);


--
-- Name: services id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.services ALTER COLUMN id SET DEFAULT nextval('public.services_id_seq'::regclass);


--
-- Name: technologies id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.technologies ALTER COLUMN id SET DEFAULT nextval('public.technologies_id_seq'::regclass);


--
-- Data for Name: admins; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.admins (id, name, email, password_hash, created_at) FROM stdin;
2	BitBrains Admin	admin@bitbrainstech.com	$2a$10$wV/hkJbxPKg8lQsopIKVXekEzTZRObLnWqixruFGp6CN8B0H4gNEy	2026-08-18 16:01:28.381611
\.


--
-- Data for Name: company_info; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.company_info (id, company_name, tagline, phone, whatsapp, email, skype, address, about_text, updated_at) FROM stdin;
1	BitBrains Technology	We engineer IT to perfection.	+91 90030 87970	+91 90030 87970	admin@bitbrainstech.com	bitbrainstech	BitBrains Technology, Block 2, Rathinam Tech Zone, Eachanari, Coimbatore, Tamil Nadu, India 641021.	We are a leading professional team of skilled developers and architects with a common vision to achieve customer satisfaction.	2026-08-28 17:16:46.37829
\.


--
-- Data for Name: contacts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.contacts (id, name, email, phone, subject, message, created_at) FROM stdin;
1	kanagu	demouser1@gmail.com	9876543212	matgs	no	2026-08-18 09:37:21.719211
\.


--
-- Data for Name: portfolio; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.portfolio (id, title, slug, client_name, description, image_url, project_url, sort_order, created_at) FROM stdin;
1	Cottage Accommodation Portal	cottage-accommodation-portal	Isha Foundation	An end-to-end solution managing over 300 rooms across 10 blocks.	/images/portfolio/cottage-new.jpg		1	2026-08-18 09:35:28.373682
2	College Management System	college-management-system	Rathinam Institutions	A highly efficient CMS to streamline enquiries and admissions.	/images/portfolio/college-new.jpg		2	2026-08-18 09:35:28.373682
3	Data Aggregate Automation	data-aggregate-automation	VNP Solutions, Canada	Aggregated payments data cluttered across multiple platforms.	/images/portfolio/automation-new.jpg		3	2026-08-18 09:35:28.373682
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.products (id, name, slug, description, icon_url, sort_order, created_at) FROM stdin;
2	Ecommerce Portal	ecommerce	A full online storefront with catalog, cart, checkout, and payments.	/images/products/ecommerce.png	2	2026-08-18 09:35:28.373682
3	Education Management	education	Admissions, student records, fee tracking, and academic scheduling.	/images/products/education.png	3	2026-08-18 09:35:28.373682
4	Employee Attendance Application	attendance	Biometric, geo-tagged, or QR-based attendance tracking.	/images/products/attendance.png	4	2026-08-18 09:35:28.373682
5	HR Management	hr	Employee records, leave management, and performance tracking.	/images/products/hr.png	5	2026-08-18 09:35:28.373682
6	Sales, Purchase & Inventory Management	erp	An Odoo-based ERP covering sales, purchase, and inventory.	/images/products/erp.png	6	2026-08-18 09:35:28.373682
7	Vehicles / Fleet Management	vehicles	Track vehicle usage, maintenance, fuel logs, and drivers.	/images/products/vehicles.png	7	2026-08-18 09:35:28.373682
1	Customer Relationship Management	crm	Track leads, follow-ups, deals, and customer history in one place.	/images/products/crm.png	1	2026-08-18 09:35:28.373682
\.


--
-- Data for Name: services; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.services (id, title, slug, summary, full_description, image_url, sort_order, created_at) FROM stdin;
3	ERP Development	erp-development	End-to-end ERP solutions for any sector.	We develop ERP business applications that give organizations an optimized, end-to-end solution for any sector, from design through implementation. We specialize in Odoo.	/images/products/erp-new.jpg	3	2026-08-18 09:35:28.373682
1	Mobile Apps Development	mobile-apps	We build native and hybrid mobile apps for iOS, Android and Windows platforms.	We build native and hybrid mobile apps for iOS, Android and Windows platforms, using the latest tools and standards to deliver a unique user experience.	/images/products/mobile-app-new.jpg	1	2026-08-18 09:35:28.373682
2	Web Applications Development	web-applications	From simple websites to complex, multi-functional e-commerce and web portals.	Professional design and development for everything from simple websites to complex, multi-functional e-commerce and web portals, built with current technologies.	/images/products/web-app-new.jpg	2	2026-08-18 09:35:28.373682
4	Corporate Trainings	corporate-trainings	Technology training programs for corporates and institutions.	Exhaustive technology training programs for corporates and educational institutions, led by experienced industry experts across development, deployment, and troubleshooting.	/images/products/corporate-training-new.jpg	4	2026-08-18 09:35:28.373682
\.


--
-- Data for Name: technologies; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.technologies (id, name, icon_url, sort_order, created_at) FROM stdin;
1	Angular	/images/technologies/angular.png	1	2026-08-18 15:54:02.078953
2	MySQL	/images/technologies/mysql.png	2	2026-08-18 15:54:02.078953
3	Node.js	/images/technologies/nodejs.png	3	2026-08-18 15:54:02.078953
4	Odoo	/images/technologies/odoo.png	4	2026-08-18 15:54:02.078953
5	PostgreSQL	/images/technologies/postgres.png	5	2026-08-18 15:54:02.078953
6	Python	/images/technologies/python.png	6	2026-08-18 15:54:02.078953
7	React	/images/technologies/react.png	7	2026-08-18 15:54:02.078953
\.


--
-- Name: admins_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.admins_id_seq', 2, true);


--
-- Name: contacts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.contacts_id_seq', 1, true);


--
-- Name: portfolio_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.portfolio_id_seq', 8, true);


--
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.products_id_seq', 19, true);


--
-- Name: services_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.services_id_seq', 16, true);


--
-- Name: technologies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.technologies_id_seq', 8, true);


--
-- Name: admins admins_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admins
    ADD CONSTRAINT admins_email_key UNIQUE (email);


--
-- Name: admins admins_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admins
    ADD CONSTRAINT admins_pkey PRIMARY KEY (id);


--
-- Name: company_info company_info_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.company_info
    ADD CONSTRAINT company_info_pkey PRIMARY KEY (id);


--
-- Name: contacts contacts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contacts
    ADD CONSTRAINT contacts_pkey PRIMARY KEY (id);


--
-- Name: portfolio portfolio_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.portfolio
    ADD CONSTRAINT portfolio_pkey PRIMARY KEY (id);


--
-- Name: portfolio portfolio_slug_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.portfolio
    ADD CONSTRAINT portfolio_slug_key UNIQUE (slug);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: products products_slug_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_slug_key UNIQUE (slug);


--
-- Name: services services_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.services
    ADD CONSTRAINT services_pkey PRIMARY KEY (id);


--
-- Name: services services_slug_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.services
    ADD CONSTRAINT services_slug_key UNIQUE (slug);


--
-- Name: technologies technologies_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.technologies
    ADD CONSTRAINT technologies_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

\unrestrict UchlTz6XJccMTiuXlTTm6VawvpRpYmAeHzyIKnQFh0YYm2reTTPrYOcnFKH1dYF

