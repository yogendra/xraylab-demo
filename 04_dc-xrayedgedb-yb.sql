--
-- YSQL database dump
--

-- Dumped from database version 11.2-YB-2.19.2.0-b0
-- Dumped by ysql_dump version 11.2-YB-2.19.2.0-b0

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: yugabyte
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL,
    CONSTRAINT auth_group_pkey PRIMARY KEY((id) HASH)
);


ALTER TABLE public.auth_group OWNER TO yugabyte;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: yugabyte
--

CREATE SEQUENCE public.auth_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 100;


ALTER TABLE public.auth_group_id_seq OWNER TO yugabyte;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: yugabyte
--

ALTER SEQUENCE public.auth_group_id_seq OWNED BY public.auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: yugabyte
--

CREATE TABLE public.auth_group_permissions (
    id bigint NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL,
    CONSTRAINT auth_group_permissions_pkey PRIMARY KEY((id) HASH)
);


ALTER TABLE public.auth_group_permissions OWNER TO yugabyte;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: yugabyte
--

CREATE SEQUENCE public.auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 100;


ALTER TABLE public.auth_group_permissions_id_seq OWNER TO yugabyte;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: yugabyte
--

ALTER SEQUENCE public.auth_group_permissions_id_seq OWNED BY public.auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: yugabyte
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL,
    CONSTRAINT auth_permission_pkey PRIMARY KEY((id) HASH)
);


ALTER TABLE public.auth_permission OWNER TO yugabyte;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: yugabyte
--

CREATE SEQUENCE public.auth_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 100;


ALTER TABLE public.auth_permission_id_seq OWNER TO yugabyte;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: yugabyte
--

ALTER SEQUENCE public.auth_permission_id_seq OWNED BY public.auth_permission.id;


--
-- Name: auth_user; Type: TABLE; Schema: public; Owner: yugabyte
--

CREATE TABLE public.auth_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(150) NOT NULL,
    last_name character varying(150) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL,
    CONSTRAINT auth_user_pkey PRIMARY KEY((id) HASH)
);


ALTER TABLE public.auth_user OWNER TO yugabyte;

--
-- Name: auth_user_groups; Type: TABLE; Schema: public; Owner: yugabyte
--

CREATE TABLE public.auth_user_groups (
    id bigint NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL,
    CONSTRAINT auth_user_groups_pkey PRIMARY KEY((id) HASH)
);


ALTER TABLE public.auth_user_groups OWNER TO yugabyte;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: yugabyte
--

CREATE SEQUENCE public.auth_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 100;


ALTER TABLE public.auth_user_groups_id_seq OWNER TO yugabyte;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: yugabyte
--

ALTER SEQUENCE public.auth_user_groups_id_seq OWNED BY public.auth_user_groups.id;


--
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: public; Owner: yugabyte
--

CREATE SEQUENCE public.auth_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 100;


ALTER TABLE public.auth_user_id_seq OWNER TO yugabyte;

--
-- Name: auth_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: yugabyte
--

ALTER SEQUENCE public.auth_user_id_seq OWNED BY public.auth_user.id;


--
-- Name: auth_user_user_permissions; Type: TABLE; Schema: public; Owner: yugabyte
--

CREATE TABLE public.auth_user_user_permissions (
    id bigint NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL,
    CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY((id) HASH)
);


ALTER TABLE public.auth_user_user_permissions OWNER TO yugabyte;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: yugabyte
--

CREATE SEQUENCE public.auth_user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 100;


ALTER TABLE public.auth_user_user_permissions_id_seq OWNER TO yugabyte;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: yugabyte
--

ALTER SEQUENCE public.auth_user_user_permissions_id_seq OWNED BY public.auth_user_user_permissions.id;


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: yugabyte
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0)),
    CONSTRAINT django_admin_log_pkey PRIMARY KEY((id) HASH)
);


ALTER TABLE public.django_admin_log OWNER TO yugabyte;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: yugabyte
--

CREATE SEQUENCE public.django_admin_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 100;


ALTER TABLE public.django_admin_log_id_seq OWNER TO yugabyte;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: yugabyte
--

ALTER SEQUENCE public.django_admin_log_id_seq OWNED BY public.django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: yugabyte
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL,
    CONSTRAINT django_content_type_pkey PRIMARY KEY((id) HASH)
);


ALTER TABLE public.django_content_type OWNER TO yugabyte;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: yugabyte
--

CREATE SEQUENCE public.django_content_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 100;


ALTER TABLE public.django_content_type_id_seq OWNER TO yugabyte;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: yugabyte
--

ALTER SEQUENCE public.django_content_type_id_seq OWNED BY public.django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: yugabyte
--

