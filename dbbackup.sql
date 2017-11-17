--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.9
-- Dumped by pg_dump version 9.5.9

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: all_weather; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE all_weather (
    weather_id integer NOT NULL,
    city_id integer NOT NULL,
    month character varying(15) NOT NULL,
    temp_high integer NOT NULL,
    temp_low integer NOT NULL,
    summary character varying(100) NOT NULL,
    icon character varying(50) NOT NULL
);


ALTER TABLE all_weather OWNER TO vagrant;

--
-- Name: all_weather_weather_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE all_weather_weather_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE all_weather_weather_id_seq OWNER TO vagrant;

--
-- Name: all_weather_weather_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE all_weather_weather_id_seq OWNED BY all_weather.weather_id;


--
-- Name: cities; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE cities (
    city_id integer NOT NULL,
    city_name character varying(50) NOT NULL,
    city_lat character varying(50) NOT NULL,
    city_long character varying(50) NOT NULL,
    country_code character varying(3) NOT NULL
);


ALTER TABLE cities OWNER TO vagrant;

--
-- Name: cities_city_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE cities_city_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE cities_city_id_seq OWNER TO vagrant;

--
-- Name: cities_city_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE cities_city_id_seq OWNED BY cities.city_id;


--
-- Name: countries; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE countries (
    country_code character varying(3) NOT NULL,
    country_name character varying(50) NOT NULL
);


ALTER TABLE countries OWNER TO vagrant;

--
-- Name: months; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE months (
    month character varying(15) NOT NULL,
    date character varying(30) NOT NULL
);


ALTER TABLE months OWNER TO vagrant;

--
-- Name: trips; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE trips (
    trip_id integer NOT NULL,
    city_id integer,
    user_id integer,
    month character varying(15)
);


ALTER TABLE trips OWNER TO vagrant;

--
-- Name: trips_trip_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE trips_trip_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE trips_trip_id_seq OWNER TO vagrant;

--
-- Name: trips_trip_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE trips_trip_id_seq OWNED BY trips.trip_id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE users (
    user_id integer NOT NULL,
    fname character varying(30) NOT NULL,
    lname character varying(30) NOT NULL,
    email character varying(40) NOT NULL,
    password character varying(30) NOT NULL
);


ALTER TABLE users OWNER TO vagrant;

--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE users_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE users_user_id_seq OWNER TO vagrant;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE users_user_id_seq OWNED BY users.user_id;


--
-- Name: weather_id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY all_weather ALTER COLUMN weather_id SET DEFAULT nextval('all_weather_weather_id_seq'::regclass);


--
-- Name: city_id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY cities ALTER COLUMN city_id SET DEFAULT nextval('cities_city_id_seq'::regclass);


--
-- Name: trip_id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY trips ALTER COLUMN trip_id SET DEFAULT nextval('trips_trip_id_seq'::regclass);


--
-- Name: user_id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY users ALTER COLUMN user_id SET DEFAULT nextval('users_user_id_seq'::regclass);


