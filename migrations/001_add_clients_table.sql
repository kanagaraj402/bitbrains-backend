CREATE TABLE IF NOT EXISTS public.clients (
    id integer NOT NULL,
    name character varying(150) NOT NULL,
    logo_url character varying(255),
    website_url character varying(255),
    sort_order integer DEFAULT 0,
    created_at timestamp without time zone DEFAULT now()
);

CREATE SEQUENCE IF NOT EXISTS public.clients_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE public.clients_id_seq OWNED BY public.clients.id;

ALTER TABLE ONLY public.clients ALTER COLUMN id SET DEFAULT nextval('public.clients_id_seq'::regclass);

ALTER TABLE ONLY public.clients
    ADD CONSTRAINT clients_pkey PRIMARY KEY (id);

INSERT INTO public.clients (name, logo_url, website_url, sort_order)
SELECT * FROM (VALUES
    ('Isha Foundation', '/images/clients/isha.png', 'http://www.ishafoundation.org/', 1),
    ('Rathinam Institutions', '/images/clients/rathinam.png', 'https://rathinam.in/', 2),
    ('VNP Solutions, Canada', '/images/clients/vnps.webp', 'https://www.vnpsolutions.com/', 3),
    ('Booma Hospital', '/images/clients/booma.jpeg', 'http://www.boomanursinghome.com/', 4),
    ('Strike Gold, USA', '/images/clients/gold.png', 'https://strikegold.com/', 5),
    ('Raise Business Incubator', '/images/clients/raise.png', 'http://aicraise.com/', 6),
    ('Cultr Cafe', '/images/clients/cultrcafe.png', NULL, 7),
    ('VAct Technologies', '/images/clients/vact.jpeg', 'http://www.vact-tech.com/', 8),
    ('OVIS Tech, Singapore', '/images/clients/ovis.png', 'http://ovistech.sg/', 9),
    ('AIRAA Corporates LLP', '/images/clients/airaa.png', 'https://www.airaacorp.com/', 10),
    ('Inflair, Singapore', '/images/clients/inflair.webp', 'http://www.inflair.com/', 11)
) AS seed(name, logo_url, website_url, sort_order)
WHERE NOT EXISTS (SELECT 1 FROM public.clients);

SELECT pg_catalog.setval('public.clients_id_seq', GREATEST((SELECT COALESCE(MAX(id), 0) FROM public.clients), 1), true);