CREATE TABLE public.django_migrations (
    id bigint NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL,
    CONSTRAINT django_migrations_pkey PRIMARY KEY((id) HASH)
);


ALTER TABLE public.django_migrations OWNER TO yugabyte;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: yugabyte
--

CREATE SEQUENCE public.django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 100;


ALTER TABLE public.django_migrations_id_seq OWNER TO yugabyte;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: yugabyte
--

ALTER SEQUENCE public.django_migrations_id_seq OWNED BY public.django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: yugabyte
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL,
    CONSTRAINT django_session_pkey PRIMARY KEY((session_key) HASH)
);


ALTER TABLE public.django_session OWNER TO yugabyte;

--
-- Name: xraylab_xraydata; Type: TABLE; Schema: public; Owner: yugabyte
--

CREATE TABLE public.xraylab_xraydata (
    id bigint NOT NULL,
    test_date timestamp with time zone NOT NULL,
    name character varying(100) NOT NULL,
    risk double precision NOT NULL,
    notes text,
    image_name character varying(255),
    model_name character varying(50) NOT NULL,
    author_id integer,
    CONSTRAINT xraylab_xraydata_pkey PRIMARY KEY((id) HASH)
);


ALTER TABLE public.xraylab_xraydata OWNER TO yugabyte;

--
-- Name: xraylab_xraydata_id_seq; Type: SEQUENCE; Schema: public; Owner: yugabyte
--

CREATE SEQUENCE public.xraylab_xraydata_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 100;


ALTER TABLE public.xraylab_xraydata_id_seq OWNER TO yugabyte;

--
-- Name: xraylab_xraydata_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: yugabyte
--

ALTER SEQUENCE public.xraylab_xraydata_id_seq OWNED BY public.xraylab_xraydata.id;


--
-- Name: auth_group id; Type: DEFAULT; Schema: public; Owner: yugabyte
--

ALTER TABLE ONLY public.auth_group ALTER COLUMN id SET DEFAULT nextval('public.auth_group_id_seq'::regclass);


--
-- Name: auth_group_permissions id; Type: DEFAULT; Schema: public; Owner: yugabyte
--

ALTER TABLE ONLY public.auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_group_permissions_id_seq'::regclass);


--
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: yugabyte
--

ALTER TABLE ONLY public.auth_permission ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_id_seq'::regclass);


--
-- Name: auth_user id; Type: DEFAULT; Schema: public; Owner: yugabyte
--

ALTER TABLE ONLY public.auth_user ALTER COLUMN id SET DEFAULT nextval('public.auth_user_id_seq'::regclass);


--
-- Name: auth_user_groups id; Type: DEFAULT; Schema: public; Owner: yugabyte
--

ALTER TABLE ONLY public.auth_user_groups ALTER COLUMN id SET DEFAULT nextval('public.auth_user_groups_id_seq'::regclass);


--
-- Name: auth_user_user_permissions id; Type: DEFAULT; Schema: public; Owner: yugabyte
--

ALTER TABLE ONLY public.auth_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_user_user_permissions_id_seq'::regclass);


--
-- Name: django_admin_log id; Type: DEFAULT; Schema: public; Owner: yugabyte
--

ALTER TABLE ONLY public.django_admin_log ALTER COLUMN id SET DEFAULT nextval('public.django_admin_log_id_seq'::regclass);


--
-- Name: django_content_type id; Type: DEFAULT; Schema: public; Owner: yugabyte
--

ALTER TABLE ONLY public.django_content_type ALTER COLUMN id SET DEFAULT nextval('public.django_content_type_id_seq'::regclass);


--
-- Name: django_migrations id; Type: DEFAULT; Schema: public; Owner: yugabyte
--

ALTER TABLE ONLY public.django_migrations ALTER COLUMN id SET DEFAULT nextval('public.django_migrations_id_seq'::regclass);


--
-- Name: xraylab_xraydata id; Type: DEFAULT; Schema: public; Owner: yugabyte
--

ALTER TABLE ONLY public.xraylab_xraydata ALTER COLUMN id SET DEFAULT nextval('public.xraylab_xraydata_id_seq'::regclass);


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: yugabyte
--

COPY public.auth_group (id, name) FROM stdin;
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: yugabyte
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: yugabyte
--

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
5       Can add log entry       2       add_logentry
1       Can add x ray data      1       add_xraydata
11      Can delete permission   3       delete_permission
13      Can add group   4       add_group
21      Can add content type    6       add_contenttype
16      Can view group  4       view_group
12      Can view permission     3       view_permission
15      Can delete group        4       delete_group
6       Can change log entry    2       change_logentry
7       Can delete log entry    2       delete_logentry
9       Can add permission      3       add_permission
17      Can add user    5       add_user
10      Can change permission   3       change_permission
19      Can delete user 5       delete_user
23      Can delete content type 6       delete_contenttype
4       Can view x ray data     1       view_xraydata
18      Can change user 5       change_user
27      Can delete session      7       delete_session
2       Can change x ray data   1       change_xraydata
8       Can view log entry      2       view_logentry
14      Can change group        4       change_group
22      Can change content type 6       change_contenttype
24      Can view content type   6       view_contenttype
26      Can change session      7       change_session
28      Can view session        7       view_session
3       Can delete x ray data   1       delete_xraydata
25      Can add session 7       add_session
20      Can view user   5       view_user
\.