--
-- Data for Name: all_weather; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY all_weather (weather_id, city_id, month, temp_high, temp_low, summary, icon) FROM stdin;
1	1	January	60	42	Partly cloudy throughout the day.	partly-cloudy-day
2	1	February	63	45	Partly cloudy throughout the day.	partly-cloudy-day
3	1	March	70	51	Partly cloudy throughout the day.	partly-cloudy-day
4	1	April	77	58	Partly cloudy throughout the day.	partly-cloudy-day
5	1	May	84	65	Partly cloudy throughout the day.	partly-cloudy-day
6	1	June	91	72	Partly cloudy throughout the day.	partly-cloudy-day
7	1	July	92	73	Humid and partly cloudy throughout the day.	partly-cloudy-day
8	1	August	91	72	Humid and partly cloudy throughout the day.	partly-cloudy-day
9	1	September	87	68	Partly cloudy throughout the day.	partly-cloudy-day
10	1	October	77	58	Partly cloudy until evening.	partly-cloudy-day
11	1	November	67	49	Partly cloudy throughout the day.	partly-cloudy-day
12	1	December	62	44	Partly cloudy throughout the day.	partly-cloudy-day
13	2	January	41	33	Partly cloudy throughout the day.	partly-cloudy-day
14	2	February	46	36	Partly cloudy throughout the day.	partly-cloudy-day
15	2	March	53	41	Partly cloudy throughout the day.	partly-cloudy-day
16	2	April	62	48	Partly cloudy throughout the day.	partly-cloudy-day
17	2	May	72	56	Partly cloudy throughout the day.	partly-cloudy-day
18	2	June	80	62	Partly cloudy throughout the day.	partly-cloudy-day
19	2	July	84	67	Partly cloudy throughout the day.	partly-cloudy-day
20	2	August	83	67	Partly cloudy throughout the day.	partly-cloudy-day
21	2	September	75	61	Partly cloudy throughout the day.	partly-cloudy-day
22	2	October	64	52	Partly cloudy throughout the day.	partly-cloudy-day
23	2	November	51	42	Partly cloudy throughout the day.	partly-cloudy-day
24	2	December	43	35	Partly cloudy throughout the day.	partly-cloudy-day
25	3	January	41	32	Partly cloudy throughout the day.	partly-cloudy-day
26	3	February	46	36	Partly cloudy throughout the day.	partly-cloudy-day
27	3	March	51	41	Partly cloudy throughout the day.	partly-cloudy-day
28	3	April	58	47	Partly cloudy throughout the day.	partly-cloudy-day
29	3	May	65	54	Partly cloudy throughout the day.	partly-cloudy-day
30	3	June	73	61	Partly cloudy throughout the day.	partly-cloudy-day
31	3	July	78	65	Partly cloudy throughout the day.	partly-cloudy-day
32	3	August	76	64	Partly cloudy throughout the day.	partly-cloudy-day
33	3	September	70	59	Partly cloudy throughout the day.	partly-cloudy-day
34	3	October	61	51	Partly cloudy throughout the day.	partly-cloudy-day
35	3	November	50	40	Partly cloudy throughout the day.	partly-cloudy-day
36	3	December	42	33	Partly cloudy throughout the day.	partly-cloudy-day
37	4	January	56	44	Partly cloudy throughout the day.	partly-cloudy-day
38	4	February	57	45	Partly cloudy throughout the day.	partly-cloudy-day
39	4	March	64	52	Partly cloudy throughout the day.	partly-cloudy-day
40	4	April	71	59	Partly cloudy throughout the day.	partly-cloudy-day
41	4	May	79	67	Partly cloudy throughout the day.	partly-cloudy-day
42	4	June	85	74	Partly cloudy throughout the day.	partly-cloudy-day
43	4	July	88	76	Humid and partly cloudy throughout the day.	partly-cloudy-day
44	4	August	87	76	Humid throughout the day and partly cloudy until evening.	partly-cloudy-day
45	4	September	82	70	Partly cloudy throughout the day.	partly-cloudy-day
46	4	October	74	62	Partly cloudy until evening.	partly-cloudy-day
47	4	November	65	53	Partly cloudy throughout the day.	partly-cloudy-day
48	4	December	58	46	Partly cloudy throughout the day.	partly-cloudy-day
49	5	January	18	6	Partly cloudy throughout the day.	partly-cloudy-day
50	5	February	23	9	Partly cloudy throughout the day.	partly-cloudy-day
51	5	March	35	20	Partly cloudy throughout the day.	partly-cloudy-day
52	5	April	51	34	Partly cloudy throughout the day.	partly-cloudy-day
53	5	May	65	47	Partly cloudy throughout the day.	partly-cloudy-day
54	5	June	75	57	Partly cloudy throughout the day.	partly-cloudy-day
55	5	July	78	60	Partly cloudy throughout the day.	partly-cloudy-day
56	5	August	76	60	Partly cloudy throughout the day.	partly-cloudy-day
57	5	September	67	52	Partly cloudy throughout the day.	partly-cloudy-day
58	5	October	53	40	Partly cloudy throughout the day.	partly-cloudy-day
59	5	November	36	24	Partly cloudy throughout the day.	partly-cloudy-day
60	5	December	22	11	Partly cloudy throughout the day.	partly-cloudy-day
61	7	January	84	70	Partly cloudy throughout the day.	partly-cloudy-day
62	7	February	86	73	Partly cloudy until evening.	partly-cloudy-day
63	7	March	90	76	Humid throughout the day and partly cloudy until evening.	partly-cloudy-day
64	7	April	95	81	Humid and partly cloudy throughout the day.	partly-cloudy-day
65	7	May	97	83	Humid and partly cloudy throughout the day.	partly-cloudy-day
66	7	June	96	83	Humid and partly cloudy throughout the day.	partly-cloudy-day
67	7	July	94	82	Humid and mostly cloudy throughout the day.	partly-cloudy-day
68	7	August	93	80	Humid and mostly cloudy throughout the day.	partly-cloudy-day
69	7	September	91	79	Humid and partly cloudy throughout the day.	partly-cloudy-day
70	7	October	89	77	Humid and partly cloudy throughout the day.	partly-cloudy-day
71	7	November	86	74	Humid and partly cloudy throughout the day.	partly-cloudy-day
72	7	December	84	71	Partly cloudy throughout the day.	partly-cloudy-day
73	8	January	60	42	Partly cloudy throughout the day.	partly-cloudy-day
74	8	February	63	45	Partly cloudy throughout the day.	partly-cloudy-day
75	8	March	70	51	Partly cloudy throughout the day.	partly-cloudy-day
76	8	April	76	58	Partly cloudy throughout the day.	partly-cloudy-day
77	8	May	84	65	Partly cloudy throughout the day.	partly-cloudy-day
78	8	June	91	72	Partly cloudy throughout the day.	partly-cloudy-day
79	8	July	92	73	Humid and partly cloudy throughout the day.	partly-cloudy-day
80	8	August	90	72	Humid and partly cloudy throughout the day.	partly-cloudy-day
81	8	September	86	68	Partly cloudy throughout the day.	partly-cloudy-day
82	8	October	77	59	Partly cloudy until evening.	partly-cloudy-day
83	8	November	67	49	Partly cloudy throughout the day.	partly-cloudy-day
84	8	December	62	44	Partly cloudy throughout the day.	partly-cloudy-day
85	9	January	42	32	Partly cloudy throughout the day.	partly-cloudy-day
86	9	February	45	35	Partly cloudy throughout the day.	partly-cloudy-day
87	9	March	52	41	Partly cloudy throughout the day.	partly-cloudy-day
88	9	April	62	50	Partly cloudy throughout the day.	partly-cloudy-day
89	9	May	71	59	Partly cloudy throughout the day.	partly-cloudy-day
90	9	June	79	66	Partly cloudy throughout the day.	partly-cloudy-day
91	9	July	83	70	Partly cloudy throughout the day.	partly-cloudy-day
92	9	August	81	69	Partly cloudy throughout the day.	partly-cloudy-day
93	9	September	74	62	Partly cloudy throughout the day.	partly-cloudy-day
94	9	October	64	53	Partly cloudy throughout the day.	partly-cloudy-day
95	9	November	53	42	Partly cloudy throughout the day.	partly-cloudy-day
96	9	December	44	34	Partly cloudy throughout the day.	partly-cloudy-day
97	10	January	81	71	Mostly cloudy throughout the day.	partly-cloudy-day
98	10	February	82	72	Partly cloudy throughout the day.	partly-cloudy-day
99	10	March	81	70	Partly cloudy throughout the day.	partly-cloudy-day
100	10	April	78	65	Partly cloudy throughout the day.	partly-cloudy-day
101	10	May	74	60	Partly cloudy throughout the day.	partly-cloudy-day
102	10	June	71	57	Partly cloudy throughout the day.	partly-cloudy-day
103	10	July	70	56	Partly cloudy throughout the day.	partly-cloudy-day
104	10	August	72	58	Partly cloudy throughout the day.	partly-cloudy-day
105	10	September	74	61	Partly cloudy throughout the day.	partly-cloudy-day
106	10	October	76	64	Mostly cloudy throughout the day.	partly-cloudy-day
107	10	November	77	67	Mostly cloudy throughout the day.	partly-cloudy-day
108	10	December	79	69	Mostly cloudy throughout the day.	partly-cloudy-day
109	11	January	88	74	Humid and partly cloudy throughout the day.	partly-cloudy-day
110	11	February	88	74	Humid and partly cloudy throughout the day.	partly-cloudy-day
111	11	March	89	76	Humid and partly cloudy throughout the day.	partly-cloudy-day
112	11	April	89	77	Humid and partly cloudy throughout the day.	partly-cloudy-day
113	11	May	88	79	Humid and partly cloudy throughout the day.	partly-cloudy-day
114	11	June	87	80	Humid and partly cloudy throughout the day.	partly-cloudy-day
115	11	July	86	80	Humid and partly cloudy throughout the day.	partly-cloudy-day
116	11	August	86	79	Humid and partly cloudy throughout the day.	partly-cloudy-day
117	11	September	85	78	Humid and partly cloudy throughout the day.	partly-cloudy-day
118	11	October	85	76	Humid and partly cloudy throughout the day.	partly-cloudy-day
119	11	November	86	75	Humid and partly cloudy throughout the day.	partly-cloudy-day
120	11	December	87	74	Humid and partly cloudy throughout the day.	partly-cloudy-day
121	12	January	53	44	Mostly cloudy throughout the day.	partly-cloudy-day
122	12	February	53	44	Mostly cloudy throughout the day.	partly-cloudy-day
123	12	March	56	47	Partly cloudy throughout the day.	partly-cloudy-day
124	12	April	59	49	Partly cloudy throughout the day.	partly-cloudy-day
125	12	May	63	54	Mostly cloudy throughout the day.	partly-cloudy-day
126	12	June	68	58	Mostly cloudy throughout the day.	partly-cloudy-day
127	12	July	72	62	Partly cloudy throughout the day.	partly-cloudy-day
128	12	August	74	64	Partly cloudy throughout the day.	partly-cloudy-day
129	12	September	70	60	Partly cloudy throughout the day.	partly-cloudy-day
130	12	October	65	56	Partly cloudy throughout the day.	partly-cloudy-day
131	12	November	59	49	Mostly cloudy throughout the day.	partly-cloudy-day
132	12	December	55	45	Mostly cloudy throughout the day.	partly-cloudy-day
133	13	January	51	35	Partly cloudy throughout the day.	partly-cloudy-day
134	13	February	55	39	Partly cloudy throughout the day.	partly-cloudy-day
135	13	March	63	46	Partly cloudy throughout the day.	partly-cloudy-day
136	13	April	71	54	Partly cloudy throughout the day.	partly-cloudy-day
137	13	May	79	61	Partly cloudy throughout the day.	partly-cloudy-day
138	13	June	86	68	Partly cloudy throughout the day.	partly-cloudy-day
139	13	July	89	71	Partly cloudy throughout the day.	partly-cloudy-day
140	13	August	87	71	Partly cloudy throughout the day.	partly-cloudy-day
141	13	September	82	65	Partly cloudy throughout the day.	partly-cloudy-day
142	13	October	71	55	Partly cloudy throughout the day.	partly-cloudy-day
143	13	November	60	44	Partly cloudy throughout the day.	partly-cloudy-day
144	13	December	53	38	Partly cloudy throughout the day.	partly-cloudy-day
145	14	January	74	53	Foggy overnight.	fog
146	14	February	80	57	Clear throughout the day.	clear-day
147	14	March	88	66	Clear throughout the day.	clear-day
148	14	April	93	74	Partly cloudy until evening.	partly-cloudy-day
149	14	May	93	78	Humid and partly cloudy throughout the day.	partly-cloudy-day
150	14	June	89	79	Humid and mostly cloudy throughout the day.	partly-cloudy-day
151	14	July	87	79	Humid and mostly cloudy throughout the day.	partly-cloudy-day
152	14	August	87	81	Humid and mostly cloudy throughout the day.	partly-cloudy-day
153	14	September	87	80	Humid and mostly cloudy throughout the day.	partly-cloudy-day
154	14	October	85	75	Humid and partly cloudy throughout the day.	partly-cloudy-day
155	14	November	80	65	Partly cloudy until afternoon.	partly-cloudy-day
156	14	December	75	56	Foggy overnight.	fog
157	15	January	53	43	Mostly cloudy throughout the day.	partly-cloudy-day
158	15	February	53	44	Mostly cloudy throughout the day.	partly-cloudy-day
159	15	March	57	48	Mostly cloudy throughout the day.	partly-cloudy-day
160	15	April	60	51	Mostly cloudy throughout the day.	partly-cloudy-day
161	15	May	65	56	Mostly cloudy throughout the day.	partly-cloudy-day
162	15	June	71	61	Mostly cloudy throughout the day.	partly-cloudy-day
163	15	July	74	64	Mostly cloudy throughout the day.	partly-cloudy-day
164	15	August	76	66	Mostly cloudy throughout the day.	partly-cloudy-day
165	15	September	72	62	Partly cloudy throughout the day.	partly-cloudy-day
166	15	October	66	57	Mostly cloudy throughout the day.	partly-cloudy-day
167	15	November	58	49	Mostly cloudy throughout the day.	partly-cloudy-day
168	15	December	54	44	Mostly cloudy throughout the day.	partly-cloudy-day
169	16	January	57	42	Partly cloudy throughout the day.	partly-cloudy-day
170	16	February	58	44	Partly cloudy throughout the day.	partly-cloudy-day
171	16	March	66	51	Partly cloudy throughout the day.	partly-cloudy-day
172	16	April	73	58	Partly cloudy throughout the day.	partly-cloudy-day
173	16	May	81	66	Partly cloudy throughout the day.	partly-cloudy-day
174	16	June	87	73	Partly cloudy throughout the day.	partly-cloudy-day
175	16	July	89	75	Humid and partly cloudy throughout the day.	partly-cloudy-day
176	16	August	89	75	Humid and partly cloudy throughout the day.	partly-cloudy-day
177	16	September	83	69	Partly cloudy throughout the day.	partly-cloudy-day
178	16	October	75	60	Partly cloudy throughout the day.	partly-cloudy-day
179	16	November	65	51	Partly cloudy throughout the day.	partly-cloudy-day
180	16	December	58	44	Partly cloudy throughout the day.	partly-cloudy-day
181	17	January	59	35	Partly cloudy until evening.	partly-cloudy-day
182	17	February	62	38	Partly cloudy until evening.	partly-cloudy-day
183	17	March	67	43	Partly cloudy starting in the afternoon, continuing until evening.	partly-cloudy-day
184	17	April	73	49	Clear throughout the day.	clear-day
185	17	May	84	60	Clear throughout the day.	clear-day
186	17	June	91	67	Clear throughout the day.	clear-day
187	17	July	92	68	Partly cloudy throughout the day.	partly-cloudy-day
188	17	August	89	65	Partly cloudy throughout the day.	partly-cloudy-day
189	17	September	85	61	Partly cloudy starting in the afternoon, continuing until evening.	partly-cloudy-day
190	17	October	78	54	Clear throughout the day.	clear-day
191	17	November	66	42	Clear throughout the day.	clear-day
192	17	December	59	35	Partly cloudy throughout the day.	partly-cloudy-day
193	18	January	34	24	Partly cloudy throughout the day.	partly-cloudy-day
194	18	February	36	25	Partly cloudy throughout the day.	partly-cloudy-day
195	18	March	43	31	Partly cloudy throughout the day.	partly-cloudy-day
196	18	April	54	41	Partly cloudy throughout the day.	partly-cloudy-day
197	18	May	64	51	Partly cloudy throughout the day.	partly-cloudy-day
198	18	June	74	60	Partly cloudy throughout the day.	partly-cloudy-day
199	18	July	80	66	Partly cloudy throughout the day.	partly-cloudy-day
200	18	August	78	65	Partly cloudy throughout the day.	partly-cloudy-day
201	18	September	70	58	Partly cloudy throughout the day.	partly-cloudy-day
202	18	October	60	48	Partly cloudy throughout the day.	partly-cloudy-day
203	18	November	49	39	Partly cloudy throughout the day.	partly-cloudy-day
204	18	December	39	29	Partly cloudy throughout the day.	partly-cloudy-day
205	19	January	50	34	Partly cloudy throughout the day.	partly-cloudy-day
206	19	February	54	36	Partly cloudy throughout the day.	partly-cloudy-day
207	19	March	61	44	Partly cloudy throughout the day.	partly-cloudy-day
208	19	April	70	52	Partly cloudy throughout the day.	partly-cloudy-day
209	19	May	79	60	Partly cloudy throughout the day.	partly-cloudy-day
210	19	June	87	68	Partly cloudy throughout the day.	partly-cloudy-day
211	19	July	89	71	Partly cloudy throughout the day.	partly-cloudy-day
212	19	August	87	69	Partly cloudy throughout the day.	partly-cloudy-day
213	19	September	81	64	Partly cloudy throughout the day.	partly-cloudy-day
214	19	October	71	54	Partly cloudy throughout the day.	partly-cloudy-day
215	19	November	60	43	Partly cloudy throughout the day.	partly-cloudy-day
216	19	December	53	36	Partly cloudy throughout the day.	partly-cloudy-day
217	20	January	81	56	Clear throughout the day.	clear-day
218	20	February	87	61	Clear throughout the day.	clear-day
219	20	March	95	70	Clear throughout the day.	clear-day
220	20	April	103	80	Clear throughout the day.	clear-day
221	20	May	104	83	Clear throughout the day.	clear-day
222	20	June	99	81	Humid and partly cloudy throughout the day.	partly-cloudy-day
223	20	July	94	78	Humid and mostly cloudy throughout the day.	partly-cloudy-day
224	20	August	93	77	Humid and mostly cloudy throughout the day.	partly-cloudy-day
225	20	September	94	78	Humid and partly cloudy throughout the day.	partly-cloudy-day
226	20	October	94	75	Clear throughout the day.	clear-day
227	20	November	89	68	Clear throughout the day.	clear-day
228	20	December	83	60	Clear throughout the day.	clear-day
229	21	January	55	39	Partly cloudy throughout the day.	partly-cloudy-day
230	21	February	58	41	Partly cloudy throughout the day.	partly-cloudy-day
231	21	March	62	45	Partly cloudy throughout the day.	partly-cloudy-day
232	21	April	68	49	Partly cloudy throughout the day.	partly-cloudy-day
233	21	May	76	56	Partly cloudy throughout the day.	partly-cloudy-day
234	21	June	84	64	Partly cloudy throughout the day.	partly-cloudy-day
235	21	July	90	69	Partly cloudy throughout the day.	partly-cloudy-day
236	21	August	90	70	Partly cloudy throughout the day.	partly-cloudy-day
237	21	September	83	63	Partly cloudy throughout the day.	partly-cloudy-day
238	21	October	72	54	Partly cloudy throughout the day.	partly-cloudy-day
239	21	November	62	44	Partly cloudy throughout the day.	partly-cloudy-day
240	21	December	56	39	Partly cloudy throughout the day.	partly-cloudy-day
241	22	January	85	70	Partly cloudy throughout the day.	partly-cloudy-day
242	22	February	84	69	Partly cloudy throughout the day.	partly-cloudy-day
243	22	March	81	65	Partly cloudy throughout the day.	partly-cloudy-day
244	22	April	76	60	Partly cloudy throughout the day.	partly-cloudy-day
245	22	May	72	54	Partly cloudy throughout the day.	partly-cloudy-day
246	22	June	68	50	Partly cloudy throughout the day.	partly-cloudy-day
247	22	July	67	48	Partly cloudy throughout the day.	partly-cloudy-day
248	22	August	69	50	Partly cloudy throughout the day.	partly-cloudy-day
249	22	September	73	55	Partly cloudy throughout the day.	partly-cloudy-day
250	22	October	78	60	Partly cloudy throughout the day.	partly-cloudy-day
251	22	November	82	65	Partly cloudy throughout the day.	partly-cloudy-day
252	22	December	84	68	Partly cloudy throughout the day.	partly-cloudy-day
253	23	January	87	76	Humid and mostly cloudy throughout the day.	partly-cloudy-day
254	23	February	88	76	Humid and mostly cloudy throughout the day.	partly-cloudy-day
255	23	March	88	77	Humid and mostly cloudy throughout the day.	partly-cloudy-day
256	23	April	89	77	Humid and mostly cloudy throughout the day.	partly-cloudy-day
257	23	May	89	77	Humid and mostly cloudy throughout the day.	partly-cloudy-day
258	23	June	88	77	Humid and mostly cloudy throughout the day.	partly-cloudy-day
259	23	July	88	77	Humid and mostly cloudy throughout the day.	partly-cloudy-day
260	23	August	87	76	Humid and mostly cloudy throughout the day.	partly-cloudy-day
261	23	September	87	76	Humid and mostly cloudy throughout the day.	partly-cloudy-day
262	23	October	86	75	Humid and mostly cloudy throughout the day.	partly-cloudy-day
263	23	November	86	75	Humid and mostly cloudy throughout the day.	partly-cloudy-day
264	23	December	87	75	Humid and mostly cloudy throughout the day.	partly-cloudy-day
265	24	January	17	8	Partly cloudy throughout the day.	partly-cloudy-day
266	24	February	21	11	Partly cloudy throughout the day.	partly-cloudy-day
267	24	March	31	19	Partly cloudy throughout the day.	partly-cloudy-day
268	24	April	46	33	Partly cloudy throughout the day.	partly-cloudy-day
269	24	May	59	43	Partly cloudy throughout the day.	partly-cloudy-day
270	24	June	67	51	Partly cloudy throughout the day.	partly-cloudy-day
271	24	July	72	55	Partly cloudy throughout the day.	partly-cloudy-day
272	24	August	68	52	Partly cloudy throughout the day.	partly-cloudy-day
273	24	September	58	43	Partly cloudy throughout the day.	partly-cloudy-day
274	24	October	46	34	Partly cloudy throughout the day.	partly-cloudy-day
275	24	November	30	20	Partly cloudy throughout the day.	partly-cloudy-day
276	24	December	18	10	Partly cloudy throughout the day.	partly-cloudy-day
277	25	January	35	24	Partly cloudy throughout the day.	partly-cloudy-day
278	25	February	36	25	Partly cloudy throughout the day.	partly-cloudy-day
279	25	March	44	31	Partly cloudy throughout the day.	partly-cloudy-day
280	25	April	55	42	Partly cloudy throughout the day.	partly-cloudy-day
281	25	May	67	52	Partly cloudy throughout the day.	partly-cloudy-day
282	25	June	77	61	Partly cloudy throughout the day.	partly-cloudy-day
283	25	July	82	66	Partly cloudy throughout the day.	partly-cloudy-day
284	25	August	80	65	Partly cloudy throughout the day.	partly-cloudy-day
285	25	September	72	58	Partly cloudy throughout the day.	partly-cloudy-day
286	25	October	61	48	Partly cloudy throughout the day.	partly-cloudy-day
287	25	November	49	37	Partly cloudy throughout the day.	partly-cloudy-day
288	25	December	39	29	Partly cloudy throughout the day.	partly-cloudy-day
289	27	January	44	40	Mostly cloudy throughout the day.	partly-cloudy-day
290	27	February	46	41	Mostly cloudy throughout the day.	partly-cloudy-day
291	27	March	50	43	Mostly cloudy throughout the day.	partly-cloudy-day
292	27	April	54	46	Mostly cloudy throughout the day.	partly-cloudy-day
293	27	May	60	49	Mostly cloudy throughout the day.	partly-cloudy-day
294	27	June	65	54	Mostly cloudy throughout the day.	partly-cloudy-day
295	27	July	69	58	Partly cloudy throughout the day.	partly-cloudy-day
296	27	August	70	59	Partly cloudy throughout the day.	partly-cloudy-day
297	27	September	65	56	Partly cloudy throughout the day.	partly-cloudy-day
298	27	October	57	50	Mostly cloudy throughout the day.	partly-cloudy-day
299	27	November	49	44	Mostly cloudy throughout the day.	partly-cloudy-day
300	27	December	45	41	Mostly cloudy throughout the day.	partly-cloudy-day
301	28	January	74	61	Partly cloudy throughout the day.	partly-cloudy-day
302	28	February	75	62	Partly cloudy throughout the day.	partly-cloudy-day
303	28	March	74	60	Partly cloudy throughout the day.	partly-cloudy-day
304	28	April	71	57	Partly cloudy throughout the day.	partly-cloudy-day
305	28	May	68	54	Partly cloudy throughout the day.	partly-cloudy-day
306	28	June	65	51	Partly cloudy throughout the day.	partly-cloudy-day
307	28	July	64	49	Partly cloudy throughout the day.	partly-cloudy-day
308	28	August	63	49	Partly cloudy throughout the day.	partly-cloudy-day
309	28	September	64	51	Partly cloudy throughout the day.	partly-cloudy-day
310	28	October	67	54	Partly cloudy throughout the day.	partly-cloudy-day
311	28	November	70	57	Mostly cloudy throughout the day.	partly-cloudy-day
312	28	December	73	60	Partly cloudy throughout the day.	partly-cloudy-day
313	29	January	49	35	Partly cloudy throughout the day.	partly-cloudy-day
314	29	February	52	37	Partly cloudy throughout the day.	partly-cloudy-day
315	29	March	57	40	Partly cloudy throughout the day.	partly-cloudy-day
316	29	April	63	45	Partly cloudy throughout the day.	partly-cloudy-day
317	29	May	72	51	Partly cloudy throughout the day.	partly-cloudy-day
318	29	June	82	59	Partly cloudy throughout the day.	partly-cloudy-day
319	29	July	89	65	Partly cloudy throughout the day.	partly-cloudy-day
320	29	August	89	66	Partly cloudy throughout the day.	partly-cloudy-day
321	29	September	80	59	Partly cloudy throughout the day.	partly-cloudy-day
322	29	October	68	49	Partly cloudy throughout the day.	partly-cloudy-day
323	29	November	56	39	Partly cloudy throughout the day.	partly-cloudy-day
324	29	December	49	35	Partly cloudy throughout the day.	partly-cloudy-day
325	30	January	41	22	Partly cloudy throughout the day.	partly-cloudy-day
326	30	February	43	24	Partly cloudy throughout the day.	partly-cloudy-day
327	30	March	49	29	Partly cloudy throughout the day.	partly-cloudy-day
328	30	April	58	38	Partly cloudy throughout the day.	partly-cloudy-day
329	30	May	69	47	Partly cloudy throughout the day.	partly-cloudy-day
330	30	June	78	57	Partly cloudy throughout the day.	partly-cloudy-day
331	30	July	85	63	Partly cloudy throughout the day.	partly-cloudy-day
332	30	August	84	62	Partly cloudy throughout the day.	partly-cloudy-day
333	30	September	75	54	Partly cloudy throughout the day.	partly-cloudy-day
334	30	October	63	42	Partly cloudy throughout the day.	partly-cloudy-day
335	30	November	50	30	Partly cloudy throughout the day.	partly-cloudy-day
336	30	December	42	23	Partly cloudy throughout the day.	partly-cloudy-day
337	31	January	87	72	Partly cloudy throughout the day.	partly-cloudy-day
338	31	February	89	74	Partly cloudy throughout the day.	partly-cloudy-day
339	31	March	91	76	Humid and partly cloudy throughout the day.	partly-cloudy-day
340	31	April	93	78	Humid and partly cloudy throughout the day.	partly-cloudy-day
341	31	May	93	78	Humid and mostly cloudy throughout the day.	partly-cloudy-day
342	31	June	91	77	Humid and mostly cloudy throughout the day.	partly-cloudy-day
343	31	July	89	76	Humid and mostly cloudy throughout the day.	partly-cloudy-day
344	31	August	88	76	Humid and mostly cloudy throughout the day.	partly-cloudy-day
345	31	September	88	76	Humid and mostly cloudy throughout the day.	partly-cloudy-day
346	31	October	88	75	Humid and mostly cloudy throughout the day.	partly-cloudy-day
347	31	November	87	74	Humid and mostly cloudy throughout the day.	partly-cloudy-day
348	31	December	87	72	Partly cloudy throughout the day.	partly-cloudy-day
349	32	January	79	64	Mostly cloudy throughout the day.	partly-cloudy-day
350	32	February	79	65	Mostly cloudy throughout the day.	partly-cloudy-day
351	32	March	77	62	Mostly cloudy throughout the day.	partly-cloudy-day
352	32	April	73	58	Mostly cloudy throughout the day.	partly-cloudy-day
353	32	May	68	53	Mostly cloudy throughout the day.	partly-cloudy-day
354	32	June	66	51	Mostly cloudy throughout the day.	partly-cloudy-day
355	32	July	65	50	Mostly cloudy throughout the day.	partly-cloudy-day
356	32	August	67	52	Mostly cloudy throughout the day.	partly-cloudy-day
357	32	September	69	54	Mostly cloudy throughout the day.	partly-cloudy-day
358	32	October	72	57	Mostly cloudy throughout the day.	partly-cloudy-day
359	32	November	74	59	Mostly cloudy throughout the day.	partly-cloudy-day
360	32	December	77	63	Mostly cloudy throughout the day.	partly-cloudy-day
361	33	January	47	33	Partly cloudy throughout the day.	partly-cloudy-day
362	33	February	51	36	Partly cloudy throughout the day.	partly-cloudy-day
363	33	March	60	44	Partly cloudy throughout the day.	partly-cloudy-day
364	33	April	70	54	Partly cloudy throughout the day.	partly-cloudy-day
365	33	May	80	63	Partly cloudy throughout the day.	partly-cloudy-day
366	33	June	87	70	Partly cloudy until evening.	partly-cloudy-day
367	33	July	91	73	Partly cloudy until evening.	partly-cloudy-day
368	33	August	90	73	Partly cloudy until evening.	partly-cloudy-day
369	33	September	82	66	Partly cloudy throughout the day.	partly-cloudy-day
370	33	October	71	56	Partly cloudy throughout the day.	partly-cloudy-day
371	33	November	58	44	Partly cloudy throughout the day.	partly-cloudy-day
372	33	December	50	35	Partly cloudy throughout the day.	partly-cloudy-day
373	34	January	38	34	Mostly cloudy throughout the day.	partly-cloudy-day
374	34	February	41	35	Mostly cloudy throughout the day.	partly-cloudy-day
375	34	March	46	38	Mostly cloudy throughout the day.	partly-cloudy-day
376	34	April	55	43	Mostly cloudy throughout the day.	partly-cloudy-day
377	34	May	63	49	Mostly cloudy throughout the day.	partly-cloudy-day
378	34	June	70	55	Mostly cloudy throughout the day.	partly-cloudy-day
379	34	July	73	58	Mostly cloudy throughout the day.	partly-cloudy-day
380	34	August	71	57	Partly cloudy throughout the day.	partly-cloudy-day
381	34	September	64	54	Mostly cloudy throughout the day.	partly-cloudy-day
382	34	October	56	48	Mostly cloudy throughout the day.	partly-cloudy-day
383	34	November	47	41	Mostly cloudy throughout the day.	partly-cloudy-day
384	34	December	41	36	Mostly cloudy throughout the day.	partly-cloudy-day
385	35	January	34	28	Mostly cloudy throughout the day.	partly-cloudy-day
386	35	February	36	29	Mostly cloudy throughout the day.	partly-cloudy-day
387	35	March	45	35	Mostly cloudy throughout the day.	partly-cloudy-day
388	35	April	57	44	Partly cloudy throughout the day.	partly-cloudy-day
389	35	May	67	52	Mostly cloudy throughout the day.	partly-cloudy-day
390	35	June	74	57	Mostly cloudy throughout the day.	partly-cloudy-day
391	35	July	77	61	Partly cloudy throughout the day.	partly-cloudy-day
392	35	August	75	60	Partly cloudy throughout the day.	partly-cloudy-day
393	35	September	66	54	Partly cloudy throughout the day.	partly-cloudy-day
394	35	October	54	45	Partly cloudy throughout the day.	partly-cloudy-day
395	35	November	44	37	Mostly cloudy throughout the day.	partly-cloudy-day
396	35	December	37	32	Mostly cloudy throughout the day.	partly-cloudy-day
397	36	January	63	54	Partly cloudy throughout the day.	partly-cloudy-day
398	36	February	65	56	Mostly cloudy throughout the day.	partly-cloudy-day
399	36	March	70	62	Mostly cloudy throughout the day.	partly-cloudy-day
400	36	April	78	70	Mostly cloudy throughout the day.	partly-cloudy-day
401	36	May	83	75	Humid and mostly cloudy throughout the day.	partly-cloudy-day
402	36	June	87	79	Humid and mostly cloudy throughout the day.	partly-cloudy-day
403	36	July	89	80	Humid and partly cloudy throughout the day.	partly-cloudy-day
404	36	August	89	80	Humid and partly cloudy throughout the day.	partly-cloudy-day
405	36	September	88	78	Humid and partly cloudy throughout the day.	partly-cloudy-day
406	36	October	83	73	Partly cloudy throughout the day.	partly-cloudy-day
407	36	November	75	65	Partly cloudy throughout the day.	partly-cloudy-day
408	36	December	67	57	Partly cloudy throughout the day.	partly-cloudy-day
409	37	January	72	60	Partly cloudy throughout the day.	partly-cloudy-day
410	37	February	74	61	Partly cloudy throughout the day.	partly-cloudy-day
411	37	March	77	65	Partly cloudy throughout the day.	partly-cloudy-day
412	37	April	81	69	Partly cloudy throughout the day.	partly-cloudy-day
413	37	May	85	72	Partly cloudy throughout the day.	partly-cloudy-day
414	37	June	87	75	Humid and partly cloudy throughout the day.	partly-cloudy-day
415	37	July	88	77	Humid and partly cloudy throughout the day.	partly-cloudy-day
416	37	August	89	78	Humid and partly cloudy throughout the day.	partly-cloudy-day
417	37	September	87	77	Humid and partly cloudy throughout the day.	partly-cloudy-day
418	37	October	83	73	Partly cloudy throughout the day.	partly-cloudy-day
419	37	November	78	67	Partly cloudy throughout the day.	partly-cloudy-day
420	37	December	74	63	Partly cloudy throughout the day.	partly-cloudy-day
421	38	January	88	75	Humid and mostly cloudy throughout the day.	partly-cloudy-day
422	38	February	89	76	Humid and mostly cloudy throughout the day.	partly-cloudy-day
423	38	March	89	76	Humid and mostly cloudy throughout the day.	partly-cloudy-day
424	38	April	90	77	Humid and mostly cloudy throughout the day.	partly-cloudy-day
425	38	May	90	77	Humid and mostly cloudy throughout the day.	partly-cloudy-day
426	38	June	90	77	Humid and mostly cloudy throughout the day.	partly-cloudy-day
427	38	July	89	77	Humid and mostly cloudy throughout the day.	partly-cloudy-day
428	38	August	89	76	Humid and mostly cloudy throughout the day.	partly-cloudy-day
429	38	September	88	75	Humid and mostly cloudy throughout the day.	partly-cloudy-day
430	38	October	88	75	Humid and mostly cloudy throughout the day.	partly-cloudy-day
431	38	November	88	75	Humid and mostly cloudy throughout the day.	partly-cloudy-day
432	38	December	88	75	Humid and mostly cloudy throughout the day.	partly-cloudy-day
433	39	January	73	61	Partly cloudy throughout the day.	partly-cloudy-day
434	39	February	73	62	Partly cloudy throughout the day.	partly-cloudy-day
435	39	March	71	60	Partly cloudy throughout the day.	partly-cloudy-day
436	39	April	67	56	Partly cloudy throughout the day.	partly-cloudy-day
437	39	May	62	51	Partly cloudy throughout the day.	partly-cloudy-day
438	39	June	58	48	Partly cloudy throughout the day.	partly-cloudy-day
439	39	July	57	47	Partly cloudy throughout the day.	partly-cloudy-day
440	39	August	57	48	Partly cloudy throughout the day.	partly-cloudy-day
441	39	September	60	50	Partly cloudy throughout the day.	partly-cloudy-day
442	39	October	63	53	Partly cloudy throughout the day.	partly-cloudy-day
443	39	November	67	56	Partly cloudy throughout the day.	partly-cloudy-day
444	39	December	70	59	Partly cloudy throughout the day.	partly-cloudy-day
445	40	January	40	21	Partly cloudy throughout the day.	partly-cloudy-day
446	40	February	42	23	Partly cloudy throughout the day.	partly-cloudy-day
447	40	March	48	29	Partly cloudy throughout the day.	partly-cloudy-day
448	40	April	58	37	Partly cloudy throughout the day.	partly-cloudy-day
449	40	May	67	46	Partly cloudy throughout the day.	partly-cloudy-day
450	40	June	77	55	Partly cloudy throughout the day.	partly-cloudy-day
451	40	July	83	61	Partly cloudy throughout the day.	partly-cloudy-day
452	40	August	82	60	Partly cloudy throughout the day.	partly-cloudy-day
453	40	September	74	52	Partly cloudy throughout the day.	partly-cloudy-day
454	40	October	62	41	Partly cloudy throughout the day.	partly-cloudy-day
455	40	November	49	29	Partly cloudy throughout the day.	partly-cloudy-day
456	40	December	42	22	Partly cloudy throughout the day.	partly-cloudy-day
457	41	January	54	37	Partly cloudy throughout the day.	partly-cloudy-day
458	41	February	58	41	Partly cloudy throughout the day.	partly-cloudy-day
459	41	March	65	48	Partly cloudy throughout the day.	partly-cloudy-day
460	41	April	74	55	Partly cloudy throughout the day.	partly-cloudy-day
461	41	May	81	63	Partly cloudy throughout the day.	partly-cloudy-day
462	41	June	88	70	Partly cloudy throughout the day.	partly-cloudy-day
463	41	July	91	73	Humid and partly cloudy throughout the day.	partly-cloudy-day
464	41	August	90	72	Partly cloudy throughout the day.	partly-cloudy-day
465	41	September	84	67	Partly cloudy throughout the day.	partly-cloudy-day
466	41	October	74	56	Partly cloudy throughout the day.	partly-cloudy-day
467	41	November	62	45	Partly cloudy throughout the day.	partly-cloudy-day
468	41	December	56	39	Partly cloudy throughout the day.	partly-cloudy-day
469	42	January	40	34	Mostly cloudy throughout the day.	partly-cloudy-day
470	42	February	42	35	Mostly cloudy throughout the day.	partly-cloudy-day
471	42	March	47	38	Mostly cloudy throughout the day.	partly-cloudy-day
472	42	April	56	44	Partly cloudy throughout the day.	partly-cloudy-day
473	42	May	64	49	Partly cloudy throughout the day.	partly-cloudy-day
474	42	June	71	54	Mostly cloudy throughout the day.	partly-cloudy-day
475	42	July	73	57	Partly cloudy throughout the day.	partly-cloudy-day
476	42	August	71	56	Partly cloudy throughout the day.	partly-cloudy-day
477	42	September	65	53	Partly cloudy throughout the day.	partly-cloudy-day
478	42	October	57	48	Mostly cloudy throughout the day.	partly-cloudy-day
479	42	November	48	42	Mostly cloudy throughout the day.	partly-cloudy-day
480	42	December	42	37	Mostly cloudy throughout the day.	partly-cloudy-day
481	43	January	79	60	Partly cloudy throughout the day.	partly-cloudy-day
482	43	February	79	60	Partly cloudy throughout the day.	partly-cloudy-day
483	43	March	77	58	Partly cloudy throughout the day.	partly-cloudy-day
484	43	April	73	53	Partly cloudy throughout the day.	partly-cloudy-day
485	43	May	67	47	Partly cloudy throughout the day.	partly-cloudy-day
486	43	June	63	41	Clear throughout the day.	clear-day
487	43	July	63	41	Partly cloudy until afternoon.	partly-cloudy-day
488	43	August	68	46	Partly cloudy until afternoon.	partly-cloudy-day
489	43	September	74	53	Partly cloudy throughout the day.	partly-cloudy-day
490	43	October	77	57	Partly cloudy throughout the day.	partly-cloudy-day
491	43	November	78	58	Partly cloudy throughout the day.	partly-cloudy-day
492	43	December	78	59	Partly cloudy throughout the day.	partly-cloudy-day
493	44	January	26	19	Mostly cloudy throughout the day.	partly-cloudy-day
494	44	February	31	23	Mostly cloudy throughout the day.	partly-cloudy-day
495	44	March	40	28	Mostly cloudy throughout the day.	partly-cloudy-day
496	44	April	51	34	Mostly cloudy throughout the day.	partly-cloudy-day
497	44	May	63	41	Mostly cloudy throughout the day.	partly-cloudy-day
498	44	June	73	48	Partly cloudy throughout the day.	partly-cloudy-day
499	44	July	79	52	Partly cloudy throughout the day.	partly-cloudy-day
500	44	August	78	52	Partly cloudy throughout the day.	partly-cloudy-day
501	44	September	68	45	Partly cloudy throughout the day.	partly-cloudy-day
502	44	October	52	35	Partly cloudy throughout the day.	partly-cloudy-day
503	44	November	37	25	Mostly cloudy throughout the day.	partly-cloudy-day
504	44	December	28	20	Mostly cloudy throughout the day.	partly-cloudy-day
505	45	January	35	29	Mostly cloudy throughout the day.	partly-cloudy-day
506	45	February	38	30	Mostly cloudy throughout the day.	partly-cloudy-day
507	45	March	44	34	Mostly cloudy throughout the day.	partly-cloudy-day
508	45	April	53	41	Partly cloudy throughout the day.	partly-cloudy-day
509	45	May	63	47	Mostly cloudy throughout the day.	partly-cloudy-day
510	45	June	70	53	Mostly cloudy throughout the day.	partly-cloudy-day
511	45	July	73	57	Partly cloudy throughout the day.	partly-cloudy-day
512	45	August	71	56	Partly cloudy throughout the day.	partly-cloudy-day
513	45	September	64	51	Partly cloudy throughout the day.	partly-cloudy-day
514	45	October	54	44	Partly cloudy throughout the day.	partly-cloudy-day
515	45	November	44	36	Mostly cloudy throughout the day.	partly-cloudy-day
516	45	December	37	31	Mostly cloudy throughout the day.	partly-cloudy-day
517	46	January	63	50	Partly cloudy throughout the day.	partly-cloudy-day
518	46	February	63	51	Partly cloudy throughout the day.	partly-cloudy-day
519	46	March	65	53	Partly cloudy throughout the day.	partly-cloudy-day
520	46	April	66	56	Partly cloudy throughout the day.	partly-cloudy-day
521	46	May	68	58	Partly cloudy throughout the day.	partly-cloudy-day
522	46	June	71	61	Partly cloudy throughout the day.	partly-cloudy-day
523	46	July	75	64	Partly cloudy throughout the day.	partly-cloudy-day
524	46	August	77	66	Partly cloudy throughout the day.	partly-cloudy-day
525	46	September	77	65	Partly cloudy throughout the day.	partly-cloudy-day
526	46	October	73	60	Partly cloudy throughout the day.	partly-cloudy-day
527	46	November	68	55	Partly cloudy throughout the day.	partly-cloudy-day
528	46	December	64	51	Partly cloudy throughout the day.	partly-cloudy-day
529	47	January	85	68	Foggy in the morning.	fog
530	47	February	86	69	Foggy in the morning.	fog
531	47	March	88	74	Clear throughout the day.	clear-day
532	47	April	90	80	Humid throughout the day.	clear-day
533	47	May	90	82	Humid and partly cloudy throughout the day.	partly-cloudy-day
534	47	June	87	82	Humid and mostly cloudy throughout the day.	partly-cloudy-day
535	47	July	84	80	Humid and mostly cloudy throughout the day.	partly-cloudy-day
536	47	August	84	79	Humid throughout the day and foggy overnight.	fog
537	47	September	86	79	Humid throughout the day and foggy overnight.	fog
538	47	October	89	79	Humid and partly cloudy throughout the day.	partly-cloudy-day
539	47	November	89	75	Foggy overnight.	fog
540	47	December	87	71	Foggy in the morning.	fog
541	48	January	49	35	Partly cloudy throughout the day.	partly-cloudy-day
542	48	February	52	37	Partly cloudy throughout the day.	partly-cloudy-day
543	48	March	57	41	Partly cloudy throughout the day.	partly-cloudy-day
544	48	April	63	45	Partly cloudy throughout the day.	partly-cloudy-day
545	48	May	72	52	Partly cloudy throughout the day.	partly-cloudy-day
546	48	June	82	60	Partly cloudy throughout the day.	partly-cloudy-day
547	48	July	88	66	Partly cloudy throughout the day.	partly-cloudy-day
548	48	August	88	67	Partly cloudy throughout the day.	partly-cloudy-day
549	48	September	80	60	Partly cloudy throughout the day.	partly-cloudy-day
550	48	October	68	49	Partly cloudy throughout the day.	partly-cloudy-day
551	48	November	56	40	Partly cloudy throughout the day.	partly-cloudy-day
552	48	December	50	35	Partly cloudy throughout the day.	partly-cloudy-day
553	49	January	28	19	Partly cloudy throughout the day.	partly-cloudy-day
554	49	February	32	22	Partly cloudy throughout the day.	partly-cloudy-day
555	49	March	41	31	Partly cloudy throughout the day.	partly-cloudy-day
556	49	April	55	43	Partly cloudy throughout the day.	partly-cloudy-day
557	49	May	68	53	Partly cloudy throughout the day.	partly-cloudy-day
558	49	June	78	62	Partly cloudy throughout the day.	partly-cloudy-day
559	49	July	82	66	Partly cloudy throughout the day.	partly-cloudy-day
560	49	August	81	65	Partly cloudy throughout the day.	partly-cloudy-day
561	49	September	73	58	Partly cloudy throughout the day.	partly-cloudy-day
562	49	October	59	47	Partly cloudy throughout the day.	partly-cloudy-day
563	49	November	45	34	Partly cloudy throughout the day.	partly-cloudy-day
564	49	December	33	24	Partly cloudy throughout the day.	partly-cloudy-day
565	50	January	36	30	Mostly cloudy throughout the day.	partly-cloudy-day
566	50	February	39	31	Mostly cloudy throughout the day.	partly-cloudy-day
567	50	March	45	36	Mostly cloudy throughout the day.	partly-cloudy-day
568	50	April	55	43	Mostly cloudy throughout the day.	partly-cloudy-day
569	50	May	65	50	Mostly cloudy throughout the day.	partly-cloudy-day
570	50	June	72	56	Partly cloudy throughout the day.	partly-cloudy-day
571	50	July	74	59	Partly cloudy throughout the day.	partly-cloudy-day
572	50	August	71	58	Partly cloudy throughout the day.	partly-cloudy-day
573	50	September	64	53	Partly cloudy throughout the day.	partly-cloudy-day
574	50	October	55	46	Mostly cloudy throughout the day.	partly-cloudy-day
575	50	November	45	38	Mostly cloudy throughout the day.	partly-cloudy-day
576	50	December	38	33	Mostly cloudy throughout the day.	partly-cloudy-day
577	51	January	41	37	Mostly cloudy throughout the day.	partly-cloudy-day
578	51	February	42	37	Mostly cloudy throughout the day.	partly-cloudy-day
579	51	March	46	38	Mostly cloudy throughout the day.	partly-cloudy-day
580	51	April	52	41	Partly cloudy throughout the day.	partly-cloudy-day
581	51	May	59	45	Mostly cloudy throughout the day.	partly-cloudy-day
582	51	June	65	50	Mostly cloudy throughout the day.	partly-cloudy-day
583	51	July	69	54	Mostly cloudy throughout the day.	partly-cloudy-day
584	51	August	68	55	Mostly cloudy throughout the day.	partly-cloudy-day
585	51	September	63	52	Mostly cloudy throughout the day.	partly-cloudy-day
586	51	October	55	47	Mostly cloudy throughout the day.	partly-cloudy-day
587	51	November	47	42	Mostly cloudy throughout the day.	partly-cloudy-day
588	51	December	42	38	Mostly cloudy throughout the day.	partly-cloudy-day
589	52	January	39	24	Foggy in the morning.	fog
590	52	February	47	31	Partly cloudy throughout the day.	partly-cloudy-day
591	52	March	57	42	Partly cloudy throughout the day.	partly-cloudy-day
592	52	April	68	53	Partly cloudy throughout the day.	partly-cloudy-day
593	52	May	77	62	Partly cloudy throughout the day.	partly-cloudy-day
594	52	June	86	70	Partly cloudy throughout the day.	partly-cloudy-day
595	52	July	90	74	Partly cloudy throughout the day.	partly-cloudy-day
596	52	August	86	70	Partly cloudy throughout the day.	partly-cloudy-day
597	52	September	77	62	Partly cloudy throughout the day.	partly-cloudy-day
598	52	October	66	51	Partly cloudy throughout the day.	partly-cloudy-day
599	52	November	54	38	Foggy in the morning.	fog
600	52	December	42	27	Foggy in the morning.	fog
601	53	January	80	60	Partly cloudy throughout the day.	partly-cloudy-day
602	53	February	80	61	Partly cloudy throughout the day.	partly-cloudy-day
603	53	March	78	58	Partly cloudy throughout the day.	partly-cloudy-day
604	53	April	74	53	Partly cloudy throughout the day.	partly-cloudy-day
605	53	May	68	46	Partly cloudy until evening.	partly-cloudy-day
606	53	June	64	41	Clear throughout the day.	clear-day
607	53	July	64	41	Partly cloudy until afternoon.	partly-cloudy-day
608	53	August	69	46	Clear throughout the day.	clear-day
609	53	September	75	52	Partly cloudy throughout the day.	partly-cloudy-day
610	53	October	78	57	Partly cloudy throughout the day.	partly-cloudy-day
611	53	November	79	58	Partly cloudy throughout the day.	partly-cloudy-day
612	53	December	79	59	Partly cloudy throughout the day.	partly-cloudy-day
613	54	January	55	45	Partly cloudy throughout the day.	partly-cloudy-day
614	54	February	57	47	Partly cloudy throughout the day.	partly-cloudy-day
615	54	March	59	49	Partly cloudy throughout the day.	partly-cloudy-day
616	54	April	61	51	Partly cloudy throughout the day.	partly-cloudy-day
617	54	May	63	53	Partly cloudy throughout the day.	partly-cloudy-day
618	54	June	66	55	Partly cloudy throughout the day.	partly-cloudy-day
619	54	July	67	56	Partly cloudy throughout the day.	partly-cloudy-day
620	54	August	68	57	Partly cloudy throughout the day.	partly-cloudy-day
621	54	September	69	57	Partly cloudy throughout the day.	partly-cloudy-day
622	54	October	66	55	Partly cloudy throughout the day.	partly-cloudy-day
623	54	November	61	50	Partly cloudy throughout the day.	partly-cloudy-day
624	54	December	56	45	Partly cloudy throughout the day.	partly-cloudy-day
625	55	January	36	20	Partly cloudy throughout the day.	partly-cloudy-day
626	55	February	40	24	Partly cloudy throughout the day.	partly-cloudy-day
627	55	March	51	34	Partly cloudy throughout the day.	partly-cloudy-day
628	55	April	64	46	Partly cloudy throughout the day.	partly-cloudy-day
629	55	May	75	57	Partly cloudy throughout the day.	partly-cloudy-day
630	55	June	85	67	Partly cloudy throughout the day.	partly-cloudy-day
631	55	July	88	70	Partly cloudy until evening.	partly-cloudy-day
632	55	August	87	69	Partly cloudy until evening.	partly-cloudy-day
633	55	September	78	60	Partly cloudy throughout the day.	partly-cloudy-day
634	55	October	65	48	Partly cloudy throughout the day.	partly-cloudy-day
635	55	November	51	34	Partly cloudy throughout the day.	partly-cloudy-day
636	55	December	39	23	Partly cloudy throughout the day.	partly-cloudy-day
637	56	January	45	30	Partly cloudy throughout the day.	partly-cloudy-day
638	56	February	50	34	Partly cloudy throughout the day.	partly-cloudy-day
639	56	March	58	42	Partly cloudy throughout the day.	partly-cloudy-day
640	56	April	68	51	Partly cloudy throughout the day.	partly-cloudy-day
641	56	May	77	59	Partly cloudy throughout the day.	partly-cloudy-day
642	56	June	85	67	Partly cloudy until evening.	partly-cloudy-day
643	56	July	90	72	Partly cloudy until evening.	partly-cloudy-day
644	56	August	88	70	Partly cloudy until afternoon.	partly-cloudy-day
645	56	September	80	63	Partly cloudy until evening.	partly-cloudy-day
646	56	October	69	52	Partly cloudy throughout the day.	partly-cloudy-day
647	56	November	57	41	Partly cloudy throughout the day.	partly-cloudy-day
648	56	December	48	32	Partly cloudy throughout the day.	partly-cloudy-day
649	57	January	42	33	Mostly cloudy throughout the day.	partly-cloudy-day
650	57	February	44	34	Partly cloudy throughout the day.	partly-cloudy-day
651	57	March	51	39	Partly cloudy throughout the day.	partly-cloudy-day
652	57	April	59	45	Partly cloudy throughout the day.	partly-cloudy-day
653	57	May	67	52	Partly cloudy throughout the day.	partly-cloudy-day
654	57	June	75	58	Partly cloudy throughout the day.	partly-cloudy-day
655	57	July	78	61	Partly cloudy throughout the day.	partly-cloudy-day
656	57	August	77	61	Partly cloudy throughout the day.	partly-cloudy-day
657	57	September	70	56	Partly cloudy throughout the day.	partly-cloudy-day
658	57	October	61	49	Partly cloudy throughout the day.	partly-cloudy-day
659	57	November	50	40	Partly cloudy throughout the day.	partly-cloudy-day
660	57	December	44	35	Mostly cloudy throughout the day.	partly-cloudy-day
661	58	January	48	40	Mostly cloudy throughout the day.	partly-cloudy-day
662	58	February	48	40	Mostly cloudy throughout the day.	partly-cloudy-day
663	58	March	52	43	Partly cloudy throughout the day.	partly-cloudy-day
664	58	April	60	50	Partly cloudy throughout the day.	partly-cloudy-day
665	58	May	69	57	Partly cloudy throughout the day.	partly-cloudy-day
666	58	June	78	66	Partly cloudy throughout the day.	partly-cloudy-day
667	58	July	82	69	Partly cloudy throughout the day.	partly-cloudy-day
668	58	August	83	70	Partly cloudy throughout the day.	partly-cloudy-day
669	58	September	76	64	Partly cloudy throughout the day.	partly-cloudy-day
670	58	October	67	57	Partly cloudy throughout the day.	partly-cloudy-day
671	58	November	59	50	Partly cloudy throughout the day.	partly-cloudy-day
672	58	December	50	42	Mostly cloudy throughout the day.	partly-cloudy-day
673	59	January	46	31	Partly cloudy throughout the day.	partly-cloudy-day
674	59	February	49	33	Partly cloudy throughout the day.	partly-cloudy-day
675	59	March	57	40	Partly cloudy throughout the day.	partly-cloudy-day
676	59	April	67	49	Partly cloudy throughout the day.	partly-cloudy-day
677	59	May	78	59	Partly cloudy throughout the day.	partly-cloudy-day
678	59	June	86	67	Partly cloudy throughout the day.	partly-cloudy-day
679	59	July	89	71	Partly cloudy throughout the day.	partly-cloudy-day
680	59	August	87	69	Partly cloudy throughout the day.	partly-cloudy-day
681	59	September	79	63	Partly cloudy throughout the day.	partly-cloudy-day
682	59	October	69	53	Partly cloudy throughout the day.	partly-cloudy-day
683	59	November	58	42	Partly cloudy throughout the day.	partly-cloudy-day
684	59	December	49	35	Partly cloudy throughout the day.	partly-cloudy-day
\.