--
-- Data for Name: auth_user; Type: TABLE DATA; Schema: public; Owner: yugabyte
--

COPY public.auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) FROM stdin;
1       pbkdf2_sha256$260000$AJAfJ3dOx8iFMDu4X5QO8a$Yhs4xsZOGm8AlNNLuukSz1vqtpVQhVhOKAbWJHcNTLs=        \N      t       admin                   admin@yugabyte.com      t       t       2023-09-18 03:49:34.431508+00
\.


--
-- Data for Name: auth_user_groups; Type: TABLE DATA; Schema: public; Owner: yugabyte
--

COPY public.auth_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- Data for Name: auth_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: yugabyte
--

COPY public.auth_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: yugabyte
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: yugabyte
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
5       auth    user
1       xraylab xraydata
6       contenttypes    contenttype
7       sessions        session
4       auth    group
2       admin   logentry
3       auth    permission
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: yugabyte
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
3       admin   0001_initial    2023-09-18 03:49:24.957173+00
19      xraylab 0001_initial    2023-09-18 03:49:33.845584+00
14      auth    0009_alter_user_last_name_max_length    2023-09-18 03:49:26.048952+00
9       auth    0004_alter_user_username_opts   2023-09-18 03:49:25.577398+00
12      auth    0007_alter_validators_add_error_messages        2023-09-18 03:49:25.870202+00
16      auth    0011_update_proxy_permissions   2023-09-18 03:49:26.227667+00
5       admin   0003_logentry_add_action_flag_choices   2023-09-18 03:49:25.108408+00
17      auth    0012_alter_user_first_name_max_length   2023-09-18 03:49:26.312898+00
18      sessions        0001_initial    2023-09-18 03:49:31.181501+00
13      auth    0008_alter_user_username_max_length     2023-09-18 03:49:25.963575+00
15      auth    0010_alter_group_name_max_length        2023-09-18 03:49:26.146832+00
10      auth    0005_alter_user_last_login_null 2023-09-18 03:49:25.709831+00
7       auth    0002_alter_permission_name_max_length   2023-09-18 03:49:25.414926+00
11      auth    0006_require_contenttypes_0002  2023-09-18 03:49:25.788734+00
4       admin   0002_logentry_remove_auto_add   2023-09-18 03:49:25.032673+00
2       auth    0001_initial    2023-09-18 03:49:19.799818+00
8       auth    0003_alter_user_email_max_length        2023-09-18 03:49:25.497331+00
6       contenttypes    0002_remove_content_type_name   2023-09-18 03:49:25.333169+00
1       contenttypes    0001_initial    2023-09-18 03:48:56.727654+00
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: yugabyte
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
\.


--
-- Data for Name: xraylab_xraydata; Type: TABLE DATA; Schema: public; Owner: yugabyte
--

COPY public.xraylab_xraydata (id, test_date, name, risk, notes, image_name, model_name, author_id) FROM stdin;
\.


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: yugabyte
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: yugabyte
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: yugabyte
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 100, true);


--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: yugabyte
--

SELECT pg_catalog.setval('public.auth_user_groups_id_seq', 1, false);


--
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: yugabyte
--

SELECT pg_catalog.setval('public.auth_user_id_seq', 100, true);


--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: yugabyte
--

SELECT pg_catalog.setval('public.auth_user_user_permissions_id_seq', 1, false);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: yugabyte
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 1, false);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: yugabyte
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 100, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: yugabyte
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 100, true);


--
-- Name: xraylab_xraydata_id_seq; Type: SEQUENCE SET; Schema: public; Owner: yugabyte
--

SELECT pg_catalog.setval('public.xraylab_xraydata_id_seq', 1, false);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: yugabyte
--

CREATE UNIQUE INDEX NONCONCURRENTLY auth_group_name_key ON public.auth_group USING lsm (name HASH);

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE USING INDEX auth_group_name_key;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: yugabyte
--

CREATE UNIQUE INDEX NONCONCURRENTLY auth_group_permissions_group_id_permission_id_0cd325b0_uniq ON public.auth_group_permissions USING lsm (group_id HASH, permission_id ASC);

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE USING INDEX auth_group_permissions_group_id_permission_id_0cd325b0_uniq;


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: yugabyte
--