--
-- Name: all_weather_weather_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('all_weather_weather_id_seq', 684, true);


--
-- Data for Name: cities; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY cities (city_id, city_name, city_lat, city_long, country_code) FROM stdin;
1	Edison	31.558259	-84.738724	USA
2	Bologna	44.50483	11.345169	ITA
3	Torino	45.069512	7.705403	ITA
4	Awendaw	33.036392	-79.617865	USA
5	Ironton	46.477587	-93.978324	USA
6	Viracopos	-14.24292	-54.387829	BRA
7	Chennai	13.06397	80.24311	IND
8	Columbia	31.292727	-85.110484	USA
9	Verona	45.438113	10.991505	ITA
10	Pietermaritzburg	-29.600759	30.37812	ZAF
11	Katunayaka	7.1652	79.8722	LKA
12	Santander	43.4615	-3.810009	ESP
13	Atlanta	33.748315	-84.391109	USA
14	Ahmedabad	25.28287	87.80413	IND
15	Irun	43.339525	-1.790234	ESP
16	Ladson	33.007766	-80.128038	USA
17	Elgin	31.661045	-110.526119	USA
18	Medford	42.419815	-71.108759	USA
19	Charlotte	35.2225	-80.837539	USA
20	Kanpur	22.6084	73.66283	IND
21	Linares	38.09391	-3.635724	ESP
22	Brisbane	-27.46888	153.022827	AUS
23	Penang	5.35388	100.444412	MYS
24	Edmonton	53.54622	-113.490374	CAN
25	Plainville	41.668945	-72.867229	USA
26	Panjim	15.48691	73.831879	IND
27	Seattle	47.60356	-122.329439	USA
28	George	-33.961102	22.471514	ZAF
29	Alovera	40.595545	-3.24893	ESP
30	Denver	39.74001	-104.992259	USA
31	Ho Chi Minh City	10.75918	106.662498	VNM
32	Curitiba	-25.440024	-49.276709	BRA
33	Augusta	35.282972	-91.365428	USA
34	Duesseldorf	51.21563	6.776055	DEU
35	Linz	48.30425	14.288155	AUT
36	Guangzhou	23.107389	113.267616	CHN
37	Haverhill	26.692911	-80.113658	USA
38	Kuala Lumpur	3.104665	101.69117	MYS
39	Hamilton	-37.783214	175.277	NZL
40	Colorado Springs	38.83345	-104.821814	USA
41	Vance	33.17534	-87.233799	USA
42	Eindhoven	51.43447	5.484105	NLD
43	Greenstone	-26.118599	28.150762	ZAF
44	Missoula	46.87278	-113.996234	USA
45	Stuttgart	48.7666667	9.1833333	DEU
46	San Diego	32.715695	-117.161719	USA
47	Chakan	18.755791	73.864014	IND
48	Las Rozas	40.4916	-3.87291	ESP
49	Hanover Park	41.991122	-88.158495	USA
50	Zurich	47.37706	8.53955	CHE
51	Northampton	52.23394	-0.895284	GBR
52	Xian	34.27301	108.928009	CHN
53	Roodepoort	-26.160079	27.863915	ZAF
54	South San Francisco	37.65589	-122.413374	USA
55	Home	39.84156	-96.520639	USA
56	Chester	35.68104	-94.176874	USA
57	Lyon	45.759399	4.82897	FRA
58	Istanbul	41.040855	28.986183	TUR
59	Richmond	37.5407	-77.433654	USA
60	Louisville	38.25486	-85.766404	USA
61	Aguascalientes	21.88232	-102.294119	MEX
62	Manila	14.60962	121.00589	PHL
63	Midrand	-25.974588	28.135165	ZAF
64	Nice	43.701539	7.278244	FRA
65	Getafe	40.30488	-3.731089	ESP
66	Columbus	39.96196	-83.002984	USA
67	Port Klang	2.97981	101.408684	MYS
68	Hong Kong	22.283325	114.15872	HKG
69	Shanghai	31.247709	121.472618	CHN
70	New Delhi	24.7338	81.33463	IND
71	Humble	30.000185	-95.268624	USA
72	Linkou	25.105579	121.340202	TWN
73	Muenster	48.623685	10.90317	DEU
74	Montreal	45.512293	-73.554407	CAN
75	Toulouse	43.6	1.4333333	FRA
76	Triana	34.583455	-86.735424	USA
77	Whitestown	39.995455	-86.345919	USA
78	Birmingham	52.478595	-1.908604	GBR
79	Surabaya	-7.25857	112.746689	IDN
80	Edison Executive	40.526791	-74.39357	USA
81	Queretaro	20.59214	-100.396054	MEX
82	Springfield Gardens	40.67945	-73.750789	USA
83	New Holland	40.18667	-89.580495	USA
84	Matamoros	26.76481	-105.589269	MEX
85	Elk Grove Village	42.002816	-88.009045	USA
86	Glasgow	55.8333333	-4.25	GBR
87	Lakewood	33.848815	-118.133784	USA
88	Munich	48.136415	11.577531	DEU
89	East London	-33.015419	27.90403	ZAF
90	Folcroft	39.89974	-75.278934	USA
91	Joliet	41.524935	-88.084594	USA
92	Lugoff	34.226524	-80.67996	USA
93	Tainan	22.99721	120.180862	TWN
94	Eilat	29.556	34.95071	ISR
95	Laurens	42.847655	-94.856209	USA
96	Mississauga	43.588285	-79.643724	CAN
97	Witbank	-25.872654	29.21122	ZAF
98	Los Indios	26.0521	-97.744529	USA
99	Vitoria-Gasteiz	42.843578	-2.68261	ESP
100	Indore	21.90847	73.24932	IND
101	St. Louis	38.62774	-90.199514	USA
102	Phoenix	33.44826	-112.075774	USA
103	Salisbury	41.98276	-73.422484	USA
104	Upington	-28.457189	21.246645	ZAF
105	Lusaka	-15.40884	28.2824	ZMB
106	Vicenza	45.547985	11.549435	ITA
107	Monterrey	25.670975	-100.309959	MEX
108	Zhengzhou	34.762501	113.653023	CHN
109	Cartagena	37.606755	-0.988009	ESP
110	Grapevine	34.148412	-92.315593	USA
111	Perth	-31.95302	115.857239	AUS
112	Otopeni	44.549999	26.0667	ROU
113	Sao Paulo	-23.56288	-46.654659	BRA
114	Wuhan	30.572399	114.279121	CHN
115	Migdal Haemek	32.833302	35.5	ISR
116	Noida	28.56737	77.36779	IND
117	Niagara Falls	43.10663	-79.064239	CAN
118	Lodz	51.76174	19.468015	POL
119	Polokwane	-23.908934	29.45981	ZAF
120	Hamburg	53.553345	9.992455	DEU
121	Vandalia	38.96073	-89.098919	USA
122	Azuqueca De Henares	40.56464	-3.267744	ESP
123	Porto	41.14945	-8.610314	PRT
124	Dubai	25.269445	55.30865	ARE
125	Mannheim	49.48651	8.466785	DEU
126	Miami	25.728985	-80.237419	USA
127	Phnom Penh	11.56474	104.913208	KHM
128	Mohali	22.58805	81.93449	IND
129	Rome	41.90311	12.49576	ITA
130	Edwardsville	33.706387	-85.512417	USA
131	Taipei	25.080441	121.564194	TWN
132	Alverca do Ribatejo	38.89996	-9.03975	PRT
133	Cairo	30.08374	31.25536	EGY
134	Shenyang	41.788509	123.40612	CHN
135	McAllen	26.20742	-98.229364	USA
136	Vaal	-34.014984	24.73836	ZAF
137	Milan	45.468945	9.18103	ITA
138	Kimberley	-28.734429	24.76026	ZAF
139	Osaka	34.677471	135.503235	JPN
140	Heathrow	51.47245	-0.45293	GBR
141	Dhaka	23.709801	90.407112	BGD
142	Little Hocking	39.261405	-81.699344	USA
143	Rishon Lezion	31.96479	34.805859	ISR
144	Dortmund	51.516615	7.458295	DEU
145	Guadalajara	20.68759	-103.351074	MEX
146	Reading	51.45352	-0.963009	GBR
147	Lansdale	40.240585	-75.285314	USA
148	Jetpark	-28.47933	24.67993	ZAF
149	Carolina	31.242498	-86.527729	USA
150	Metaire	37.167931	-95.845016	USA
151	Salt Lake City	40.759505	-111.888229	USA
152	Cochin	9.93846	76.26948	IND
153	Haifa	32.81171	34.998711	ISR
154	Lucknow	26.83906	80.93326	IND
155	Zaventem	50.883545	4.474115	BEL
156	Watertown	41.604888	-73.119398	USA
157	Frankfurt	50.112065	8.683415	DEU
158	Cambridge	45.852971	-66.07252	CAN
159	Brampton	43.684305	-79.758729	CAN
160	Rio De Janeiro	-22.976734	-43.195084	BRA
161	Nashik	19.98463	73.79349	IND
162	Monee	41.41998	-87.734224	USA
163	Fairlawn	41.134339	-81.622978	USA
164	Adelaide	-34.926102	138.599884	AUS
165	Mexico City	19.4319	-99.132851	MEX
166	Chihuahua	28.639655	-106.072059	MEX
167	Belfast	54.595295	-5.934524	GBR
168	Port Said	31.259279	32.284458	EGY
169	Johor Bahru	1.48009	103.763763	MYS
170	Ahrensburg	53.66945	10.231935	DEU
171	Sevilla	37.387697	-6.001813	ESP
172	Napier	-39.492196	176.912184	NZL
173	Mesa	33.417045	-111.831459	USA
174	Tirupur	11.08911	77.390007	IND
175	Markham	43.856034	-79.339942	CAN
176	Hvidovre	55.63664	12.47436	DNK
177	Helsinki	60.17116	24.93258	FIN
178	Pusan	35.170429	128.999481	KOR
179	Beverly	39.01488	-97.974829	USA
180	Charleston	35.297125	-94.038474	USA
181	Bordeaux	44.836635	-0.581039	FRA
182	Incheon	37.704639	126.440872	KOR
183	Wroclaw	51.10805	17.026703	POL
184	Lima	-12.0436	-77.021217	PER
185	Barajas	40.363312	-5.14682	ESP
186	Yavne	31.8167	34.716702	ISR
187	Mumbai	19.076191	72.875877	IND
188	Cali	3.43863	-76.517014	COL
189	Zhangjiagang	31.950001	120.449997	CHN
190	Vila Nova de Famalicao	41.405995	-8.516489	PRT
191	Pachuca	20.09881	-98.71508	MEX
192	Welkom	-27.978979	26.7338	ZAF
193	Cudahy	33.95983	-118.17602	USA
194	Klia Sepang	2.718755	101.724635	MYS
195	Grand Rapids	42.96641	-85.671179	USA
196	Chongqing	29.544001	106.522621	CHN
197	El Prat De Llobregat	41.327881	2.08632	ESP
198	Morrisville	37.48092	-93.427834	USA
199	La Coruna	43.370155	-8.396744	ESP
200	New Johnsonville	36.021106	-87.966726	USA
201	Narita	35.786518	140.319305	JPN
202	Suzhou	31.3092	120.613121	CHN
203	Mayhill	32.890563	-105.477979	USA
204	Troisdorf-Spich	50.826801	7.12534	DEU
205	Oevel	51.138741	4.90372	BEL
206	Prague	50.079083	14.43323	CZE
207	Pflugerville	30.440565	-97.619934	USA
208	Romulus	42.22183	-83.385339	USA
209	Beira	-19.820109	34.85101	MOZ
210	Sturtevant	42.69798	-87.895429	USA
211	Lisboa	38.725735	-9.15021	PRT
212	Amsterdam	52.37312	4.893195	NLD
213	Colfax	39.095515	-120.950714	USA
214	Santos	-23.961694	-46.328099	BRA
215	Ashdod	31.798809	34.648899	ISR
216	Chehalis	46.662105	-122.964619	USA
217	Barry	51.401782	-3.277994	GBR
218	Freiburg	47.99854	7.849655	DEU
219	Johannesburg	-26.204944	28.040035	ZAF
220	Centurion	-25.846284	28.152708	ZAF
221	Independence	36.803585	-118.200339	USA
222	Santiago	-33.437269	-70.650564	CHL
223	Buenaventura	3.88369	-77.040314	COL
224	Berlin	52.5166667	13.4	DEU
225	Campinas	-22.909049	-47.064594	BRA
226	Nantes	47.218115	-1.553059	FRA
227	W Columbia Span	36.851985	-84.771889	USA
228	Pune	18.52671	73.8616	IND
229	Chittagong	22.330299	91.825111	BGD
230	Dublin	53.34807	-6.248274	IRL
231	Pilsen	49.74654	13.381902	CZE
232	Havant	50.854496	-0.985544	GBR
233	Rayong	12.70712	101.18882	THA
234	Gdynia	54.519655	18.536485	POL
235	Manchester	53.479605	-2.248818	GBR
236	Kelsterbach	50.061415	8.53165	DEU
237	Kassel	51.311788	9.491211	DEU
238	Whitakers	36.105227	-77.715004	USA
239	Fontana	34.10205	-117.435759	USA
240	Guanyin	25.032009	121.10199	TWN
241	Alenbi bridge	32.1138889	34.8041667	ISR
242	Sydney	-33.869629	151.206955	AUS
243	Amman	31.950001	35.933331	JOR
244	North Charleston	32.876727	-80.009282	USA
245	Nelspruit	-25.472811	30.976999	ZAF
246	Gurgaon	26.313	87.85969	IND
247	Ludhiana	30.89314	75.86938	IND
248	Aurora	39.708709	-104.812649	USA
249	Asghabat	37.95042	58.390121	TKM
250	Roissy Cdg Cedex	49.005749	2.53782	FRA
251	Bangalore	12.97092	77.60482	IND
252	Leamington	42.054155	-82.599714	CAN
253	Southampton	50.90994	-1.407319	GBR
254	Xiamen	24.45252	118.079117	CHN
255	Cadiz	36.52986	-6.290239	ESP
256	Bhiwandi	19.296341	73.065338	IND
257	Mulhouse	47.75171	7.34365	FRA
258	Fuzhou	26.070999	119.303223	CHN
259	Teiyuan	25.001909	121.304977	TWN
260	Krakow	50.06006	19.9326	POL
261	Suwanee	34.056886	-84.065333	USA
262	Mesquite	36.80393	-114.067219	USA
263	Aberdeen	57.15382	-2.106789	GBR
264	Lod	31.95875	34.886429	ISR
265	Hanoi	21.03195	105.819908	VNM
266	Lahore	31.54991	74.327301	PAK
267	Jaipur	26.9166667	75.8166667	IND
268	Calcultta	21.7866	82.794762	IND
269	Moberly	39.42796	-92.433269	USA
270	West Columbia	33.988977	-81.073284	USA
271	Tokyo	35.670479	139.740921	JPN
272	Puyallup	47.190445	-122.295699	USA
273	Wellington	-41.280515	174.767121	NZL
274	Anaheim	33.83276	-117.915719	USA
275	Stockholm	59.33228	18.06284	SWE
276	Davenport	37.011115	-122.194904	USA
277	Sokhna	26.69636	30.246469	EGY
278	Muenchen	48.136415	11.577531	DEU
279	Salem	11.67336	78.166229	IND
280	Shannon	52.710215	-8.882226	IRL
281	Coslada	40.42611	-3.564542	ESP
282	Tianjin	38.95892	117.63343	CHN
283	Port Elizabeth	-33.962499	25.62328	ZAF
284	Tczew	54.092079	18.774006	POL
285	Hazelwood	38.784988	-90.355291	USA
286	Valencia	39.468791	-0.376913	ESP
287	Montevideo	-34.880901	-56.16544	URY
288	Gothenburg	57.701235	11.967105	SWE
289	Huntsville	34.729135	-86.584979	USA
290	Buenos Aires	-34.608521	-58.373539	ARG
291	Bangkok	13.75333	100.504822	THA
292	Qingdao	36.087509	120.34272	CHN
293	Zilina	49.22367	18.74753	SVK
294	Taichung	24.161329	120.641487	TWN
295	Budapest	47.506225	19.06482	HUN
296	Aylesford	51.30364	0.48011	GBR
297	Jakarta	-6.17144	106.82782	IDN
298	Gaborone	-24.655284	25.919065	BWA
299	Argentona	41.556415	2.403665	ESP
300	Lilongwe	-13.9826	33.773762	MWI
301	Carmel	39.97839	-86.126419	USA
302	Dulles	39.02784	-77.397179	USA
303	Bogota	4.65637	-74.11779	COL
304	Reno	39.527395	-119.813414	USA
305	Colombo	6.9272	79.8722	LKA
306	Blantyre	-15.79304	34.993591	MWI
307	Portland	45.511795	-122.675629	USA
308	Izmir	38.425147	27.142302	TUR
309	Senec	48.22061	17.398035	SVK
310	Breinigsville	40.542742	-75.65691	USA
311	Bremen	53.075166	8.804667	DEU
312	Zhongshan	22.516701	113.366699	CHN
313	Eagan	44.81808	-93.167134	USA
314	Paranagua	-25.520629	-48.509349	BRA
315	Littlehampton	50.82103	-0.538959	GBR
316	Shenzhen	22.546789	114.112556	CHN
317	Zaragoza	41.65173	-0.881319	ESP
318	Bloemfontein	-29.113449	26.225335	ZAF
319	Auga	26.69636	30.246469	EGY
320	Grand Prairie	32.7477	-97.007199	USA
321	Newcastle	-27.756274	29.930345	ZAF
322	Houdeng-Goegnies	50.4893	4.15672	BEL
323	Tampa	27.94653	-82.459269	USA
324	Bellary	15.14735	76.919762	IND
325	Nuremberg	49.45432	11.073955	DEU
326	Pass Christian	30.324515	-89.217949	USA
327	Christchurch	-43.531027	172.637767	NZL
328	Vigo	42.22124	-8.733224	ESP
329	Jamaica	41.84475	-94.309359	USA
330	Alexandria	31.19224	29.88987	EGY
331	Cincinnati	39.106614	-84.504552	USA
332	Long Beach	33.766725	-118.192399	USA
333	Bedfordview	-26.179934	28.129106	ZAF
334	Cebu	10.31009	123.894638	PHL
335	Auckland	-36.884109	174.77042	NZL
336	Guarulhos	-23.443987	-46.507779	BRA
337	Kaohsiung	22.672569	120.293228	TWN
338	Vienna	48.202548	16.368805	AUT
339	Seoul	37.557121	126.977379	KOR
340	Singapore	1.29378	103.853256	SGP
341	Moscow	55.75695	37.614975	RUS
342	Rubi	41.491914	2.031624	ESP
343	Karachi	24.88978	67.028511	PAK
344	Cabanillas del Campo	40.637765	-3.237442	ESP
345	Graz	47.068565	15.44318	AUT
346	Medellin	6.23651	-75.590279	COL
347	Le Havre	49.49346	0.101395	FRA
348	Cape Town	-33.919104	18.42197	ZAF
349	Washington	38.89037	-77.031959	USA
350	Ningbo	29.87096	121.543549	CHN
351	Earls Colne	51.927158	0.6997	GBR
352	Hyderabad	17.4376	78.4706	IND
353	Madison	34.705885	-86.750953	USA
354	Nankan	26.14975	119.93911	TWN
355	Vila Franca Xira	38.95395	-8.989858	PRT
356	Schiphol-Rijk	52.286781	4.76761	NLD
357	Nuernberg	49.45432	11.073955	DEU
358	Basildon	51.567795	0.444556	GBR
359	Dallas	32.778155	-96.795404	USA
360	Dayuan	25.0644	121.207291	TWN
361	Greenville	31.829446	-86.633489	USA
362	St. Petersburg	59.93314	30.306115	RUS
363	Derrimut	-37.79953	144.789078	AUS
364	Meriden	41.536285	-72.797845	USA
365	Calgary	51.04522	-114.063014	CAN
366	Rotterdam	51.922835	4.478455	NLD
367	Malpensa	45.625019	8.70837	ITA
368	Durban	-29.855744	31.035125	ZAF
369	Harare	-17.823351	31.05023	ZWE
370	Ferrol	43.48685	-8.227339	ESP
371	Melville	30.692035	-91.739674	USA
372	Hannover	52.372278	9.738157	DEU
373	Panipat	29.38616	76.96981	IND
374	Belleville	35.093455	-93.447899	USA
375	Chelsea	33.34106	-86.630419	USA
376	Beijing	39.90601	116.387909	CHN
377	Lawrenceville	33.952465	-83.987994	USA
378	Memphis	35.14968	-90.048929	USA
379	Hebron	41.660238	-72.358303	USA
380	Maputo	-25.9681	32.58065	MOZ
381	Carson	33.83161	-118.262119	USA
382	Vancouver	49.26044	-123.114034	CAN
383	Porto Alegre	-30.034259	-51.22802	BRA
384	Taylors	34.88884	-82.304459	USA
385	Berne	46.948432	7.440461	CHE
386	Chandigarh	30.73012	76.78244	IND
387	Koeln	50.941655	6.955055	DEU
388	Spartan	-26.116934	28.21561	ZAF
389	Middleburg Heights	41.371738	-81.810877	USA
390	Ankara	39.94293	32.86048	TUR
391	Lod-Ben Gurion Airport	32.0117	34.886101	ISR
392	Laredo	40.027405	-93.444489	USA
393	Gauteng	-26.01601	28.25897	ZAF
394	Wilmington	33.789425	-118.263189	USA
395	Melbourne	-37.817532	144.967148	AUS
396	Baroda	22.66755	72.55271	IND
397	Almaty	43.255051	76.912628	KAZ
398	Baltimore	39.290555	-76.609604	USA
399	Dalian	38.94381	121.576523	CHN
400	Chengdu	30.67	104.071022	CHN
401	Graniteville	33.56234	-81.80829	USA
402	Taoyuan	25.001909	121.304977	TWN
403	Reynosa	26.092515	-98.300454	MEX
\.


--
-- Name: cities_city_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('cities_city_id_seq', 403, true);


--
-- Data for Name: countries; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY countries (country_code, country_name) FROM stdin;
CAN	Canada
LBY	Libyan Arab Jamahiriya
STP	Sao Tome and Principe
VEN	Venezuela, Bolivarian Republic of
GNB	Guinea-Bissau
MNE	Montenegro
LTU	Lithuania
KHM	Cambodia
KNA	Saint Kitts and Nevis
ETH	Ethiopia
ABW	Aruba
SWZ	Swaziland
ARG	Argentina
CMR	Cameroon
BFA	Burkina Faso
TKM	Turkmenistan
GHA	Ghana
SAU	Saudi Arabia
RWA	Rwanda
TGO	Togo
JPN	Japan
ASM	American Samoa
UMI	United States Minor Outlying Islands
CCK	Cocos (Keeling) Islands
PCN	Pitcairn
GTM	Guatemala
BIH	Bosnia and Herzegovina
KWT	Kuwait
JOR	Jordan
VGB	Virgin Islands, British
DMA	Dominica
LBR	Liberia
MDV	Maldives
FSM	Micronesia, Federated States of
JAM	Jamaica
OMN	Oman
MTQ	Martinique
CXR	Christmas Island
GAB	Gabon
NIU	Niue
MCO	Monaco
WLF	Wallis and Futuna
NZL	New Zealand
SHN	Saint Helena, Ascension and Tristan da Cunha
JEY	Jersey
BHS	Bahamas
YEM	Yemen
ALB	Albania
WSM	Samoa
NFK	Norfolk Island
ARE	United Arab Emirates
CIV	Côte d'Ivoire
IND	India
AZE	Azerbaijan
MDG	Madagascar
LSO	Lesotho
VCT	Saint Vincent and the Grenadines
KEN	Kenya
KOR	South Korea
MAC	Macao
GUM	Guam
TUR	Turkey
AFG	Afghanistan
BGD	Bangladesh
MRT	Mauritania
SLB	Solomon Islands
TCA	Turks and Caicos Islands
LCA	Saint Lucia
SMR	San Marino
MNG	Mongolia
FRA	France
MKD	Macedonia, the former Yugoslav Republic of
SYR	Syrian Arab Republic
BMU	Bermuda
NAM	Namibia
SOM	Somalia
PER	Peru
VUT	Vanuatu
NRU	Nauru
SYC	Seychelles
NOR	Norway
MWI	Malawi
COK	Cook Islands
BEN	Benin
COD	Congo, the Democratic Republic of the
CUB	Cuba
IRN	Iran, Islamic Republic of
FLK	Falkland Islands (Malvinas)
MYT	Mayotte
HMD	Heard Island and McDonald Islands
CHN	China
ARM	Armenia
TLS	Timor-Leste
DOM	Dominican Republic
UKR	Ukraine
BHR	Bahrain
TON	Tonga
FIN	Finland
ESH	Western Sahara
CYM	Cayman Islands
CAF	Central African Republic
MEX	Mexico
TJK	Tajikistan
LIE	Liechtenstein
BLR	Belarus
MLI	Mali
SWE	Sweden
RUS	Russia
BGR	Bulgaria
VIR	Virgin Islands, U.S.
MUS	Mauritius
ROU	Romania
AGO	Angola
ATF	French Southern Territories
PRT	Portugal
TTO	Trinidad and Tobago
TKL	Tokelau
CYP	Cyprus
SGS	South Georgia and the South Sandwich Islands
BRN	Brunei Darussalam
QAT	Qatar
MYS	Malaysia
AUT	Austria
VNM	Vietnam
MOZ	Mozambique
SVN	Slovenia
UGA	Uganda
ALA	Åland Islands
HUN	Hungary
NER	Niger
BRA	Brazil
FRO	Faroe Islands
GIN	Guinea
PAN	Panama
CRI	Costa Rica
LUX	Luxembourg
CPV	Cape Verde
AND	Andorra
GIB	Gibraltar
IRL	Ireland
PAK	Pakistan
PLW	Palau
NGA	Nigeria
ECU	Ecuador
CZE	Czech Republic
AUS	Australia
USA	USA
DZA	Algeria
PRK	Korea, Democratic People's Republic of
SLV	El Salvador
TUV	Tuvalu
ZAF	South Africa
SPM	Saint Pierre and Miquelon
VAT	Holy See (Vatican City State)
MHL	Marshall Islands
CHL	Chile
PRI	Puerto Rico
BEL	Belgium
KIR	Kiribati
HTI	Haiti
BLZ	Belize
HKG	Hong Kong
SLE	Sierra Leone
GEO	Georgia
LAO	Lao People's Democratic Republic
REU	Réunion
GMB	Gambia
PHL	Philippines
ANT	Netherlands Antilles
HRV	Croatia
PYF	French Polynesia
GGY	Guernsey
THA	Thailand
CHE	Switzerland
GRD	Grenada
IMN	Isle of Man
TZA	Tanzania, United Republic of
TCD	Chad
EST	Estonia
URY	Uruguay
BLM	Saint Barthélemy
GNQ	Equatorial Guinea
LBN	Lebanon
SJM	Svalbard and Jan Mayen
UZB	Uzbekistan
TUN	Tunisia
DJI	Djibouti
GRL	Greenland
ATG	Antigua and Barbuda
ESP	Spain
COL	Colombia
BDI	Burundi
SVK	Slovakia
TWN	Taiwan
FJI	Fiji
BRB	Barbados
MAF	Saint Martin (French part)
ITA	Italy
BTN	Bhutan
SDN	Sudan
BOL	Bolivia, Plurinational State of
NPL	Nepal
MLT	Malta
NLD	Netherlands
MNP	Northern Mariana Islands
SUR	Suriname
AIA	Anguilla
ISR	Israel
IDN	Indonesia
ISL	Iceland
ZMB	Zambia
SEN	Senegal
PNG	Papua New Guinea
ZWE	Zimbabwe
DEU	Germany
DNK	Denmark
KAZ	Kazakhstan
POL	Poland
MDA	Moldova, Republic of
ERI	Eritrea
KGZ	Kyrgyzstan
IOT	British Indian Ocean Territory
IRQ	Iraq
MSR	Montserrat
NCL	New Caledonia
PRY	Paraguay
LVA	Latvia
GUY	Guyana
GLP	Guadeloupe
MAR	Morocco
HND	Honduras
MMR	Myanmar
BVT	Bouvet Island
EGY	Egypt
NIC	Nicaragua
SGP	Singapore
SRB	Serbia
BWA	Botswana
GBR	United Kingdom
ATA	Antarctica
COG	Congo
GRC	Greece
LKA	Sri Lanka
GUF	French Guiana
PSE	Palestinian Territory, Occupied
COM	Comoros
\.