CREATE UNIQUE INDEX NONCONCURRENTLY auth_permission_content_type_id_codename_01ab375a_uniq ON public.auth_permission USING lsm (content_type_id HASH, codename ASC);

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE USING INDEX auth_permission_content_type_id_codename_01ab375a_uniq;


--
-- Name: auth_user_groups auth_user_groups_user_id_group_id_94350c0c_uniq; Type: CONSTRAINT; Schema: public; Owner: yugabyte
--

CREATE UNIQUE INDEX NONCONCURRENTLY auth_user_groups_user_id_group_id_94350c0c_uniq ON public.auth_user_groups USING lsm (user_id HASH, group_id ASC);

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_group_id_94350c0c_uniq UNIQUE USING INDEX auth_user_groups_user_id_group_id_94350c0c_uniq;


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_permission_id_14a6b632_uniq; Type: CONSTRAINT; Schema: public; Owner: yugabyte
--

CREATE UNIQUE INDEX NONCONCURRENTLY auth_user_user_permissions_user_id_permission_id_14a6b632_uniq ON public.auth_user_user_permissions USING lsm (user_id HASH, permission_id ASC);

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_permission_id_14a6b632_uniq UNIQUE USING INDEX auth_user_user_permissions_user_id_permission_id_14a6b632_uniq;


--
-- Name: auth_user auth_user_username_key; Type: CONSTRAINT; Schema: public; Owner: yugabyte
--

CREATE UNIQUE INDEX NONCONCURRENTLY auth_user_username_key ON public.auth_user USING lsm (username HASH);

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE USING INDEX auth_user_username_key;


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: yugabyte
--

CREATE UNIQUE INDEX NONCONCURRENTLY django_content_type_app_label_model_76bd3d3b_uniq ON public.django_content_type USING lsm (app_label HASH, model ASC);

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE USING INDEX django_content_type_app_label_model_76bd3d3b_uniq;


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: yugabyte
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING lsm (name varchar_pattern_ops HASH);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: yugabyte
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING lsm (group_id HASH);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: yugabyte
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING lsm (permission_id HASH);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: yugabyte
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING lsm (content_type_id HASH);


--
-- Name: auth_user_groups_group_id_97559544; Type: INDEX; Schema: public; Owner: yugabyte
--

CREATE INDEX auth_user_groups_group_id_97559544 ON public.auth_user_groups USING lsm (group_id HASH);


--
-- Name: auth_user_groups_user_id_6a12ed8b; Type: INDEX; Schema: public; Owner: yugabyte
--

CREATE INDEX auth_user_groups_user_id_6a12ed8b ON public.auth_user_groups USING lsm (user_id HASH);


--
-- Name: auth_user_user_permissions_permission_id_1fbb5f2c; Type: INDEX; Schema: public; Owner: yugabyte
--

CREATE INDEX auth_user_user_permissions_permission_id_1fbb5f2c ON public.auth_user_user_permissions USING lsm (permission_id HASH);


--
-- Name: auth_user_user_permissions_user_id_a95ead1b; Type: INDEX; Schema: public; Owner: yugabyte
--

CREATE INDEX auth_user_user_permissions_user_id_a95ead1b ON public.auth_user_user_permissions USING lsm (user_id HASH);


--
-- Name: auth_user_username_6821ab7c_like; Type: INDEX; Schema: public; Owner: yugabyte
--

CREATE INDEX auth_user_username_6821ab7c_like ON public.auth_user USING lsm (username varchar_pattern_ops HASH);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: yugabyte
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING lsm (content_type_id HASH);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: yugabyte
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING lsm (user_id HASH);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: yugabyte
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING lsm (expire_date HASH);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: yugabyte
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING lsm (session_key varchar_pattern_ops HASH);


--
-- Name: xraylab_xraydata_author_id_555bd6f9; Type: INDEX; Schema: public; Owner: yugabyte
--

CREATE INDEX xraylab_xraydata_author_id_555bd6f9 ON public.xraylab_xraydata USING lsm (author_id HASH);


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: yugabyte
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: yugabyte
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: yugabyte
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_group_id_97559544_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: yugabyte
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_97559544_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_user_id_6a12ed8b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: yugabyte
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_6a12ed8b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: yugabyte
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: yugabyte
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: yugabyte
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: yugabyte
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: xraylab_xraydata xraylab_xraydata_author_id_555bd6f9_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: yugabyte
--

ALTER TABLE ONLY public.xraylab_xraydata
    ADD CONSTRAINT xraylab_xraydata_author_id_555bd6f9_fk_auth_user_id FOREIGN KEY (author_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- YSQL database dump complete
--