--
-- Data for Name: months; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY months (month, date) FROM stdin;
January	2018-01-15T00:00:00
February	2018-02-15T00:00:00
March	2018-03-15T00:00:00
April	2018-04-15T00:00:00
May	2018-05-15T00:00:00
June	2018-06-15T00:00:00
July	2018-07-15T00:00:00
August	2018-08-15T00:00:00
September	2018-09-15T00:00:00
October	2018-10-15T00:00:00
November	2018-11-15T00:00:00
December	2018-12-15T00:00:00
\.


--
-- Data for Name: trips; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY trips (trip_id, city_id, user_id, month) FROM stdin;
\.


--
-- Name: trips_trip_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('trips_trip_id_seq', 1, false);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY users (user_id, fname, lname, email, password) FROM stdin;
1	Lady	MacBeth	dagger@dagger.com	dagger
2	Ophelia	Flowers	flowers@dead.com	flowers
\.


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('users_user_id_seq', 2, true);


--
-- Name: all_weather_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY all_weather
    ADD CONSTRAINT all_weather_pkey PRIMARY KEY (weather_id);


--
-- Name: cities_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY cities
    ADD CONSTRAINT cities_pkey PRIMARY KEY (city_id);


--
-- Name: countries_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY countries
    ADD CONSTRAINT countries_pkey PRIMARY KEY (country_code);


--
-- Name: months_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY months
    ADD CONSTRAINT months_pkey PRIMARY KEY (month);


--
-- Name: trips_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY trips
    ADD CONSTRAINT trips_pkey PRIMARY KEY (trip_id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: ix_all_weather_city_id; Type: INDEX; Schema: public; Owner: vagrant
--

CREATE INDEX ix_all_weather_city_id ON all_weather USING btree (city_id);


--
-- Name: ix_all_weather_month; Type: INDEX; Schema: public; Owner: vagrant
--

CREATE INDEX ix_all_weather_month ON all_weather USING btree (month);


--
-- Name: ix_cities_country_code; Type: INDEX; Schema: public; Owner: vagrant
--

CREATE INDEX ix_cities_country_code ON cities USING btree (country_code);


--
-- Name: ix_trips_city_id; Type: INDEX; Schema: public; Owner: vagrant
--

CREATE INDEX ix_trips_city_id ON trips USING btree (city_id);


--
-- Name: ix_trips_month; Type: INDEX; Schema: public; Owner: vagrant
--

CREATE INDEX ix_trips_month ON trips USING btree (month);


--
-- Name: ix_trips_user_id; Type: INDEX; Schema: public; Owner: vagrant
--

CREATE INDEX ix_trips_user_id ON trips USING btree (user_id);


--
-- Name: all_weather_city_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY all_weather
    ADD CONSTRAINT all_weather_city_id_fkey FOREIGN KEY (city_id) REFERENCES cities(city_id);


--
-- Name: all_weather_month_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY all_weather
    ADD CONSTRAINT all_weather_month_fkey FOREIGN KEY (month) REFERENCES months(month);


--
-- Name: cities_country_code_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY cities
    ADD CONSTRAINT cities_country_code_fkey FOREIGN KEY (country_code) REFERENCES countries(country_code);


--
-- Name: trips_city_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY trips
    ADD CONSTRAINT trips_city_id_fkey FOREIGN KEY (city_id) REFERENCES cities(city_id);


--
-- Name: trips_month_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY trips
    ADD CONSTRAINT trips_month_fkey FOREIGN KEY (month) REFERENCES months(month);


--
-- Name: trips_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY trips
    ADD CONSTRAINT trips_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(user_id);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

