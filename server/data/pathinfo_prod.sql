--
-- PostgreSQL database dump
--

-- Dumped from database version 11.22 (Ubuntu 11.22-3.pgdg22.04+3)
-- Dumped by pg_dump version 11.22 (Ubuntu 11.22-3.pgdg22.04+3)

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

--
-- Name: boolean_char; Type: DOMAIN; Schema: public; Owner: openbis
--

CREATE DOMAIN public.boolean_char AS boolean DEFAULT false;


ALTER DOMAIN public.boolean_char OWNER TO openbis;

--
-- Name: code; Type: DOMAIN; Schema: public; Owner: openbis
--

CREATE DOMAIN public.code AS character varying(60);


ALTER DOMAIN public.code OWNER TO openbis;

--
-- Name: file_path; Type: DOMAIN; Schema: public; Owner: openbis
--

CREATE DOMAIN public.file_path AS character varying(1000);


ALTER DOMAIN public.file_path OWNER TO openbis;

--
-- Name: tech_id; Type: DOMAIN; Schema: public; Owner: openbis
--

CREATE DOMAIN public.tech_id AS bigint;


ALTER DOMAIN public.tech_id OWNER TO openbis;

--
-- Name: time_stamp; Type: DOMAIN; Schema: public; Owner: openbis
--

CREATE DOMAIN public.time_stamp AS timestamp with time zone;


ALTER DOMAIN public.time_stamp OWNER TO openbis;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: data_set_files; Type: TABLE; Schema: public; Owner: openbis
--

CREATE TABLE public.data_set_files (
    id bigint NOT NULL,
    dase_id public.tech_id NOT NULL,
    parent_id public.tech_id,
    relative_path public.file_path NOT NULL,
    file_name public.file_path NOT NULL,
    size_in_bytes bigint NOT NULL,
    checksum_crc32 integer,
    checksum text,
    is_directory public.boolean_char NOT NULL,
    last_modified public.time_stamp DEFAULT now() NOT NULL
);


ALTER TABLE public.data_set_files OWNER TO openbis;

--
-- Name: data_set_files_id_seq; Type: SEQUENCE; Schema: public; Owner: openbis
--

CREATE SEQUENCE public.data_set_files_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.data_set_files_id_seq OWNER TO openbis;

--
-- Name: data_set_files_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: openbis
--

ALTER SEQUENCE public.data_set_files_id_seq OWNED BY public.data_set_files.id;


--
-- Name: data_sets; Type: TABLE; Schema: public; Owner: openbis
--

CREATE TABLE public.data_sets (
    id bigint NOT NULL,
    code public.code NOT NULL,
    location public.file_path NOT NULL
);


ALTER TABLE public.data_sets OWNER TO openbis;

--
-- Name: data_sets_id_seq; Type: SEQUENCE; Schema: public; Owner: openbis
--

CREATE SEQUENCE public.data_sets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.data_sets_id_seq OWNER TO openbis;

--
-- Name: data_sets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: openbis
--

ALTER SEQUENCE public.data_sets_id_seq OWNED BY public.data_sets.id;


--
-- Name: database_version_logs; Type: TABLE; Schema: public; Owner: openbis
--

CREATE TABLE public.database_version_logs (
    db_version character varying(4) NOT NULL,
    module_name character varying(250),
    run_status character varying(10),
    run_status_timestamp timestamp without time zone,
    module_code bytea,
    run_exception bytea
);


ALTER TABLE public.database_version_logs OWNER TO openbis;

--
-- Name: events; Type: TABLE; Schema: public; Owner: openbis
--

CREATE TABLE public.events (
    last_seen_deletion_event_id public.tech_id NOT NULL
);


ALTER TABLE public.events OWNER TO openbis;

--
-- Name: last_feeding_event; Type: TABLE; Schema: public; Owner: openbis
--

CREATE TABLE public.last_feeding_event (
    registration_timestamp public.time_stamp NOT NULL
);


ALTER TABLE public.last_feeding_event OWNER TO openbis;

--
-- Name: data_set_files id; Type: DEFAULT; Schema: public; Owner: openbis
--

ALTER TABLE ONLY public.data_set_files ALTER COLUMN id SET DEFAULT nextval('public.data_set_files_id_seq'::regclass);


--
-- Name: data_sets id; Type: DEFAULT; Schema: public; Owner: openbis
--

ALTER TABLE ONLY public.data_sets ALTER COLUMN id SET DEFAULT nextval('public.data_sets_id_seq'::regclass);


--
-- Data for Name: data_set_files; Type: TABLE DATA; Schema: public; Owner: openbis
--

COPY public.data_set_files (id, dase_id, parent_id, relative_path, file_name, size_in_bytes, checksum_crc32, checksum, is_directory, last_modified) FROM stdin;
19	7	\N		20220916105315990-43	28013199	\N	\N	t	2022-09-16 10:53:17.82+00
20	7	19	original	original	28013199	\N	\N	t	2022-09-16 10:53:17.068+00
21	7	20	original/upload	upload	28013199	\N	\N	t	2022-09-16 10:53:15.88+00
22	7	21	original/upload/SRR14057125_R1_001.fastq.gz	SRR14057125_R1_001.fastq.gz	13775760	1153053194	\N	f	2022-09-16 10:53:15.88+00
23	7	21	original/upload/SRR14057125_R2_001.fastq.gz	SRR14057125_R2_001.fastq.gz	14237439	-211927166	\N	f	2022-09-16 10:53:15.92+00
24	8	\N		20220916105318900-46	24459189	\N	\N	t	2022-09-16 10:53:20.516+00
25	8	24	original	original	24459189	\N	\N	t	2022-09-16 10:53:19.788+00
26	8	25	original/upload	upload	24459189	\N	\N	t	2022-09-16 10:53:18.824+00
27	8	26	original/upload/SRR14057134_R1_001.fastq.gz	SRR14057134_R1_001.fastq.gz	11934032	981429814	\N	f	2022-09-16 10:53:18.82+00
28	8	26	original/upload/SRR14057134_R2_001.fastq.gz	SRR14057134_R2_001.fastq.gz	12525157	1385258128	\N	f	2022-09-16 10:53:18.856+00
29	9	\N		20220916105408646-47	5552986	\N	\N	t	2022-09-16 10:54:09.783+00
30	9	29	original	original	5552986	\N	\N	t	2022-09-16 10:54:09.323+00
31	9	30	original/ecoli.gtf	ecoli.gtf	5552986	-1986543220	\N	f	2022-09-16 10:54:08.603+00
32	10	\N		20220916105409958-48	4710048	\N	\N	t	2022-09-16 10:54:11.088+00
33	10	32	original	original	4710048	\N	\N	t	2022-09-16 10:54:10.624+00
34	10	33	original/ecoli.fasta	ecoli.fasta	4710048	-527715069	\N	f	2022-09-16 10:54:09.923+00
35	11	\N		20220916111346647-53	112009699	\N	\N	t	2022-09-16 11:13:48.45+00
36	11	35	original	original	112009699	\N	\N	t	2022-09-16 11:13:47.706+00
37	11	36	original/upload	upload	112009699	\N	\N	t	2022-09-16 11:13:46.478+00
38	11	37	original/upload/SRR19579109_1_c005.fastq.gz	SRR19579109_1_c005.fastq.gz	54712756	416850675	\N	f	2022-09-16 11:13:46.474+00
39	11	37	original/upload/SRR19579109_2_c005.fastq.gz	SRR19579109_2_c005.fastq.gz	57296943	2041606127	\N	f	2022-09-16 11:13:46.606+00
40	12	\N		20220916111349528-56	132580639	\N	\N	t	2022-09-16 11:13:50.922+00
41	12	40	original	original	132580639	\N	\N	t	2022-09-16 11:13:50.194+00
42	12	41	original/upload	upload	132580639	\N	\N	t	2022-09-16 11:13:49.342+00
43	12	42	original/upload/SRR19579112_1_c005.fastq.gz	SRR19579112_1_c005.fastq.gz	66293786	-1229719546	\N	f	2022-09-16 11:13:49.338+00
44	12	42	original/upload/SRR19579112_2_c005.fastq.gz	SRR19579112_2_c005.fastq.gz	66286853	811065348	\N	f	2022-09-16 11:13:49.49+00
45	13	\N		20220916112128074-57	121216688	\N	\N	t	2022-09-16 11:21:28.976+00
46	13	45	original	original	121216688	\N	\N	t	2022-09-16 11:21:28.348+00
47	13	46	original/ath.fasta	ath.fasta	121216688	1555628053	\N	f	2022-09-16 11:21:28.036+00
48	14	\N		20220916112130140-58	419093686	\N	\N	t	2022-09-16 11:21:31.024+00
49	14	48	original	original	419093686	\N	\N	t	2022-09-16 11:21:30.412+00
50	14	49	original/ath.gtf	ath.gtf	419093686	-550267353	\N	f	2022-09-16 11:21:30.1+00
51	15	\N		20220916143849160-65	2837	\N	\N	t	2022-09-16 14:38:50.903+00
52	15	51	original	original	2837	\N	\N	t	2022-09-16 14:38:49.939+00
53	15	52	original/logs	logs	2837	\N	\N	t	2022-09-16 14:38:48.899+00
54	15	53	original/logs/salmon_quant.log	salmon_quant.log	2837	556759208	\N	f	2022-09-16 14:38:48.899+00
55	16	\N		20220916143849849-66	525872605	\N	\N	t	2022-09-16 14:38:50.903+00
56	16	55	original	original	525872605	\N	\N	t	2022-09-16 14:38:49.939+00
57	16	56	original/2eb6024f-9bbe-4329-8a58-be673abf69f8	2eb6024f-9bbe-4329-8a58-be673abf69f8	525872605	\N	\N	t	2022-09-16 14:38:45.79+00
58	16	57	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results	results	525872605	\N	\N	t	2022-09-16 11:53:58+00
59	16	58	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/fastqc	fastqc	3688148	\N	\N	t	2022-09-16 14:38:49.207+00
60	16	58	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/genome	genome	257	\N	\N	t	2022-09-16 14:38:49.207+00
61	16	58	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc	multiqc	7199800	\N	\N	t	2022-09-16 11:53:58+00
62	16	61	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon	star_salmon	7199800	\N	\N	t	2022-09-16 14:38:49.783+00
63	16	62	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_data	multiqc_data	1954490	\N	\N	t	2022-09-16 14:38:49.811+00
64	16	62	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots	multiqc_plots	3759466	\N	\N	t	2022-09-16 11:53:58+00
65	16	64	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/pdf	pdf	805662	\N	\N	t	2022-09-16 14:38:49.803+00
66	16	64	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/png	png	1289759	\N	\N	t	2022-09-16 14:38:49.795+00
67	16	64	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/svg	svg	1664045	\N	\N	t	2022-09-16 14:38:49.791+00
68	16	58	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/pipeline_info	pipeline_info	3579029	\N	\N	t	2022-09-16 14:38:49.199+00
69	16	58	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon	star_salmon	507688408	\N	\N	t	2022-09-16 14:38:49.779+00
70	16	69	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/bigwig	bigwig	23917110	\N	\N	t	2022-09-16 14:38:49.739+00
71	16	69	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/deseq2_qc	deseq2_qc	517720	\N	\N	t	2022-09-16 14:38:49.779+00
72	16	71	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/deseq2_qc/size_factors	size_factors	241	\N	\N	t	2022-09-16 14:38:49.779+00
73	16	69	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/dupradar	dupradar	6661485	\N	\N	t	2022-09-16 11:47:28+00
74	16	73	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/dupradar/box_plot	box_plot	25975	\N	\N	t	2022-09-16 14:38:49.755+00
75	16	73	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/dupradar/gene_data	gene_data	4843534	\N	\N	t	2022-09-16 14:38:49.751+00
76	16	73	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/dupradar/histogram	histogram	10572	\N	\N	t	2022-09-16 14:38:49.751+00
77	16	73	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/dupradar/intercepts_slope	intercepts_slope	362	\N	\N	t	2022-09-16 14:38:49.755+00
78	16	73	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/dupradar/scatter_plot	scatter_plot	1781042	\N	\N	t	2022-09-16 14:38:49.755+00
79	16	69	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/featurecounts	featurecounts	9137500	\N	\N	t	2022-09-16 14:38:49.355+00
80	16	69	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/log	log	4637583	\N	\N	t	2022-09-16 14:38:49.747+00
81	16	69	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/mutant	mutant	2885983	\N	\N	t	2022-09-16 14:38:49.763+00
82	16	81	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/mutant/aux_info	aux_info	178853	\N	\N	t	2022-09-16 14:38:49.763+00
83	16	81	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/mutant/libParams	libParams	11763	\N	\N	t	2022-09-16 14:38:49.763+00
84	16	69	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/picard_metrics	picard_metrics	6843	\N	\N	t	2022-09-16 14:38:49.343+00
85	16	69	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/preseq	preseq	958802	\N	\N	t	2022-09-16 14:38:49.463+00
86	16	85	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/preseq/log	log	1237	\N	\N	t	2022-09-16 14:38:49.463+00
87	16	69	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/qualimap	qualimap	1001033	\N	\N	t	2022-09-16 11:52:47+00
88	16	87	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/qualimap/mutant	mutant	494866	\N	\N	t	2022-09-16 14:38:49.775+00
89	16	88	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/qualimap/mutant/css	css	166918	\N	\N	t	2022-09-16 14:38:49.775+00
90	16	88	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/qualimap/mutant/images_qualimapReport	images_qualimapReport	307915	\N	\N	t	2022-09-16 14:38:49.775+00
91	16	88	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/qualimap/mutant/raw_data_qualimapReport	raw_data_qualimapReport	7266	\N	\N	t	2022-09-16 14:38:49.775+00
92	16	87	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/qualimap/wildtype	wildtype	506167	\N	\N	t	2022-09-16 14:38:49.771+00
93	16	92	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/qualimap/wildtype/css	css	166918	\N	\N	t	2022-09-16 14:38:49.771+00
94	16	92	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/qualimap/wildtype/images_qualimapReport	images_qualimapReport	319178	\N	\N	t	2022-09-16 14:38:49.771+00
95	16	92	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/qualimap/wildtype/raw_data_qualimapReport	raw_data_qualimapReport	7302	\N	\N	t	2022-09-16 14:38:49.771+00
96	16	69	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/rseqc	rseqc	84439423	\N	\N	t	2022-09-16 11:49:23+00
97	16	96	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/rseqc/bam_stat	bam_stat	1711	\N	\N	t	2022-09-16 14:38:49.523+00
98	16	96	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/rseqc/infer_experiment	infer_experiment	422	\N	\N	t	2022-09-16 14:38:49.563+00
99	16	96	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/rseqc/inner_distance	inner_distance	47287707	\N	\N	t	2022-09-16 11:48:45+00
100	16	99	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/rseqc/inner_distance/pdf	pdf	17178	\N	\N	t	2022-09-16 14:38:49.519+00
101	16	99	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/rseqc/inner_distance/rscript	rscript	3157	\N	\N	t	2022-09-16 14:38:49.519+00
102	16	99	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/rseqc/inner_distance/txt	txt	47267372	\N	\N	t	2022-09-16 14:38:49.515+00
103	16	96	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/rseqc/junction_annotation	junction_annotation	37116606	\N	\N	t	2022-09-16 11:48:53+00
104	16	103	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/rseqc/junction_annotation/bed	bed	32473709	\N	\N	t	2022-09-16 14:38:49.555+00
105	16	103	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/rseqc/junction_annotation/log	log	1145	\N	\N	t	2022-09-16 14:38:49.563+00
106	16	103	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/rseqc/junction_annotation/pdf	pdf	52856	\N	\N	t	2022-09-16 14:38:49.563+00
107	16	103	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/rseqc/junction_annotation/rscript	rscript	1171	\N	\N	t	2022-09-16 14:38:49.563+00
108	16	103	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/rseqc/junction_annotation/xls	xls	4587725	\N	\N	t	2022-09-16 14:38:49.563+00
109	16	96	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/rseqc/junction_saturation	junction_saturation	12803	\N	\N	t	2022-09-16 11:49:23+00
110	16	109	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/rseqc/junction_saturation/pdf	pdf	11147	\N	\N	t	2022-09-16 14:38:49.523+00
111	16	109	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/rseqc/junction_saturation/rscript	rscript	1656	\N	\N	t	2022-09-16 14:38:49.523+00
112	16	96	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/rseqc/read_distribution	read_distribution	2306	\N	\N	t	2022-09-16 14:38:49.519+00
113	16	96	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/rseqc/read_duplication	read_duplication	17868	\N	\N	t	2022-09-16 11:47:47+00
114	16	113	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/rseqc/read_duplication/pdf	pdf	12896	\N	\N	t	2022-09-16 14:38:49.519+00
115	16	113	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/rseqc/read_duplication/rscript	rscript	3257	\N	\N	t	2022-09-16 14:38:49.519+00
116	16	113	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/rseqc/read_duplication/xls	xls	1715	\N	\N	t	2022-09-16 14:38:49.519+00
117	16	69	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/samtools_stats	samtools_stats	543166	\N	\N	t	2022-09-16 14:38:49.767+00
118	16	69	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/stringtie	stringtie	133671420	\N	\N	t	2022-09-16 14:38:49.711+00
119	16	118	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/stringtie/mutant.ballgown	mutant.ballgown	23739966	\N	\N	t	2022-09-16 14:38:49.675+00
120	16	118	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/stringtie/wildtype.ballgown	wildtype.ballgown	23727497	\N	\N	t	2022-09-16 14:38:49.707+00
121	16	69	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/wildtype	wildtype	2884406	\N	\N	t	2022-09-16 14:38:49.759+00
122	16	121	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/wildtype/aux_info	aux_info	177032	\N	\N	t	2022-09-16 14:38:49.759+00
123	16	121	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/wildtype/libParams	libParams	11776	\N	\N	t	2022-09-16 14:38:49.759+00
124	16	121	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/wildtype/logs	logs	2838	\N	\N	t	2022-09-16 14:38:49.759+00
125	16	58	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/trimgalore	trimgalore	3716963	\N	\N	t	2022-09-16 14:38:49.195+00
126	16	125	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/trimgalore/fastqc	fastqc	3702005	\N	\N	t	2022-09-16 14:38:49.195+00
127	16	59	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/fastqc/mutant_1_fastqc.html	mutant_1_fastqc.html	570159	-689469632	\N	f	2022-09-16 14:38:49.207+00
128	16	59	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/fastqc/mutant_1_fastqc.zip	mutant_1_fastqc.zip	311501	1317352976	\N	f	2022-09-16 14:38:49.207+00
129	16	59	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/fastqc/mutant_2_fastqc.html	mutant_2_fastqc.html	568779	1855838060	\N	f	2022-09-16 14:38:49.203+00
130	16	59	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/fastqc/mutant_2_fastqc.zip	mutant_2_fastqc.zip	308774	-1250152722	\N	f	2022-09-16 14:38:49.207+00
131	16	59	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/fastqc/wildtype_1_fastqc.html	wildtype_1_fastqc.html	606606	-116980239	\N	f	2022-09-16 14:38:49.203+00
132	16	59	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/fastqc/wildtype_1_fastqc.zip	wildtype_1_fastqc.zip	363892	-1138599866	\N	f	2022-09-16 14:38:49.207+00
133	16	59	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/fastqc/wildtype_2_fastqc.html	wildtype_2_fastqc.html	599938	805177130	\N	f	2022-09-16 14:38:49.203+00
134	16	59	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/fastqc/wildtype_2_fastqc.zip	wildtype_2_fastqc.zip	358499	-708486354	\N	f	2022-09-16 14:38:49.203+00
135	16	60	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/genome/README.txt	README.txt	257	58706730	\N	f	2022-09-16 14:38:49.207+00
136	16	63	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_data/mqc_cutadapt_filtered_reads_plot_1.txt	mqc_cutadapt_filtered_reads_plot_1.txt	133	523069855	\N	f	2022-09-16 14:38:49.807+00
137	16	63	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_data/mqc_cutadapt_trimmed_sequences_plot_3_Counts.txt	mqc_cutadapt_trimmed_sequences_plot_3_Counts.txt	2645	-214630613	\N	f	2022-09-16 14:38:49.811+00
138	16	63	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_data/mqc_cutadapt_trimmed_sequences_plot_3_Obs_Exp.txt	mqc_cutadapt_trimmed_sequences_plot_3_Obs_Exp.txt	3998	346835120	\N	f	2022-09-16 14:38:49.807+00
139	16	63	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_data/mqc_fastqc_adapter_content_plot_1.txt	mqc_fastqc_adapter_content_plot_1.txt	3238	1567199111	\N	f	2022-09-16 14:38:49.807+00
140	16	63	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_data/mqc_fastqc_per_base_n_content_plot-2_1.txt	mqc_fastqc_per_base_n_content_plot-2_1.txt	2661	1880088553	\N	f	2022-09-16 14:38:49.803+00
141	16	63	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_data/mqc_fastqc_per_base_n_content_plot_1.txt	mqc_fastqc_per_base_n_content_plot_1.txt	2957	-1188690856	\N	f	2022-09-16 14:38:49.803+00
142	16	63	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_data/mqc_fastqc_per_base_sequence_quality_plot-2_1.txt	mqc_fastqc_per_base_sequence_quality_plot-2_1.txt	2794	1534952098	\N	f	2022-09-16 14:38:49.807+00
143	16	63	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_data/mqc_fastqc_per_base_sequence_quality_plot_1.txt	mqc_fastqc_per_base_sequence_quality_plot_1.txt	2837	463040106	\N	f	2022-09-16 14:38:49.807+00
144	16	63	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_data/mqc_fastqc_per_sequence_gc_content_plot-2_Counts.txt	mqc_fastqc_per_sequence_gc_content_plot-2_Counts.txt	2959	138346768	\N	f	2022-09-16 14:38:49.803+00
145	16	63	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_data/mqc_fastqc_per_sequence_gc_content_plot-2_Percentages.txt	mqc_fastqc_per_sequence_gc_content_plot-2_Percentages.txt	7876	-2089558993	\N	f	2022-09-16 14:38:49.807+00
146	16	63	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_data/mqc_fastqc_per_sequence_gc_content_plot_Counts.txt	mqc_fastqc_per_sequence_gc_content_plot_Counts.txt	2927	467016875	\N	f	2022-09-16 14:38:49.811+00
147	16	63	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_data/mqc_fastqc_per_sequence_gc_content_plot_Percentages.txt	mqc_fastqc_per_sequence_gc_content_plot_Percentages.txt	7340	1509887650	\N	f	2022-09-16 14:38:49.803+00
148	16	63	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_data/mqc_fastqc_per_sequence_quality_scores_plot-2_1.txt	mqc_fastqc_per_sequence_quality_scores_plot-2_1.txt	1504	-1039035045	\N	f	2022-09-16 14:38:49.803+00
149	16	63	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_data/mqc_fastqc_per_sequence_quality_scores_plot_1.txt	mqc_fastqc_per_sequence_quality_scores_plot_1.txt	1881	1048689938	\N	f	2022-09-16 14:38:49.807+00
150	16	63	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_data/mqc_fastqc_sequence_counts_plot-2_1.txt	mqc_fastqc_sequence_counts_plot-2_1.txt	173	1661444762	\N	f	2022-09-16 14:38:49.803+00
151	16	63	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_data/mqc_fastqc_sequence_counts_plot_1.txt	mqc_fastqc_sequence_counts_plot_1.txt	174	-1272006437	\N	f	2022-09-16 14:38:49.807+00
152	16	63	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_data/mqc_fastqc_sequence_duplication_levels_plot-2_1.txt	mqc_fastqc_sequence_duplication_levels_plot-2_1.txt	627	1191643865	\N	f	2022-09-16 14:38:49.803+00
153	16	63	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_data/mqc_fastqc_sequence_duplication_levels_plot_1.txt	mqc_fastqc_sequence_duplication_levels_plot_1.txt	658	824039765	\N	f	2022-09-16 14:38:49.807+00
154	16	63	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_data/mqc_fastqc_sequence_length_distribution_plot_1.txt	mqc_fastqc_sequence_length_distribution_plot_1.txt	1126	441313835	\N	f	2022-09-16 14:38:49.803+00
155	16	63	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_data/mqc_featurecounts_biotype_plot_1.txt	mqc_featurecounts_biotype_plot_1.txt	238	1897116337	\N	f	2022-09-16 14:38:49.807+00
156	16	63	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_data/mqc_mqc_mplplot_qdmetuojzf_1.txt	mqc_mqc_mplplot_qdmetuojzf_1.txt	126376	-1819281416	\N	f	2022-09-16 14:38:49.803+00
157	16	63	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_data/mqc_picard_deduplication_1.txt	mqc_picard_deduplication_1.txt	184	-2142950687	\N	f	2022-09-16 14:38:49.807+00
158	16	63	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_data/mqc_preseq_plot_1.txt	mqc_preseq_plot_1.txt	36160	-1985482618	\N	f	2022-09-16 14:38:49.811+00
159	16	63	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_data/mqc_qualimap_gene_coverage_profile_Counts.txt	mqc_qualimap_gene_coverage_profile_Counts.txt	4067	765732641	\N	f	2022-09-16 14:38:49.811+00
160	16	63	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_data/mqc_qualimap_gene_coverage_profile_Normalised.txt	mqc_qualimap_gene_coverage_profile_Normalised.txt	4120	-754168211	\N	f	2022-09-16 14:38:49.807+00
161	16	63	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_data/mqc_qualimap_genomic_origin_1.txt	mqc_qualimap_genomic_origin_1.txt	132	-1899370270	\N	f	2022-09-16 14:38:49.803+00
162	16	63	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_data/mqc_rseqc_infer_experiment_plot_1.txt	mqc_rseqc_infer_experiment_plot_1.txt	114	-1957774435	\N	f	2022-09-16 14:38:49.807+00
163	16	63	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_data/mqc_rseqc_inner_distance_plot_Counts.txt	mqc_rseqc_inner_distance_plot_Counts.txt	1902	-603010959	\N	f	2022-09-16 14:38:49.811+00
164	16	63	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_data/mqc_rseqc_inner_distance_plot_Percentages.txt	mqc_rseqc_inner_distance_plot_Percentages.txt	3879	1716558163	\N	f	2022-09-16 14:38:49.803+00
165	16	63	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_data/mqc_rseqc_junction_annotation_junctions_plot_Events.txt	mqc_rseqc_junction_annotation_junctions_plot_Events.txt	167	213545780	\N	f	2022-09-16 14:38:49.811+00
166	16	63	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_data/mqc_rseqc_junction_annotation_junctions_plot_Junctions.txt	mqc_rseqc_junction_annotation_junctions_plot_Junctions.txt	174	687802607	\N	f	2022-09-16 14:38:49.803+00
167	16	63	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_data/mqc_rseqc_junction_saturation_plot_All_Junctions.txt	mqc_rseqc_junction_saturation_plot_All_Junctions.txt	471	127566662	\N	f	2022-09-16 14:38:49.803+00
168	16	63	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_data/mqc_rseqc_junction_saturation_plot_Known_Junctions.txt	mqc_rseqc_junction_saturation_plot_Known_Junctions.txt	471	892107327	\N	f	2022-09-16 14:38:49.811+00
169	16	63	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_data/mqc_rseqc_junction_saturation_plot_Novel_Junctions.txt	mqc_rseqc_junction_saturation_plot_Novel_Junctions.txt	401	-763842164	\N	f	2022-09-16 14:38:49.807+00
170	16	63	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_data/mqc_rseqc_read_distribution_plot_1.txt	mqc_rseqc_read_distribution_plot_1.txt	313	-972380374	\N	f	2022-09-16 14:38:49.807+00
171	16	63	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_data/mqc_rseqc_read_dups_plot_1.txt	mqc_rseqc_read_dups_plot_1.txt	843	560532486	\N	f	2022-09-16 14:38:49.807+00
172	16	63	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_data/mqc_samtools-idxstats-mapped-reads-plot_Normalised_Counts.txt	mqc_samtools-idxstats-mapped-reads-plot_Normalised_Counts.txt	302	112292048	\N	f	2022-09-16 14:38:49.811+00
173	16	63	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_data/mqc_samtools-idxstats-mapped-reads-plot_Observed_over_Expected_Counts.txt	mqc_samtools-idxstats-mapped-reads-plot_Observed_over_Expected_Counts.txt	288	300155221	\N	f	2022-09-16 14:38:49.807+00
174	16	63	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_data/mqc_samtools-idxstats-mapped-reads-plot_Raw_Counts.txt	mqc_samtools-idxstats-mapped-reads-plot_Raw_Counts.txt	144	-1984397221	\N	f	2022-09-16 14:38:49.803+00
175	16	63	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_data/mqc_samtools_alignment_plot_1.txt	mqc_samtools_alignment_plot_1.txt	78	486250675	\N	f	2022-09-16 14:38:49.807+00
176	16	63	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_data/mqc_star_alignment_plot_1.txt	mqc_star_alignment_plot_1.txt	217	853280211	\N	f	2022-09-16 14:38:49.803+00
177	16	63	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_data/multiqc.log	multiqc.log	21834	728250913	\N	f	2022-09-16 14:38:49.811+00
178	16	63	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_data/multiqc_cutadapt.txt	multiqc_cutadapt.txt	463	1948093910	\N	f	2022-09-16 14:38:49.803+00
179	16	63	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_data/multiqc_data.json	multiqc_data.json	1682821	304634992	\N	f	2022-09-16 14:38:49.807+00
180	16	63	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_data/multiqc_fastqc.txt	multiqc_fastqc.txt	1114	-677728013	\N	f	2022-09-16 14:38:49.811+00
181	16	63	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_data/multiqc_fastqc_1.txt	multiqc_fastqc_1.txt	1181	-105601142	\N	f	2022-09-16 14:38:49.811+00
182	16	63	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_data/multiqc_general_stats.txt	multiqc_general_stats.txt	2581	1688596288	\N	f	2022-09-16 14:38:49.803+00
183	16	63	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_data/multiqc_picard_dups.txt	multiqc_picard_dups.txt	428	-1467139836	\N	f	2022-09-16 14:38:49.803+00
184	16	63	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_data/multiqc_rseqc_bam_stat.txt	multiqc_rseqc_bam_stat.txt	624	506285857	\N	f	2022-09-16 14:38:49.807+00
185	16	63	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_data/multiqc_rseqc_infer_experiment.txt	multiqc_rseqc_infer_experiment.txt	122	1167502254	\N	f	2022-09-16 14:38:49.803+00
186	16	63	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_data/multiqc_rseqc_junction_annotation.txt	multiqc_rseqc_junction_annotation.txt	752	1769566230	\N	f	2022-09-16 14:38:49.803+00
187	16	63	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_data/multiqc_rseqc_read_distribution.txt	multiqc_rseqc_read_distribution.txt	1858	-1053263040	\N	f	2022-09-16 14:38:49.807+00
188	16	63	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_data/multiqc_samtools_flagstat.txt	multiqc_samtools_flagstat.txt	1100	-128578009	\N	f	2022-09-16 14:38:49.811+00
189	16	63	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_data/multiqc_samtools_idxstats.txt	multiqc_samtools_idxstats.txt	331	-932995731	\N	f	2022-09-16 14:38:49.803+00
190	16	63	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_data/multiqc_samtools_stats.txt	multiqc_samtools_stats.txt	1805	620577092	\N	f	2022-09-16 14:38:49.807+00
191	16	63	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_data/multiqc_sources.txt	multiqc_sources.txt	6798	-1354791235	\N	f	2022-09-16 14:38:49.807+00
192	16	63	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_data/multiqc_star.txt	multiqc_star.txt	845	198753304	\N	f	2022-09-16 14:38:49.803+00
193	16	63	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_data/multiqc_warning:_fail_strand_check.txt	multiqc_warning:_fail_strand_check.txt	284	581149747	\N	f	2022-09-16 14:38:49.811+00
194	16	65	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_cutadapt_filtered_reads_plot_1.pdf	mqc_cutadapt_filtered_reads_plot_1.pdf	12492	727973470	\N	f	2022-09-16 14:38:49.803+00
195	16	65	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_cutadapt_filtered_reads_plot_1_pc.pdf	mqc_cutadapt_filtered_reads_plot_1_pc.pdf	12654	-685098747	\N	f	2022-09-16 14:38:49.795+00
196	16	65	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_cutadapt_trimmed_sequences_plot_3_Counts.pdf	mqc_cutadapt_trimmed_sequences_plot_3_Counts.pdf	17929	-1189725423	\N	f	2022-09-16 14:38:49.799+00
197	16	65	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_cutadapt_trimmed_sequences_plot_3_Obs_Exp.pdf	mqc_cutadapt_trimmed_sequences_plot_3_Obs_Exp.pdf	18416	-655502869	\N	f	2022-09-16 14:38:49.799+00
198	16	65	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_fastqc_adapter_content_plot_1.pdf	mqc_fastqc_adapter_content_plot_1.pdf	16964	-1864760507	\N	f	2022-09-16 14:38:49.803+00
199	16	65	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_fastqc_per_base_n_content_plot-2_1.pdf	mqc_fastqc_per_base_n_content_plot-2_1.pdf	16333	1066557444	\N	f	2022-09-16 14:38:49.799+00
200	16	65	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_fastqc_per_base_n_content_plot_1.pdf	mqc_fastqc_per_base_n_content_plot_1.pdf	16472	414489930	\N	f	2022-09-16 14:38:49.803+00
201	16	65	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_fastqc_per_base_sequence_quality_plot-2_1.pdf	mqc_fastqc_per_base_sequence_quality_plot-2_1.pdf	16252	743871662	\N	f	2022-09-16 14:38:49.799+00
202	16	65	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_fastqc_per_base_sequence_quality_plot_1.pdf	mqc_fastqc_per_base_sequence_quality_plot_1.pdf	16242	767442721	\N	f	2022-09-16 14:38:49.799+00
203	16	65	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_fastqc_per_sequence_gc_content_plot-2_Counts.pdf	mqc_fastqc_per_sequence_gc_content_plot-2_Counts.pdf	17559	1440468074	\N	f	2022-09-16 14:38:49.803+00
204	16	65	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_fastqc_per_sequence_gc_content_plot-2_Percentages.pdf	mqc_fastqc_per_sequence_gc_content_plot-2_Percentages.pdf	18017	1676760814	\N	f	2022-09-16 14:38:49.799+00
205	16	65	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_fastqc_per_sequence_gc_content_plot_Counts.pdf	mqc_fastqc_per_sequence_gc_content_plot_Counts.pdf	17389	-484556619	\N	f	2022-09-16 14:38:49.799+00
206	16	65	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_fastqc_per_sequence_gc_content_plot_Percentages.pdf	mqc_fastqc_per_sequence_gc_content_plot_Percentages.pdf	17835	621685106	\N	f	2022-09-16 14:38:49.799+00
207	16	65	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_fastqc_per_sequence_quality_scores_plot-2_1.pdf	mqc_fastqc_per_sequence_quality_scores_plot-2_1.pdf	15321	203891060	\N	f	2022-09-16 14:38:49.799+00
208	16	65	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_fastqc_per_sequence_quality_scores_plot_1.pdf	mqc_fastqc_per_sequence_quality_scores_plot_1.pdf	15521	1464834151	\N	f	2022-09-16 14:38:49.799+00
209	16	65	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_fastqc_sequence_counts_plot-2_1.pdf	mqc_fastqc_sequence_counts_plot-2_1.pdf	14760	-1272816282	\N	f	2022-09-16 14:38:49.799+00
210	16	65	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_fastqc_sequence_counts_plot-2_1_pc.pdf	mqc_fastqc_sequence_counts_plot-2_1_pc.pdf	14924	1942702371	\N	f	2022-09-16 14:38:49.803+00
211	16	65	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_fastqc_sequence_counts_plot_1.pdf	mqc_fastqc_sequence_counts_plot_1.pdf	14764	1055999477	\N	f	2022-09-16 14:38:49.803+00
212	16	65	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_fastqc_sequence_counts_plot_1_pc.pdf	mqc_fastqc_sequence_counts_plot_1_pc.pdf	14923	-223244245	\N	f	2022-09-16 14:38:49.799+00
213	16	65	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_fastqc_sequence_duplication_levels_plot-2_1.pdf	mqc_fastqc_sequence_duplication_levels_plot-2_1.pdf	17119	364467151	\N	f	2022-09-16 14:38:49.803+00
214	16	65	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_fastqc_sequence_duplication_levels_plot_1.pdf	mqc_fastqc_sequence_duplication_levels_plot_1.pdf	17128	1820211848	\N	f	2022-09-16 14:38:49.803+00
215	16	65	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_fastqc_sequence_length_distribution_plot_1.pdf	mqc_fastqc_sequence_length_distribution_plot_1.pdf	16721	-517568734	\N	f	2022-09-16 14:38:49.799+00
216	16	65	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_featurecounts_biotype_plot_1.pdf	mqc_featurecounts_biotype_plot_1.pdf	14162	1888546761	\N	f	2022-09-16 14:38:49.799+00
217	16	65	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_featurecounts_biotype_plot_1_pc.pdf	mqc_featurecounts_biotype_plot_1_pc.pdf	14958	-1334466506	\N	f	2022-09-16 14:38:49.803+00
218	16	65	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_mqc_mplplot_qdmetuojzf_1.pdf	mqc_mqc_mplplot_qdmetuojzf_1.pdf	14943	1271803378	\N	f	2022-09-16 14:38:49.803+00
219	16	65	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_picard_deduplication_1.pdf	mqc_picard_deduplication_1.pdf	13676	1407722085	\N	f	2022-09-16 14:38:49.799+00
220	16	65	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_picard_deduplication_1_pc.pdf	mqc_picard_deduplication_1_pc.pdf	13945	-1354786891	\N	f	2022-09-16 14:38:49.799+00
221	16	65	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_preseq_plot_1.pdf	mqc_preseq_plot_1.pdf	16621	-488622076	\N	f	2022-09-16 14:38:49.799+00
222	16	65	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_qualimap_gene_coverage_profile_Counts.pdf	mqc_qualimap_gene_coverage_profile_Counts.pdf	18404	-1169547519	\N	f	2022-09-16 14:38:49.799+00
223	16	65	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_qualimap_gene_coverage_profile_Normalised.pdf	mqc_qualimap_gene_coverage_profile_Normalised.pdf	17958	1417144966	\N	f	2022-09-16 14:38:49.799+00
224	16	65	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_qualimap_genomic_origin_1.pdf	mqc_qualimap_genomic_origin_1.pdf	14827	-53690591	\N	f	2022-09-16 14:38:49.799+00
225	16	65	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_qualimap_genomic_origin_1_pc.pdf	mqc_qualimap_genomic_origin_1_pc.pdf	15109	1915029987	\N	f	2022-09-16 14:38:49.799+00
226	16	65	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_rseqc_infer_experiment_plot_1.pdf	mqc_rseqc_infer_experiment_plot_1.pdf	13898	1795840494	\N	f	2022-09-16 14:38:49.803+00
227	16	65	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_rseqc_inner_distance_plot_Counts.pdf	mqc_rseqc_inner_distance_plot_Counts.pdf	14795	-599277137	\N	f	2022-09-16 14:38:49.799+00
228	16	65	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_rseqc_inner_distance_plot_Percentages.pdf	mqc_rseqc_inner_distance_plot_Percentages.pdf	15443	-533772685	\N	f	2022-09-16 14:38:49.799+00
229	16	65	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_rseqc_junction_annotation_junctions_plot_Events.pdf	mqc_rseqc_junction_annotation_junctions_plot_Events.pdf	14486	293987174	\N	f	2022-09-16 14:38:49.803+00
230	16	65	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_rseqc_junction_annotation_junctions_plot_Events_pc.pdf	mqc_rseqc_junction_annotation_junctions_plot_Events_pc.pdf	14584	1935140604	\N	f	2022-09-16 14:38:49.803+00
231	16	65	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_rseqc_junction_annotation_junctions_plot_Junctions.pdf	mqc_rseqc_junction_annotation_junctions_plot_Junctions.pdf	14958	-1707653372	\N	f	2022-09-16 14:38:49.799+00
232	16	65	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_rseqc_junction_annotation_junctions_plot_Junctions_pc.pdf	mqc_rseqc_junction_annotation_junctions_plot_Junctions_pc.pdf	14387	-1241092250	\N	f	2022-09-16 14:38:49.799+00
233	16	65	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_rseqc_junction_saturation_plot_All_Junctions.pdf	mqc_rseqc_junction_saturation_plot_All_Junctions.pdf	14961	-1741114980	\N	f	2022-09-16 14:38:49.795+00
234	16	65	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_rseqc_junction_saturation_plot_Known_Junctions.pdf	mqc_rseqc_junction_saturation_plot_Known_Junctions.pdf	14957	302502250	\N	f	2022-09-16 14:38:49.799+00
235	16	65	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_rseqc_junction_saturation_plot_Novel_Junctions.pdf	mqc_rseqc_junction_saturation_plot_Novel_Junctions.pdf	14267	304668617	\N	f	2022-09-16 14:38:49.799+00
236	16	65	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_rseqc_read_distribution_plot_1.pdf	mqc_rseqc_read_distribution_plot_1.pdf	17239	-1490176632	\N	f	2022-09-16 14:38:49.799+00
237	16	65	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_rseqc_read_distribution_plot_1_pc.pdf	mqc_rseqc_read_distribution_plot_1_pc.pdf	18027	-288527406	\N	f	2022-09-16 14:38:49.799+00
238	16	65	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_rseqc_read_dups_plot_1.pdf	mqc_rseqc_read_dups_plot_1.pdf	16313	937322520	\N	f	2022-09-16 14:38:49.799+00
239	16	65	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_samtools-idxstats-mapped-reads-plot_Normalised_Counts.pdf	mqc_samtools-idxstats-mapped-reads-plot_Normalised_Counts.pdf	13757	164055601	\N	f	2022-09-16 14:38:49.795+00
269	16	66	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/png/mqc_featurecounts_biotype_plot_1_pc.png	mqc_featurecounts_biotype_plot_1_pc.png	13388	-1343040296	\N	f	2022-09-16 14:38:49.791+00
240	16	65	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_samtools-idxstats-mapped-reads-plot_Observed_over_Expected_Counts.pdf	mqc_samtools-idxstats-mapped-reads-plot_Observed_over_Expected_Counts.pdf	14836	1455473872	\N	f	2022-09-16 14:38:49.803+00
241	16	65	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_samtools-idxstats-mapped-reads-plot_Raw_Counts.pdf	mqc_samtools-idxstats-mapped-reads-plot_Raw_Counts.pdf	13499	1059522463	\N	f	2022-09-16 14:38:49.799+00
242	16	65	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_samtools_alignment_plot_1.pdf	mqc_samtools_alignment_plot_1.pdf	12817	-1642676200	\N	f	2022-09-16 14:38:49.795+00
243	16	65	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_samtools_alignment_plot_1_pc.pdf	mqc_samtools_alignment_plot_1_pc.pdf	13096	-179564162	\N	f	2022-09-16 14:38:49.799+00
244	16	65	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_star_alignment_plot_1.pdf	mqc_star_alignment_plot_1.pdf	14423	2069736191	\N	f	2022-09-16 14:38:49.799+00
245	16	65	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_star_alignment_plot_1_pc.pdf	mqc_star_alignment_plot_1_pc.pdf	14581	-1917764266	\N	f	2022-09-16 14:38:49.799+00
246	16	66	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/png/mqc_cutadapt_filtered_reads_plot_1.png	mqc_cutadapt_filtered_reads_plot_1.png	10408	850243321	\N	f	2022-09-16 14:38:49.791+00
247	16	66	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/png/mqc_cutadapt_filtered_reads_plot_1_pc.png	mqc_cutadapt_filtered_reads_plot_1_pc.png	10669	-1818926373	\N	f	2022-09-16 14:38:49.795+00
248	16	66	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/png/mqc_cutadapt_trimmed_sequences_plot_3_Counts.png	mqc_cutadapt_trimmed_sequences_plot_3_Counts.png	25706	-710574731	\N	f	2022-09-16 14:38:49.795+00
249	16	66	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/png/mqc_cutadapt_trimmed_sequences_plot_3_Obs_Exp.png	mqc_cutadapt_trimmed_sequences_plot_3_Obs_Exp.png	27862	-848060063	\N	f	2022-09-16 14:38:49.791+00
250	16	66	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/png/mqc_fastqc_adapter_content_plot_1.png	mqc_fastqc_adapter_content_plot_1.png	17378	-1996376286	\N	f	2022-09-16 14:38:49.791+00
251	16	66	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/png/mqc_fastqc_per_base_n_content_plot-2_1.png	mqc_fastqc_per_base_n_content_plot-2_1.png	19662	-1485999070	\N	f	2022-09-16 14:38:49.791+00
252	16	66	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/png/mqc_fastqc_per_base_n_content_plot_1.png	mqc_fastqc_per_base_n_content_plot_1.png	21933	544368351	\N	f	2022-09-16 14:38:49.791+00
253	16	66	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/png/mqc_fastqc_per_base_sequence_quality_plot-2_1.png	mqc_fastqc_per_base_sequence_quality_plot-2_1.png	32706	-1043753054	\N	f	2022-09-16 14:38:49.795+00
254	16	66	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/png/mqc_fastqc_per_base_sequence_quality_plot_1.png	mqc_fastqc_per_base_sequence_quality_plot_1.png	35376	12959318	\N	f	2022-09-16 14:38:49.795+00
255	16	66	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/png/mqc_fastqc_per_sequence_gc_content_plot-2_Counts.png	mqc_fastqc_per_sequence_gc_content_plot-2_Counts.png	45839	888535057	\N	f	2022-09-16 14:38:49.791+00
256	16	66	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/png/mqc_fastqc_per_sequence_gc_content_plot-2_Percentages.png	mqc_fastqc_per_sequence_gc_content_plot-2_Percentages.png	46100	-1816776736	\N	f	2022-09-16 14:38:49.791+00
257	16	66	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/png/mqc_fastqc_per_sequence_gc_content_plot_Counts.png	mqc_fastqc_per_sequence_gc_content_plot_Counts.png	45420	-2130749063	\N	f	2022-09-16 14:38:49.795+00
258	16	66	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/png/mqc_fastqc_per_sequence_gc_content_plot_Percentages.png	mqc_fastqc_per_sequence_gc_content_plot_Percentages.png	45401	1563543876	\N	f	2022-09-16 14:38:49.795+00
259	16	66	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/png/mqc_fastqc_per_sequence_quality_scores_plot-2_1.png	mqc_fastqc_per_sequence_quality_scores_plot-2_1.png	44750	-284102242	\N	f	2022-09-16 14:38:49.795+00
260	16	66	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/png/mqc_fastqc_per_sequence_quality_scores_plot_1.png	mqc_fastqc_per_sequence_quality_scores_plot_1.png	47051	-1021634694	\N	f	2022-09-16 14:38:49.791+00
261	16	66	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/png/mqc_fastqc_sequence_counts_plot-2_1.png	mqc_fastqc_sequence_counts_plot-2_1.png	11519	-1549735945	\N	f	2022-09-16 14:38:49.795+00
262	16	66	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/png/mqc_fastqc_sequence_counts_plot-2_1_pc.png	mqc_fastqc_sequence_counts_plot-2_1_pc.png	11775	1913055779	\N	f	2022-09-16 14:38:49.795+00
263	16	66	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/png/mqc_fastqc_sequence_counts_plot_1.png	mqc_fastqc_sequence_counts_plot_1.png	11517	-709510576	\N	f	2022-09-16 14:38:49.795+00
264	16	66	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/png/mqc_fastqc_sequence_counts_plot_1_pc.png	mqc_fastqc_sequence_counts_plot_1_pc.png	11772	-1718050014	\N	f	2022-09-16 14:38:49.791+00
265	16	66	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/png/mqc_fastqc_sequence_duplication_levels_plot-2_1.png	mqc_fastqc_sequence_duplication_levels_plot-2_1.png	30622	2041003573	\N	f	2022-09-16 14:38:49.791+00
266	16	66	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/png/mqc_fastqc_sequence_duplication_levels_plot_1.png	mqc_fastqc_sequence_duplication_levels_plot_1.png	30473	325703166	\N	f	2022-09-16 14:38:49.791+00
267	16	66	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/png/mqc_fastqc_sequence_length_distribution_plot_1.png	mqc_fastqc_sequence_length_distribution_plot_1.png	29105	-1773434126	\N	f	2022-09-16 14:38:49.791+00
268	16	66	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/png/mqc_featurecounts_biotype_plot_1.png	mqc_featurecounts_biotype_plot_1.png	13072	-930951832	\N	f	2022-09-16 14:38:49.791+00
362	16	71	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/deseq2_qc/deseq2.dds.RData	deseq2.dds.RData	506472	-1521392315	\N	f	2022-09-16 14:38:49.779+00
270	16	66	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/png/mqc_mqc_mplplot_qdmetuojzf_1.png	mqc_mqc_mplplot_qdmetuojzf_1.png	21185	-101464358	\N	f	2022-09-16 14:38:49.791+00
271	16	66	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/png/mqc_picard_deduplication_1.png	mqc_picard_deduplication_1.png	10485	1766522251	\N	f	2022-09-16 14:38:49.791+00
272	16	66	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/png/mqc_picard_deduplication_1_pc.png	mqc_picard_deduplication_1_pc.png	10977	-525360250	\N	f	2022-09-16 14:38:49.791+00
273	16	66	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/png/mqc_preseq_plot_1.png	mqc_preseq_plot_1.png	41028	760407970	\N	f	2022-09-16 14:38:49.795+00
274	16	66	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/png/mqc_qualimap_gene_coverage_profile_Counts.png	mqc_qualimap_gene_coverage_profile_Counts.png	49914	-1839997314	\N	f	2022-09-16 14:38:49.795+00
275	16	66	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/png/mqc_qualimap_gene_coverage_profile_Normalised.png	mqc_qualimap_gene_coverage_profile_Normalised.png	49863	1058912045	\N	f	2022-09-16 14:38:49.795+00
276	16	66	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/png/mqc_qualimap_genomic_origin_1.png	mqc_qualimap_genomic_origin_1.png	9269	1560389940	\N	f	2022-09-16 14:38:49.795+00
277	16	66	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/png/mqc_qualimap_genomic_origin_1_pc.png	mqc_qualimap_genomic_origin_1_pc.png	9701	300256777	\N	f	2022-09-16 14:38:49.795+00
278	16	66	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/png/mqc_rseqc_infer_experiment_plot_1.png	mqc_rseqc_infer_experiment_plot_1.png	9324	785854637	\N	f	2022-09-16 14:38:49.795+00
279	16	66	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/png/mqc_rseqc_inner_distance_plot_Counts.png	mqc_rseqc_inner_distance_plot_Counts.png	38056	102109656	\N	f	2022-09-16 14:38:49.791+00
280	16	66	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/png/mqc_rseqc_inner_distance_plot_Percentages.png	mqc_rseqc_inner_distance_plot_Percentages.png	36924	369755332	\N	f	2022-09-16 14:38:49.795+00
281	16	66	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/png/mqc_rseqc_junction_annotation_junctions_plot_Events.png	mqc_rseqc_junction_annotation_junctions_plot_Events.png	11223	740183492	\N	f	2022-09-16 14:38:49.791+00
282	16	66	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/png/mqc_rseqc_junction_annotation_junctions_plot_Events_pc.png	mqc_rseqc_junction_annotation_junctions_plot_Events_pc.png	12044	1744930085	\N	f	2022-09-16 14:38:49.795+00
283	16	66	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/png/mqc_rseqc_junction_annotation_junctions_plot_Junctions.png	mqc_rseqc_junction_annotation_junctions_plot_Junctions.png	11505	24073869	\N	f	2022-09-16 14:38:49.795+00
284	16	66	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/png/mqc_rseqc_junction_annotation_junctions_plot_Junctions_pc.png	mqc_rseqc_junction_annotation_junctions_plot_Junctions_pc.png	12179	-1148267697	\N	f	2022-09-16 14:38:49.795+00
285	16	66	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/png/mqc_rseqc_junction_saturation_plot_All_Junctions.png	mqc_rseqc_junction_saturation_plot_All_Junctions.png	35864	-668873581	\N	f	2022-09-16 14:38:49.795+00
286	16	66	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/png/mqc_rseqc_junction_saturation_plot_Known_Junctions.png	mqc_rseqc_junction_saturation_plot_Known_Junctions.png	35460	-628659328	\N	f	2022-09-16 14:38:49.791+00
287	16	66	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/png/mqc_rseqc_junction_saturation_plot_Novel_Junctions.png	mqc_rseqc_junction_saturation_plot_Novel_Junctions.png	29829	582929271	\N	f	2022-09-16 14:38:49.795+00
288	16	66	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/png/mqc_rseqc_read_distribution_plot_1.png	mqc_rseqc_read_distribution_plot_1.png	14758	1415802018	\N	f	2022-09-16 14:38:49.791+00
289	16	66	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/png/mqc_rseqc_read_distribution_plot_1_pc.png	mqc_rseqc_read_distribution_plot_1_pc.png	15102	2047627998	\N	f	2022-09-16 14:38:49.795+00
290	16	66	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/png/mqc_rseqc_read_dups_plot_1.png	mqc_rseqc_read_dups_plot_1.png	20031	1982359820	\N	f	2022-09-16 14:38:49.795+00
291	16	66	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/png/mqc_samtools-idxstats-mapped-reads-plot_Normalised_Counts.png	mqc_samtools-idxstats-mapped-reads-plot_Normalised_Counts.png	43869	-1164483279	\N	f	2022-09-16 14:38:49.791+00
292	16	66	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/png/mqc_samtools-idxstats-mapped-reads-plot_Observed_over_Expected_Counts.png	mqc_samtools-idxstats-mapped-reads-plot_Observed_over_Expected_Counts.png	35607	533336611	\N	f	2022-09-16 14:38:49.791+00
293	16	66	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/png/mqc_samtools-idxstats-mapped-reads-plot_Raw_Counts.png	mqc_samtools-idxstats-mapped-reads-plot_Raw_Counts.png	46015	-1512031243	\N	f	2022-09-16 14:38:49.795+00
294	16	66	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/png/mqc_samtools_alignment_plot_1.png	mqc_samtools_alignment_plot_1.png	8040	-1620753528	\N	f	2022-09-16 14:38:49.795+00
295	16	66	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/png/mqc_samtools_alignment_plot_1_pc.png	mqc_samtools_alignment_plot_1_pc.png	8549	-1439451736	\N	f	2022-09-16 14:38:49.791+00
296	16	66	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/png/mqc_star_alignment_plot_1.png	mqc_star_alignment_plot_1.png	11594	-699730969	\N	f	2022-09-16 14:38:49.795+00
297	16	66	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/png/mqc_star_alignment_plot_1_pc.png	mqc_star_alignment_plot_1_pc.png	11860	-1511340831	\N	f	2022-09-16 14:38:49.795+00
298	16	67	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/svg/mqc_cutadapt_filtered_reads_plot_1.svg	mqc_cutadapt_filtered_reads_plot_1.svg	24690	1391641271	\N	f	2022-09-16 14:38:49.783+00
299	16	67	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/svg/mqc_cutadapt_filtered_reads_plot_1_pc.svg	mqc_cutadapt_filtered_reads_plot_1_pc.svg	23782	1873138459	\N	f	2022-09-16 14:38:49.783+00
300	16	67	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/svg/mqc_cutadapt_trimmed_sequences_plot_3_Counts.svg	mqc_cutadapt_trimmed_sequences_plot_3_Counts.svg	44356	-93708403	\N	f	2022-09-16 14:38:49.787+00
301	16	67	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/svg/mqc_cutadapt_trimmed_sequences_plot_3_Obs_Exp.svg	mqc_cutadapt_trimmed_sequences_plot_3_Obs_Exp.svg	44203	-342484949	\N	f	2022-09-16 14:38:49.787+00
302	16	67	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/svg/mqc_fastqc_adapter_content_plot_1.svg	mqc_fastqc_adapter_content_plot_1.svg	35201	797480831	\N	f	2022-09-16 14:38:49.783+00
303	16	67	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/svg/mqc_fastqc_per_base_n_content_plot-2_1.svg	mqc_fastqc_per_base_n_content_plot-2_1.svg	33995	47860857	\N	f	2022-09-16 14:38:49.783+00
304	16	67	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/svg/mqc_fastqc_per_base_n_content_plot_1.svg	mqc_fastqc_per_base_n_content_plot_1.svg	34002	886067107	\N	f	2022-09-16 14:38:49.787+00
305	16	67	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/svg/mqc_fastqc_per_base_sequence_quality_plot-2_1.svg	mqc_fastqc_per_base_sequence_quality_plot-2_1.svg	33861	-408545617	\N	f	2022-09-16 14:38:49.791+00
306	16	67	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/svg/mqc_fastqc_per_base_sequence_quality_plot_1.svg	mqc_fastqc_per_base_sequence_quality_plot_1.svg	33867	-1651996081	\N	f	2022-09-16 14:38:49.787+00
307	16	67	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/svg/mqc_fastqc_per_sequence_gc_content_plot-2_Counts.svg	mqc_fastqc_per_sequence_gc_content_plot-2_Counts.svg	40190	-1917708655	\N	f	2022-09-16 14:38:49.787+00
308	16	67	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/svg/mqc_fastqc_per_sequence_gc_content_plot-2_Percentages.svg	mqc_fastqc_per_sequence_gc_content_plot-2_Percentages.svg	38579	-182115647	\N	f	2022-09-16 14:38:49.783+00
309	16	67	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/svg/mqc_fastqc_per_sequence_gc_content_plot_Counts.svg	mqc_fastqc_per_sequence_gc_content_plot_Counts.svg	40158	1513242729	\N	f	2022-09-16 14:38:49.787+00
310	16	67	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/svg/mqc_fastqc_per_sequence_gc_content_plot_Percentages.svg	mqc_fastqc_per_sequence_gc_content_plot_Percentages.svg	38560	583984728	\N	f	2022-09-16 14:38:49.787+00
311	16	67	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/svg/mqc_fastqc_per_sequence_quality_scores_plot-2_1.svg	mqc_fastqc_per_sequence_quality_scores_plot-2_1.svg	35286	-210601262	\N	f	2022-09-16 14:38:49.787+00
312	16	67	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/svg/mqc_fastqc_per_sequence_quality_scores_plot_1.svg	mqc_fastqc_per_sequence_quality_scores_plot_1.svg	36029	-1343033794	\N	f	2022-09-16 14:38:49.787+00
313	16	67	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/svg/mqc_fastqc_sequence_counts_plot-2_1.svg	mqc_fastqc_sequence_counts_plot-2_1.svg	29360	-1607245589	\N	f	2022-09-16 14:38:49.787+00
314	16	67	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/svg/mqc_fastqc_sequence_counts_plot-2_1_pc.svg	mqc_fastqc_sequence_counts_plot-2_1_pc.svg	28452	1152773858	\N	f	2022-09-16 14:38:49.783+00
315	16	67	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/svg/mqc_fastqc_sequence_counts_plot_1.svg	mqc_fastqc_sequence_counts_plot_1.svg	29352	1696911206	\N	f	2022-09-16 14:38:49.787+00
316	16	67	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/svg/mqc_fastqc_sequence_counts_plot_1_pc.svg	mqc_fastqc_sequence_counts_plot_1_pc.svg	28448	-902897650	\N	f	2022-09-16 14:38:49.787+00
317	16	67	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/svg/mqc_fastqc_sequence_duplication_levels_plot-2_1.svg	mqc_fastqc_sequence_duplication_levels_plot-2_1.svg	37098	1619729921	\N	f	2022-09-16 14:38:49.783+00
318	16	67	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/svg/mqc_fastqc_sequence_duplication_levels_plot_1.svg	mqc_fastqc_sequence_duplication_levels_plot_1.svg	37102	-130924833	\N	f	2022-09-16 14:38:49.783+00
319	16	67	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/svg/mqc_fastqc_sequence_length_distribution_plot_1.svg	mqc_fastqc_sequence_length_distribution_plot_1.svg	34450	-1713466229	\N	f	2022-09-16 14:38:49.787+00
320	16	67	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/svg/mqc_featurecounts_biotype_plot_1.svg	mqc_featurecounts_biotype_plot_1.svg	32217	1373354490	\N	f	2022-09-16 14:38:49.783+00
321	16	67	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/svg/mqc_featurecounts_biotype_plot_1_pc.svg	mqc_featurecounts_biotype_plot_1_pc.svg	32339	1682587262	\N	f	2022-09-16 14:38:49.787+00
322	16	67	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/svg/mqc_mqc_mplplot_qdmetuojzf_1.svg	mqc_mqc_mplplot_qdmetuojzf_1.svg	28243	-791683729	\N	f	2022-09-16 14:38:49.787+00
323	16	67	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/svg/mqc_picard_deduplication_1.svg	mqc_picard_deduplication_1.svg	28453	716771728	\N	f	2022-09-16 14:38:49.783+00
324	16	67	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/svg/mqc_picard_deduplication_1_pc.svg	mqc_picard_deduplication_1_pc.svg	28460	1538648374	\N	f	2022-09-16 14:38:49.783+00
325	16	67	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/svg/mqc_preseq_plot_1.svg	mqc_preseq_plot_1.svg	35845	777982709	\N	f	2022-09-16 14:38:49.787+00
326	16	67	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/svg/mqc_qualimap_gene_coverage_profile_Counts.svg	mqc_qualimap_gene_coverage_profile_Counts.svg	37869	-879915031	\N	f	2022-09-16 14:38:49.787+00
327	16	67	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/svg/mqc_qualimap_gene_coverage_profile_Normalised.svg	mqc_qualimap_gene_coverage_profile_Normalised.svg	37070	-1361604135	\N	f	2022-09-16 14:38:49.787+00
328	16	67	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/svg/mqc_qualimap_genomic_origin_1.svg	mqc_qualimap_genomic_origin_1.svg	27413	-391176710	\N	f	2022-09-16 14:38:49.791+00
329	16	67	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/svg/mqc_qualimap_genomic_origin_1_pc.svg	mqc_qualimap_genomic_origin_1_pc.svg	27424	967159321	\N	f	2022-09-16 14:38:49.787+00
330	16	67	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/svg/mqc_rseqc_infer_experiment_plot_1.svg	mqc_rseqc_infer_experiment_plot_1.svg	24524	-1553090892	\N	f	2022-09-16 14:38:49.787+00
331	16	67	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/svg/mqc_rseqc_inner_distance_plot_Counts.svg	mqc_rseqc_inner_distance_plot_Counts.svg	28584	849838264	\N	f	2022-09-16 14:38:49.787+00
332	16	67	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/svg/mqc_rseqc_inner_distance_plot_Percentages.svg	mqc_rseqc_inner_distance_plot_Percentages.svg	28412	-111108129	\N	f	2022-09-16 14:38:49.783+00
333	16	67	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/svg/mqc_rseqc_junction_annotation_junctions_plot_Events.svg	mqc_rseqc_junction_annotation_junctions_plot_Events.svg	29220	-1262528997	\N	f	2022-09-16 14:38:49.787+00
334	16	67	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/svg/mqc_rseqc_junction_annotation_junctions_plot_Events_pc.svg	mqc_rseqc_junction_annotation_junctions_plot_Events_pc.svg	28758	-1910123269	\N	f	2022-09-16 14:38:49.783+00
335	16	67	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/svg/mqc_rseqc_junction_annotation_junctions_plot_Junctions.svg	mqc_rseqc_junction_annotation_junctions_plot_Junctions.svg	31321	1479320434	\N	f	2022-09-16 14:38:49.787+00
336	16	67	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/svg/mqc_rseqc_junction_annotation_junctions_plot_Junctions_pc.svg	mqc_rseqc_junction_annotation_junctions_plot_Junctions_pc.svg	29054	1440133039	\N	f	2022-09-16 14:38:49.787+00
337	16	67	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/svg/mqc_rseqc_junction_saturation_plot_All_Junctions.svg	mqc_rseqc_junction_saturation_plot_All_Junctions.svg	29453	797778868	\N	f	2022-09-16 14:38:49.783+00
338	16	67	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/svg/mqc_rseqc_junction_saturation_plot_Known_Junctions.svg	mqc_rseqc_junction_saturation_plot_Known_Junctions.svg	29451	1820125215	\N	f	2022-09-16 14:38:49.787+00
339	16	67	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/svg/mqc_rseqc_junction_saturation_plot_Novel_Junctions.svg	mqc_rseqc_junction_saturation_plot_Novel_Junctions.svg	26420	1128481167	\N	f	2022-09-16 14:38:49.783+00
340	16	67	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/svg/mqc_rseqc_read_distribution_plot_1.svg	mqc_rseqc_read_distribution_plot_1.svg	39637	-578326299	\N	f	2022-09-16 14:38:49.791+00
341	16	67	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/svg/mqc_rseqc_read_distribution_plot_1_pc.svg	mqc_rseqc_read_distribution_plot_1_pc.svg	39672	-547823715	\N	f	2022-09-16 14:38:49.787+00
342	16	67	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/svg/mqc_rseqc_read_dups_plot_1.svg	mqc_rseqc_read_dups_plot_1.svg	31427	1240973200	\N	f	2022-09-16 14:38:49.791+00
343	16	67	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/svg/mqc_samtools-idxstats-mapped-reads-plot_Normalised_Counts.svg	mqc_samtools-idxstats-mapped-reads-plot_Normalised_Counts.svg	26560	-557030349	\N	f	2022-09-16 14:38:49.783+00
344	16	67	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/svg/mqc_samtools-idxstats-mapped-reads-plot_Observed_over_Expected_Counts.svg	mqc_samtools-idxstats-mapped-reads-plot_Observed_over_Expected_Counts.svg	29797	714593626	\N	f	2022-09-16 14:38:49.787+00
345	16	67	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/svg/mqc_samtools-idxstats-mapped-reads-plot_Raw_Counts.svg	mqc_samtools-idxstats-mapped-reads-plot_Raw_Counts.svg	27613	-832921194	\N	f	2022-09-16 14:38:49.787+00
346	16	67	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/svg/mqc_samtools_alignment_plot_1.svg	mqc_samtools_alignment_plot_1.svg	22462	-1445182978	\N	f	2022-09-16 14:38:49.791+00
347	16	67	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/svg/mqc_samtools_alignment_plot_1_pc.svg	mqc_samtools_alignment_plot_1_pc.svg	22469	-613591125	\N	f	2022-09-16 14:38:49.787+00
348	16	67	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/svg/mqc_star_alignment_plot_1.svg	mqc_star_alignment_plot_1.svg	31886	-212528216	\N	f	2022-09-16 14:38:49.783+00
349	16	67	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_plots/svg/mqc_star_alignment_plot_1_pc.svg	mqc_star_alignment_plot_1_pc.svg	30971	-1854448115	\N	f	2022-09-16 14:38:49.783+00
350	16	62	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/multiqc/star_salmon/multiqc_report.html	multiqc_report.html	1485844	180223696	\N	f	2022-09-16 14:38:49.783+00
351	16	68	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/pipeline_info/execution_report_2022-09-16_11-33-50.html	execution_report_2022-09-16_11-33-50.html	3222291	129731653	\N	f	2022-09-16 14:38:49.199+00
352	16	68	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/pipeline_info/execution_timeline_2022-09-16_11-33-50.html	execution_timeline_2022-09-16_11-33-50.html	276525	639024801	\N	f	2022-09-16 14:38:49.195+00
353	16	68	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/pipeline_info/execution_trace_2022-09-16_11-33-50.txt	execution_trace_2022-09-16_11-33-50.txt	13274	1437056700	\N	f	2022-09-16 14:38:49.195+00
354	16	68	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/pipeline_info/pipeline_dag_2022-09-16_11-33-50.html	pipeline_dag_2022-09-16_11-33-50.html	65132	-1680387261	\N	f	2022-09-16 14:38:49.195+00
355	16	68	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/pipeline_info/samplesheet.valid.csv	samplesheet.valid.csv	253	-1179588763	\N	f	2022-09-16 14:38:49.195+00
356	16	68	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/pipeline_info/software_versions.yml	software_versions.yml	1554	926112616	\N	f	2022-09-16 14:38:49.195+00
357	16	70	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/bigwig/mutant.forward.bigWig	mutant.forward.bigWig	6463443	-801669687	\N	f	2022-09-16 14:38:49.739+00
358	16	70	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/bigwig/mutant.reverse.bigWig	mutant.reverse.bigWig	6468058	1633671995	\N	f	2022-09-16 14:38:49.727+00
359	16	70	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/bigwig/wildtype.forward.bigWig	wildtype.forward.bigWig	5490853	-979619176	\N	f	2022-09-16 14:38:49.731+00
360	16	70	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/bigwig/wildtype.reverse.bigWig	wildtype.reverse.bigWig	5494756	-1103518901	\N	f	2022-09-16 14:38:49.719+00
361	16	71	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/deseq2_qc/R_sessionInfo.log	R_sessionInfo.log	2006	1859817789	\N	f	2022-09-16 14:38:49.779+00
363	16	71	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/deseq2_qc/deseq2.pca.vals.txt	deseq2.pca.vals.txt	174	300783233	\N	f	2022-09-16 14:38:49.779+00
364	16	71	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/deseq2_qc/deseq2.plots.pdf	deseq2.plots.pdf	8722	-1908274680	\N	f	2022-09-16 14:38:49.779+00
365	16	71	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/deseq2_qc/deseq2.sample.dists.txt	deseq2.sample.dists.txt	105	-1604068630	\N	f	2022-09-16 14:38:49.779+00
366	16	72	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/deseq2_qc/size_factors/deseq2.size_factors.RData	deseq2.size_factors.RData	166	-1540669284	\N	f	2022-09-16 14:38:49.779+00
367	16	72	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/deseq2_qc/size_factors/mutant.txt	mutant.txt	37	457293335	\N	f	2022-09-16 14:38:49.779+00
368	16	72	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/deseq2_qc/size_factors/wildtype.txt	wildtype.txt	38	1146383577	\N	f	2022-09-16 14:38:49.779+00
369	16	74	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/dupradar/box_plot/mutant_duprateExpBoxplot.pdf	mutant_duprateExpBoxplot.pdf	11037	806103749	\N	f	2022-09-16 14:38:49.755+00
370	16	74	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/dupradar/box_plot/wildtype_duprateExpBoxplot.pdf	wildtype_duprateExpBoxplot.pdf	14938	-1532229766	\N	f	2022-09-16 14:38:49.755+00
371	16	75	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/dupradar/gene_data/mutant_dupMatrix.txt	mutant_dupMatrix.txt	2420659	-1376776429	\N	f	2022-09-16 14:38:49.747+00
372	16	75	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/dupradar/gene_data/wildtype_dupMatrix.txt	wildtype_dupMatrix.txt	2422875	-12951929	\N	f	2022-09-16 14:38:49.751+00
373	16	76	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/dupradar/histogram/mutant_expressionHist.pdf	mutant_expressionHist.pdf	5335	1153504428	\N	f	2022-09-16 14:38:49.751+00
374	16	76	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/dupradar/histogram/wildtype_expressionHist.pdf	wildtype_expressionHist.pdf	5237	655044819	\N	f	2022-09-16 14:38:49.751+00
375	16	77	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/dupradar/intercepts_slope/mutant_intercept_slope.txt	mutant_intercept_slope.txt	179	-617799201	\N	f	2022-09-16 14:38:49.755+00
376	16	77	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/dupradar/intercepts_slope/wildtype_intercept_slope.txt	wildtype_intercept_slope.txt	183	282244307	\N	f	2022-09-16 14:38:49.755+00
377	16	78	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/dupradar/scatter_plot/mutant_duprateExpDens.pdf	mutant_duprateExpDens.pdf	893812	1555293104	\N	f	2022-09-16 14:38:49.755+00
378	16	78	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/dupradar/scatter_plot/wildtype_duprateExpDens.pdf	wildtype_duprateExpDens.pdf	887230	810399063	\N	f	2022-09-16 14:38:49.751+00
379	16	79	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/featurecounts/mutant.biotype_counts_mqc.tsv	mutant.biotype_counts_mqc.tsv	583	-1233946117	\N	f	2022-09-16 14:38:49.355+00
380	16	79	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/featurecounts/mutant.biotype_counts_rrna_mqc.tsv	mutant.biotype_counts_rrna_mqc.tsv	360	829275813	\N	f	2022-09-16 14:38:49.355+00
381	16	79	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/featurecounts/mutant.featureCounts.txt	mutant.featureCounts.txt	4567393	-253853993	\N	f	2022-09-16 14:38:49.355+00
382	16	79	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/featurecounts/mutant.featureCounts.txt.summary	mutant.featureCounts.txt.summary	407	-206937292	\N	f	2022-09-16 14:38:49.355+00
383	16	79	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/featurecounts/wildtype.biotype_counts_mqc.tsv	wildtype.biotype_counts_mqc.tsv	584	-405597375	\N	f	2022-09-16 14:38:49.351+00
384	16	79	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/featurecounts/wildtype.biotype_counts_rrna_mqc.tsv	wildtype.biotype_counts_rrna_mqc.tsv	363	1018428827	\N	f	2022-09-16 14:38:49.351+00
385	16	79	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/featurecounts/wildtype.featureCounts.txt	wildtype.featureCounts.txt	4567400	843304068	\N	f	2022-09-16 14:38:49.347+00
386	16	79	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/featurecounts/wildtype.featureCounts.txt.summary	wildtype.featureCounts.txt.summary	410	-1051662517	\N	f	2022-09-16 14:38:49.351+00
387	16	80	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/log/mutant.Log.final.out	mutant.Log.final.out	1875	701104443	\N	f	2022-09-16 14:38:49.739+00
388	16	80	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/log/mutant.Log.out	mutant.Log.out	23265	1945253763	\N	f	2022-09-16 14:38:49.739+00
389	16	80	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/log/mutant.Log.progress.out	mutant.Log.progress.out	475	541318618	\N	f	2022-09-16 14:38:49.743+00
390	16	80	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/log/mutant.SJ.out.tab	mutant.SJ.out.tab	2369466	407171644	\N	f	2022-09-16 14:38:49.743+00
391	16	80	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/log/wildtype.Log.final.out	wildtype.Log.final.out	1874	1442871773	\N	f	2022-09-16 14:38:49.743+00
392	16	80	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/log/wildtype.Log.out	wildtype.Log.out	23362	-1020746834	\N	f	2022-09-16 14:38:49.739+00
393	16	80	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/log/wildtype.Log.progress.out	wildtype.Log.progress.out	475	327318448	\N	f	2022-09-16 14:38:49.743+00
394	16	80	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/log/wildtype.SJ.out.tab	wildtype.SJ.out.tab	2216791	-405315259	\N	f	2022-09-16 14:38:49.747+00
395	16	82	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/mutant/aux_info/ambig_info.tsv	ambig_info.tsv	176780	-1880515994	\N	f	2022-09-16 14:38:49.763+00
396	16	82	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/mutant/aux_info/expected_bias.gz	expected_bias.gz	117	-985369631	\N	f	2022-09-16 14:38:49.763+00
397	16	82	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/mutant/aux_info/fld.gz	fld.gz	489	1656041158	\N	f	2022-09-16 14:38:49.763+00
398	16	82	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/mutant/aux_info/meta_info.json	meta_info.json	1303	-1011334677	\N	f	2022-09-16 14:38:49.763+00
399	16	82	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/mutant/aux_info/observed_bias.gz	observed_bias.gz	82	-1411601084	\N	f	2022-09-16 14:38:49.763+00
400	16	82	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/mutant/aux_info/observed_bias_3p.gz	observed_bias_3p.gz	82	888759984	\N	f	2022-09-16 14:38:49.763+00
401	16	81	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/mutant/cmd_info.json	cmd_info.json	281	1558484642	\N	f	2022-09-16 14:38:49.759+00
402	16	83	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/mutant/libParams/flenDist.txt	flenDist.txt	11763	-743861979	\N	f	2022-09-16 14:38:49.763+00
403	16	81	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/mutant/quant.genes.sf	quant.genes.sf	999333	866735716	\N	f	2022-09-16 14:38:49.759+00
404	16	81	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/mutant/quant.sf	quant.sf	1695753	-952815991	\N	f	2022-09-16 14:38:49.763+00
405	16	69	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/mutant.markdup.sorted.bam	mutant.markdup.sorted.bam	123611802	1227082967	\N	f	2022-09-16 14:38:49.327+00
406	16	69	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/mutant.markdup.sorted.bam.bai	mutant.markdup.sorted.bam.bai	109496	-598211193	\N	f	2022-09-16 14:38:49.343+00
407	16	84	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/picard_metrics/mutant.markdup.sorted.MarkDuplicates.metrics.txt	mutant.markdup.sorted.MarkDuplicates.metrics.txt	3409	1420751614	\N	f	2022-09-16 14:38:49.343+00
408	16	84	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/picard_metrics/wildtype.markdup.sorted.MarkDuplicates.metrics.txt	wildtype.markdup.sorted.MarkDuplicates.metrics.txt	3434	-1061425343	\N	f	2022-09-16 14:38:49.343+00
409	16	86	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/preseq/log/mutant.command.log	mutant.command.log	553	-637837065	\N	f	2022-09-16 14:38:49.463+00
410	16	86	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/preseq/log/wildtype.command.log	wildtype.command.log	684	921982052	\N	f	2022-09-16 14:38:49.463+00
411	16	85	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/preseq/mutant.lc_extrap.txt	mutant.lc_extrap.txt	488626	-1843780933	\N	f	2022-09-16 14:38:49.463+00
412	16	85	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/preseq/wildtype.lc_extrap.txt	wildtype.lc_extrap.txt	468939	-1841243311	\N	f	2022-09-16 14:38:49.463+00
413	16	89	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/qualimap/mutant/css/agogo.css	agogo.css	7158	-628586191	\N	f	2022-09-16 14:38:49.775+00
414	16	89	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/qualimap/mutant/css/ajax-loader.gif	ajax-loader.gif	701	195242360	\N	f	2022-09-16 14:38:49.775+00
415	16	89	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/qualimap/mutant/css/basic.css	basic.css	8489	-160780653	\N	f	2022-09-16 14:38:49.775+00
416	16	89	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/qualimap/mutant/css/bgfooter.png	bgfooter.png	462	-1571910480	\N	f	2022-09-16 14:38:49.775+00
417	16	89	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/qualimap/mutant/css/bgtop.png	bgtop.png	458	174634016	\N	f	2022-09-16 14:38:49.775+00
418	16	89	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/qualimap/mutant/css/comment-bright.png	comment-bright.png	3528	-125013338	\N	f	2022-09-16 14:38:49.775+00
419	16	89	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/qualimap/mutant/css/comment-close.png	comment-close.png	3606	-66961227	\N	f	2022-09-16 14:38:49.775+00
420	16	89	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/qualimap/mutant/css/comment.png	comment.png	3473	1762905298	\N	f	2022-09-16 14:38:49.775+00
421	16	89	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/qualimap/mutant/css/doctools.js	doctools.js	6868	-1783542771	\N	f	2022-09-16 14:38:49.775+00
422	16	89	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/qualimap/mutant/css/down-pressed.png	down-pressed.png	396	-964938807	\N	f	2022-09-16 14:38:49.775+00
423	16	89	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/qualimap/mutant/css/down.png	down.png	391	1086380132	\N	f	2022-09-16 14:38:49.775+00
424	16	89	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/qualimap/mutant/css/file.png	file.png	420	-1222657508	\N	f	2022-09-16 14:38:49.775+00
425	16	89	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/qualimap/mutant/css/jquery.js	jquery.js	72230	-311841177	\N	f	2022-09-16 14:38:49.775+00
426	16	89	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/qualimap/mutant/css/minus.png	minus.png	227	-1701052211	\N	f	2022-09-16 14:38:49.775+00
427	16	89	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/qualimap/mutant/css/plus.png	plus.png	227	62530731	\N	f	2022-09-16 14:38:49.775+00
428	16	89	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/qualimap/mutant/css/pygments.css	pygments.css	3960	181941498	\N	f	2022-09-16 14:38:49.775+00
429	16	89	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/qualimap/mutant/css/qualimap_logo_small.png	qualimap_logo_small.png	2950	73259164	\N	f	2022-09-16 14:38:49.775+00
430	16	89	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/qualimap/mutant/css/report.css	report.css	636	-101604852	\N	f	2022-09-16 14:38:49.775+00
431	16	89	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/qualimap/mutant/css/searchtools.js	searchtools.js	16071	99100931	\N	f	2022-09-16 14:38:49.775+00
432	16	89	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/qualimap/mutant/css/underscore.js	underscore.js	8602	815784897	\N	f	2022-09-16 14:38:49.775+00
433	16	89	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/qualimap/mutant/css/up-pressed.png	up-pressed.png	400	-2058374194	\N	f	2022-09-16 14:38:49.775+00
434	16	89	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/qualimap/mutant/css/up.png	up.png	391	-1972886725	\N	f	2022-09-16 14:38:49.775+00
435	16	89	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/qualimap/mutant/css/websupport.js	websupport.js	25274	589288723	\N	f	2022-09-16 14:38:49.775+00
436	16	90	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/qualimap/mutant/images_qualimapReport/Coverage Profile Along Genes (High).png	Coverage Profile Along Genes (High).png	50424	-2139844009	\N	f	2022-09-16 14:38:49.775+00
437	16	90	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/qualimap/mutant/images_qualimapReport/Coverage Profile Along Genes (Low).png	Coverage Profile Along Genes (Low).png	74132	13354393	\N	f	2022-09-16 14:38:49.771+00
438	16	90	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/qualimap/mutant/images_qualimapReport/Coverage Profile Along Genes (Total).png	Coverage Profile Along Genes (Total).png	51782	1284132089	\N	f	2022-09-16 14:38:49.775+00
544	16	117	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/samtools_stats/wildtype.sorted.bam.idxstats	wildtype.sorted.bam.idxstats	169	1967600971	\N	f	2022-09-16 14:38:49.767+00
439	16	90	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/qualimap/mutant/images_qualimapReport/Junction Analysis.png	Junction Analysis.png	35346	-1621769408	\N	f	2022-09-16 14:38:49.775+00
440	16	90	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/qualimap/mutant/images_qualimapReport/Reads Genomic Origin.png	Reads Genomic Origin.png	36363	-1800241205	\N	f	2022-09-16 14:38:49.771+00
441	16	90	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/qualimap/mutant/images_qualimapReport/Transcript coverage histogram.png	Transcript coverage histogram.png	59868	-183723938	\N	f	2022-09-16 14:38:49.775+00
442	16	88	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/qualimap/mutant/qualimapReport.html	qualimapReport.html	11588	126277841	\N	f	2022-09-16 14:38:49.775+00
443	16	91	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/qualimap/mutant/raw_data_qualimapReport/coverage_profile_along_genes_(high).txt	coverage_profile_along_genes_(high).txt	2365	688503906	\N	f	2022-09-16 14:38:49.775+00
444	16	91	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/qualimap/mutant/raw_data_qualimapReport/coverage_profile_along_genes_(low).txt	coverage_profile_along_genes_(low).txt	2472	686962989	\N	f	2022-09-16 14:38:49.775+00
445	16	91	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/qualimap/mutant/raw_data_qualimapReport/coverage_profile_along_genes_(total).txt	coverage_profile_along_genes_(total).txt	2429	554921594	\N	f	2022-09-16 14:38:49.775+00
446	16	88	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/qualimap/mutant/rnaseq_qc_results.txt	rnaseq_qc_results.txt	1179	-1676849862	\N	f	2022-09-16 14:38:49.771+00
447	16	93	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/qualimap/wildtype/css/agogo.css	agogo.css	7158	-1716286949	\N	f	2022-09-16 14:38:49.771+00
448	16	93	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/qualimap/wildtype/css/ajax-loader.gif	ajax-loader.gif	701	822955981	\N	f	2022-09-16 14:38:49.771+00
449	16	93	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/qualimap/wildtype/css/basic.css	basic.css	8489	1345538791	\N	f	2022-09-16 14:38:49.771+00
450	16	93	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/qualimap/wildtype/css/bgfooter.png	bgfooter.png	462	-2048769316	\N	f	2022-09-16 14:38:49.771+00
451	16	93	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/qualimap/wildtype/css/bgtop.png	bgtop.png	458	1361581333	\N	f	2022-09-16 14:38:49.771+00
452	16	93	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/qualimap/wildtype/css/comment-bright.png	comment-bright.png	3528	-642631973	\N	f	2022-09-16 14:38:49.771+00
453	16	93	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/qualimap/wildtype/css/comment-close.png	comment-close.png	3606	-579382009	\N	f	2022-09-16 14:38:49.771+00
454	16	93	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/qualimap/wildtype/css/comment.png	comment.png	3473	85429521	\N	f	2022-09-16 14:38:49.771+00
455	16	93	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/qualimap/wildtype/css/doctools.js	doctools.js	6868	-831754916	\N	f	2022-09-16 14:38:49.771+00
456	16	93	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/qualimap/wildtype/css/down-pressed.png	down-pressed.png	396	-604911618	\N	f	2022-09-16 14:38:49.771+00
457	16	93	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/qualimap/wildtype/css/down.png	down.png	391	1244830872	\N	f	2022-09-16 14:38:49.771+00
458	16	93	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/qualimap/wildtype/css/file.png	file.png	420	-257156786	\N	f	2022-09-16 14:38:49.771+00
459	16	93	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/qualimap/wildtype/css/jquery.js	jquery.js	72230	369808609	\N	f	2022-09-16 14:38:49.771+00
460	16	93	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/qualimap/wildtype/css/minus.png	minus.png	227	-363345323	\N	f	2022-09-16 14:38:49.771+00
461	16	93	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/qualimap/wildtype/css/plus.png	plus.png	227	-1952445794	\N	f	2022-09-16 14:38:49.771+00
462	16	93	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/qualimap/wildtype/css/pygments.css	pygments.css	3960	1624375480	\N	f	2022-09-16 14:38:49.771+00
463	16	93	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/qualimap/wildtype/css/qualimap_logo_small.png	qualimap_logo_small.png	2950	446276823	\N	f	2022-09-16 14:38:49.771+00
464	16	93	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/qualimap/wildtype/css/report.css	report.css	636	-1023969743	\N	f	2022-09-16 14:38:49.771+00
465	16	93	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/qualimap/wildtype/css/searchtools.js	searchtools.js	16071	-1042900438	\N	f	2022-09-16 14:38:49.771+00
466	16	93	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/qualimap/wildtype/css/underscore.js	underscore.js	8602	46104262	\N	f	2022-09-16 14:38:49.771+00
467	16	93	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/qualimap/wildtype/css/up-pressed.png	up-pressed.png	400	-196986900	\N	f	2022-09-16 14:38:49.771+00
468	16	93	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/qualimap/wildtype/css/up.png	up.png	391	1171357333	\N	f	2022-09-16 14:38:49.771+00
469	16	93	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/qualimap/wildtype/css/websupport.js	websupport.js	25274	1335943749	\N	f	2022-09-16 14:38:49.771+00
470	16	94	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/qualimap/wildtype/images_qualimapReport/Coverage Profile Along Genes (High).png	Coverage Profile Along Genes (High).png	52090	-205640509	\N	f	2022-09-16 14:38:49.767+00
471	16	94	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/qualimap/wildtype/images_qualimapReport/Coverage Profile Along Genes (Low).png	Coverage Profile Along Genes (Low).png	74599	-913377097	\N	f	2022-09-16 14:38:49.767+00
472	16	94	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/qualimap/wildtype/images_qualimapReport/Coverage Profile Along Genes (Total).png	Coverage Profile Along Genes (Total).png	58810	-1174977833	\N	f	2022-09-16 14:38:49.771+00
473	16	94	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/qualimap/wildtype/images_qualimapReport/Junction Analysis.png	Junction Analysis.png	35182	-1754245308	\N	f	2022-09-16 14:38:49.767+00
474	16	94	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/qualimap/wildtype/images_qualimapReport/Reads Genomic Origin.png	Reads Genomic Origin.png	37516	1681553761	\N	f	2022-09-16 14:38:49.767+00
545	16	117	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/samtools_stats/wildtype.sorted.bam.stats	wildtype.sorted.bam.stats	133440	-188472725	\N	f	2022-09-16 14:38:49.767+00
475	16	94	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/qualimap/wildtype/images_qualimapReport/Transcript coverage histogram.png	Transcript coverage histogram.png	60981	-499724702	\N	f	2022-09-16 14:38:49.767+00
476	16	92	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/qualimap/wildtype/qualimapReport.html	qualimapReport.html	11589	1046652657	\N	f	2022-09-16 14:38:49.771+00
477	16	95	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/qualimap/wildtype/raw_data_qualimapReport/coverage_profile_along_genes_(high).txt	coverage_profile_along_genes_(high).txt	2371	-1303630430	\N	f	2022-09-16 14:38:49.771+00
478	16	95	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/qualimap/wildtype/raw_data_qualimapReport/coverage_profile_along_genes_(low).txt	coverage_profile_along_genes_(low).txt	2500	922946945	\N	f	2022-09-16 14:38:49.771+00
479	16	95	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/qualimap/wildtype/raw_data_qualimapReport/coverage_profile_along_genes_(total).txt	coverage_profile_along_genes_(total).txt	2431	-1811232650	\N	f	2022-09-16 14:38:49.771+00
480	16	92	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/qualimap/wildtype/rnaseq_qc_results.txt	rnaseq_qc_results.txt	1180	-796247823	\N	f	2022-09-16 14:38:49.767+00
481	16	97	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/rseqc/bam_stat/mutant.bam_stat.txt	mutant.bam_stat.txt	856	325306413	\N	f	2022-09-16 14:38:49.519+00
482	16	97	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/rseqc/bam_stat/wildtype.bam_stat.txt	wildtype.bam_stat.txt	855	220441659	\N	f	2022-09-16 14:38:49.523+00
483	16	98	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/rseqc/infer_experiment/mutant.infer_experiment.txt	mutant.infer_experiment.txt	211	-1808321972	\N	f	2022-09-16 14:38:49.563+00
484	16	98	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/rseqc/infer_experiment/wildtype.infer_experiment.txt	wildtype.infer_experiment.txt	211	-1716111746	\N	f	2022-09-16 14:38:49.563+00
485	16	100	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/rseqc/inner_distance/pdf/mutant.inner_distance_plot.pdf	mutant.inner_distance_plot.pdf	8595	-1591073257	\N	f	2022-09-16 14:38:49.519+00
486	16	100	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/rseqc/inner_distance/pdf/wildtype.inner_distance_plot.pdf	wildtype.inner_distance_plot.pdf	8583	22175466	\N	f	2022-09-16 14:38:49.519+00
487	16	101	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/rseqc/inner_distance/rscript/mutant.inner_distance_plot.r	mutant.inner_distance_plot.r	1579	-1312395982	\N	f	2022-09-16 14:38:49.519+00
488	16	101	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/rseqc/inner_distance/rscript/wildtype.inner_distance_plot.r	wildtype.inner_distance_plot.r	1578	-2013505389	\N	f	2022-09-16 14:38:49.519+00
489	16	102	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/rseqc/inner_distance/txt/mutant.inner_distance.txt	mutant.inner_distance.txt	25864382	1057541784	\N	f	2022-09-16 14:38:49.515+00
490	16	102	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/rseqc/inner_distance/txt/mutant.inner_distance_freq.txt	mutant.inner_distance_freq.txt	1268	-510941231	\N	f	2022-09-16 14:38:49.491+00
491	16	102	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/rseqc/inner_distance/txt/mutant.inner_distance_mean.txt	mutant.inner_distance_mean.txt	95	1434035459	\N	f	2022-09-16 14:38:49.467+00
492	16	102	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/rseqc/inner_distance/txt/wildtype.inner_distance.txt	wildtype.inner_distance.txt	21400266	2058645036	\N	f	2022-09-16 14:38:49.487+00
493	16	102	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/rseqc/inner_distance/txt/wildtype.inner_distance_freq.txt	wildtype.inner_distance_freq.txt	1263	783854801	\N	f	2022-09-16 14:38:49.467+00
494	16	102	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/rseqc/inner_distance/txt/wildtype.inner_distance_mean.txt	wildtype.inner_distance_mean.txt	98	709350283	\N	f	2022-09-16 14:38:49.467+00
495	16	104	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/rseqc/junction_annotation/bed/mutant.junction.Interact.bed	mutant.junction.Interact.bed	11638464	-96265768	\N	f	2022-09-16 14:38:49.543+00
496	16	104	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/rseqc/junction_annotation/bed/mutant.junction.bed	mutant.junction.bed	5124521	1250538201	\N	f	2022-09-16 14:38:49.527+00
497	16	104	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/rseqc/junction_annotation/bed/wildtype.junction.Interact.bed	wildtype.junction.Interact.bed	10904798	1301160581	\N	f	2022-09-16 14:38:49.555+00
498	16	104	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/rseqc/junction_annotation/bed/wildtype.junction.bed	wildtype.junction.bed	4805926	-1225317682	\N	f	2022-09-16 14:38:49.531+00
499	16	105	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/rseqc/junction_annotation/log/mutant.junction_annotation.log	mutant.junction_annotation.log	568	1692021062	\N	f	2022-09-16 14:38:49.563+00
500	16	105	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/rseqc/junction_annotation/log/wildtype.junction_annotation.log	wildtype.junction_annotation.log	577	2082497736	\N	f	2022-09-16 14:38:49.563+00
501	16	106	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/rseqc/junction_annotation/pdf/mutant.splice_events.pdf	mutant.splice_events.pdf	13053	-1114024319	\N	f	2022-09-16 14:38:49.563+00
502	16	106	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/rseqc/junction_annotation/pdf/mutant.splice_junction.pdf	mutant.splice_junction.pdf	13189	81415331	\N	f	2022-09-16 14:38:49.563+00
503	16	106	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/rseqc/junction_annotation/pdf/wildtype.splice_events.pdf	wildtype.splice_events.pdf	13336	-232444751	\N	f	2022-09-16 14:38:49.563+00
504	16	106	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/rseqc/junction_annotation/pdf/wildtype.splice_junction.pdf	wildtype.splice_junction.pdf	13278	354783899	\N	f	2022-09-16 14:38:49.563+00
505	16	107	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/rseqc/junction_annotation/rscript/mutant.junction_plot.r	mutant.junction_plot.r	588	-785338608	\N	f	2022-09-16 14:38:49.563+00
506	16	107	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/rseqc/junction_annotation/rscript/wildtype.junction_plot.r	wildtype.junction_plot.r	583	2006421900	\N	f	2022-09-16 14:38:49.563+00
507	16	108	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/rseqc/junction_annotation/xls/mutant.junction.xls	mutant.junction.xls	2365238	695041783	\N	f	2022-09-16 14:38:49.563+00
508	16	108	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/rseqc/junction_annotation/xls/wildtype.junction.xls	wildtype.junction.xls	2222487	-1823323091	\N	f	2022-09-16 14:38:49.559+00
509	16	110	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/rseqc/junction_saturation/pdf/mutant.junctionSaturation_plot.pdf	mutant.junctionSaturation_plot.pdf	5515	1504111630	\N	f	2022-09-16 14:38:49.523+00
510	16	110	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/rseqc/junction_saturation/pdf/wildtype.junctionSaturation_plot.pdf	wildtype.junctionSaturation_plot.pdf	5632	-870797606	\N	f	2022-09-16 14:38:49.523+00
511	16	111	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/rseqc/junction_saturation/rscript/mutant.junctionSaturation_plot.r	mutant.junctionSaturation_plot.r	817	-1465805902	\N	f	2022-09-16 14:38:49.523+00
512	16	111	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/rseqc/junction_saturation/rscript/wildtype.junctionSaturation_plot.r	wildtype.junctionSaturation_plot.r	839	1245847391	\N	f	2022-09-16 14:38:49.523+00
513	16	112	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/rseqc/read_distribution/mutant.read_distribution.txt	mutant.read_distribution.txt	1153	1406721669	\N	f	2022-09-16 14:38:49.519+00
514	16	112	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/rseqc/read_distribution/wildtype.read_distribution.txt	wildtype.read_distribution.txt	1153	-1280790300	\N	f	2022-09-16 14:38:49.519+00
515	16	114	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/rseqc/read_duplication/pdf/mutant.DupRate_plot.pdf	mutant.DupRate_plot.pdf	5422	-197052317	\N	f	2022-09-16 14:38:49.519+00
516	16	114	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/rseqc/read_duplication/pdf/wildtype.DupRate_plot.pdf	wildtype.DupRate_plot.pdf	7474	815662227	\N	f	2022-09-16 14:38:49.519+00
517	16	115	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/rseqc/read_duplication/rscript/mutant.DupRate_plot.r	mutant.DupRate_plot.r	1142	489270766	\N	f	2022-09-16 14:38:49.519+00
518	16	115	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/rseqc/read_duplication/rscript/wildtype.DupRate_plot.r	wildtype.DupRate_plot.r	2115	869002654	\N	f	2022-09-16 14:38:49.519+00
519	16	116	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/rseqc/read_duplication/xls/mutant.pos.DupRate.xls	mutant.pos.DupRate.xls	203	-1279044553	\N	f	2022-09-16 14:38:49.519+00
520	16	116	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/rseqc/read_duplication/xls/mutant.seq.DupRate.xls	mutant.seq.DupRate.xls	169	-981173034	\N	f	2022-09-16 14:38:49.519+00
521	16	116	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/rseqc/read_duplication/xls/wildtype.pos.DupRate.xls	wildtype.pos.DupRate.xls	707	448031062	\N	f	2022-09-16 14:38:49.519+00
522	16	116	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/rseqc/read_duplication/xls/wildtype.seq.DupRate.xls	wildtype.seq.DupRate.xls	636	-2133254138	\N	f	2022-09-16 14:38:49.519+00
523	16	69	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/salmon.merged.gene_counts.rds	salmon.merged.gene_counts.rds	776309	1078875414	\N	f	2022-09-16 14:38:49.207+00
524	16	69	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/salmon.merged.gene_counts.tsv	salmon.merged.gene_counts.tsv	770336	-543141645	\N	f	2022-09-16 14:38:49.467+00
525	16	69	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/salmon.merged.gene_counts_length_scaled.rds	salmon.merged.gene_counts_length_scaled.rds	985917	850696670	\N	f	2022-09-16 14:38:49.763+00
526	16	69	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/salmon.merged.gene_counts_length_scaled.tsv	salmon.merged.gene_counts_length_scaled.tsv	1269483	-1170851754	\N	f	2022-09-16 14:38:49.779+00
527	16	69	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/salmon.merged.gene_counts_scaled.rds	salmon.merged.gene_counts_scaled.rds	994658	1658755811	\N	f	2022-09-16 14:38:49.767+00
528	16	69	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/salmon.merged.gene_counts_scaled.tsv	salmon.merged.gene_counts_scaled.tsv	1269899	1415958886	\N	f	2022-09-16 14:38:49.563+00
529	16	69	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/salmon.merged.gene_tpm.tsv	salmon.merged.gene_tpm.tsv	1019853	-257828820	\N	f	2022-09-16 14:38:49.779+00
530	16	69	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/salmon.merged.transcript_counts.rds	salmon.merged.transcript_counts.rds	1032628	-1050395844	\N	f	2022-09-16 14:38:49.715+00
531	16	69	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/salmon.merged.transcript_counts.tsv	salmon.merged.transcript_counts.tsv	1107433	-1872286649	\N	f	2022-09-16 14:38:49.739+00
532	16	69	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/salmon.merged.transcript_tpm.tsv	salmon.merged.transcript_tpm.tsv	1357236	511183816	\N	f	2022-09-16 14:38:49.467+00
533	16	69	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/salmon_tx2gene.tsv	salmon_tx2gene.tsv	1265629	-919027322	\N	f	2022-09-16 14:38:49.567+00
534	16	117	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/samtools_stats/mutant.markdup.sorted.bam.flagstat	mutant.markdup.sorted.bam.flagstat	548	1313137394	\N	f	2022-09-16 14:38:49.767+00
535	16	117	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/samtools_stats/mutant.markdup.sorted.bam.idxstats	mutant.markdup.sorted.bam.idxstats	169	196370769	\N	f	2022-09-16 14:38:49.767+00
536	16	117	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/samtools_stats/mutant.markdup.sorted.bam.stats	mutant.markdup.sorted.bam.stats	136712	1270155402	\N	f	2022-09-16 14:38:49.767+00
537	16	117	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/samtools_stats/mutant.sorted.bam.flagstat	mutant.sorted.bam.flagstat	542	858490635	\N	f	2022-09-16 14:38:49.767+00
538	16	117	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/samtools_stats/mutant.sorted.bam.idxstats	mutant.sorted.bam.idxstats	169	200439836	\N	f	2022-09-16 14:38:49.767+00
539	16	117	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/samtools_stats/mutant.sorted.bam.stats	mutant.sorted.bam.stats	136696	847401925	\N	f	2022-09-16 14:38:49.767+00
540	16	117	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/samtools_stats/wildtype.markdup.sorted.bam.flagstat	wildtype.markdup.sorted.bam.flagstat	551	-2012868965	\N	f	2022-09-16 14:38:49.767+00
541	16	117	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/samtools_stats/wildtype.markdup.sorted.bam.idxstats	wildtype.markdup.sorted.bam.idxstats	169	-1081297378	\N	f	2022-09-16 14:38:49.767+00
542	16	117	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/samtools_stats/wildtype.markdup.sorted.bam.stats	wildtype.markdup.sorted.bam.stats	133458	-6024856	\N	f	2022-09-16 14:38:49.767+00
543	16	117	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/samtools_stats/wildtype.sorted.bam.flagstat	wildtype.sorted.bam.flagstat	543	-1189508513	\N	f	2022-09-16 14:38:49.767+00
546	16	119	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/stringtie/mutant.ballgown/e2t.ctab	e2t.ctab	2620376	1866923139	\N	f	2022-09-16 14:38:49.671+00
547	16	119	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/stringtie/mutant.ballgown/e_data.ctab	e_data.ctab	10975603	1315987824	\N	f	2022-09-16 14:38:49.659+00
548	16	119	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/stringtie/mutant.ballgown/i2t.ctab	i2t.ctab	2079572	-426519396	\N	f	2022-09-16 14:38:49.675+00
549	16	119	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/stringtie/mutant.ballgown/i_data.ctab	i_data.ctab	4638597	-1716252654	\N	f	2022-09-16 14:38:49.667+00
550	16	119	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/stringtie/mutant.ballgown/t_data.ctab	t_data.ctab	3425818	-1961377318	\N	f	2022-09-16 14:38:49.675+00
551	16	118	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/stringtie/mutant.coverage.gtf	mutant.coverage.gtf	2709832	-2125778034	\N	f	2022-09-16 14:38:49.679+00
552	16	118	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/stringtie/mutant.gene.abundance.txt	mutant.gene.abundance.txt	2151099	-1967769839	\N	f	2022-09-16 14:38:49.683+00
553	16	118	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/stringtie/mutant.transcripts.gtf	mutant.transcripts.gtf	38642906	199873227	\N	f	2022-09-16 14:38:49.647+00
554	16	120	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/stringtie/wildtype.ballgown/e2t.ctab	e2t.ctab	2620376	-559459972	\N	f	2022-09-16 14:38:49.703+00
555	16	120	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/stringtie/wildtype.ballgown/e_data.ctab	e_data.ctab	10964462	277416740	\N	f	2022-09-16 14:38:49.691+00
556	16	120	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/stringtie/wildtype.ballgown/i2t.ctab	i2t.ctab	2079572	427679475	\N	f	2022-09-16 14:38:49.707+00
557	16	120	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/stringtie/wildtype.ballgown/i_data.ctab	i_data.ctab	4637505	1367268505	\N	f	2022-09-16 14:38:49.699+00
558	16	120	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/stringtie/wildtype.ballgown/t_data.ctab	t_data.ctab	3425582	-787876050	\N	f	2022-09-16 14:38:49.703+00
559	16	118	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/stringtie/wildtype.coverage.gtf	wildtype.coverage.gtf	2132876	1415643346	\N	f	2022-09-16 14:38:49.711+00
560	16	118	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/stringtie/wildtype.gene.abundance.txt	wildtype.gene.abundance.txt	2095815	-1017176051	\N	f	2022-09-16 14:38:49.711+00
561	16	118	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/stringtie/wildtype.transcripts.gtf	wildtype.transcripts.gtf	38471429	-994458359	\N	f	2022-09-16 14:38:49.603+00
562	16	122	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/wildtype/aux_info/ambig_info.tsv	ambig_info.tsv	174915	2068318588	\N	f	2022-09-16 14:38:49.759+00
563	16	122	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/wildtype/aux_info/expected_bias.gz	expected_bias.gz	117	-418775707	\N	f	2022-09-16 14:38:49.759+00
564	16	122	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/wildtype/aux_info/fld.gz	fld.gz	532	-2130726431	\N	f	2022-09-16 14:38:49.759+00
565	16	122	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/wildtype/aux_info/meta_info.json	meta_info.json	1304	1225554103	\N	f	2022-09-16 14:38:49.759+00
566	16	122	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/wildtype/aux_info/observed_bias.gz	observed_bias.gz	82	1990981973	\N	f	2022-09-16 14:38:49.759+00
567	16	122	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/wildtype/aux_info/observed_bias_3p.gz	observed_bias_3p.gz	82	1686646307	\N	f	2022-09-16 14:38:49.759+00
568	16	121	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/wildtype/cmd_info.json	cmd_info.json	285	-885229850	\N	f	2022-09-16 14:38:49.755+00
569	16	123	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/wildtype/libParams/flenDist.txt	flenDist.txt	11776	-1767016360	\N	f	2022-09-16 14:38:49.759+00
570	16	124	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/wildtype/logs/salmon_quant.log	salmon_quant.log	2838	-750426436	\N	f	2022-09-16 14:38:49.759+00
571	16	121	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/wildtype/quant.genes.sf	quant.genes.sf	998952	809868229	\N	f	2022-09-16 14:38:49.755+00
572	16	121	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/wildtype/quant.sf	quant.sf	1693523	-293636178	\N	f	2022-09-16 14:38:49.759+00
573	16	69	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/wildtype.markdup.sorted.bam	wildtype.markdup.sorted.bam	100750591	-1213676987	\N	f	2022-09-16 14:38:49.451+00
574	16	69	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/star_salmon/wildtype.markdup.sorted.bam.bai	wildtype.markdup.sorted.bam.bai	104664	-1526290658	\N	f	2022-09-16 14:38:49.567+00
575	16	126	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/trimgalore/fastqc/mutant_1_val_1_fastqc.html	mutant_1_val_1_fastqc.html	592858	-1867777954	\N	f	2022-09-16 14:38:49.187+00
576	16	126	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/trimgalore/fastqc/mutant_1_val_1_fastqc.zip	mutant_1_val_1_fastqc.zip	300154	-1313788855	\N	f	2022-09-16 14:38:49.191+00
577	16	126	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/trimgalore/fastqc/mutant_2_val_2_fastqc.html	mutant_2_val_2_fastqc.html	592713	293862605	\N	f	2022-09-16 14:38:49.191+00
578	16	126	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/trimgalore/fastqc/mutant_2_val_2_fastqc.zip	mutant_2_val_2_fastqc.zip	298572	-1105519199	\N	f	2022-09-16 14:38:49.195+00
579	16	126	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/trimgalore/fastqc/wildtype_1_val_1_fastqc.html	wildtype_1_val_1_fastqc.html	612913	-469447307	\N	f	2022-09-16 14:38:49.187+00
580	16	126	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/trimgalore/fastqc/wildtype_1_val_1_fastqc.zip	wildtype_1_val_1_fastqc.zip	352736	-2046114144	\N	f	2022-09-16 14:38:49.191+00
581	16	126	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/trimgalore/fastqc/wildtype_2_val_2_fastqc.html	wildtype_2_val_2_fastqc.html	606686	-1954665944	\N	f	2022-09-16 14:38:49.191+00
582	16	126	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/trimgalore/fastqc/wildtype_2_val_2_fastqc.zip	wildtype_2_val_2_fastqc.zip	345373	1286161004	\N	f	2022-09-16 14:38:49.191+00
583	16	125	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/trimgalore/mutant_1.fastq.gz_trimming_report.txt	mutant_1.fastq.gz_trimming_report.txt	3944	-436754396	\N	f	2022-09-16 14:38:49.195+00
584	16	125	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/trimgalore/mutant_2.fastq.gz_trimming_report.txt	mutant_2.fastq.gz_trimming_report.txt	3570	-721207071	\N	f	2022-09-16 14:38:49.195+00
585	16	125	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/trimgalore/wildtype_1.fastq.gz_trimming_report.txt	wildtype_1.fastq.gz_trimming_report.txt	3755	846541308	\N	f	2022-09-16 14:38:49.195+00
586	16	125	original/2eb6024f-9bbe-4329-8a58-be673abf69f8/results/trimgalore/wildtype_2.fastq.gz_trimming_report.txt	wildtype_2.fastq.gz_trimming_report.txt	3689	-1760538199	\N	f	2022-09-16 14:38:49.195+00
587	17	\N		20220916144035060-68	13757694	\N	\N	t	2022-09-16 14:40:36.723+00
588	17	587	original	original	13757694	\N	\N	t	2022-09-16 14:40:35.843+00
589	17	588	original/logs	logs	13757694	\N	\N	t	2022-09-16 14:40:35.047+00
590	17	589	original/logs/salmon_quant.log	salmon_quant.log	13757694	492595190	\N	f	2022-09-16 14:40:35.047+00
591	18	\N		20220916144035778-69	627712252	\N	\N	t	2022-09-16 14:40:36.723+00
592	18	591	original	original	627712252	\N	\N	t	2022-09-16 14:40:35.843+00
593	18	592	original/73de4c12-2b67-4ff2-a2bb-194693a84e30	73de4c12-2b67-4ff2-a2bb-194693a84e30	627712252	\N	\N	t	2022-09-16 14:40:31.342+00
594	18	593	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results	results	627712252	\N	\N	t	2022-09-16 12:29:08+00
595	18	594	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/fastqc	fastqc	3688148	\N	\N	t	2022-09-16 14:40:35.075+00
596	18	594	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc	multiqc	7247795	\N	\N	t	2022-09-16 12:29:08+00
597	18	596	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon	star_salmon	7247795	\N	\N	t	2022-09-16 14:40:35.735+00
598	18	597	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_data	multiqc_data	1986934	\N	\N	t	2022-09-16 14:40:35.759+00
599	18	597	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots	multiqc_plots	3770952	\N	\N	t	2022-09-16 12:29:08+00
600	18	599	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/pdf	pdf	807798	\N	\N	t	2022-09-16 14:40:35.751+00
601	18	599	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/png	png	1291547	\N	\N	t	2022-09-16 14:40:35.747+00
602	18	599	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/svg	svg	1671607	\N	\N	t	2022-09-16 14:40:35.739+00
603	18	594	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/pipeline_info	pipeline_info	3593586	\N	\N	t	2022-09-16 14:40:35.071+00
604	18	594	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon	star_salmon	609465760	\N	\N	t	2022-09-16 14:40:35.731+00
605	18	604	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/bigwig	bigwig	23923179	\N	\N	t	2022-09-16 14:40:35.675+00
606	18	604	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/deseq2_qc	deseq2_qc	566159	\N	\N	t	2022-09-16 14:40:35.735+00
607	18	606	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/deseq2_qc/size_factors	size_factors	241	\N	\N	t	2022-09-16 14:40:35.735+00
608	18	604	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/dupradar	dupradar	7207673	\N	\N	t	2022-09-16 12:20:43+00
609	18	608	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/dupradar/box_plot	box_plot	27238	\N	\N	t	2022-09-16 14:40:35.695+00
610	18	608	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/dupradar/gene_data	gene_data	5299584	\N	\N	t	2022-09-16 14:40:35.691+00
611	18	608	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/dupradar/histogram	histogram	10571	\N	\N	t	2022-09-16 14:40:35.691+00
612	18	608	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/dupradar/intercepts_slope	intercepts_slope	360	\N	\N	t	2022-09-16 14:40:35.695+00
613	18	608	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/dupradar/scatter_plot	scatter_plot	1869920	\N	\N	t	2022-09-16 14:40:35.695+00
614	18	604	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/featurecounts	featurecounts	20135239	\N	\N	t	2022-09-16 14:40:35.227+00
615	18	604	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/log	log	6053392	\N	\N	t	2022-09-16 14:40:35.683+00
616	18	604	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/mutant	mutant	4835992	\N	\N	t	2022-09-16 14:40:35.719+00
617	18	616	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/mutant/aux_info	aux_info	254915	\N	\N	t	2022-09-16 14:40:35.719+00
618	18	616	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/mutant/libParams	libParams	11762	\N	\N	t	2022-09-16 14:40:35.719+00
619	18	604	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/picard_metrics	picard_metrics	6850	\N	\N	t	2022-09-16 14:40:35.207+00
620	18	604	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/preseq	preseq	958804	\N	\N	t	2022-09-16 14:40:35.339+00
621	18	620	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/preseq/log	log	1233	\N	\N	t	2022-09-16 14:40:35.339+00
622	18	604	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/qualimap	qualimap	1002956	\N	\N	t	2022-09-16 12:26:59+00
623	18	622	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/qualimap/mutant	mutant	503834	\N	\N	t	2022-09-16 14:40:35.727+00
624	18	623	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/qualimap/mutant/css	css	166918	\N	\N	t	2022-09-16 14:40:35.731+00
625	18	623	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/qualimap/mutant/images_qualimapReport	images_qualimapReport	316850	\N	\N	t	2022-09-16 14:40:35.727+00
626	18	623	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/qualimap/mutant/raw_data_qualimapReport	raw_data_qualimapReport	7305	\N	\N	t	2022-09-16 14:40:35.731+00
627	18	622	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/qualimap/wildtype	wildtype	499122	\N	\N	t	2022-09-16 14:40:35.723+00
628	18	627	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/qualimap/wildtype/css	css	166918	\N	\N	t	2022-09-16 14:40:35.727+00
629	18	627	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/qualimap/wildtype/images_qualimapReport	images_qualimapReport	312113	\N	\N	t	2022-09-16 14:40:35.723+00
630	18	627	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/qualimap/wildtype/raw_data_qualimapReport	raw_data_qualimapReport	7326	\N	\N	t	2022-09-16 14:40:35.727+00
631	18	604	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/rseqc	rseqc	95840283	\N	\N	t	2022-09-16 12:23:15+00
632	18	631	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/rseqc/bam_stat	bam_stat	1711	\N	\N	t	2022-09-16 14:40:35.395+00
633	18	631	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/rseqc/infer_experiment	infer_experiment	422	\N	\N	t	2022-09-16 14:40:35.447+00
634	18	631	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/rseqc/inner_distance	inner_distance	47262255	\N	\N	t	2022-09-16 12:23:11+00
635	18	634	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/rseqc/inner_distance/pdf	pdf	17184	\N	\N	t	2022-09-16 14:40:35.391+00
636	18	634	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/rseqc/inner_distance/rscript	rscript	3157	\N	\N	t	2022-09-16 14:40:35.391+00
637	18	634	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/rseqc/inner_distance/txt	txt	47241914	\N	\N	t	2022-09-16 14:40:35.387+00
638	18	631	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/rseqc/junction_annotation	junction_annotation	48542881	\N	\N	t	2022-09-16 12:22:08+00
639	18	638	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/rseqc/junction_annotation/bed	bed	42472430	\N	\N	t	2022-09-16 14:40:35.435+00
640	18	638	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/rseqc/junction_annotation/log	log	1144	\N	\N	t	2022-09-16 14:40:35.447+00
641	18	638	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/rseqc/junction_annotation/pdf	pdf	53226	\N	\N	t	2022-09-16 14:40:35.447+00
642	18	638	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/rseqc/junction_annotation/rscript	rscript	1164	\N	\N	t	2022-09-16 14:40:35.443+00
643	18	638	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/rseqc/junction_annotation/xls	xls	6014917	\N	\N	t	2022-09-16 14:40:35.443+00
644	18	631	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/rseqc/junction_saturation	junction_saturation	12831	\N	\N	t	2022-09-16 12:22:18+00
645	18	644	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/rseqc/junction_saturation/pdf	pdf	11174	\N	\N	t	2022-09-16 14:40:35.395+00
646	18	644	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/rseqc/junction_saturation/rscript	rscript	1657	\N	\N	t	2022-09-16 14:40:35.395+00
647	18	631	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/rseqc/read_distribution	read_distribution	2306	\N	\N	t	2022-09-16 14:40:35.391+00
648	18	631	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/rseqc/read_duplication	read_duplication	17877	\N	\N	t	2022-09-16 12:21:59+00
649	18	648	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/rseqc/read_duplication/pdf	pdf	12905	\N	\N	t	2022-09-16 14:40:35.395+00
650	18	648	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/rseqc/read_duplication/rscript	rscript	3257	\N	\N	t	2022-09-16 14:40:35.391+00
651	18	648	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/rseqc/read_duplication/xls	xls	1715	\N	\N	t	2022-09-16 14:40:35.391+00
652	18	604	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/samtools_stats	samtools_stats	544968	\N	\N	t	2022-09-16 14:40:35.723+00
653	18	604	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/stringtie	stringtie	190076441	\N	\N	t	2022-09-16 14:40:35.651+00
654	18	653	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/stringtie/mutant.ballgown	mutant.ballgown	34050337	\N	\N	t	2022-09-16 14:40:35.603+00
655	18	653	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/stringtie/wildtype.ballgown	wildtype.ballgown	34036044	\N	\N	t	2022-09-16 14:40:35.643+00
656	18	604	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/wildtype	wildtype	18587926	\N	\N	t	2022-09-16 14:40:35.699+00
657	18	656	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/wildtype/aux_info	aux_info	252614	\N	\N	t	2022-09-16 14:40:35.715+00
658	18	656	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/wildtype/libParams	libParams	11777	\N	\N	t	2022-09-16 14:40:35.715+00
659	18	656	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/wildtype/logs	logs	13757516	\N	\N	t	2022-09-16 14:40:35.711+00
660	18	594	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/trimgalore	trimgalore	3716963	\N	\N	t	2022-09-16 14:40:35.067+00
661	18	660	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/trimgalore/fastqc	fastqc	3702005	\N	\N	t	2022-09-16 14:40:35.063+00
662	18	595	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/fastqc/mutant_1_fastqc.html	mutant_1_fastqc.html	570159	384961896	\N	f	2022-09-16 14:40:35.071+00
663	18	595	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/fastqc/mutant_1_fastqc.zip	mutant_1_fastqc.zip	311501	1749978518	\N	f	2022-09-16 14:40:35.075+00
664	18	595	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/fastqc/mutant_2_fastqc.html	mutant_2_fastqc.html	568779	1721116617	\N	f	2022-09-16 14:40:35.071+00
665	18	595	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/fastqc/mutant_2_fastqc.zip	mutant_2_fastqc.zip	308774	-1857653219	\N	f	2022-09-16 14:40:35.075+00
666	18	595	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/fastqc/wildtype_1_fastqc.html	wildtype_1_fastqc.html	606606	378950823	\N	f	2022-09-16 14:40:35.071+00
667	18	595	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/fastqc/wildtype_1_fastqc.zip	wildtype_1_fastqc.zip	363892	-1826020505	\N	f	2022-09-16 14:40:35.075+00
668	18	595	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/fastqc/wildtype_2_fastqc.html	wildtype_2_fastqc.html	599938	1652540404	\N	f	2022-09-16 14:40:35.071+00
669	18	595	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/fastqc/wildtype_2_fastqc.zip	wildtype_2_fastqc.zip	358499	-1764436425	\N	f	2022-09-16 14:40:35.071+00
670	18	598	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_data/mqc_cutadapt_filtered_reads_plot_1.txt	mqc_cutadapt_filtered_reads_plot_1.txt	133	37451970	\N	f	2022-09-16 14:40:35.755+00
671	18	598	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_data/mqc_cutadapt_trimmed_sequences_plot_3_Counts.txt	mqc_cutadapt_trimmed_sequences_plot_3_Counts.txt	2645	-1723609946	\N	f	2022-09-16 14:40:35.755+00
672	18	598	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_data/mqc_cutadapt_trimmed_sequences_plot_3_Obs_Exp.txt	mqc_cutadapt_trimmed_sequences_plot_3_Obs_Exp.txt	3998	848170265	\N	f	2022-09-16 14:40:35.755+00
673	18	598	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_data/mqc_fastqc_adapter_content_plot_1.txt	mqc_fastqc_adapter_content_plot_1.txt	3238	-1069200558	\N	f	2022-09-16 14:40:35.755+00
674	18	598	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_data/mqc_fastqc_per_base_n_content_plot-2_1.txt	mqc_fastqc_per_base_n_content_plot-2_1.txt	2661	-1679213464	\N	f	2022-09-16 14:40:35.751+00
675	18	598	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_data/mqc_fastqc_per_base_n_content_plot_1.txt	mqc_fastqc_per_base_n_content_plot_1.txt	2957	-89723945	\N	f	2022-09-16 14:40:35.751+00
676	18	598	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_data/mqc_fastqc_per_base_sequence_quality_plot-2_1.txt	mqc_fastqc_per_base_sequence_quality_plot-2_1.txt	2794	-1716587590	\N	f	2022-09-16 14:40:35.755+00
677	18	598	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_data/mqc_fastqc_per_base_sequence_quality_plot_1.txt	mqc_fastqc_per_base_sequence_quality_plot_1.txt	2837	994520023	\N	f	2022-09-16 14:40:35.755+00
678	18	598	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_data/mqc_fastqc_per_sequence_gc_content_plot-2_Counts.txt	mqc_fastqc_per_sequence_gc_content_plot-2_Counts.txt	2959	-1359977847	\N	f	2022-09-16 14:40:35.751+00
679	18	598	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_data/mqc_fastqc_per_sequence_gc_content_plot-2_Percentages.txt	mqc_fastqc_per_sequence_gc_content_plot-2_Percentages.txt	7876	1394387154	\N	f	2022-09-16 14:40:35.755+00
680	18	598	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_data/mqc_fastqc_per_sequence_gc_content_plot_Counts.txt	mqc_fastqc_per_sequence_gc_content_plot_Counts.txt	2927	-722685396	\N	f	2022-09-16 14:40:35.755+00
681	18	598	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_data/mqc_fastqc_per_sequence_gc_content_plot_Percentages.txt	mqc_fastqc_per_sequence_gc_content_plot_Percentages.txt	7340	-1366275161	\N	f	2022-09-16 14:40:35.751+00
682	18	598	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_data/mqc_fastqc_per_sequence_quality_scores_plot-2_1.txt	mqc_fastqc_per_sequence_quality_scores_plot-2_1.txt	1504	1151653705	\N	f	2022-09-16 14:40:35.751+00
683	18	598	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_data/mqc_fastqc_per_sequence_quality_scores_plot_1.txt	mqc_fastqc_per_sequence_quality_scores_plot_1.txt	1881	1692063662	\N	f	2022-09-16 14:40:35.755+00
684	18	598	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_data/mqc_fastqc_sequence_counts_plot-2_1.txt	mqc_fastqc_sequence_counts_plot-2_1.txt	173	296625833	\N	f	2022-09-16 14:40:35.751+00
685	18	598	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_data/mqc_fastqc_sequence_counts_plot_1.txt	mqc_fastqc_sequence_counts_plot_1.txt	174	-827566327	\N	f	2022-09-16 14:40:35.755+00
686	18	598	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_data/mqc_fastqc_sequence_duplication_levels_plot-2_1.txt	mqc_fastqc_sequence_duplication_levels_plot-2_1.txt	627	1887266059	\N	f	2022-09-16 14:40:35.751+00
687	18	598	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_data/mqc_fastqc_sequence_duplication_levels_plot_1.txt	mqc_fastqc_sequence_duplication_levels_plot_1.txt	658	1489044403	\N	f	2022-09-16 14:40:35.755+00
688	18	598	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_data/mqc_fastqc_sequence_length_distribution_plot_1.txt	mqc_fastqc_sequence_length_distribution_plot_1.txt	1126	-551346088	\N	f	2022-09-16 14:40:35.751+00
689	18	598	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_data/mqc_featurecounts_biotype_plot_1.txt	mqc_featurecounts_biotype_plot_1.txt	171	2010701973	\N	f	2022-09-16 14:40:35.755+00
690	18	598	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_data/mqc_mqc_mplplot_ksbuxlnfvp_1.txt	mqc_mqc_mplplot_ksbuxlnfvp_1.txt	132378	266880437	\N	f	2022-09-16 14:40:35.751+00
691	18	598	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_data/mqc_picard_deduplication_1.txt	mqc_picard_deduplication_1.txt	184	721695492	\N	f	2022-09-16 14:40:35.755+00
692	18	598	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_data/mqc_preseq_plot_1.txt	mqc_preseq_plot_1.txt	36023	-1030845062	\N	f	2022-09-16 14:40:35.759+00
693	18	598	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_data/mqc_qualimap_gene_coverage_profile_Counts.txt	mqc_qualimap_gene_coverage_profile_Counts.txt	4074	1873389117	\N	f	2022-09-16 14:40:35.759+00
694	18	598	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_data/mqc_qualimap_gene_coverage_profile_Normalised.txt	mqc_qualimap_gene_coverage_profile_Normalised.txt	4110	-885221426	\N	f	2022-09-16 14:40:35.755+00
695	18	598	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_data/mqc_qualimap_genomic_origin_1.txt	mqc_qualimap_genomic_origin_1.txt	132	53308445	\N	f	2022-09-16 14:40:35.751+00
696	18	598	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_data/mqc_rseqc_infer_experiment_plot_1.txt	mqc_rseqc_infer_experiment_plot_1.txt	114	199910627	\N	f	2022-09-16 14:40:35.755+00
697	18	598	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_data/mqc_rseqc_inner_distance_plot_Counts.txt	mqc_rseqc_inner_distance_plot_Counts.txt	1902	-1905496673	\N	f	2022-09-16 14:40:35.759+00
698	18	598	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_data/mqc_rseqc_inner_distance_plot_Percentages.txt	mqc_rseqc_inner_distance_plot_Percentages.txt	3881	-175530920	\N	f	2022-09-16 14:40:35.751+00
699	18	598	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_data/mqc_rseqc_junction_annotation_junctions_plot_Events.txt	mqc_rseqc_junction_annotation_junctions_plot_Events.txt	170	-1894418556	\N	f	2022-09-16 14:40:35.759+00
700	18	598	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_data/mqc_rseqc_junction_annotation_junctions_plot_Junctions.txt	mqc_rseqc_junction_annotation_junctions_plot_Junctions.txt	174	1389318378	\N	f	2022-09-16 14:40:35.751+00
701	18	598	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_data/mqc_rseqc_junction_saturation_plot_All_Junctions.txt	mqc_rseqc_junction_saturation_plot_All_Junctions.txt	471	835994084	\N	f	2022-09-16 14:40:35.751+00
702	18	598	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_data/mqc_rseqc_junction_saturation_plot_Known_Junctions.txt	mqc_rseqc_junction_saturation_plot_Known_Junctions.txt	471	1717330083	\N	f	2022-09-16 14:40:35.759+00
703	18	598	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_data/mqc_rseqc_junction_saturation_plot_Novel_Junctions.txt	mqc_rseqc_junction_saturation_plot_Novel_Junctions.txt	402	-491754063	\N	f	2022-09-16 14:40:35.755+00
704	18	598	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_data/mqc_rseqc_read_distribution_plot_1.txt	mqc_rseqc_read_distribution_plot_1.txt	343	-746166004	\N	f	2022-09-16 14:40:35.755+00
705	18	598	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_data/mqc_rseqc_read_dups_plot_1.txt	mqc_rseqc_read_dups_plot_1.txt	843	-1860124097	\N	f	2022-09-16 14:40:35.755+00
706	18	598	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_data/mqc_samtools-idxstats-mapped-reads-plot_Normalised_Counts.txt	mqc_samtools-idxstats-mapped-reads-plot_Normalised_Counts.txt	359	977284489	\N	f	2022-09-16 14:40:35.755+00
707	18	598	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_data/mqc_samtools-idxstats-mapped-reads-plot_Observed_over_Expected_Counts.txt	mqc_samtools-idxstats-mapped-reads-plot_Observed_over_Expected_Counts.txt	347	511474980	\N	f	2022-09-16 14:40:35.755+00
708	18	598	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_data/mqc_samtools-idxstats-mapped-reads-plot_Raw_Counts.txt	mqc_samtools-idxstats-mapped-reads-plot_Raw_Counts.txt	203	-1018819851	\N	f	2022-09-16 14:40:35.751+00
709	18	598	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_data/mqc_samtools_alignment_plot_1.txt	mqc_samtools_alignment_plot_1.txt	78	-992488306	\N	f	2022-09-16 14:40:35.755+00
710	18	598	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_data/mqc_star_alignment_plot_1.txt	mqc_star_alignment_plot_1.txt	218	89946304	\N	f	2022-09-16 14:40:35.751+00
711	18	598	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_data/multiqc.log	multiqc.log	21834	805222761	\N	f	2022-09-16 14:40:35.755+00
712	18	598	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_data/multiqc_cutadapt.txt	multiqc_cutadapt.txt	463	553650287	\N	f	2022-09-16 14:40:35.751+00
713	18	598	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_data/multiqc_data.json	multiqc_data.json	1709170	-1703532433	\N	f	2022-09-16 14:40:35.755+00
714	18	598	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_data/multiqc_fastqc.txt	multiqc_fastqc.txt	1114	1259133728	\N	f	2022-09-16 14:40:35.755+00
715	18	598	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_data/multiqc_fastqc_1.txt	multiqc_fastqc_1.txt	1181	734481253	\N	f	2022-09-16 14:40:35.759+00
716	18	598	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_data/multiqc_general_stats.txt	multiqc_general_stats.txt	2583	1630366172	\N	f	2022-09-16 14:40:35.751+00
717	18	598	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_data/multiqc_picard_dups.txt	multiqc_picard_dups.txt	428	-1669254028	\N	f	2022-09-16 14:40:35.751+00
718	18	598	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_data/multiqc_rseqc_bam_stat.txt	multiqc_rseqc_bam_stat.txt	624	668288750	\N	f	2022-09-16 14:40:35.755+00
719	18	598	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_data/multiqc_rseqc_infer_experiment.txt	multiqc_rseqc_infer_experiment.txt	122	1359457437	\N	f	2022-09-16 14:40:35.751+00
720	18	598	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_data/multiqc_rseqc_junction_annotation.txt	multiqc_rseqc_junction_annotation.txt	748	1690327283	\N	f	2022-09-16 14:40:35.751+00
721	18	598	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_data/multiqc_rseqc_read_distribution.txt	multiqc_rseqc_read_distribution.txt	1876	1848146983	\N	f	2022-09-16 14:40:35.755+00
722	18	598	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_data/multiqc_samtools_flagstat.txt	multiqc_samtools_flagstat.txt	1100	-1864235301	\N	f	2022-09-16 14:40:35.759+00
723	18	598	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_data/multiqc_samtools_idxstats.txt	multiqc_samtools_idxstats.txt	399	1098827275	\N	f	2022-09-16 14:40:35.751+00
724	18	598	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_data/multiqc_samtools_stats.txt	multiqc_samtools_stats.txt	1807	-243286237	\N	f	2022-09-16 14:40:35.755+00
725	18	598	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_data/multiqc_sources.txt	multiqc_sources.txt	6798	1614533737	\N	f	2022-09-16 14:40:35.755+00
726	18	598	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_data/multiqc_star.txt	multiqc_star.txt	847	625007740	\N	f	2022-09-16 14:40:35.751+00
727	18	598	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_data/multiqc_warning:_fail_strand_check.txt	multiqc_warning:_fail_strand_check.txt	284	286591330	\N	f	2022-09-16 14:40:35.759+00
728	18	600	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_cutadapt_filtered_reads_plot_1.pdf	mqc_cutadapt_filtered_reads_plot_1.pdf	12492	1704010784	\N	f	2022-09-16 14:40:35.751+00
729	18	600	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_cutadapt_filtered_reads_plot_1_pc.pdf	mqc_cutadapt_filtered_reads_plot_1_pc.pdf	12654	-1820834988	\N	f	2022-09-16 14:40:35.747+00
730	18	600	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_cutadapt_trimmed_sequences_plot_3_Counts.pdf	mqc_cutadapt_trimmed_sequences_plot_3_Counts.pdf	17929	561245797	\N	f	2022-09-16 14:40:35.751+00
731	18	600	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_cutadapt_trimmed_sequences_plot_3_Obs_Exp.pdf	mqc_cutadapt_trimmed_sequences_plot_3_Obs_Exp.pdf	18416	2082947623	\N	f	2022-09-16 14:40:35.747+00
732	18	600	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_fastqc_adapter_content_plot_1.pdf	mqc_fastqc_adapter_content_plot_1.pdf	16964	1218497886	\N	f	2022-09-16 14:40:35.751+00
733	18	600	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_fastqc_per_base_n_content_plot-2_1.pdf	mqc_fastqc_per_base_n_content_plot-2_1.pdf	16333	-889895431	\N	f	2022-09-16 14:40:35.747+00
734	18	600	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_fastqc_per_base_n_content_plot_1.pdf	mqc_fastqc_per_base_n_content_plot_1.pdf	16472	-721494149	\N	f	2022-09-16 14:40:35.751+00
735	18	600	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_fastqc_per_base_sequence_quality_plot-2_1.pdf	mqc_fastqc_per_base_sequence_quality_plot-2_1.pdf	16252	233852753	\N	f	2022-09-16 14:40:35.747+00
795	18	601	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/png/mqc_fastqc_sequence_counts_plot-2_1.png	mqc_fastqc_sequence_counts_plot-2_1.png	11519	449392556	\N	f	2022-09-16 14:40:35.743+00
736	18	600	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_fastqc_per_base_sequence_quality_plot_1.pdf	mqc_fastqc_per_base_sequence_quality_plot_1.pdf	16242	1308199630	\N	f	2022-09-16 14:40:35.747+00
737	18	600	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_fastqc_per_sequence_gc_content_plot-2_Counts.pdf	mqc_fastqc_per_sequence_gc_content_plot-2_Counts.pdf	17559	-1509780123	\N	f	2022-09-16 14:40:35.751+00
738	18	600	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_fastqc_per_sequence_gc_content_plot-2_Percentages.pdf	mqc_fastqc_per_sequence_gc_content_plot-2_Percentages.pdf	18017	-1146603681	\N	f	2022-09-16 14:40:35.747+00
739	18	600	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_fastqc_per_sequence_gc_content_plot_Counts.pdf	mqc_fastqc_per_sequence_gc_content_plot_Counts.pdf	17389	-1618226232	\N	f	2022-09-16 14:40:35.751+00
740	18	600	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_fastqc_per_sequence_gc_content_plot_Percentages.pdf	mqc_fastqc_per_sequence_gc_content_plot_Percentages.pdf	17835	1233657291	\N	f	2022-09-16 14:40:35.747+00
741	18	600	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_fastqc_per_sequence_quality_scores_plot-2_1.pdf	mqc_fastqc_per_sequence_quality_scores_plot-2_1.pdf	15321	836106168	\N	f	2022-09-16 14:40:35.747+00
742	18	600	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_fastqc_per_sequence_quality_scores_plot_1.pdf	mqc_fastqc_per_sequence_quality_scores_plot_1.pdf	15521	1815817206	\N	f	2022-09-16 14:40:35.747+00
743	18	600	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_fastqc_sequence_counts_plot-2_1.pdf	mqc_fastqc_sequence_counts_plot-2_1.pdf	14760	-20799931	\N	f	2022-09-16 14:40:35.747+00
744	18	600	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_fastqc_sequence_counts_plot-2_1_pc.pdf	mqc_fastqc_sequence_counts_plot-2_1_pc.pdf	14924	1807401338	\N	f	2022-09-16 14:40:35.751+00
745	18	600	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_fastqc_sequence_counts_plot_1.pdf	mqc_fastqc_sequence_counts_plot_1.pdf	14764	1252782640	\N	f	2022-09-16 14:40:35.751+00
746	18	600	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_fastqc_sequence_counts_plot_1_pc.pdf	mqc_fastqc_sequence_counts_plot_1_pc.pdf	14923	404737304	\N	f	2022-09-16 14:40:35.747+00
747	18	600	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_fastqc_sequence_duplication_levels_plot-2_1.pdf	mqc_fastqc_sequence_duplication_levels_plot-2_1.pdf	17119	-2063279970	\N	f	2022-09-16 14:40:35.751+00
748	18	600	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_fastqc_sequence_duplication_levels_plot_1.pdf	mqc_fastqc_sequence_duplication_levels_plot_1.pdf	17128	-2026109261	\N	f	2022-09-16 14:40:35.751+00
749	18	600	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_fastqc_sequence_length_distribution_plot_1.pdf	mqc_fastqc_sequence_length_distribution_plot_1.pdf	16721	308372489	\N	f	2022-09-16 14:40:35.747+00
750	18	600	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_featurecounts_biotype_plot_1.pdf	mqc_featurecounts_biotype_plot_1.pdf	13057	-1050678610	\N	f	2022-09-16 14:40:35.747+00
751	18	600	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_featurecounts_biotype_plot_1_pc.pdf	mqc_featurecounts_biotype_plot_1_pc.pdf	13856	1171900321	\N	f	2022-09-16 14:40:35.751+00
752	18	600	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_mqc_mplplot_ksbuxlnfvp_1.pdf	mqc_mqc_mplplot_ksbuxlnfvp_1.pdf	14502	1900786317	\N	f	2022-09-16 14:40:35.751+00
753	18	600	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_picard_deduplication_1.pdf	mqc_picard_deduplication_1.pdf	13674	-1556024978	\N	f	2022-09-16 14:40:35.751+00
754	18	600	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_picard_deduplication_1_pc.pdf	mqc_picard_deduplication_1_pc.pdf	13944	-1283604755	\N	f	2022-09-16 14:40:35.747+00
755	18	600	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_preseq_plot_1.pdf	mqc_preseq_plot_1.pdf	16639	-849722675	\N	f	2022-09-16 14:40:35.747+00
756	18	600	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_qualimap_gene_coverage_profile_Counts.pdf	mqc_qualimap_gene_coverage_profile_Counts.pdf	18125	176207303	\N	f	2022-09-16 14:40:35.751+00
757	18	600	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_qualimap_gene_coverage_profile_Normalised.pdf	mqc_qualimap_gene_coverage_profile_Normalised.pdf	17963	936480898	\N	f	2022-09-16 14:40:35.751+00
758	18	600	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_qualimap_genomic_origin_1.pdf	mqc_qualimap_genomic_origin_1.pdf	14830	-1922268508	\N	f	2022-09-16 14:40:35.747+00
759	18	600	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_qualimap_genomic_origin_1_pc.pdf	mqc_qualimap_genomic_origin_1_pc.pdf	15109	-769181394	\N	f	2022-09-16 14:40:35.747+00
760	18	600	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_rseqc_infer_experiment_plot_1.pdf	mqc_rseqc_infer_experiment_plot_1.pdf	13904	700650161	\N	f	2022-09-16 14:40:35.751+00
761	18	600	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_rseqc_inner_distance_plot_Counts.pdf	mqc_rseqc_inner_distance_plot_Counts.pdf	14788	1427153035	\N	f	2022-09-16 14:40:35.747+00
762	18	600	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_rseqc_inner_distance_plot_Percentages.pdf	mqc_rseqc_inner_distance_plot_Percentages.pdf	15446	1583336845	\N	f	2022-09-16 14:40:35.747+00
763	18	600	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_rseqc_junction_annotation_junctions_plot_Events.pdf	mqc_rseqc_junction_annotation_junctions_plot_Events.pdf	14488	1013050824	\N	f	2022-09-16 14:40:35.751+00
764	18	600	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_rseqc_junction_annotation_junctions_plot_Events_pc.pdf	mqc_rseqc_junction_annotation_junctions_plot_Events_pc.pdf	14580	-473990403	\N	f	2022-09-16 14:40:35.751+00
765	18	600	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_rseqc_junction_annotation_junctions_plot_Junctions.pdf	mqc_rseqc_junction_annotation_junctions_plot_Junctions.pdf	14955	-1303506185	\N	f	2022-09-16 14:40:35.751+00
766	18	600	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_rseqc_junction_annotation_junctions_plot_Junctions_pc.pdf	mqc_rseqc_junction_annotation_junctions_plot_Junctions_pc.pdf	14387	-1211483048	\N	f	2022-09-16 14:40:35.751+00
767	18	600	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_rseqc_junction_saturation_plot_All_Junctions.pdf	mqc_rseqc_junction_saturation_plot_All_Junctions.pdf	14949	-129015180	\N	f	2022-09-16 14:40:35.747+00
768	18	600	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_rseqc_junction_saturation_plot_Known_Junctions.pdf	mqc_rseqc_junction_saturation_plot_Known_Junctions.pdf	14961	400337637	\N	f	2022-09-16 14:40:35.747+00
769	18	600	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_rseqc_junction_saturation_plot_Novel_Junctions.pdf	mqc_rseqc_junction_saturation_plot_Novel_Junctions.pdf	14525	1177676241	\N	f	2022-09-16 14:40:35.747+00
770	18	600	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_rseqc_read_distribution_plot_1.pdf	mqc_rseqc_read_distribution_plot_1.pdf	17341	1873134103	\N	f	2022-09-16 14:40:35.747+00
771	18	600	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_rseqc_read_distribution_plot_1_pc.pdf	mqc_rseqc_read_distribution_plot_1_pc.pdf	18132	1929847765	\N	f	2022-09-16 14:40:35.747+00
772	18	600	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_rseqc_read_dups_plot_1.pdf	mqc_rseqc_read_dups_plot_1.pdf	16315	-1295209792	\N	f	2022-09-16 14:40:35.751+00
773	18	600	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_samtools-idxstats-mapped-reads-plot_Normalised_Counts.pdf	mqc_samtools-idxstats-mapped-reads-plot_Normalised_Counts.pdf	15221	248723381	\N	f	2022-09-16 14:40:35.747+00
774	18	600	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_samtools-idxstats-mapped-reads-plot_Observed_over_Expected_Counts.pdf	mqc_samtools-idxstats-mapped-reads-plot_Observed_over_Expected_Counts.pdf	16313	-2012842922	\N	f	2022-09-16 14:40:35.751+00
775	18	600	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_samtools-idxstats-mapped-reads-plot_Raw_Counts.pdf	mqc_samtools-idxstats-mapped-reads-plot_Raw_Counts.pdf	15138	-764665793	\N	f	2022-09-16 14:40:35.747+00
776	18	600	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_samtools_alignment_plot_1.pdf	mqc_samtools_alignment_plot_1.pdf	12813	1551222151	\N	f	2022-09-16 14:40:35.747+00
777	18	600	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_samtools_alignment_plot_1_pc.pdf	mqc_samtools_alignment_plot_1_pc.pdf	13096	-352560091	\N	f	2022-09-16 14:40:35.747+00
778	18	600	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_star_alignment_plot_1.pdf	mqc_star_alignment_plot_1.pdf	14425	1129414490	\N	f	2022-09-16 14:40:35.751+00
779	18	600	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_star_alignment_plot_1_pc.pdf	mqc_star_alignment_plot_1_pc.pdf	14587	341252223	\N	f	2022-09-16 14:40:35.751+00
780	18	601	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/png/mqc_cutadapt_filtered_reads_plot_1.png	mqc_cutadapt_filtered_reads_plot_1.png	10408	1073528406	\N	f	2022-09-16 14:40:35.743+00
781	18	601	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/png/mqc_cutadapt_filtered_reads_plot_1_pc.png	mqc_cutadapt_filtered_reads_plot_1_pc.png	10669	799749564	\N	f	2022-09-16 14:40:35.747+00
782	18	601	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/png/mqc_cutadapt_trimmed_sequences_plot_3_Counts.png	mqc_cutadapt_trimmed_sequences_plot_3_Counts.png	25706	1310456533	\N	f	2022-09-16 14:40:35.743+00
783	18	601	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/png/mqc_cutadapt_trimmed_sequences_plot_3_Obs_Exp.png	mqc_cutadapt_trimmed_sequences_plot_3_Obs_Exp.png	27862	2064694606	\N	f	2022-09-16 14:40:35.743+00
784	18	601	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/png/mqc_fastqc_adapter_content_plot_1.png	mqc_fastqc_adapter_content_plot_1.png	17378	-1548020994	\N	f	2022-09-16 14:40:35.743+00
785	18	601	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/png/mqc_fastqc_per_base_n_content_plot-2_1.png	mqc_fastqc_per_base_n_content_plot-2_1.png	19662	-64600068	\N	f	2022-09-16 14:40:35.743+00
786	18	601	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/png/mqc_fastqc_per_base_n_content_plot_1.png	mqc_fastqc_per_base_n_content_plot_1.png	21933	1158407086	\N	f	2022-09-16 14:40:35.743+00
787	18	601	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/png/mqc_fastqc_per_base_sequence_quality_plot-2_1.png	mqc_fastqc_per_base_sequence_quality_plot-2_1.png	32706	-680085739	\N	f	2022-09-16 14:40:35.743+00
788	18	601	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/png/mqc_fastqc_per_base_sequence_quality_plot_1.png	mqc_fastqc_per_base_sequence_quality_plot_1.png	35376	-582836774	\N	f	2022-09-16 14:40:35.747+00
789	18	601	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/png/mqc_fastqc_per_sequence_gc_content_plot-2_Counts.png	mqc_fastqc_per_sequence_gc_content_plot-2_Counts.png	45839	1770736870	\N	f	2022-09-16 14:40:35.743+00
790	18	601	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/png/mqc_fastqc_per_sequence_gc_content_plot-2_Percentages.png	mqc_fastqc_per_sequence_gc_content_plot-2_Percentages.png	46100	518725352	\N	f	2022-09-16 14:40:35.743+00
791	18	601	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/png/mqc_fastqc_per_sequence_gc_content_plot_Counts.png	mqc_fastqc_per_sequence_gc_content_plot_Counts.png	45420	1389290769	\N	f	2022-09-16 14:40:35.743+00
792	18	601	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/png/mqc_fastqc_per_sequence_gc_content_plot_Percentages.png	mqc_fastqc_per_sequence_gc_content_plot_Percentages.png	45401	1060365796	\N	f	2022-09-16 14:40:35.747+00
793	18	601	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/png/mqc_fastqc_per_sequence_quality_scores_plot-2_1.png	mqc_fastqc_per_sequence_quality_scores_plot-2_1.png	44750	-1694682892	\N	f	2022-09-16 14:40:35.747+00
794	18	601	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/png/mqc_fastqc_per_sequence_quality_scores_plot_1.png	mqc_fastqc_per_sequence_quality_scores_plot_1.png	47051	-846970054	\N	f	2022-09-16 14:40:35.743+00
796	18	601	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/png/mqc_fastqc_sequence_counts_plot-2_1_pc.png	mqc_fastqc_sequence_counts_plot-2_1_pc.png	11775	-1784426209	\N	f	2022-09-16 14:40:35.747+00
797	18	601	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/png/mqc_fastqc_sequence_counts_plot_1.png	mqc_fastqc_sequence_counts_plot_1.png	11517	-414812623	\N	f	2022-09-16 14:40:35.743+00
798	18	601	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/png/mqc_fastqc_sequence_counts_plot_1_pc.png	mqc_fastqc_sequence_counts_plot_1_pc.png	11772	-1539865528	\N	f	2022-09-16 14:40:35.743+00
799	18	601	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/png/mqc_fastqc_sequence_duplication_levels_plot-2_1.png	mqc_fastqc_sequence_duplication_levels_plot-2_1.png	30622	-1265029252	\N	f	2022-09-16 14:40:35.743+00
800	18	601	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/png/mqc_fastqc_sequence_duplication_levels_plot_1.png	mqc_fastqc_sequence_duplication_levels_plot_1.png	30473	1447111166	\N	f	2022-09-16 14:40:35.743+00
801	18	601	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/png/mqc_fastqc_sequence_length_distribution_plot_1.png	mqc_fastqc_sequence_length_distribution_plot_1.png	29105	998655901	\N	f	2022-09-16 14:40:35.743+00
802	18	601	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/png/mqc_featurecounts_biotype_plot_1.png	mqc_featurecounts_biotype_plot_1.png	11007	509090693	\N	f	2022-09-16 14:40:35.743+00
803	18	601	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/png/mqc_featurecounts_biotype_plot_1_pc.png	mqc_featurecounts_biotype_plot_1_pc.png	11304	-1568541778	\N	f	2022-09-16 14:40:35.743+00
804	18	601	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/png/mqc_mqc_mplplot_ksbuxlnfvp_1.png	mqc_mqc_mplplot_ksbuxlnfvp_1.png	21199	1203482582	\N	f	2022-09-16 14:40:35.747+00
805	18	601	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/png/mqc_picard_deduplication_1.png	mqc_picard_deduplication_1.png	10485	-694429612	\N	f	2022-09-16 14:40:35.743+00
806	18	601	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/png/mqc_picard_deduplication_1_pc.png	mqc_picard_deduplication_1_pc.png	10977	169582021	\N	f	2022-09-16 14:40:35.743+00
807	18	601	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/png/mqc_preseq_plot_1.png	mqc_preseq_plot_1.png	40966	-1953925569	\N	f	2022-09-16 14:40:35.743+00
808	18	601	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/png/mqc_qualimap_gene_coverage_profile_Counts.png	mqc_qualimap_gene_coverage_profile_Counts.png	49153	1322088560	\N	f	2022-09-16 14:40:35.743+00
809	18	601	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/png/mqc_qualimap_gene_coverage_profile_Normalised.png	mqc_qualimap_gene_coverage_profile_Normalised.png	50673	1184851840	\N	f	2022-09-16 14:40:35.743+00
810	18	601	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/png/mqc_qualimap_genomic_origin_1.png	mqc_qualimap_genomic_origin_1.png	9263	-583310292	\N	f	2022-09-16 14:40:35.747+00
811	18	601	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/png/mqc_qualimap_genomic_origin_1_pc.png	mqc_qualimap_genomic_origin_1_pc.png	9700	-350619147	\N	f	2022-09-16 14:40:35.747+00
812	18	601	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/png/mqc_rseqc_infer_experiment_plot_1.png	mqc_rseqc_infer_experiment_plot_1.png	9326	493703835	\N	f	2022-09-16 14:40:35.747+00
813	18	601	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/png/mqc_rseqc_inner_distance_plot_Counts.png	mqc_rseqc_inner_distance_plot_Counts.png	37958	1165008224	\N	f	2022-09-16 14:40:35.743+00
814	18	601	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/png/mqc_rseqc_inner_distance_plot_Percentages.png	mqc_rseqc_inner_distance_plot_Percentages.png	36585	-238629241	\N	f	2022-09-16 14:40:35.747+00
815	18	601	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/png/mqc_rseqc_junction_annotation_junctions_plot_Events.png	mqc_rseqc_junction_annotation_junctions_plot_Events.png	11222	329404852	\N	f	2022-09-16 14:40:35.743+00
816	18	601	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/png/mqc_rseqc_junction_annotation_junctions_plot_Events_pc.png	mqc_rseqc_junction_annotation_junctions_plot_Events_pc.png	12051	135531061	\N	f	2022-09-16 14:40:35.743+00
817	18	601	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/png/mqc_rseqc_junction_annotation_junctions_plot_Junctions.png	mqc_rseqc_junction_annotation_junctions_plot_Junctions.png	11516	-1046868426	\N	f	2022-09-16 14:40:35.747+00
818	18	601	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/png/mqc_rseqc_junction_annotation_junctions_plot_Junctions_pc.png	mqc_rseqc_junction_annotation_junctions_plot_Junctions_pc.png	12186	-111361993	\N	f	2022-09-16 14:40:35.743+00
819	18	601	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/png/mqc_rseqc_junction_saturation_plot_All_Junctions.png	mqc_rseqc_junction_saturation_plot_All_Junctions.png	35118	-2031128099	\N	f	2022-09-16 14:40:35.743+00
820	18	601	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/png/mqc_rseqc_junction_saturation_plot_Known_Junctions.png	mqc_rseqc_junction_saturation_plot_Known_Junctions.png	35135	1142362923	\N	f	2022-09-16 14:40:35.743+00
821	18	601	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/png/mqc_rseqc_junction_saturation_plot_Novel_Junctions.png	mqc_rseqc_junction_saturation_plot_Novel_Junctions.png	32862	1653512846	\N	f	2022-09-16 14:40:35.747+00
822	18	601	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/png/mqc_rseqc_read_distribution_plot_1.png	mqc_rseqc_read_distribution_plot_1.png	15318	708840257	\N	f	2022-09-16 14:40:35.743+00
823	18	601	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/png/mqc_rseqc_read_distribution_plot_1_pc.png	mqc_rseqc_read_distribution_plot_1_pc.png	15696	692259513	\N	f	2022-09-16 14:40:35.743+00
824	18	601	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/png/mqc_rseqc_read_dups_plot_1.png	mqc_rseqc_read_dups_plot_1.png	20051	1168581318	\N	f	2022-09-16 14:40:35.743+00
825	18	601	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/png/mqc_samtools-idxstats-mapped-reads-plot_Normalised_Counts.png	mqc_samtools-idxstats-mapped-reads-plot_Normalised_Counts.png	44872	-838528841	\N	f	2022-09-16 14:40:35.743+00
826	18	601	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/png/mqc_samtools-idxstats-mapped-reads-plot_Observed_over_Expected_Counts.png	mqc_samtools-idxstats-mapped-reads-plot_Observed_over_Expected_Counts.png	37051	1656226465	\N	f	2022-09-16 14:40:35.743+00
827	18	601	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/png/mqc_samtools-idxstats-mapped-reads-plot_Raw_Counts.png	mqc_samtools-idxstats-mapped-reads-plot_Raw_Counts.png	47224	788309183	\N	f	2022-09-16 14:40:35.743+00
828	18	601	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/png/mqc_samtools_alignment_plot_1.png	mqc_samtools_alignment_plot_1.png	8040	990861796	\N	f	2022-09-16 14:40:35.743+00
829	18	601	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/png/mqc_samtools_alignment_plot_1_pc.png	mqc_samtools_alignment_plot_1_pc.png	8549	-2061302812	\N	f	2022-09-16 14:40:35.743+00
830	18	601	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/png/mqc_star_alignment_plot_1.png	mqc_star_alignment_plot_1.png	11156	2094159309	\N	f	2022-09-16 14:40:35.747+00
831	18	601	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/png/mqc_star_alignment_plot_1_pc.png	mqc_star_alignment_plot_1_pc.png	11860	-1918214381	\N	f	2022-09-16 14:40:35.743+00
832	18	602	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/svg/mqc_cutadapt_filtered_reads_plot_1.svg	mqc_cutadapt_filtered_reads_plot_1.svg	24690	1885455318	\N	f	2022-09-16 14:40:35.735+00
833	18	602	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/svg/mqc_cutadapt_filtered_reads_plot_1_pc.svg	mqc_cutadapt_filtered_reads_plot_1_pc.svg	23782	-471365071	\N	f	2022-09-16 14:40:35.735+00
834	18	602	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/svg/mqc_cutadapt_trimmed_sequences_plot_3_Counts.svg	mqc_cutadapt_trimmed_sequences_plot_3_Counts.svg	44356	1325857098	\N	f	2022-09-16 14:40:35.739+00
835	18	602	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/svg/mqc_cutadapt_trimmed_sequences_plot_3_Obs_Exp.svg	mqc_cutadapt_trimmed_sequences_plot_3_Obs_Exp.svg	44203	-956879302	\N	f	2022-09-16 14:40:35.739+00
836	18	602	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/svg/mqc_fastqc_adapter_content_plot_1.svg	mqc_fastqc_adapter_content_plot_1.svg	35201	-1536996326	\N	f	2022-09-16 14:40:35.735+00
837	18	602	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/svg/mqc_fastqc_per_base_n_content_plot-2_1.svg	mqc_fastqc_per_base_n_content_plot-2_1.svg	33995	-287881150	\N	f	2022-09-16 14:40:35.735+00
838	18	602	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/svg/mqc_fastqc_per_base_n_content_plot_1.svg	mqc_fastqc_per_base_n_content_plot_1.svg	34002	824391880	\N	f	2022-09-16 14:40:35.739+00
839	18	602	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/svg/mqc_fastqc_per_base_sequence_quality_plot-2_1.svg	mqc_fastqc_per_base_sequence_quality_plot-2_1.svg	33861	-846297773	\N	f	2022-09-16 14:40:35.739+00
840	18	602	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/svg/mqc_fastqc_per_base_sequence_quality_plot_1.svg	mqc_fastqc_per_base_sequence_quality_plot_1.svg	33867	-773681019	\N	f	2022-09-16 14:40:35.739+00
841	18	602	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/svg/mqc_fastqc_per_sequence_gc_content_plot-2_Counts.svg	mqc_fastqc_per_sequence_gc_content_plot-2_Counts.svg	40190	-72642506	\N	f	2022-09-16 14:40:35.739+00
842	18	602	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/svg/mqc_fastqc_per_sequence_gc_content_plot-2_Percentages.svg	mqc_fastqc_per_sequence_gc_content_plot-2_Percentages.svg	38579	1062532146	\N	f	2022-09-16 14:40:35.735+00
843	18	602	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/svg/mqc_fastqc_per_sequence_gc_content_plot_Counts.svg	mqc_fastqc_per_sequence_gc_content_plot_Counts.svg	40158	1403939092	\N	f	2022-09-16 14:40:35.739+00
844	18	602	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/svg/mqc_fastqc_per_sequence_gc_content_plot_Percentages.svg	mqc_fastqc_per_sequence_gc_content_plot_Percentages.svg	38560	1951972776	\N	f	2022-09-16 14:40:35.739+00
845	18	602	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/svg/mqc_fastqc_per_sequence_quality_scores_plot-2_1.svg	mqc_fastqc_per_sequence_quality_scores_plot-2_1.svg	35286	859234698	\N	f	2022-09-16 14:40:35.739+00
846	18	602	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/svg/mqc_fastqc_per_sequence_quality_scores_plot_1.svg	mqc_fastqc_per_sequence_quality_scores_plot_1.svg	36029	797908432	\N	f	2022-09-16 14:40:35.739+00
847	18	602	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/svg/mqc_fastqc_sequence_counts_plot-2_1.svg	mqc_fastqc_sequence_counts_plot-2_1.svg	29360	-805643931	\N	f	2022-09-16 14:40:35.739+00
848	18	602	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/svg/mqc_fastqc_sequence_counts_plot-2_1_pc.svg	mqc_fastqc_sequence_counts_plot-2_1_pc.svg	28452	1882130918	\N	f	2022-09-16 14:40:35.735+00
849	18	602	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/svg/mqc_fastqc_sequence_counts_plot_1.svg	mqc_fastqc_sequence_counts_plot_1.svg	29352	634459629	\N	f	2022-09-16 14:40:35.739+00
850	18	602	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/svg/mqc_fastqc_sequence_counts_plot_1_pc.svg	mqc_fastqc_sequence_counts_plot_1_pc.svg	28448	-1956485000	\N	f	2022-09-16 14:40:35.739+00
851	18	602	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/svg/mqc_fastqc_sequence_duplication_levels_plot-2_1.svg	mqc_fastqc_sequence_duplication_levels_plot-2_1.svg	37098	71884230	\N	f	2022-09-16 14:40:35.735+00
852	18	602	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/svg/mqc_fastqc_sequence_duplication_levels_plot_1.svg	mqc_fastqc_sequence_duplication_levels_plot_1.svg	37102	-626008829	\N	f	2022-09-16 14:40:35.735+00
853	18	602	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/svg/mqc_fastqc_sequence_length_distribution_plot_1.svg	mqc_fastqc_sequence_length_distribution_plot_1.svg	34450	246788399	\N	f	2022-09-16 14:40:35.739+00
854	18	602	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/svg/mqc_featurecounts_biotype_plot_1.svg	mqc_featurecounts_biotype_plot_1.svg	27123	228823920	\N	f	2022-09-16 14:40:35.735+00
922	18	615	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/log/mutant.Log.out	mutant.Log.out	10557	-626302586	\N	f	2022-09-16 14:40:35.679+00
855	18	602	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/svg/mqc_featurecounts_biotype_plot_1_pc.svg	mqc_featurecounts_biotype_plot_1_pc.svg	27253	1994908658	\N	f	2022-09-16 14:40:35.739+00
856	18	602	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/svg/mqc_mqc_mplplot_ksbuxlnfvp_1.svg	mqc_mqc_mplplot_ksbuxlnfvp_1.svg	27185	-1725737837	\N	f	2022-09-16 14:40:35.739+00
857	18	602	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/svg/mqc_picard_deduplication_1.svg	mqc_picard_deduplication_1.svg	28447	1822294544	\N	f	2022-09-16 14:40:35.735+00
858	18	602	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/svg/mqc_picard_deduplication_1_pc.svg	mqc_picard_deduplication_1_pc.svg	28456	1192046571	\N	f	2022-09-16 14:40:35.735+00
859	18	602	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/svg/mqc_preseq_plot_1.svg	mqc_preseq_plot_1.svg	35845	-1809507503	\N	f	2022-09-16 14:40:35.739+00
860	18	602	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/svg/mqc_qualimap_gene_coverage_profile_Counts.svg	mqc_qualimap_gene_coverage_profile_Counts.svg	35561	1979955564	\N	f	2022-09-16 14:40:35.739+00
861	18	602	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/svg/mqc_qualimap_gene_coverage_profile_Normalised.svg	mqc_qualimap_gene_coverage_profile_Normalised.svg	37096	236211340	\N	f	2022-09-16 14:40:35.739+00
862	18	602	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/svg/mqc_qualimap_genomic_origin_1.svg	mqc_qualimap_genomic_origin_1.svg	27409	855241572	\N	f	2022-09-16 14:40:35.739+00
863	18	602	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/svg/mqc_qualimap_genomic_origin_1_pc.svg	mqc_qualimap_genomic_origin_1_pc.svg	27424	-872695469	\N	f	2022-09-16 14:40:35.739+00
864	18	602	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/svg/mqc_rseqc_infer_experiment_plot_1.svg	mqc_rseqc_infer_experiment_plot_1.svg	24524	-590094072	\N	f	2022-09-16 14:40:35.739+00
865	18	602	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/svg/mqc_rseqc_inner_distance_plot_Counts.svg	mqc_rseqc_inner_distance_plot_Counts.svg	28593	-392153238	\N	f	2022-09-16 14:40:35.739+00
866	18	602	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/svg/mqc_rseqc_inner_distance_plot_Percentages.svg	mqc_rseqc_inner_distance_plot_Percentages.svg	28406	996132585	\N	f	2022-09-16 14:40:35.739+00
867	18	602	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/svg/mqc_rseqc_junction_annotation_junctions_plot_Events.svg	mqc_rseqc_junction_annotation_junctions_plot_Events.svg	29229	-113972592	\N	f	2022-09-16 14:40:35.739+00
868	18	602	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/svg/mqc_rseqc_junction_annotation_junctions_plot_Events_pc.svg	mqc_rseqc_junction_annotation_junctions_plot_Events_pc.svg	28750	780088046	\N	f	2022-09-16 14:40:35.739+00
869	18	602	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/svg/mqc_rseqc_junction_annotation_junctions_plot_Junctions.svg	mqc_rseqc_junction_annotation_junctions_plot_Junctions.svg	31328	-894908730	\N	f	2022-09-16 14:40:35.739+00
870	18	602	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/svg/mqc_rseqc_junction_annotation_junctions_plot_Junctions_pc.svg	mqc_rseqc_junction_annotation_junctions_plot_Junctions_pc.svg	29054	-76190933	\N	f	2022-09-16 14:40:35.739+00
871	18	602	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/svg/mqc_rseqc_junction_saturation_plot_All_Junctions.svg	mqc_rseqc_junction_saturation_plot_All_Junctions.svg	29455	-491306785	\N	f	2022-09-16 14:40:35.735+00
872	18	602	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/svg/mqc_rseqc_junction_saturation_plot_Known_Junctions.svg	mqc_rseqc_junction_saturation_plot_Known_Junctions.svg	29452	-1511809838	\N	f	2022-09-16 14:40:35.739+00
873	18	602	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/svg/mqc_rseqc_junction_saturation_plot_Novel_Junctions.svg	mqc_rseqc_junction_saturation_plot_Novel_Junctions.svg	28186	-1964692623	\N	f	2022-09-16 14:40:35.735+00
874	18	602	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/svg/mqc_rseqc_read_distribution_plot_1.svg	mqc_rseqc_read_distribution_plot_1.svg	41151	-332693199	\N	f	2022-09-16 14:40:35.739+00
875	18	602	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/svg/mqc_rseqc_read_distribution_plot_1_pc.svg	mqc_rseqc_read_distribution_plot_1_pc.svg	41157	-1666031625	\N	f	2022-09-16 14:40:35.739+00
876	18	602	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/svg/mqc_rseqc_read_dups_plot_1.svg	mqc_rseqc_read_dups_plot_1.svg	31428	1200744608	\N	f	2022-09-16 14:40:35.739+00
877	18	602	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/svg/mqc_samtools-idxstats-mapped-reads-plot_Normalised_Counts.svg	mqc_samtools-idxstats-mapped-reads-plot_Normalised_Counts.svg	31957	1303665571	\N	f	2022-09-16 14:40:35.735+00
878	18	602	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/svg/mqc_samtools-idxstats-mapped-reads-plot_Observed_over_Expected_Counts.svg	mqc_samtools-idxstats-mapped-reads-plot_Observed_over_Expected_Counts.svg	35195	-1382224997	\N	f	2022-09-16 14:40:35.739+00
879	18	602	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/svg/mqc_samtools-idxstats-mapped-reads-plot_Raw_Counts.svg	mqc_samtools-idxstats-mapped-reads-plot_Raw_Counts.svg	33137	1961238661	\N	f	2022-09-16 14:40:35.739+00
880	18	602	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/svg/mqc_samtools_alignment_plot_1.svg	mqc_samtools_alignment_plot_1.svg	22456	813848910	\N	f	2022-09-16 14:40:35.739+00
881	18	602	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/svg/mqc_samtools_alignment_plot_1_pc.svg	mqc_samtools_alignment_plot_1_pc.svg	22469	-108556474	\N	f	2022-09-16 14:40:35.739+00
882	18	602	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/svg/mqc_star_alignment_plot_1.svg	mqc_star_alignment_plot_1.svg	31881	-2061486414	\N	f	2022-09-16 14:40:35.739+00
883	18	602	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_plots/svg/mqc_star_alignment_plot_1_pc.svg	mqc_star_alignment_plot_1_pc.svg	30979	-1557121649	\N	f	2022-09-16 14:40:35.735+00
884	18	597	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/multiqc/star_salmon/multiqc_report.html	multiqc_report.html	1489909	-1849155450	\N	f	2022-09-16 14:40:35.735+00
885	18	603	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/pipeline_info/execution_report_2022-09-16_12-13-52.html	execution_report_2022-09-16_12-13-52.html	3235144	1818847943	\N	f	2022-09-16 14:40:35.067+00
886	18	603	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/pipeline_info/execution_timeline_2022-09-16_12-13-52.html	execution_timeline_2022-09-16_12-13-52.html	277030	29554977	\N	f	2022-09-16 14:40:35.071+00
887	18	603	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/pipeline_info/execution_trace_2022-09-16_12-13-52.txt	execution_trace_2022-09-16_12-13-52.txt	13601	-197010820	\N	f	2022-09-16 14:40:35.067+00
888	18	603	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/pipeline_info/pipeline_dag_2022-09-16_12-13-52.html	pipeline_dag_2022-09-16_12-13-52.html	65918	-1513042193	\N	f	2022-09-16 14:40:35.071+00
889	18	603	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/pipeline_info/samplesheet.valid.csv	samplesheet.valid.csv	253	803975711	\N	f	2022-09-16 14:40:35.067+00
890	18	603	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/pipeline_info/software_versions.yml	software_versions.yml	1640	518292253	\N	f	2022-09-16 14:40:35.067+00
891	18	605	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/bigwig/mutant.forward.bigWig	mutant.forward.bigWig	6465625	-890854892	\N	f	2022-09-16 14:40:35.675+00
892	18	605	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/bigwig/mutant.reverse.bigWig	mutant.reverse.bigWig	6469366	-1142534299	\N	f	2022-09-16 14:40:35.663+00
893	18	605	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/bigwig/wildtype.forward.bigWig	wildtype.forward.bigWig	5492187	-1156025466	\N	f	2022-09-16 14:40:35.667+00
894	18	605	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/bigwig/wildtype.reverse.bigWig	wildtype.reverse.bigWig	5496001	-1926444767	\N	f	2022-09-16 14:40:35.655+00
895	18	606	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/deseq2_qc/R_sessionInfo.log	R_sessionInfo.log	2006	399246171	\N	f	2022-09-16 14:40:35.735+00
896	18	606	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/deseq2_qc/deseq2.dds.RData	deseq2.dds.RData	554950	-1613840674	\N	f	2022-09-16 14:40:35.731+00
897	18	606	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/deseq2_qc/deseq2.pca.vals.txt	deseq2.pca.vals.txt	173	1917914394	\N	f	2022-09-16 14:40:35.735+00
898	18	606	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/deseq2_qc/deseq2.plots.pdf	deseq2.plots.pdf	8686	1943728138	\N	f	2022-09-16 14:40:35.731+00
899	18	606	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/deseq2_qc/deseq2.sample.dists.txt	deseq2.sample.dists.txt	103	-99464397	\N	f	2022-09-16 14:40:35.735+00
900	18	607	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/deseq2_qc/size_factors/deseq2.size_factors.RData	deseq2.size_factors.RData	166	1509833648	\N	f	2022-09-16 14:40:35.735+00
901	18	607	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/deseq2_qc/size_factors/mutant.txt	mutant.txt	37	584518793	\N	f	2022-09-16 14:40:35.735+00
902	18	607	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/deseq2_qc/size_factors/wildtype.txt	wildtype.txt	38	-6897510	\N	f	2022-09-16 14:40:35.735+00
903	18	609	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/dupradar/box_plot/mutant_duprateExpBoxplot.pdf	mutant_duprateExpBoxplot.pdf	11360	361935239	\N	f	2022-09-16 14:40:35.695+00
904	18	609	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/dupradar/box_plot/wildtype_duprateExpBoxplot.pdf	wildtype_duprateExpBoxplot.pdf	15878	559487647	\N	f	2022-09-16 14:40:35.695+00
905	18	610	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/dupradar/gene_data/mutant_dupMatrix.txt	mutant_dupMatrix.txt	2646907	311033988	\N	f	2022-09-16 14:40:35.687+00
906	18	610	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/dupradar/gene_data/wildtype_dupMatrix.txt	wildtype_dupMatrix.txt	2652677	93857583	\N	f	2022-09-16 14:40:35.691+00
907	18	611	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/dupradar/histogram/mutant_expressionHist.pdf	mutant_expressionHist.pdf	5244	1453914362	\N	f	2022-09-16 14:40:35.691+00
908	18	611	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/dupradar/histogram/wildtype_expressionHist.pdf	wildtype_expressionHist.pdf	5327	-2096024349	\N	f	2022-09-16 14:40:35.691+00
909	18	612	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/dupradar/intercepts_slope/mutant_intercept_slope.txt	mutant_intercept_slope.txt	178	-1167691870	\N	f	2022-09-16 14:40:35.695+00
910	18	612	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/dupradar/intercepts_slope/wildtype_intercept_slope.txt	wildtype_intercept_slope.txt	182	1809272439	\N	f	2022-09-16 14:40:35.695+00
911	18	613	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/dupradar/scatter_plot/mutant_duprateExpDens.pdf	mutant_duprateExpDens.pdf	936758	1094087789	\N	f	2022-09-16 14:40:35.695+00
912	18	613	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/dupradar/scatter_plot/wildtype_duprateExpDens.pdf	wildtype_duprateExpDens.pdf	933162	1401876272	\N	f	2022-09-16 14:40:35.691+00
913	18	614	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/featurecounts/mutant.biotype_counts_mqc.tsv	mutant.biotype_counts_mqc.tsv	537	187530019	\N	f	2022-09-16 14:40:35.227+00
914	18	614	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/featurecounts/mutant.biotype_counts_rrna_mqc.tsv	mutant.biotype_counts_rrna_mqc.tsv	361	-1339714071	\N	f	2022-09-16 14:40:35.227+00
915	18	614	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/featurecounts/mutant.featureCounts.txt	mutant.featureCounts.txt	10066308	1684492671	\N	f	2022-09-16 14:40:35.227+00
916	18	614	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/featurecounts/mutant.featureCounts.txt.summary	mutant.featureCounts.txt.summary	408	235968519	\N	f	2022-09-16 14:40:35.227+00
917	18	614	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/featurecounts/wildtype.biotype_counts_mqc.tsv	wildtype.biotype_counts_mqc.tsv	537	-1440377201	\N	f	2022-09-16 14:40:35.215+00
918	18	614	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/featurecounts/wildtype.biotype_counts_rrna_mqc.tsv	wildtype.biotype_counts_rrna_mqc.tsv	363	-1246405276	\N	f	2022-09-16 14:40:35.215+00
919	18	614	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/featurecounts/wildtype.featureCounts.txt	wildtype.featureCounts.txt	10066314	127258151	\N	f	2022-09-16 14:40:35.215+00
920	18	614	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/featurecounts/wildtype.featureCounts.txt.summary	wildtype.featureCounts.txt.summary	411	528923650	\N	f	2022-09-16 14:40:35.215+00
921	18	615	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/log/mutant.Log.final.out	mutant.Log.final.out	2032	915727121	\N	f	2022-09-16 14:40:35.679+00
923	18	615	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/log/mutant.Log.progress.out	mutant.Log.progress.out	475	-386005858	\N	f	2022-09-16 14:40:35.683+00
924	18	615	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/log/mutant.SJ.out.tab	mutant.SJ.out.tab	3112713	1001772380	\N	f	2022-09-16 14:40:35.683+00
925	18	615	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/log/wildtype.Log.final.out	wildtype.Log.final.out	2036	989546196	\N	f	2022-09-16 14:40:35.683+00
926	18	615	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/log/wildtype.Log.out	wildtype.Log.out	10637	302696813	\N	f	2022-09-16 14:40:35.679+00
927	18	615	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/log/wildtype.Log.progress.out	wildtype.Log.progress.out	475	-1308919828	\N	f	2022-09-16 14:40:35.683+00
928	18	615	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/log/wildtype.SJ.out.tab	wildtype.SJ.out.tab	2914467	1542872556	\N	f	2022-09-16 14:40:35.683+00
929	18	617	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/mutant/aux_info/ambig_info.tsv	ambig_info.tsv	252855	-731911256	\N	f	2022-09-16 14:40:35.719+00
930	18	617	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/mutant/aux_info/expected_bias.gz	expected_bias.gz	117	1116039987	\N	f	2022-09-16 14:40:35.719+00
931	18	617	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/mutant/aux_info/fld.gz	fld.gz	474	-1863972988	\N	f	2022-09-16 14:40:35.719+00
932	18	617	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/mutant/aux_info/meta_info.json	meta_info.json	1305	-647504056	\N	f	2022-09-16 14:40:35.719+00
933	18	617	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/mutant/aux_info/observed_bias.gz	observed_bias.gz	82	-483260268	\N	f	2022-09-16 14:40:35.719+00
934	18	617	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/mutant/aux_info/observed_bias_3p.gz	observed_bias_3p.gz	82	-1284071394	\N	f	2022-09-16 14:40:35.719+00
935	18	616	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/mutant/cmd_info.json	cmd_info.json	279	213441466	\N	f	2022-09-16 14:40:35.715+00
936	18	618	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/mutant/libParams/flenDist.txt	flenDist.txt	11762	698757907	\N	f	2022-09-16 14:40:35.719+00
937	18	616	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/mutant/quant.genes.sf	quant.genes.sf	1984054	1124954446	\N	f	2022-09-16 14:40:35.715+00
938	18	616	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/mutant/quant.sf	quant.sf	2584982	-1451436154	\N	f	2022-09-16 14:40:35.719+00
939	18	604	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/mutant.markdup.sorted.bam	mutant.markdup.sorted.bam	123615116	-1065953658	\N	f	2022-09-16 14:40:35.191+00
940	18	604	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/mutant.markdup.sorted.bam.bai	mutant.markdup.sorted.bam.bai	109736	2056215173	\N	f	2022-09-16 14:40:35.207+00
941	18	619	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/picard_metrics/mutant.markdup.sorted.MarkDuplicates.metrics.txt	mutant.markdup.sorted.MarkDuplicates.metrics.txt	3408	-1953938363	\N	f	2022-09-16 14:40:35.207+00
942	18	619	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/picard_metrics/wildtype.markdup.sorted.MarkDuplicates.metrics.txt	wildtype.markdup.sorted.MarkDuplicates.metrics.txt	3442	1309637271	\N	f	2022-09-16 14:40:35.207+00
943	18	621	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/preseq/log/mutant.command.log	mutant.command.log	553	-579410856	\N	f	2022-09-16 14:40:35.339+00
944	18	621	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/preseq/log/wildtype.command.log	wildtype.command.log	680	-1251663606	\N	f	2022-09-16 14:40:35.339+00
945	18	620	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/preseq/mutant.lc_extrap.txt	mutant.lc_extrap.txt	488626	-1745976942	\N	f	2022-09-16 14:40:35.339+00
946	18	620	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/preseq/wildtype.lc_extrap.txt	wildtype.lc_extrap.txt	468945	783840268	\N	f	2022-09-16 14:40:35.339+00
947	18	624	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/qualimap/mutant/css/agogo.css	agogo.css	7158	-1644811219	\N	f	2022-09-16 14:40:35.731+00
948	18	624	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/qualimap/mutant/css/ajax-loader.gif	ajax-loader.gif	701	1539247609	\N	f	2022-09-16 14:40:35.727+00
949	18	624	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/qualimap/mutant/css/basic.css	basic.css	8489	-843647578	\N	f	2022-09-16 14:40:35.727+00
950	18	624	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/qualimap/mutant/css/bgfooter.png	bgfooter.png	462	-1945787229	\N	f	2022-09-16 14:40:35.727+00
951	18	624	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/qualimap/mutant/css/bgtop.png	bgtop.png	458	217178312	\N	f	2022-09-16 14:40:35.731+00
952	18	624	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/qualimap/mutant/css/comment-bright.png	comment-bright.png	3528	1640078068	\N	f	2022-09-16 14:40:35.727+00
953	18	624	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/qualimap/mutant/css/comment-close.png	comment-close.png	3606	-1835604068	\N	f	2022-09-16 14:40:35.727+00
954	18	624	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/qualimap/mutant/css/comment.png	comment.png	3473	-322693761	\N	f	2022-09-16 14:40:35.727+00
955	18	624	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/qualimap/mutant/css/doctools.js	doctools.js	6868	-1321367198	\N	f	2022-09-16 14:40:35.727+00
956	18	624	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/qualimap/mutant/css/down-pressed.png	down-pressed.png	396	-1391133172	\N	f	2022-09-16 14:40:35.727+00
957	18	624	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/qualimap/mutant/css/down.png	down.png	391	-1043808415	\N	f	2022-09-16 14:40:35.727+00
958	18	624	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/qualimap/mutant/css/file.png	file.png	420	-1984360454	\N	f	2022-09-16 14:40:35.727+00
959	18	624	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/qualimap/mutant/css/jquery.js	jquery.js	72230	-37370680	\N	f	2022-09-16 14:40:35.727+00
960	18	624	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/qualimap/mutant/css/minus.png	minus.png	227	815265862	\N	f	2022-09-16 14:40:35.727+00
961	18	624	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/qualimap/mutant/css/plus.png	plus.png	227	215828189	\N	f	2022-09-16 14:40:35.727+00
962	18	624	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/qualimap/mutant/css/pygments.css	pygments.css	3960	-1805979031	\N	f	2022-09-16 14:40:35.727+00
963	18	624	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/qualimap/mutant/css/qualimap_logo_small.png	qualimap_logo_small.png	2950	-82089844	\N	f	2022-09-16 14:40:35.727+00
964	18	624	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/qualimap/mutant/css/report.css	report.css	636	251290568	\N	f	2022-09-16 14:40:35.727+00
965	18	624	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/qualimap/mutant/css/searchtools.js	searchtools.js	16071	-1305339062	\N	f	2022-09-16 14:40:35.727+00
966	18	624	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/qualimap/mutant/css/underscore.js	underscore.js	8602	-1283497223	\N	f	2022-09-16 14:40:35.727+00
967	18	624	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/qualimap/mutant/css/up-pressed.png	up-pressed.png	400	655082631	\N	f	2022-09-16 14:40:35.731+00
968	18	624	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/qualimap/mutant/css/up.png	up.png	391	1090910567	\N	f	2022-09-16 14:40:35.727+00
969	18	624	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/qualimap/mutant/css/websupport.js	websupport.js	25274	2046827467	\N	f	2022-09-16 14:40:35.727+00
970	18	625	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/qualimap/mutant/images_qualimapReport/Coverage Profile Along Genes (High).png	Coverage Profile Along Genes (High).png	50703	-1426794844	\N	f	2022-09-16 14:40:35.727+00
971	18	625	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/qualimap/mutant/images_qualimapReport/Coverage Profile Along Genes (Low).png	Coverage Profile Along Genes (Low).png	75915	439747424	\N	f	2022-09-16 14:40:35.727+00
972	18	625	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/qualimap/mutant/images_qualimapReport/Coverage Profile Along Genes (Total).png	Coverage Profile Along Genes (Total).png	52939	1180842919	\N	f	2022-09-16 14:40:35.727+00
973	18	625	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/qualimap/mutant/images_qualimapReport/Junction Analysis.png	Junction Analysis.png	36232	838385441	\N	f	2022-09-16 14:40:35.727+00
974	18	625	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/qualimap/mutant/images_qualimapReport/Reads Genomic Origin.png	Reads Genomic Origin.png	34899	-967517328	\N	f	2022-09-16 14:40:35.727+00
975	18	625	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/qualimap/mutant/images_qualimapReport/Transcript coverage histogram.png	Transcript coverage histogram.png	66162	-1338592898	\N	f	2022-09-16 14:40:35.727+00
976	18	623	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/qualimap/mutant/qualimapReport.html	qualimapReport.html	11585	2127491608	\N	f	2022-09-16 14:40:35.727+00
977	18	626	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/qualimap/mutant/raw_data_qualimapReport/coverage_profile_along_genes_(high).txt	coverage_profile_along_genes_(high).txt	2358	-1039673482	\N	f	2022-09-16 14:40:35.731+00
978	18	626	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/qualimap/mutant/raw_data_qualimapReport/coverage_profile_along_genes_(low).txt	coverage_profile_along_genes_(low).txt	2517	989767686	\N	f	2022-09-16 14:40:35.731+00
979	18	626	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/qualimap/mutant/raw_data_qualimapReport/coverage_profile_along_genes_(total).txt	coverage_profile_along_genes_(total).txt	2430	-1182566413	\N	f	2022-09-16 14:40:35.731+00
980	18	623	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/qualimap/mutant/rnaseq_qc_results.txt	rnaseq_qc_results.txt	1176	67105175	\N	f	2022-09-16 14:40:35.727+00
981	18	628	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/qualimap/wildtype/css/agogo.css	agogo.css	7158	-226168911	\N	f	2022-09-16 14:40:35.727+00
982	18	628	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/qualimap/wildtype/css/ajax-loader.gif	ajax-loader.gif	701	-1830571698	\N	f	2022-09-16 14:40:35.727+00
983	18	628	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/qualimap/wildtype/css/basic.css	basic.css	8489	-623095553	\N	f	2022-09-16 14:40:35.723+00
984	18	628	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/qualimap/wildtype/css/bgfooter.png	bgfooter.png	462	-1943504918	\N	f	2022-09-16 14:40:35.727+00
985	18	628	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/qualimap/wildtype/css/bgtop.png	bgtop.png	458	375318230	\N	f	2022-09-16 14:40:35.727+00
986	18	628	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/qualimap/wildtype/css/comment-bright.png	comment-bright.png	3528	763530916	\N	f	2022-09-16 14:40:35.727+00
987	18	628	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/qualimap/wildtype/css/comment-close.png	comment-close.png	3606	-1767751122	\N	f	2022-09-16 14:40:35.727+00
988	18	628	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/qualimap/wildtype/css/comment.png	comment.png	3473	-1648691353	\N	f	2022-09-16 14:40:35.727+00
989	18	628	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/qualimap/wildtype/css/doctools.js	doctools.js	6868	-1565514243	\N	f	2022-09-16 14:40:35.727+00
990	18	628	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/qualimap/wildtype/css/down-pressed.png	down-pressed.png	396	1695255416	\N	f	2022-09-16 14:40:35.723+00
991	18	628	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/qualimap/wildtype/css/down.png	down.png	391	-862448148	\N	f	2022-09-16 14:40:35.727+00
992	18	628	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/qualimap/wildtype/css/file.png	file.png	420	926870197	\N	f	2022-09-16 14:40:35.727+00
993	18	628	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/qualimap/wildtype/css/jquery.js	jquery.js	72230	-1442036318	\N	f	2022-09-16 14:40:35.727+00
994	18	628	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/qualimap/wildtype/css/minus.png	minus.png	227	-1930754831	\N	f	2022-09-16 14:40:35.723+00
995	18	628	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/qualimap/wildtype/css/plus.png	plus.png	227	-1616991121	\N	f	2022-09-16 14:40:35.723+00
996	18	628	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/qualimap/wildtype/css/pygments.css	pygments.css	3960	465479190	\N	f	2022-09-16 14:40:35.727+00
997	18	628	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/qualimap/wildtype/css/qualimap_logo_small.png	qualimap_logo_small.png	2950	416137408	\N	f	2022-09-16 14:40:35.727+00
998	18	628	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/qualimap/wildtype/css/report.css	report.css	636	-190579318	\N	f	2022-09-16 14:40:35.723+00
999	18	628	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/qualimap/wildtype/css/searchtools.js	searchtools.js	16071	-714918963	\N	f	2022-09-16 14:40:35.727+00
1000	18	628	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/qualimap/wildtype/css/underscore.js	underscore.js	8602	5306903	\N	f	2022-09-16 14:40:35.723+00
1001	18	628	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/qualimap/wildtype/css/up-pressed.png	up-pressed.png	400	-1001491990	\N	f	2022-09-16 14:40:35.727+00
1002	18	628	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/qualimap/wildtype/css/up.png	up.png	391	-1163319816	\N	f	2022-09-16 14:40:35.727+00
1003	18	628	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/qualimap/wildtype/css/websupport.js	websupport.js	25274	1772174608	\N	f	2022-09-16 14:40:35.723+00
1004	18	629	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/qualimap/wildtype/images_qualimapReport/Coverage Profile Along Genes (High).png	Coverage Profile Along Genes (High).png	50620	357633664	\N	f	2022-09-16 14:40:35.723+00
1005	18	629	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/qualimap/wildtype/images_qualimapReport/Coverage Profile Along Genes (Low).png	Coverage Profile Along Genes (Low).png	79191	660946469	\N	f	2022-09-16 14:40:35.723+00
1006	18	629	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/qualimap/wildtype/images_qualimapReport/Coverage Profile Along Genes (Total).png	Coverage Profile Along Genes (Total).png	52115	-1176793711	\N	f	2022-09-16 14:40:35.723+00
1007	18	629	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/qualimap/wildtype/images_qualimapReport/Junction Analysis.png	Junction Analysis.png	35244	1888463318	\N	f	2022-09-16 14:40:35.723+00
1008	18	629	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/qualimap/wildtype/images_qualimapReport/Reads Genomic Origin.png	Reads Genomic Origin.png	37519	1678610191	\N	f	2022-09-16 14:40:35.723+00
1009	18	629	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/qualimap/wildtype/images_qualimapReport/Transcript coverage histogram.png	Transcript coverage histogram.png	57424	1688323034	\N	f	2022-09-16 14:40:35.723+00
1010	18	627	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/qualimap/wildtype/qualimapReport.html	qualimapReport.html	11587	1008855663	\N	f	2022-09-16 14:40:35.723+00
1011	18	630	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/qualimap/wildtype/raw_data_qualimapReport/coverage_profile_along_genes_(high).txt	coverage_profile_along_genes_(high).txt	2364	1737141341	\N	f	2022-09-16 14:40:35.727+00
1012	18	630	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/qualimap/wildtype/raw_data_qualimapReport/coverage_profile_along_genes_(low).txt	coverage_profile_along_genes_(low).txt	2525	18934714	\N	f	2022-09-16 14:40:35.727+00
1013	18	630	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/qualimap/wildtype/raw_data_qualimapReport/coverage_profile_along_genes_(total).txt	coverage_profile_along_genes_(total).txt	2437	-165662642	\N	f	2022-09-16 14:40:35.727+00
1014	18	627	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/qualimap/wildtype/rnaseq_qc_results.txt	rnaseq_qc_results.txt	1178	434174350	\N	f	2022-09-16 14:40:35.723+00
1015	18	632	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/rseqc/bam_stat/mutant.bam_stat.txt	mutant.bam_stat.txt	856	765564079	\N	f	2022-09-16 14:40:35.395+00
1016	18	632	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/rseqc/bam_stat/wildtype.bam_stat.txt	wildtype.bam_stat.txt	855	-682556890	\N	f	2022-09-16 14:40:35.395+00
1017	18	633	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/rseqc/infer_experiment/mutant.infer_experiment.txt	mutant.infer_experiment.txt	211	-534718697	\N	f	2022-09-16 14:40:35.447+00
1018	18	633	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/rseqc/infer_experiment/wildtype.infer_experiment.txt	wildtype.infer_experiment.txt	211	-538055487	\N	f	2022-09-16 14:40:35.447+00
1019	18	635	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/rseqc/inner_distance/pdf/mutant.inner_distance_plot.pdf	mutant.inner_distance_plot.pdf	8595	952921583	\N	f	2022-09-16 14:40:35.391+00
1020	18	635	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/rseqc/inner_distance/pdf/wildtype.inner_distance_plot.pdf	wildtype.inner_distance_plot.pdf	8589	-1455292128	\N	f	2022-09-16 14:40:35.391+00
1021	18	636	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/rseqc/inner_distance/rscript/mutant.inner_distance_plot.r	mutant.inner_distance_plot.r	1579	985332948	\N	f	2022-09-16 14:40:35.391+00
1022	18	636	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/rseqc/inner_distance/rscript/wildtype.inner_distance_plot.r	wildtype.inner_distance_plot.r	1578	819674782	\N	f	2022-09-16 14:40:35.391+00
1023	18	637	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/rseqc/inner_distance/txt/mutant.inner_distance.txt	mutant.inner_distance.txt	25865340	-1133962902	\N	f	2022-09-16 14:40:35.387+00
1024	18	637	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/rseqc/inner_distance/txt/mutant.inner_distance_freq.txt	mutant.inner_distance_freq.txt	1268	-159857967	\N	f	2022-09-16 14:40:35.363+00
1025	18	637	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/rseqc/inner_distance/txt/mutant.inner_distance_mean.txt	mutant.inner_distance_mean.txt	96	-85874686	\N	f	2022-09-16 14:40:35.343+00
1026	18	637	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/rseqc/inner_distance/txt/wildtype.inner_distance.txt	wildtype.inner_distance.txt	21373849	1228969170	\N	f	2022-09-16 14:40:35.363+00
1027	18	637	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/rseqc/inner_distance/txt/wildtype.inner_distance_freq.txt	wildtype.inner_distance_freq.txt	1263	1393278689	\N	f	2022-09-16 14:40:35.343+00
1028	18	637	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/rseqc/inner_distance/txt/wildtype.inner_distance_mean.txt	wildtype.inner_distance_mean.txt	98	-19838729	\N	f	2022-09-16 14:40:35.343+00
1029	18	639	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/rseqc/junction_annotation/bed/mutant.junction.Interact.bed	mutant.junction.Interact.bed	16060997	884784681	\N	f	2022-09-16 14:40:35.419+00
1030	18	639	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/rseqc/junction_annotation/bed/mutant.junction.bed	mutant.junction.bed	5864284	-1862809408	\N	f	2022-09-16 14:40:35.399+00
1031	18	639	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/rseqc/junction_annotation/bed/wildtype.junction.Interact.bed	wildtype.junction.Interact.bed	15049046	-45489805	\N	f	2022-09-16 14:40:35.435+00
1032	18	639	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/rseqc/junction_annotation/bed/wildtype.junction.bed	wildtype.junction.bed	5498103	-1679340789	\N	f	2022-09-16 14:40:35.403+00
1033	18	640	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/rseqc/junction_annotation/log/mutant.junction_annotation.log	mutant.junction_annotation.log	570	829060938	\N	f	2022-09-16 14:40:35.443+00
1034	18	640	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/rseqc/junction_annotation/log/wildtype.junction_annotation.log	wildtype.junction_annotation.log	574	1620006224	\N	f	2022-09-16 14:40:35.447+00
1035	18	641	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/rseqc/junction_annotation/pdf/mutant.splice_events.pdf	mutant.splice_events.pdf	13270	-454031931	\N	f	2022-09-16 14:40:35.447+00
1036	18	641	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/rseqc/junction_annotation/pdf/mutant.splice_junction.pdf	mutant.splice_junction.pdf	13301	-1008606776	\N	f	2022-09-16 14:40:35.447+00
1037	18	641	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/rseqc/junction_annotation/pdf/wildtype.splice_events.pdf	wildtype.splice_events.pdf	13360	284891935	\N	f	2022-09-16 14:40:35.447+00
1038	18	641	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/rseqc/junction_annotation/pdf/wildtype.splice_junction.pdf	wildtype.splice_junction.pdf	13295	1035689822	\N	f	2022-09-16 14:40:35.447+00
1039	18	642	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/rseqc/junction_annotation/rscript/mutant.junction_plot.r	mutant.junction_plot.r	583	-2117287379	\N	f	2022-09-16 14:40:35.443+00
1040	18	642	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/rseqc/junction_annotation/rscript/wildtype.junction_plot.r	wildtype.junction_plot.r	581	2114880201	\N	f	2022-09-16 14:40:35.443+00
1041	18	643	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/rseqc/junction_annotation/xls/mutant.junction.xls	mutant.junction.xls	3103125	51651992	\N	f	2022-09-16 14:40:35.443+00
1042	18	643	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/rseqc/junction_annotation/xls/wildtype.junction.xls	wildtype.junction.xls	2911792	-651276451	\N	f	2022-09-16 14:40:35.443+00
1043	18	645	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/rseqc/junction_saturation/pdf/mutant.junctionSaturation_plot.pdf	mutant.junctionSaturation_plot.pdf	5531	-432426958	\N	f	2022-09-16 14:40:35.395+00
1044	18	645	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/rseqc/junction_saturation/pdf/wildtype.junctionSaturation_plot.pdf	wildtype.junctionSaturation_plot.pdf	5643	-1136883588	\N	f	2022-09-16 14:40:35.395+00
1045	18	646	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/rseqc/junction_saturation/rscript/mutant.junctionSaturation_plot.r	mutant.junctionSaturation_plot.r	820	-28199409	\N	f	2022-09-16 14:40:35.395+00
1046	18	646	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/rseqc/junction_saturation/rscript/wildtype.junctionSaturation_plot.r	wildtype.junctionSaturation_plot.r	837	-1288091305	\N	f	2022-09-16 14:40:35.395+00
1047	18	647	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/rseqc/read_distribution/mutant.read_distribution.txt	mutant.read_distribution.txt	1153	-567650605	\N	f	2022-09-16 14:40:35.391+00
1048	18	647	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/rseqc/read_distribution/wildtype.read_distribution.txt	wildtype.read_distribution.txt	1153	661852065	\N	f	2022-09-16 14:40:35.391+00
1049	18	649	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/rseqc/read_duplication/pdf/mutant.DupRate_plot.pdf	mutant.DupRate_plot.pdf	5430	734799064	\N	f	2022-09-16 14:40:35.395+00
1050	18	649	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/rseqc/read_duplication/pdf/wildtype.DupRate_plot.pdf	wildtype.DupRate_plot.pdf	7475	1742965469	\N	f	2022-09-16 14:40:35.391+00
1051	18	650	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/rseqc/read_duplication/rscript/mutant.DupRate_plot.r	mutant.DupRate_plot.r	1142	286487447	\N	f	2022-09-16 14:40:35.391+00
1052	18	650	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/rseqc/read_duplication/rscript/wildtype.DupRate_plot.r	wildtype.DupRate_plot.r	2115	-579313566	\N	f	2022-09-16 14:40:35.391+00
1053	18	651	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/rseqc/read_duplication/xls/mutant.pos.DupRate.xls	mutant.pos.DupRate.xls	203	142816608	\N	f	2022-09-16 14:40:35.391+00
1054	18	651	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/rseqc/read_duplication/xls/mutant.seq.DupRate.xls	mutant.seq.DupRate.xls	169	268770081	\N	f	2022-09-16 14:40:35.391+00
1055	18	651	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/rseqc/read_duplication/xls/wildtype.pos.DupRate.xls	wildtype.pos.DupRate.xls	707	-963234878	\N	f	2022-09-16 14:40:35.391+00
1056	18	651	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/rseqc/read_duplication/xls/wildtype.seq.DupRate.xls	wildtype.seq.DupRate.xls	636	-119183288	\N	f	2022-09-16 14:40:35.391+00
1057	18	604	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/salmon.merged.gene_counts.rds	salmon.merged.gene_counts.rds	819646	-1525365319	\N	f	2022-09-16 14:40:35.075+00
1058	18	604	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/salmon.merged.gene_counts.tsv	salmon.merged.gene_counts.tsv	925921	1634306409	\N	f	2022-09-16 14:40:35.339+00
1059	18	604	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/salmon.merged.gene_counts_length_scaled.rds	salmon.merged.gene_counts_length_scaled.rds	1038808	9263778	\N	f	2022-09-16 14:40:35.719+00
1060	18	604	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/salmon.merged.gene_counts_length_scaled.tsv	salmon.merged.gene_counts_length_scaled.tsv	1436278	1389016267	\N	f	2022-09-16 14:40:35.731+00
1061	18	604	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/salmon.merged.gene_counts_scaled.rds	salmon.merged.gene_counts_scaled.rds	1039908	-914742125	\N	f	2022-09-16 14:40:35.723+00
1062	18	604	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/salmon.merged.gene_counts_scaled.tsv	salmon.merged.gene_counts_scaled.tsv	1436180	-432608858	\N	f	2022-09-16 14:40:35.447+00
1063	18	604	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/salmon.merged.gene_tpm.tsv	salmon.merged.gene_tpm.tsv	1180531	1590090341	\N	f	2022-09-16 14:40:35.731+00
1064	18	604	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/salmon.merged.transcript_counts.rds	salmon.merged.transcript_counts.rds	1444158	1160652068	\N	f	2022-09-16 14:40:35.651+00
1065	18	604	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/salmon.merged.transcript_counts.tsv	salmon.merged.transcript_counts.tsv	1739966	-2055226966	\N	f	2022-09-16 14:40:35.679+00
1066	18	604	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/salmon.merged.transcript_tpm.tsv	salmon.merged.transcript_tpm.tsv	1994886	1656522166	\N	f	2022-09-16 14:40:35.339+00
1067	18	604	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/salmon_tx2gene.tsv	salmon_tx2gene.tsv	2070112	-1601413033	\N	f	2022-09-16 14:40:35.451+00
1068	18	652	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/samtools_stats/mutant.markdup.sorted.bam.flagstat	mutant.markdup.sorted.bam.flagstat	548	-1181330251	\N	f	2022-09-16 14:40:35.723+00
1069	18	652	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/samtools_stats/mutant.markdup.sorted.bam.idxstats	mutant.markdup.sorted.bam.idxstats	237	206720931	\N	f	2022-09-16 14:40:35.723+00
1070	18	652	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/samtools_stats/mutant.markdup.sorted.bam.stats	mutant.markdup.sorted.bam.stats	137478	1925857525	\N	f	2022-09-16 14:40:35.723+00
1071	18	652	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/samtools_stats/mutant.sorted.bam.flagstat	mutant.sorted.bam.flagstat	542	1558178909	\N	f	2022-09-16 14:40:35.723+00
1072	18	652	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/samtools_stats/mutant.sorted.bam.idxstats	mutant.sorted.bam.idxstats	237	1614097146	\N	f	2022-09-16 14:40:35.723+00
1073	18	652	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/samtools_stats/mutant.sorted.bam.stats	mutant.sorted.bam.stats	137462	-175718910	\N	f	2022-09-16 14:40:35.723+00
1074	18	652	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/samtools_stats/wildtype.markdup.sorted.bam.flagstat	wildtype.markdup.sorted.bam.flagstat	551	491237424	\N	f	2022-09-16 14:40:35.723+00
1075	18	652	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/samtools_stats/wildtype.markdup.sorted.bam.idxstats	wildtype.markdup.sorted.bam.idxstats	237	-945540892	\N	f	2022-09-16 14:40:35.723+00
1076	18	652	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/samtools_stats/wildtype.markdup.sorted.bam.stats	wildtype.markdup.sorted.bam.stats	133457	115364027	\N	f	2022-09-16 14:40:35.723+00
1077	18	652	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/samtools_stats/wildtype.sorted.bam.flagstat	wildtype.sorted.bam.flagstat	543	297771380	\N	f	2022-09-16 14:40:35.723+00
1078	18	652	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/samtools_stats/wildtype.sorted.bam.idxstats	wildtype.sorted.bam.idxstats	237	-118092940	\N	f	2022-09-16 14:40:35.723+00
1079	18	652	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/samtools_stats/wildtype.sorted.bam.stats	wildtype.sorted.bam.stats	133439	-199641636	\N	f	2022-09-16 14:40:35.723+00
1080	18	654	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/stringtie/mutant.ballgown/e2t.ctab	e2t.ctab	3976704	357669135	\N	f	2022-09-16 14:40:35.595+00
1081	18	654	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/stringtie/mutant.ballgown/e_data.ctab	e_data.ctab	15207714	-1718596200	\N	f	2022-09-16 14:40:35.579+00
1082	18	654	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/stringtie/mutant.ballgown/i2t.ctab	i2t.ctab	3170677	-18639416	\N	f	2022-09-16 14:40:35.603+00
1083	18	654	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/stringtie/mutant.ballgown/i_data.ctab	i_data.ctab	6314350	589747633	\N	f	2022-09-16 14:40:35.587+00
1084	18	654	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/stringtie/mutant.ballgown/t_data.ctab	t_data.ctab	5380892	-1673019731	\N	f	2022-09-16 14:40:35.599+00
1085	18	653	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/stringtie/mutant.coverage.gtf	mutant.coverage.gtf	3325056	-1922617680	\N	f	2022-09-16 14:40:35.607+00
1086	18	653	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/stringtie/mutant.gene.abundance.txt	mutant.gene.abundance.txt	2602044	-264391754	\N	f	2022-09-16 14:40:35.607+00
1087	18	653	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/stringtie/mutant.transcripts.gtf	mutant.transcripts.gtf	55514828	-94284102	\N	f	2022-09-16 14:40:35.559+00
1088	18	655	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/stringtie/wildtype.ballgown/e2t.ctab	e2t.ctab	3976704	-1136022208	\N	f	2022-09-16 14:40:35.635+00
1089	18	655	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/stringtie/wildtype.ballgown/e_data.ctab	e_data.ctab	15194625	-301599092	\N	f	2022-09-16 14:40:35.623+00
1090	18	655	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/stringtie/wildtype.ballgown/i2t.ctab	i2t.ctab	3170677	204326258	\N	f	2022-09-16 14:40:35.643+00
1091	18	655	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/stringtie/wildtype.ballgown/i_data.ctab	i_data.ctab	6313244	868168961	\N	f	2022-09-16 14:40:35.631+00
1092	18	655	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/stringtie/wildtype.ballgown/t_data.ctab	t_data.ctab	5380794	1358530803	\N	f	2022-09-16 14:40:35.639+00
1093	18	653	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/stringtie/wildtype.coverage.gtf	wildtype.coverage.gtf	2653473	-1082010347	\N	f	2022-09-16 14:40:35.647+00
1094	18	653	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/stringtie/wildtype.gene.abundance.txt	wildtype.gene.abundance.txt	2539715	167348604	\N	f	2022-09-16 14:40:35.651+00
1095	18	653	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/stringtie/wildtype.transcripts.gtf	wildtype.transcripts.gtf	55354944	1918890007	\N	f	2022-09-16 14:40:35.499+00
1096	18	657	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/wildtype/aux_info/ambig_info.tsv	ambig_info.tsv	250491	1439019281	\N	f	2022-09-16 14:40:35.715+00
1097	18	657	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/wildtype/aux_info/expected_bias.gz	expected_bias.gz	117	-1408573534	\N	f	2022-09-16 14:40:35.715+00
1098	18	657	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/wildtype/aux_info/fld.gz	fld.gz	538	1126648995	\N	f	2022-09-16 14:40:35.715+00
1099	18	657	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/wildtype/aux_info/meta_info.json	meta_info.json	1304	383266012	\N	f	2022-09-16 14:40:35.715+00
1100	18	657	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/wildtype/aux_info/observed_bias.gz	observed_bias.gz	82	-1927531067	\N	f	2022-09-16 14:40:35.715+00
1101	18	657	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/wildtype/aux_info/observed_bias_3p.gz	observed_bias_3p.gz	82	821779539	\N	f	2022-09-16 14:40:35.715+00
1102	18	656	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/wildtype/cmd_info.json	cmd_info.json	283	-2107572856	\N	f	2022-09-16 14:40:35.695+00
1103	18	658	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/wildtype/libParams/flenDist.txt	flenDist.txt	11777	31885743	\N	f	2022-09-16 14:40:35.715+00
1104	18	659	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/wildtype/logs/salmon_quant.log	salmon_quant.log	13757516	1592345532	\N	f	2022-09-16 14:40:35.711+00
1105	18	656	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/wildtype/quant.genes.sf	quant.genes.sf	1983471	40719445	\N	f	2022-09-16 14:40:35.695+00
1106	18	656	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/wildtype/quant.sf	quant.sf	2582265	241324486	\N	f	2022-09-16 14:40:35.699+00
1707	32	1706	original/genome.fasta	genome.fasta	392536877	-1483927364	\N	f	2022-09-27 12:37:46.328+00
1107	18	604	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/wildtype.markdup.sorted.bam	wildtype.markdup.sorted.bam	100770444	-482415726	\N	f	2022-09-16 14:40:35.323+00
1108	18	604	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/star_salmon/wildtype.markdup.sorted.bam.bai	wildtype.markdup.sorted.bam.bai	104208	-442614010	\N	f	2022-09-16 14:40:35.451+00
1109	18	661	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/trimgalore/fastqc/mutant_1_val_1_fastqc.html	mutant_1_val_1_fastqc.html	592858	-331333048	\N	f	2022-09-16 14:40:35.063+00
1110	18	661	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/trimgalore/fastqc/mutant_1_val_1_fastqc.zip	mutant_1_val_1_fastqc.zip	300154	-1362997917	\N	f	2022-09-16 14:40:35.063+00
1111	18	661	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/trimgalore/fastqc/mutant_2_val_2_fastqc.html	mutant_2_val_2_fastqc.html	592713	135444108	\N	f	2022-09-16 14:40:35.063+00
1112	18	661	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/trimgalore/fastqc/mutant_2_val_2_fastqc.zip	mutant_2_val_2_fastqc.zip	298572	-1479953199	\N	f	2022-09-16 14:40:35.063+00
1113	18	661	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/trimgalore/fastqc/wildtype_1_val_1_fastqc.html	wildtype_1_val_1_fastqc.html	612913	1450979984	\N	f	2022-09-16 14:40:35.059+00
1114	18	661	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/trimgalore/fastqc/wildtype_1_val_1_fastqc.zip	wildtype_1_val_1_fastqc.zip	352736	-1499320572	\N	f	2022-09-16 14:40:35.063+00
1115	18	661	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/trimgalore/fastqc/wildtype_2_val_2_fastqc.html	wildtype_2_val_2_fastqc.html	606686	-1646648860	\N	f	2022-09-16 14:40:35.063+00
1116	18	661	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/trimgalore/fastqc/wildtype_2_val_2_fastqc.zip	wildtype_2_val_2_fastqc.zip	345373	-1568135635	\N	f	2022-09-16 14:40:35.063+00
1117	18	660	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/trimgalore/mutant_1.fastq.gz_trimming_report.txt	mutant_1.fastq.gz_trimming_report.txt	3944	-1528591609	\N	f	2022-09-16 14:40:35.063+00
1118	18	660	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/trimgalore/mutant_2.fastq.gz_trimming_report.txt	mutant_2.fastq.gz_trimming_report.txt	3570	-681781326	\N	f	2022-09-16 14:40:35.067+00
1119	18	660	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/trimgalore/wildtype_1.fastq.gz_trimming_report.txt	wildtype_1.fastq.gz_trimming_report.txt	3755	1550033727	\N	f	2022-09-16 14:40:35.063+00
1120	18	660	original/73de4c12-2b67-4ff2-a2bb-194693a84e30/results/trimgalore/wildtype_2.fastq.gz_trimming_report.txt	wildtype_2.fastq.gz_trimming_report.txt	3689	808649378	\N	f	2022-09-16 14:40:35.063+00
1121	19	\N		20220923133926119-79	456063633	\N	\N	t	2022-09-23 13:39:28.351+00
1122	19	1121	original	original	456063633	\N	\N	t	2022-09-23 13:39:26.911+00
1123	19	1122	original/ath.gff3	ath.gff3	456063633	-950503281	\N	f	2022-09-23 13:39:25.895+00
1124	20	\N		20220927093228519-107	13757516	\N	\N	t	2022-09-27 09:32:31.054+00
1125	20	1124	original	original	13757516	\N	\N	t	2022-09-27 09:32:29.534+00
1126	20	1125	original/logs	logs	13757516	\N	\N	t	2022-09-27 09:32:28.286+00
1127	20	1126	original/logs/salmon_quant.log	salmon_quant.log	13757516	885853512	\N	f	2022-09-27 09:32:28.286+00
1128	21	\N		20220927093229273-108	613954736	\N	\N	t	2022-09-27 09:32:31.054+00
1129	21	1128	original	original	613954736	\N	\N	t	2022-09-27 09:32:29.538+00
1130	21	1129	original/baccfc0c-7766-4806-acdb-a80d6ff648a6	baccfc0c-7766-4806-acdb-a80d6ff648a6	613954736	\N	\N	t	2022-09-27 09:32:24.078+00
1131	21	1130	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results	results	613954736	\N	\N	t	2022-09-23 10:41:13+00
1132	21	1131	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results	results	613954736	\N	\N	t	2022-09-23 10:41:13+00
1133	21	1132	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/fastqc	fastqc	3688148	\N	\N	t	2022-09-27 09:32:28.538+00
1134	21	1132	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc	multiqc	7247795	\N	\N	t	2022-09-23 10:41:13+00
1135	21	1134	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon	star_salmon	7247795	\N	\N	t	2022-09-27 09:32:29.206+00
1136	21	1135	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_data	multiqc_data	1986934	\N	\N	t	2022-09-27 09:32:29.238+00
1137	21	1135	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots	multiqc_plots	3770952	\N	\N	t	2022-09-23 10:41:13+00
1138	21	1137	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/pdf	pdf	807798	\N	\N	t	2022-09-27 09:32:29.226+00
1139	21	1137	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/png	png	1291547	\N	\N	t	2022-09-27 09:32:29.222+00
1140	21	1137	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/svg	svg	1671607	\N	\N	t	2022-09-27 09:32:29.214+00
1141	21	1132	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/pipeline_info	pipeline_info	3593586	\N	\N	t	2022-09-27 09:32:28.534+00
1142	21	1132	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon	star_salmon	595708244	\N	\N	t	2022-09-27 09:32:29.202+00
1143	21	1142	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/bigwig	bigwig	23923179	\N	\N	t	2022-09-27 09:32:29.158+00
1144	21	1142	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/deseq2_qc	deseq2_qc	566159	\N	\N	t	2022-09-27 09:32:29.206+00
1145	21	1144	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/deseq2_qc/size_factors	size_factors	241	\N	\N	t	2022-09-27 09:32:29.206+00
1146	21	1142	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/dupradar	dupradar	7207673	\N	\N	t	2022-09-23 10:41:13+00
1147	21	1146	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/dupradar/box_plot	box_plot	27238	\N	\N	t	2022-09-27 09:32:29.174+00
1148	21	1146	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/dupradar/gene_data	gene_data	5299584	\N	\N	t	2022-09-27 09:32:29.17+00
1149	21	1146	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/dupradar/histogram	histogram	10571	\N	\N	t	2022-09-27 09:32:29.174+00
1150	21	1146	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/dupradar/intercepts_slope	intercepts_slope	360	\N	\N	t	2022-09-27 09:32:29.174+00
1151	21	1146	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/dupradar/scatter_plot	scatter_plot	1869920	\N	\N	t	2022-09-27 09:32:29.174+00
1152	21	1142	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/featurecounts	featurecounts	20135239	\N	\N	t	2022-09-27 09:32:28.69+00
1153	21	1142	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/log	log	6053392	\N	\N	t	2022-09-27 09:32:29.166+00
1154	21	1142	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/mutant	mutant	4835992	\N	\N	t	2022-09-27 09:32:29.186+00
1155	21	1154	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/mutant/aux_info	aux_info	254915	\N	\N	t	2022-09-27 09:32:29.186+00
1156	21	1154	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/mutant/libParams	libParams	11762	\N	\N	t	2022-09-27 09:32:29.186+00
1157	21	1142	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/picard_metrics	picard_metrics	6850	\N	\N	t	2022-09-27 09:32:28.666+00
1158	21	1142	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/preseq	preseq	958804	\N	\N	t	2022-09-27 09:32:28.794+00
1159	21	1158	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/preseq/log	log	1233	\N	\N	t	2022-09-27 09:32:28.794+00
1160	21	1142	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/qualimap	qualimap	1002956	\N	\N	t	2022-09-23 10:41:13+00
1161	21	1160	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/qualimap/mutant	mutant	503834	\N	\N	t	2022-09-27 09:32:29.198+00
1162	21	1161	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/qualimap/mutant/css	css	166918	\N	\N	t	2022-09-27 09:32:29.198+00
1163	21	1161	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/qualimap/mutant/images_qualimapReport	images_qualimapReport	316850	\N	\N	t	2022-09-27 09:32:29.198+00
1164	21	1161	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/qualimap/mutant/raw_data_qualimapReport	raw_data_qualimapReport	7305	\N	\N	t	2022-09-27 09:32:29.202+00
1165	21	1160	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/qualimap/wildtype	wildtype	499122	\N	\N	t	2022-09-27 09:32:29.194+00
1166	21	1165	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/qualimap/wildtype/css	css	166918	\N	\N	t	2022-09-27 09:32:29.194+00
1167	21	1165	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/qualimap/wildtype/images_qualimapReport	images_qualimapReport	312113	\N	\N	t	2022-09-27 09:32:29.194+00
1168	21	1165	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/qualimap/wildtype/raw_data_qualimapReport	raw_data_qualimapReport	7326	\N	\N	t	2022-09-27 09:32:29.194+00
1169	21	1142	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/rseqc	rseqc	95840283	\N	\N	t	2022-09-23 10:41:13+00
1170	21	1169	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/rseqc/bam_stat	bam_stat	1711	\N	\N	t	2022-09-27 09:32:28.85+00
1171	21	1169	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/rseqc/infer_experiment	infer_experiment	422	\N	\N	t	2022-09-27 09:32:28.902+00
1172	21	1169	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/rseqc/inner_distance	inner_distance	47262255	\N	\N	t	2022-09-23 10:41:13+00
1173	21	1172	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/rseqc/inner_distance/pdf	pdf	17184	\N	\N	t	2022-09-27 09:32:28.846+00
1174	21	1172	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/rseqc/inner_distance/rscript	rscript	3157	\N	\N	t	2022-09-27 09:32:28.846+00
1175	21	1172	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/rseqc/inner_distance/txt	txt	47241914	\N	\N	t	2022-09-27 09:32:28.846+00
1176	21	1169	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/rseqc/junction_annotation	junction_annotation	48542881	\N	\N	t	2022-09-23 10:41:13+00
1177	21	1176	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/rseqc/junction_annotation/bed	bed	42472430	\N	\N	t	2022-09-27 09:32:28.894+00
1178	21	1176	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/rseqc/junction_annotation/log	log	1144	\N	\N	t	2022-09-27 09:32:28.902+00
1179	21	1176	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/rseqc/junction_annotation/pdf	pdf	53226	\N	\N	t	2022-09-27 09:32:28.902+00
1180	21	1176	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/rseqc/junction_annotation/rscript	rscript	1164	\N	\N	t	2022-09-27 09:32:28.902+00
1181	21	1176	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/rseqc/junction_annotation/xls	xls	6014917	\N	\N	t	2022-09-27 09:32:28.902+00
1182	21	1169	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/rseqc/junction_saturation	junction_saturation	12831	\N	\N	t	2022-09-23 10:41:13+00
1183	21	1182	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/rseqc/junction_saturation/pdf	pdf	11174	\N	\N	t	2022-09-27 09:32:28.85+00
1184	21	1182	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/rseqc/junction_saturation/rscript	rscript	1657	\N	\N	t	2022-09-27 09:32:28.85+00
1185	21	1169	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/rseqc/read_distribution	read_distribution	2306	\N	\N	t	2022-09-27 09:32:28.85+00
1186	21	1169	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/rseqc/read_duplication	read_duplication	17877	\N	\N	t	2022-09-23 10:41:13+00
1187	21	1186	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/rseqc/read_duplication/pdf	pdf	12905	\N	\N	t	2022-09-27 09:32:28.85+00
1188	21	1186	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/rseqc/read_duplication/rscript	rscript	3257	\N	\N	t	2022-09-27 09:32:28.85+00
1189	21	1186	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/rseqc/read_duplication/xls	xls	1715	\N	\N	t	2022-09-27 09:32:28.85+00
1190	21	1142	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/samtools_stats	samtools_stats	544968	\N	\N	t	2022-09-27 09:32:29.19+00
1191	21	1142	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/stringtie	stringtie	190076441	\N	\N	t	2022-09-27 09:32:29.106+00
1192	21	1191	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/stringtie/mutant.ballgown	mutant.ballgown	34050337	\N	\N	t	2022-09-27 09:32:29.058+00
1193	21	1191	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/stringtie/wildtype.ballgown	wildtype.ballgown	34036044	\N	\N	t	2022-09-27 09:32:29.098+00
1194	21	1142	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/wildtype	wildtype	4830410	\N	\N	t	2022-09-27 09:32:29.178+00
1195	21	1194	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/wildtype/aux_info	aux_info	252614	\N	\N	t	2022-09-27 09:32:29.182+00
1196	21	1194	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/wildtype/libParams	libParams	11777	\N	\N	t	2022-09-27 09:32:29.178+00
1197	21	1132	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/trimgalore	trimgalore	3716963	\N	\N	t	2022-09-27 09:32:28.53+00
1198	21	1197	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/trimgalore/fastqc	fastqc	3702005	\N	\N	t	2022-09-27 09:32:28.526+00
1199	21	1133	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/fastqc/mutant_1_fastqc.html	mutant_1_fastqc.html	570159	-529011620	\N	f	2022-09-27 09:32:28.538+00
1200	21	1133	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/fastqc/mutant_1_fastqc.zip	mutant_1_fastqc.zip	311501	101419516	\N	f	2022-09-27 09:32:28.538+00
1201	21	1133	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/fastqc/mutant_2_fastqc.html	mutant_2_fastqc.html	568779	-1284404361	\N	f	2022-09-27 09:32:28.534+00
1202	21	1133	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/fastqc/mutant_2_fastqc.zip	mutant_2_fastqc.zip	308774	1868441222	\N	f	2022-09-27 09:32:28.538+00
1203	21	1133	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/fastqc/wildtype_1_fastqc.html	wildtype_1_fastqc.html	606606	2038836778	\N	f	2022-09-27 09:32:28.534+00
1204	21	1133	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/fastqc/wildtype_1_fastqc.zip	wildtype_1_fastqc.zip	363892	102478901	\N	f	2022-09-27 09:32:28.538+00
1205	21	1133	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/fastqc/wildtype_2_fastqc.html	wildtype_2_fastqc.html	599938	-2130634997	\N	f	2022-09-27 09:32:28.534+00
1206	21	1133	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/fastqc/wildtype_2_fastqc.zip	wildtype_2_fastqc.zip	358499	-595931756	\N	f	2022-09-27 09:32:28.534+00
1207	21	1136	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_data/mqc_cutadapt_filtered_reads_plot_1.txt	mqc_cutadapt_filtered_reads_plot_1.txt	133	-1638532288	\N	f	2022-09-27 09:32:29.234+00
1208	21	1136	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_data/mqc_cutadapt_trimmed_sequences_plot_3_Counts.txt	mqc_cutadapt_trimmed_sequences_plot_3_Counts.txt	2645	-1954836337	\N	f	2022-09-27 09:32:29.234+00
1209	21	1136	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_data/mqc_cutadapt_trimmed_sequences_plot_3_Obs_Exp.txt	mqc_cutadapt_trimmed_sequences_plot_3_Obs_Exp.txt	3998	1280029012	\N	f	2022-09-27 09:32:29.234+00
1210	21	1136	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_data/mqc_fastqc_adapter_content_plot_1.txt	mqc_fastqc_adapter_content_plot_1.txt	3238	-702405494	\N	f	2022-09-27 09:32:29.234+00
1211	21	1136	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_data/mqc_fastqc_per_base_n_content_plot-2_1.txt	mqc_fastqc_per_base_n_content_plot-2_1.txt	2661	729553044	\N	f	2022-09-27 09:32:29.23+00
1212	21	1136	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_data/mqc_fastqc_per_base_n_content_plot_1.txt	mqc_fastqc_per_base_n_content_plot_1.txt	2957	-150295396	\N	f	2022-09-27 09:32:29.23+00
1213	21	1136	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_data/mqc_fastqc_per_base_sequence_quality_plot-2_1.txt	mqc_fastqc_per_base_sequence_quality_plot-2_1.txt	2794	2098547177	\N	f	2022-09-27 09:32:29.234+00
1214	21	1136	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_data/mqc_fastqc_per_base_sequence_quality_plot_1.txt	mqc_fastqc_per_base_sequence_quality_plot_1.txt	2837	1018778626	\N	f	2022-09-27 09:32:29.234+00
1215	21	1136	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_data/mqc_fastqc_per_sequence_gc_content_plot-2_Counts.txt	mqc_fastqc_per_sequence_gc_content_plot-2_Counts.txt	2959	-174214128	\N	f	2022-09-27 09:32:29.23+00
1216	21	1136	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_data/mqc_fastqc_per_sequence_gc_content_plot-2_Percentages.txt	mqc_fastqc_per_sequence_gc_content_plot-2_Percentages.txt	7876	-1725492771	\N	f	2022-09-27 09:32:29.234+00
1217	21	1136	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_data/mqc_fastqc_per_sequence_gc_content_plot_Counts.txt	mqc_fastqc_per_sequence_gc_content_plot_Counts.txt	2927	-1197478583	\N	f	2022-09-27 09:32:29.234+00
1218	21	1136	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_data/mqc_fastqc_per_sequence_gc_content_plot_Percentages.txt	mqc_fastqc_per_sequence_gc_content_plot_Percentages.txt	7340	-882517894	\N	f	2022-09-27 09:32:29.23+00
1219	21	1136	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_data/mqc_fastqc_per_sequence_quality_scores_plot-2_1.txt	mqc_fastqc_per_sequence_quality_scores_plot-2_1.txt	1504	1543176853	\N	f	2022-09-27 09:32:29.23+00
1220	21	1136	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_data/mqc_fastqc_per_sequence_quality_scores_plot_1.txt	mqc_fastqc_per_sequence_quality_scores_plot_1.txt	1881	1569952097	\N	f	2022-09-27 09:32:29.234+00
1221	21	1136	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_data/mqc_fastqc_sequence_counts_plot-2_1.txt	mqc_fastqc_sequence_counts_plot-2_1.txt	173	-1916058843	\N	f	2022-09-27 09:32:29.23+00
1222	21	1136	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_data/mqc_fastqc_sequence_counts_plot_1.txt	mqc_fastqc_sequence_counts_plot_1.txt	174	-1855185877	\N	f	2022-09-27 09:32:29.234+00
1223	21	1136	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_data/mqc_fastqc_sequence_duplication_levels_plot-2_1.txt	mqc_fastqc_sequence_duplication_levels_plot-2_1.txt	627	1857347847	\N	f	2022-09-27 09:32:29.23+00
1224	21	1136	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_data/mqc_fastqc_sequence_duplication_levels_plot_1.txt	mqc_fastqc_sequence_duplication_levels_plot_1.txt	658	1690489142	\N	f	2022-09-27 09:32:29.234+00
1225	21	1136	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_data/mqc_fastqc_sequence_length_distribution_plot_1.txt	mqc_fastqc_sequence_length_distribution_plot_1.txt	1126	1943983428	\N	f	2022-09-27 09:32:29.23+00
1226	21	1136	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_data/mqc_featurecounts_biotype_plot_1.txt	mqc_featurecounts_biotype_plot_1.txt	171	-2098915940	\N	f	2022-09-27 09:32:29.234+00
1227	21	1136	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_data/mqc_mqc_mplplot_ksbuxlnfvp_1.txt	mqc_mqc_mplplot_ksbuxlnfvp_1.txt	132378	749493637	\N	f	2022-09-27 09:32:29.23+00
1228	21	1136	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_data/mqc_picard_deduplication_1.txt	mqc_picard_deduplication_1.txt	184	1162116019	\N	f	2022-09-27 09:32:29.234+00
1229	21	1136	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_data/mqc_preseq_plot_1.txt	mqc_preseq_plot_1.txt	36023	-454863842	\N	f	2022-09-27 09:32:29.238+00
1230	21	1136	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_data/mqc_qualimap_gene_coverage_profile_Counts.txt	mqc_qualimap_gene_coverage_profile_Counts.txt	4074	-1328316481	\N	f	2022-09-27 09:32:29.234+00
1231	21	1136	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_data/mqc_qualimap_gene_coverage_profile_Normalised.txt	mqc_qualimap_gene_coverage_profile_Normalised.txt	4110	1658596044	\N	f	2022-09-27 09:32:29.234+00
1232	21	1136	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_data/mqc_qualimap_genomic_origin_1.txt	mqc_qualimap_genomic_origin_1.txt	132	-319748023	\N	f	2022-09-27 09:32:29.23+00
1233	21	1136	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_data/mqc_rseqc_infer_experiment_plot_1.txt	mqc_rseqc_infer_experiment_plot_1.txt	114	-938862821	\N	f	2022-09-27 09:32:29.234+00
1234	21	1136	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_data/mqc_rseqc_inner_distance_plot_Counts.txt	mqc_rseqc_inner_distance_plot_Counts.txt	1902	659621527	\N	f	2022-09-27 09:32:29.234+00
1235	21	1136	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_data/mqc_rseqc_inner_distance_plot_Percentages.txt	mqc_rseqc_inner_distance_plot_Percentages.txt	3881	11468527	\N	f	2022-09-27 09:32:29.23+00
1236	21	1136	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_data/mqc_rseqc_junction_annotation_junctions_plot_Events.txt	mqc_rseqc_junction_annotation_junctions_plot_Events.txt	170	1697128778	\N	f	2022-09-27 09:32:29.234+00
1237	21	1136	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_data/mqc_rseqc_junction_annotation_junctions_plot_Junctions.txt	mqc_rseqc_junction_annotation_junctions_plot_Junctions.txt	174	2133086470	\N	f	2022-09-27 09:32:29.23+00
1238	21	1136	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_data/mqc_rseqc_junction_saturation_plot_All_Junctions.txt	mqc_rseqc_junction_saturation_plot_All_Junctions.txt	471	974369384	\N	f	2022-09-27 09:32:29.23+00
1239	21	1136	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_data/mqc_rseqc_junction_saturation_plot_Known_Junctions.txt	mqc_rseqc_junction_saturation_plot_Known_Junctions.txt	471	-1830905621	\N	f	2022-09-27 09:32:29.234+00
1240	21	1136	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_data/mqc_rseqc_junction_saturation_plot_Novel_Junctions.txt	mqc_rseqc_junction_saturation_plot_Novel_Junctions.txt	402	481284253	\N	f	2022-09-27 09:32:29.234+00
1241	21	1136	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_data/mqc_rseqc_read_distribution_plot_1.txt	mqc_rseqc_read_distribution_plot_1.txt	343	-267914510	\N	f	2022-09-27 09:32:29.234+00
1242	21	1136	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_data/mqc_rseqc_read_dups_plot_1.txt	mqc_rseqc_read_dups_plot_1.txt	843	1589563703	\N	f	2022-09-27 09:32:29.234+00
1243	21	1136	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_data/mqc_samtools-idxstats-mapped-reads-plot_Normalised_Counts.txt	mqc_samtools-idxstats-mapped-reads-plot_Normalised_Counts.txt	359	-455257502	\N	f	2022-09-27 09:32:29.234+00
1244	21	1136	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_data/mqc_samtools-idxstats-mapped-reads-plot_Observed_over_Expected_Counts.txt	mqc_samtools-idxstats-mapped-reads-plot_Observed_over_Expected_Counts.txt	347	2092737328	\N	f	2022-09-27 09:32:29.234+00
1245	21	1136	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_data/mqc_samtools-idxstats-mapped-reads-plot_Raw_Counts.txt	mqc_samtools-idxstats-mapped-reads-plot_Raw_Counts.txt	203	-1463756317	\N	f	2022-09-27 09:32:29.23+00
1246	21	1136	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_data/mqc_samtools_alignment_plot_1.txt	mqc_samtools_alignment_plot_1.txt	78	2048386246	\N	f	2022-09-27 09:32:29.234+00
1247	21	1136	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_data/mqc_star_alignment_plot_1.txt	mqc_star_alignment_plot_1.txt	218	-1910776937	\N	f	2022-09-27 09:32:29.23+00
1248	21	1136	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_data/multiqc.log	multiqc.log	21834	-64521184	\N	f	2022-09-27 09:32:29.234+00
1249	21	1136	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_data/multiqc_cutadapt.txt	multiqc_cutadapt.txt	463	-188728333	\N	f	2022-09-27 09:32:29.23+00
1250	21	1136	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_data/multiqc_data.json	multiqc_data.json	1709170	280829134	\N	f	2022-09-27 09:32:29.234+00
1251	21	1136	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_data/multiqc_fastqc.txt	multiqc_fastqc.txt	1114	290775046	\N	f	2022-09-27 09:32:29.234+00
1252	21	1136	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_data/multiqc_fastqc_1.txt	multiqc_fastqc_1.txt	1181	-636997324	\N	f	2022-09-27 09:32:29.234+00
1253	21	1136	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_data/multiqc_general_stats.txt	multiqc_general_stats.txt	2583	-1605448298	\N	f	2022-09-27 09:32:29.23+00
1254	21	1136	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_data/multiqc_picard_dups.txt	multiqc_picard_dups.txt	428	1386164308	\N	f	2022-09-27 09:32:29.23+00
1255	21	1136	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_data/multiqc_rseqc_bam_stat.txt	multiqc_rseqc_bam_stat.txt	624	1011045611	\N	f	2022-09-27 09:32:29.234+00
1256	21	1136	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_data/multiqc_rseqc_infer_experiment.txt	multiqc_rseqc_infer_experiment.txt	122	1148401312	\N	f	2022-09-27 09:32:29.23+00
1257	21	1136	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_data/multiqc_rseqc_junction_annotation.txt	multiqc_rseqc_junction_annotation.txt	748	-1562469668	\N	f	2022-09-27 09:32:29.23+00
1258	21	1136	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_data/multiqc_rseqc_read_distribution.txt	multiqc_rseqc_read_distribution.txt	1876	-779447655	\N	f	2022-09-27 09:32:29.234+00
1259	21	1136	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_data/multiqc_samtools_flagstat.txt	multiqc_samtools_flagstat.txt	1100	-607181597	\N	f	2022-09-27 09:32:29.234+00
1260	21	1136	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_data/multiqc_samtools_idxstats.txt	multiqc_samtools_idxstats.txt	399	-1579683819	\N	f	2022-09-27 09:32:29.23+00
1261	21	1136	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_data/multiqc_samtools_stats.txt	multiqc_samtools_stats.txt	1807	1115839849	\N	f	2022-09-27 09:32:29.234+00
1262	21	1136	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_data/multiqc_sources.txt	multiqc_sources.txt	6798	812540429	\N	f	2022-09-27 09:32:29.234+00
1263	21	1136	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_data/multiqc_star.txt	multiqc_star.txt	847	32569672	\N	f	2022-09-27 09:32:29.23+00
1264	21	1136	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_data/multiqc_warning:_fail_strand_check.txt	multiqc_warning:_fail_strand_check.txt	284	-1371104841	\N	f	2022-09-27 09:32:29.234+00
1265	21	1138	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_cutadapt_filtered_reads_plot_1.pdf	mqc_cutadapt_filtered_reads_plot_1.pdf	12492	566314061	\N	f	2022-09-27 09:32:29.226+00
1266	21	1138	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_cutadapt_filtered_reads_plot_1_pc.pdf	mqc_cutadapt_filtered_reads_plot_1_pc.pdf	12654	1923200773	\N	f	2022-09-27 09:32:29.222+00
1267	21	1138	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_cutadapt_trimmed_sequences_plot_3_Counts.pdf	mqc_cutadapt_trimmed_sequences_plot_3_Counts.pdf	17929	2145582052	\N	f	2022-09-27 09:32:29.226+00
1268	21	1138	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_cutadapt_trimmed_sequences_plot_3_Obs_Exp.pdf	mqc_cutadapt_trimmed_sequences_plot_3_Obs_Exp.pdf	18416	1875429600	\N	f	2022-09-27 09:32:29.226+00
1269	21	1138	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_fastqc_adapter_content_plot_1.pdf	mqc_fastqc_adapter_content_plot_1.pdf	16964	-38691895	\N	f	2022-09-27 09:32:29.226+00
1270	21	1138	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_fastqc_per_base_n_content_plot-2_1.pdf	mqc_fastqc_per_base_n_content_plot-2_1.pdf	16333	1221674454	\N	f	2022-09-27 09:32:29.222+00
1271	21	1138	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_fastqc_per_base_n_content_plot_1.pdf	mqc_fastqc_per_base_n_content_plot_1.pdf	16472	-577625902	\N	f	2022-09-27 09:32:29.226+00
1272	21	1138	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_fastqc_per_base_sequence_quality_plot-2_1.pdf	mqc_fastqc_per_base_sequence_quality_plot-2_1.pdf	16252	-936404668	\N	f	2022-09-27 09:32:29.222+00
1273	21	1138	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_fastqc_per_base_sequence_quality_plot_1.pdf	mqc_fastqc_per_base_sequence_quality_plot_1.pdf	16242	-590385690	\N	f	2022-09-27 09:32:29.222+00
1274	21	1138	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_fastqc_per_sequence_gc_content_plot-2_Counts.pdf	mqc_fastqc_per_sequence_gc_content_plot-2_Counts.pdf	17559	-1742237394	\N	f	2022-09-27 09:32:29.226+00
1275	21	1138	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_fastqc_per_sequence_gc_content_plot-2_Percentages.pdf	mqc_fastqc_per_sequence_gc_content_plot-2_Percentages.pdf	18017	-1781425410	\N	f	2022-09-27 09:32:29.222+00
1276	21	1138	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_fastqc_per_sequence_gc_content_plot_Counts.pdf	mqc_fastqc_per_sequence_gc_content_plot_Counts.pdf	17389	-1408306733	\N	f	2022-09-27 09:32:29.226+00
1277	21	1138	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_fastqc_per_sequence_gc_content_plot_Percentages.pdf	mqc_fastqc_per_sequence_gc_content_plot_Percentages.pdf	17835	1424472178	\N	f	2022-09-27 09:32:29.222+00
1278	21	1138	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_fastqc_per_sequence_quality_scores_plot-2_1.pdf	mqc_fastqc_per_sequence_quality_scores_plot-2_1.pdf	15321	1420044560	\N	f	2022-09-27 09:32:29.222+00
1279	21	1138	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_fastqc_per_sequence_quality_scores_plot_1.pdf	mqc_fastqc_per_sequence_quality_scores_plot_1.pdf	15521	2134032492	\N	f	2022-09-27 09:32:29.226+00
1280	21	1138	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_fastqc_sequence_counts_plot-2_1.pdf	mqc_fastqc_sequence_counts_plot-2_1.pdf	14760	535427146	\N	f	2022-09-27 09:32:29.226+00
1281	21	1138	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_fastqc_sequence_counts_plot-2_1_pc.pdf	mqc_fastqc_sequence_counts_plot-2_1_pc.pdf	14924	1996604593	\N	f	2022-09-27 09:32:29.226+00
1282	21	1138	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_fastqc_sequence_counts_plot_1.pdf	mqc_fastqc_sequence_counts_plot_1.pdf	14764	726820832	\N	f	2022-09-27 09:32:29.226+00
1283	21	1138	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_fastqc_sequence_counts_plot_1_pc.pdf	mqc_fastqc_sequence_counts_plot_1_pc.pdf	14923	655753889	\N	f	2022-09-27 09:32:29.222+00
1284	21	1138	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_fastqc_sequence_duplication_levels_plot-2_1.pdf	mqc_fastqc_sequence_duplication_levels_plot-2_1.pdf	17119	-308828550	\N	f	2022-09-27 09:32:29.226+00
1285	21	1138	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_fastqc_sequence_duplication_levels_plot_1.pdf	mqc_fastqc_sequence_duplication_levels_plot_1.pdf	17128	-1400433908	\N	f	2022-09-27 09:32:29.226+00
1344	21	1139	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/png/mqc_preseq_plot_1.png	mqc_preseq_plot_1.png	40966	1923595139	\N	f	2022-09-27 09:32:29.218+00
1286	21	1138	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_fastqc_sequence_length_distribution_plot_1.pdf	mqc_fastqc_sequence_length_distribution_plot_1.pdf	16721	764184106	\N	f	2022-09-27 09:32:29.222+00
1287	21	1138	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_featurecounts_biotype_plot_1.pdf	mqc_featurecounts_biotype_plot_1.pdf	13057	-1133213755	\N	f	2022-09-27 09:32:29.222+00
1288	21	1138	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_featurecounts_biotype_plot_1_pc.pdf	mqc_featurecounts_biotype_plot_1_pc.pdf	13856	1525473794	\N	f	2022-09-27 09:32:29.226+00
1289	21	1138	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_mqc_mplplot_ksbuxlnfvp_1.pdf	mqc_mqc_mplplot_ksbuxlnfvp_1.pdf	14502	-411916326	\N	f	2022-09-27 09:32:29.226+00
1290	21	1138	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_picard_deduplication_1.pdf	mqc_picard_deduplication_1.pdf	13674	359693983	\N	f	2022-09-27 09:32:29.226+00
1291	21	1138	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_picard_deduplication_1_pc.pdf	mqc_picard_deduplication_1_pc.pdf	13944	-1792975648	\N	f	2022-09-27 09:32:29.222+00
1292	21	1138	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_preseq_plot_1.pdf	mqc_preseq_plot_1.pdf	16639	1144184419	\N	f	2022-09-27 09:32:29.226+00
1293	21	1138	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_qualimap_gene_coverage_profile_Counts.pdf	mqc_qualimap_gene_coverage_profile_Counts.pdf	18125	-696038017	\N	f	2022-09-27 09:32:29.226+00
1294	21	1138	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_qualimap_gene_coverage_profile_Normalised.pdf	mqc_qualimap_gene_coverage_profile_Normalised.pdf	17963	1726972200	\N	f	2022-09-27 09:32:29.226+00
1295	21	1138	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_qualimap_genomic_origin_1.pdf	mqc_qualimap_genomic_origin_1.pdf	14830	612597436	\N	f	2022-09-27 09:32:29.226+00
1296	21	1138	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_qualimap_genomic_origin_1_pc.pdf	mqc_qualimap_genomic_origin_1_pc.pdf	15109	-189676695	\N	f	2022-09-27 09:32:29.222+00
1297	21	1138	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_rseqc_infer_experiment_plot_1.pdf	mqc_rseqc_infer_experiment_plot_1.pdf	13904	238440693	\N	f	2022-09-27 09:32:29.226+00
1298	21	1138	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_rseqc_inner_distance_plot_Counts.pdf	mqc_rseqc_inner_distance_plot_Counts.pdf	14788	1148950382	\N	f	2022-09-27 09:32:29.222+00
1299	21	1138	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_rseqc_inner_distance_plot_Percentages.pdf	mqc_rseqc_inner_distance_plot_Percentages.pdf	15446	40540186	\N	f	2022-09-27 09:32:29.222+00
1300	21	1138	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_rseqc_junction_annotation_junctions_plot_Events.pdf	mqc_rseqc_junction_annotation_junctions_plot_Events.pdf	14488	1624286627	\N	f	2022-09-27 09:32:29.226+00
1301	21	1138	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_rseqc_junction_annotation_junctions_plot_Events_pc.pdf	mqc_rseqc_junction_annotation_junctions_plot_Events_pc.pdf	14580	-1528031563	\N	f	2022-09-27 09:32:29.226+00
1302	21	1138	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_rseqc_junction_annotation_junctions_plot_Junctions.pdf	mqc_rseqc_junction_annotation_junctions_plot_Junctions.pdf	14955	340254322	\N	f	2022-09-27 09:32:29.226+00
1303	21	1138	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_rseqc_junction_annotation_junctions_plot_Junctions_pc.pdf	mqc_rseqc_junction_annotation_junctions_plot_Junctions_pc.pdf	14387	975203682	\N	f	2022-09-27 09:32:29.226+00
1304	21	1138	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_rseqc_junction_saturation_plot_All_Junctions.pdf	mqc_rseqc_junction_saturation_plot_All_Junctions.pdf	14949	1304811945	\N	f	2022-09-27 09:32:29.222+00
1305	21	1138	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_rseqc_junction_saturation_plot_Known_Junctions.pdf	mqc_rseqc_junction_saturation_plot_Known_Junctions.pdf	14961	946330551	\N	f	2022-09-27 09:32:29.226+00
1306	21	1138	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_rseqc_junction_saturation_plot_Novel_Junctions.pdf	mqc_rseqc_junction_saturation_plot_Novel_Junctions.pdf	14525	96563906	\N	f	2022-09-27 09:32:29.222+00
1307	21	1138	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_rseqc_read_distribution_plot_1.pdf	mqc_rseqc_read_distribution_plot_1.pdf	17341	1986302877	\N	f	2022-09-27 09:32:29.222+00
1308	21	1138	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_rseqc_read_distribution_plot_1_pc.pdf	mqc_rseqc_read_distribution_plot_1_pc.pdf	18132	130899606	\N	f	2022-09-27 09:32:29.226+00
1309	21	1138	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_rseqc_read_dups_plot_1.pdf	mqc_rseqc_read_dups_plot_1.pdf	16315	1407970871	\N	f	2022-09-27 09:32:29.226+00
1310	21	1138	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_samtools-idxstats-mapped-reads-plot_Normalised_Counts.pdf	mqc_samtools-idxstats-mapped-reads-plot_Normalised_Counts.pdf	15221	2123827282	\N	f	2022-09-27 09:32:29.222+00
1311	21	1138	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_samtools-idxstats-mapped-reads-plot_Observed_over_Expected_Counts.pdf	mqc_samtools-idxstats-mapped-reads-plot_Observed_over_Expected_Counts.pdf	16313	-597468379	\N	f	2022-09-27 09:32:29.226+00
1312	21	1138	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_samtools-idxstats-mapped-reads-plot_Raw_Counts.pdf	mqc_samtools-idxstats-mapped-reads-plot_Raw_Counts.pdf	15138	110578208	\N	f	2022-09-27 09:32:29.222+00
1313	21	1138	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_samtools_alignment_plot_1.pdf	mqc_samtools_alignment_plot_1.pdf	12813	1777200405	\N	f	2022-09-27 09:32:29.222+00
1343	21	1139	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/png/mqc_picard_deduplication_1_pc.png	mqc_picard_deduplication_1_pc.png	10977	1593639953	\N	f	2022-09-27 09:32:29.218+00
1314	21	1138	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_samtools_alignment_plot_1_pc.pdf	mqc_samtools_alignment_plot_1_pc.pdf	13096	1866858050	\N	f	2022-09-27 09:32:29.222+00
1315	21	1138	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_star_alignment_plot_1.pdf	mqc_star_alignment_plot_1.pdf	14425	-487517657	\N	f	2022-09-27 09:32:29.226+00
1316	21	1138	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_star_alignment_plot_1_pc.pdf	mqc_star_alignment_plot_1_pc.pdf	14587	270255196	\N	f	2022-09-27 09:32:29.226+00
1317	21	1139	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/png/mqc_cutadapt_filtered_reads_plot_1.png	mqc_cutadapt_filtered_reads_plot_1.png	10408	1797249638	\N	f	2022-09-27 09:32:29.214+00
1318	21	1139	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/png/mqc_cutadapt_filtered_reads_plot_1_pc.png	mqc_cutadapt_filtered_reads_plot_1_pc.png	10669	504632589	\N	f	2022-09-27 09:32:29.222+00
1319	21	1139	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/png/mqc_cutadapt_trimmed_sequences_plot_3_Counts.png	mqc_cutadapt_trimmed_sequences_plot_3_Counts.png	25706	1733233444	\N	f	2022-09-27 09:32:29.218+00
1320	21	1139	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/png/mqc_cutadapt_trimmed_sequences_plot_3_Obs_Exp.png	mqc_cutadapt_trimmed_sequences_plot_3_Obs_Exp.png	27862	1162142507	\N	f	2022-09-27 09:32:29.214+00
1321	21	1139	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/png/mqc_fastqc_adapter_content_plot_1.png	mqc_fastqc_adapter_content_plot_1.png	17378	-1046225138	\N	f	2022-09-27 09:32:29.218+00
1322	21	1139	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/png/mqc_fastqc_per_base_n_content_plot-2_1.png	mqc_fastqc_per_base_n_content_plot-2_1.png	19662	1945658532	\N	f	2022-09-27 09:32:29.214+00
1323	21	1139	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/png/mqc_fastqc_per_base_n_content_plot_1.png	mqc_fastqc_per_base_n_content_plot_1.png	21933	2135102410	\N	f	2022-09-27 09:32:29.218+00
1324	21	1139	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/png/mqc_fastqc_per_base_sequence_quality_plot-2_1.png	mqc_fastqc_per_base_sequence_quality_plot-2_1.png	32706	-678105172	\N	f	2022-09-27 09:32:29.218+00
1325	21	1139	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/png/mqc_fastqc_per_base_sequence_quality_plot_1.png	mqc_fastqc_per_base_sequence_quality_plot_1.png	35376	-124264349	\N	f	2022-09-27 09:32:29.222+00
1326	21	1139	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/png/mqc_fastqc_per_sequence_gc_content_plot-2_Counts.png	mqc_fastqc_per_sequence_gc_content_plot-2_Counts.png	45839	498913148	\N	f	2022-09-27 09:32:29.218+00
1327	21	1139	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/png/mqc_fastqc_per_sequence_gc_content_plot-2_Percentages.png	mqc_fastqc_per_sequence_gc_content_plot-2_Percentages.png	46100	1962329238	\N	f	2022-09-27 09:32:29.218+00
1328	21	1139	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/png/mqc_fastqc_per_sequence_gc_content_plot_Counts.png	mqc_fastqc_per_sequence_gc_content_plot_Counts.png	45420	-766647439	\N	f	2022-09-27 09:32:29.218+00
1329	21	1139	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/png/mqc_fastqc_per_sequence_gc_content_plot_Percentages.png	mqc_fastqc_per_sequence_gc_content_plot_Percentages.png	45401	-1717509673	\N	f	2022-09-27 09:32:29.222+00
1330	21	1139	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/png/mqc_fastqc_per_sequence_quality_scores_plot-2_1.png	mqc_fastqc_per_sequence_quality_scores_plot-2_1.png	44750	1327702805	\N	f	2022-09-27 09:32:29.218+00
1331	21	1139	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/png/mqc_fastqc_per_sequence_quality_scores_plot_1.png	mqc_fastqc_per_sequence_quality_scores_plot_1.png	47051	-1256547060	\N	f	2022-09-27 09:32:29.218+00
1332	21	1139	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/png/mqc_fastqc_sequence_counts_plot-2_1.png	mqc_fastqc_sequence_counts_plot-2_1.png	11519	-70376420	\N	f	2022-09-27 09:32:29.218+00
1333	21	1139	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/png/mqc_fastqc_sequence_counts_plot-2_1_pc.png	mqc_fastqc_sequence_counts_plot-2_1_pc.png	11775	1195215462	\N	f	2022-09-27 09:32:29.222+00
1334	21	1139	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/png/mqc_fastqc_sequence_counts_plot_1.png	mqc_fastqc_sequence_counts_plot_1.png	11517	-1552039530	\N	f	2022-09-27 09:32:29.218+00
1335	21	1139	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/png/mqc_fastqc_sequence_counts_plot_1_pc.png	mqc_fastqc_sequence_counts_plot_1_pc.png	11772	652313334	\N	f	2022-09-27 09:32:29.218+00
1336	21	1139	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/png/mqc_fastqc_sequence_duplication_levels_plot-2_1.png	mqc_fastqc_sequence_duplication_levels_plot-2_1.png	30622	-2135438425	\N	f	2022-09-27 09:32:29.218+00
1337	21	1139	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/png/mqc_fastqc_sequence_duplication_levels_plot_1.png	mqc_fastqc_sequence_duplication_levels_plot_1.png	30473	780892314	\N	f	2022-09-27 09:32:29.218+00
1338	21	1139	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/png/mqc_fastqc_sequence_length_distribution_plot_1.png	mqc_fastqc_sequence_length_distribution_plot_1.png	29105	-1833954911	\N	f	2022-09-27 09:32:29.214+00
1339	21	1139	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/png/mqc_featurecounts_biotype_plot_1.png	mqc_featurecounts_biotype_plot_1.png	11007	354843952	\N	f	2022-09-27 09:32:29.218+00
1340	21	1139	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/png/mqc_featurecounts_biotype_plot_1_pc.png	mqc_featurecounts_biotype_plot_1_pc.png	11304	-1628507442	\N	f	2022-09-27 09:32:29.214+00
1341	21	1139	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/png/mqc_mqc_mplplot_ksbuxlnfvp_1.png	mqc_mqc_mplplot_ksbuxlnfvp_1.png	21199	1250870165	\N	f	2022-09-27 09:32:29.222+00
1342	21	1139	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/png/mqc_picard_deduplication_1.png	mqc_picard_deduplication_1.png	10485	-601778032	\N	f	2022-09-27 09:32:29.214+00
1345	21	1139	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/png/mqc_qualimap_gene_coverage_profile_Counts.png	mqc_qualimap_gene_coverage_profile_Counts.png	49153	1590371871	\N	f	2022-09-27 09:32:29.218+00
1346	21	1139	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/png/mqc_qualimap_gene_coverage_profile_Normalised.png	mqc_qualimap_gene_coverage_profile_Normalised.png	50673	-1009973413	\N	f	2022-09-27 09:32:29.218+00
1347	21	1139	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/png/mqc_qualimap_genomic_origin_1.png	mqc_qualimap_genomic_origin_1.png	9263	-322888434	\N	f	2022-09-27 09:32:29.222+00
1348	21	1139	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/png/mqc_qualimap_genomic_origin_1_pc.png	mqc_qualimap_genomic_origin_1_pc.png	9700	-1102720767	\N	f	2022-09-27 09:32:29.222+00
1349	21	1139	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/png/mqc_rseqc_infer_experiment_plot_1.png	mqc_rseqc_infer_experiment_plot_1.png	9326	651437396	\N	f	2022-09-27 09:32:29.222+00
1350	21	1139	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/png/mqc_rseqc_inner_distance_plot_Counts.png	mqc_rseqc_inner_distance_plot_Counts.png	37958	-1549121821	\N	f	2022-09-27 09:32:29.214+00
1351	21	1139	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/png/mqc_rseqc_inner_distance_plot_Percentages.png	mqc_rseqc_inner_distance_plot_Percentages.png	36585	-2062323877	\N	f	2022-09-27 09:32:29.222+00
1352	21	1139	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/png/mqc_rseqc_junction_annotation_junctions_plot_Events.png	mqc_rseqc_junction_annotation_junctions_plot_Events.png	11222	1197127578	\N	f	2022-09-27 09:32:29.218+00
1353	21	1139	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/png/mqc_rseqc_junction_annotation_junctions_plot_Events_pc.png	mqc_rseqc_junction_annotation_junctions_plot_Events_pc.png	12051	-1553503056	\N	f	2022-09-27 09:32:29.218+00
1354	21	1139	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/png/mqc_rseqc_junction_annotation_junctions_plot_Junctions.png	mqc_rseqc_junction_annotation_junctions_plot_Junctions.png	11516	-2044561554	\N	f	2022-09-27 09:32:29.218+00
1355	21	1139	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/png/mqc_rseqc_junction_annotation_junctions_plot_Junctions_pc.png	mqc_rseqc_junction_annotation_junctions_plot_Junctions_pc.png	12186	1195807977	\N	f	2022-09-27 09:32:29.218+00
1356	21	1139	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/png/mqc_rseqc_junction_saturation_plot_All_Junctions.png	mqc_rseqc_junction_saturation_plot_All_Junctions.png	35118	263219906	\N	f	2022-09-27 09:32:29.218+00
1357	21	1139	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/png/mqc_rseqc_junction_saturation_plot_Known_Junctions.png	mqc_rseqc_junction_saturation_plot_Known_Junctions.png	35135	-828858173	\N	f	2022-09-27 09:32:29.214+00
1358	21	1139	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/png/mqc_rseqc_junction_saturation_plot_Novel_Junctions.png	mqc_rseqc_junction_saturation_plot_Novel_Junctions.png	32862	1987555533	\N	f	2022-09-27 09:32:29.222+00
1359	21	1139	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/png/mqc_rseqc_read_distribution_plot_1.png	mqc_rseqc_read_distribution_plot_1.png	15318	1857092273	\N	f	2022-09-27 09:32:29.214+00
1360	21	1139	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/png/mqc_rseqc_read_distribution_plot_1_pc.png	mqc_rseqc_read_distribution_plot_1_pc.png	15696	1140341553	\N	f	2022-09-27 09:32:29.218+00
1361	21	1139	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/png/mqc_rseqc_read_dups_plot_1.png	mqc_rseqc_read_dups_plot_1.png	20051	-359533809	\N	f	2022-09-27 09:32:29.218+00
1362	21	1139	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/png/mqc_samtools-idxstats-mapped-reads-plot_Normalised_Counts.png	mqc_samtools-idxstats-mapped-reads-plot_Normalised_Counts.png	44872	-1808222030	\N	f	2022-09-27 09:32:29.214+00
1363	21	1139	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/png/mqc_samtools-idxstats-mapped-reads-plot_Observed_over_Expected_Counts.png	mqc_samtools-idxstats-mapped-reads-plot_Observed_over_Expected_Counts.png	37051	-1494446848	\N	f	2022-09-27 09:32:29.214+00
1364	21	1139	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/png/mqc_samtools-idxstats-mapped-reads-plot_Raw_Counts.png	mqc_samtools-idxstats-mapped-reads-plot_Raw_Counts.png	47224	-1981908033	\N	f	2022-09-27 09:32:29.218+00
1365	21	1139	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/png/mqc_samtools_alignment_plot_1.png	mqc_samtools_alignment_plot_1.png	8040	1611429943	\N	f	2022-09-27 09:32:29.218+00
1366	21	1139	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/png/mqc_samtools_alignment_plot_1_pc.png	mqc_samtools_alignment_plot_1_pc.png	8549	-1286016841	\N	f	2022-09-27 09:32:29.214+00
1367	21	1139	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/png/mqc_star_alignment_plot_1.png	mqc_star_alignment_plot_1.png	11156	1579676317	\N	f	2022-09-27 09:32:29.222+00
1368	21	1139	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/png/mqc_star_alignment_plot_1_pc.png	mqc_star_alignment_plot_1_pc.png	11860	-51059053	\N	f	2022-09-27 09:32:29.218+00
1369	21	1140	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/svg/mqc_cutadapt_filtered_reads_plot_1.svg	mqc_cutadapt_filtered_reads_plot_1.svg	24690	1784994694	\N	f	2022-09-27 09:32:29.206+00
1370	21	1140	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/svg/mqc_cutadapt_filtered_reads_plot_1_pc.svg	mqc_cutadapt_filtered_reads_plot_1_pc.svg	23782	886923198	\N	f	2022-09-27 09:32:29.206+00
1371	21	1140	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/svg/mqc_cutadapt_trimmed_sequences_plot_3_Counts.svg	mqc_cutadapt_trimmed_sequences_plot_3_Counts.svg	44356	1549632398	\N	f	2022-09-27 09:32:29.214+00
1372	21	1140	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/svg/mqc_cutadapt_trimmed_sequences_plot_3_Obs_Exp.svg	mqc_cutadapt_trimmed_sequences_plot_3_Obs_Exp.svg	44203	-1919848135	\N	f	2022-09-27 09:32:29.214+00
1701	30	1699	original/upload/S3R3_2.fq.gz	S3R3_2.fq.gz	903838962	346497129	\N	f	2022-09-27 12:30:23.988+00
1373	21	1140	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/svg/mqc_fastqc_adapter_content_plot_1.svg	mqc_fastqc_adapter_content_plot_1.svg	35201	376002889	\N	f	2022-09-27 09:32:29.206+00
1374	21	1140	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/svg/mqc_fastqc_per_base_n_content_plot-2_1.svg	mqc_fastqc_per_base_n_content_plot-2_1.svg	33995	-534434743	\N	f	2022-09-27 09:32:29.206+00
1375	21	1140	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/svg/mqc_fastqc_per_base_n_content_plot_1.svg	mqc_fastqc_per_base_n_content_plot_1.svg	34002	1859642054	\N	f	2022-09-27 09:32:29.21+00
1376	21	1140	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/svg/mqc_fastqc_per_base_sequence_quality_plot-2_1.svg	mqc_fastqc_per_base_sequence_quality_plot-2_1.svg	33861	-160769862	\N	f	2022-09-27 09:32:29.214+00
1377	21	1140	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/svg/mqc_fastqc_per_base_sequence_quality_plot_1.svg	mqc_fastqc_per_base_sequence_quality_plot_1.svg	33867	-74212592	\N	f	2022-09-27 09:32:29.21+00
1378	21	1140	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/svg/mqc_fastqc_per_sequence_gc_content_plot-2_Counts.svg	mqc_fastqc_per_sequence_gc_content_plot-2_Counts.svg	40190	1747537411	\N	f	2022-09-27 09:32:29.21+00
1379	21	1140	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/svg/mqc_fastqc_per_sequence_gc_content_plot-2_Percentages.svg	mqc_fastqc_per_sequence_gc_content_plot-2_Percentages.svg	38579	1696593787	\N	f	2022-09-27 09:32:29.206+00
1380	21	1140	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/svg/mqc_fastqc_per_sequence_gc_content_plot_Counts.svg	mqc_fastqc_per_sequence_gc_content_plot_Counts.svg	40158	-1422309679	\N	f	2022-09-27 09:32:29.214+00
1381	21	1140	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/svg/mqc_fastqc_per_sequence_gc_content_plot_Percentages.svg	mqc_fastqc_per_sequence_gc_content_plot_Percentages.svg	38560	-438603510	\N	f	2022-09-27 09:32:29.21+00
1382	21	1140	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/svg/mqc_fastqc_per_sequence_quality_scores_plot-2_1.svg	mqc_fastqc_per_sequence_quality_scores_plot-2_1.svg	35286	2124438580	\N	f	2022-09-27 09:32:29.21+00
1383	21	1140	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/svg/mqc_fastqc_per_sequence_quality_scores_plot_1.svg	mqc_fastqc_per_sequence_quality_scores_plot_1.svg	36029	-1380660436	\N	f	2022-09-27 09:32:29.214+00
1384	21	1140	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/svg/mqc_fastqc_sequence_counts_plot-2_1.svg	mqc_fastqc_sequence_counts_plot-2_1.svg	29360	-1180456145	\N	f	2022-09-27 09:32:29.21+00
1385	21	1140	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/svg/mqc_fastqc_sequence_counts_plot-2_1_pc.svg	mqc_fastqc_sequence_counts_plot-2_1_pc.svg	28452	-1630534198	\N	f	2022-09-27 09:32:29.21+00
1386	21	1140	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/svg/mqc_fastqc_sequence_counts_plot_1.svg	mqc_fastqc_sequence_counts_plot_1.svg	29352	214974986	\N	f	2022-09-27 09:32:29.21+00
1387	21	1140	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/svg/mqc_fastqc_sequence_counts_plot_1_pc.svg	mqc_fastqc_sequence_counts_plot_1_pc.svg	28448	1993500478	\N	f	2022-09-27 09:32:29.214+00
1388	21	1140	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/svg/mqc_fastqc_sequence_duplication_levels_plot-2_1.svg	mqc_fastqc_sequence_duplication_levels_plot-2_1.svg	37098	-1184722862	\N	f	2022-09-27 09:32:29.21+00
1389	21	1140	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/svg/mqc_fastqc_sequence_duplication_levels_plot_1.svg	mqc_fastqc_sequence_duplication_levels_plot_1.svg	37102	1305682459	\N	f	2022-09-27 09:32:29.206+00
1390	21	1140	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/svg/mqc_fastqc_sequence_length_distribution_plot_1.svg	mqc_fastqc_sequence_length_distribution_plot_1.svg	34450	-1000864779	\N	f	2022-09-27 09:32:29.214+00
1391	21	1140	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/svg/mqc_featurecounts_biotype_plot_1.svg	mqc_featurecounts_biotype_plot_1.svg	27123	1189740902	\N	f	2022-09-27 09:32:29.206+00
1392	21	1140	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/svg/mqc_featurecounts_biotype_plot_1_pc.svg	mqc_featurecounts_biotype_plot_1_pc.svg	27253	-234208361	\N	f	2022-09-27 09:32:29.21+00
1393	21	1140	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/svg/mqc_mqc_mplplot_ksbuxlnfvp_1.svg	mqc_mqc_mplplot_ksbuxlnfvp_1.svg	27185	-135307723	\N	f	2022-09-27 09:32:29.21+00
1394	21	1140	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/svg/mqc_picard_deduplication_1.svg	mqc_picard_deduplication_1.svg	28447	2108355138	\N	f	2022-09-27 09:32:29.206+00
1395	21	1140	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/svg/mqc_picard_deduplication_1_pc.svg	mqc_picard_deduplication_1_pc.svg	28456	529595455	\N	f	2022-09-27 09:32:29.21+00
1396	21	1140	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/svg/mqc_preseq_plot_1.svg	mqc_preseq_plot_1.svg	35845	-398004181	\N	f	2022-09-27 09:32:29.21+00
1397	21	1140	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/svg/mqc_qualimap_gene_coverage_profile_Counts.svg	mqc_qualimap_gene_coverage_profile_Counts.svg	35561	566921661	\N	f	2022-09-27 09:32:29.214+00
1398	21	1140	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/svg/mqc_qualimap_gene_coverage_profile_Normalised.svg	mqc_qualimap_gene_coverage_profile_Normalised.svg	37096	-68468111	\N	f	2022-09-27 09:32:29.21+00
1399	21	1140	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/svg/mqc_qualimap_genomic_origin_1.svg	mqc_qualimap_genomic_origin_1.svg	27409	-2143769182	\N	f	2022-09-27 09:32:29.214+00
1400	21	1140	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/svg/mqc_qualimap_genomic_origin_1_pc.svg	mqc_qualimap_genomic_origin_1_pc.svg	27424	-655333989	\N	f	2022-09-27 09:32:29.214+00
1401	21	1140	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/svg/mqc_rseqc_infer_experiment_plot_1.svg	mqc_rseqc_infer_experiment_plot_1.svg	24524	-1405136774	\N	f	2022-09-27 09:32:29.21+00
1702	31	\N		20220927123744843-144	64759986	\N	\N	t	2022-09-27 12:37:45.324+00
1402	21	1140	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/svg/mqc_rseqc_inner_distance_plot_Counts.svg	mqc_rseqc_inner_distance_plot_Counts.svg	28593	-1456593100	\N	f	2022-09-27 09:32:29.21+00
1403	21	1140	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/svg/mqc_rseqc_inner_distance_plot_Percentages.svg	mqc_rseqc_inner_distance_plot_Percentages.svg	28406	389624116	\N	f	2022-09-27 09:32:29.21+00
1404	21	1140	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/svg/mqc_rseqc_junction_annotation_junctions_plot_Events.svg	mqc_rseqc_junction_annotation_junctions_plot_Events.svg	29229	165233793	\N	f	2022-09-27 09:32:29.21+00
1405	21	1140	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/svg/mqc_rseqc_junction_annotation_junctions_plot_Events_pc.svg	mqc_rseqc_junction_annotation_junctions_plot_Events_pc.svg	28750	484593730	\N	f	2022-09-27 09:32:29.21+00
1406	21	1140	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/svg/mqc_rseqc_junction_annotation_junctions_plot_Junctions.svg	mqc_rseqc_junction_annotation_junctions_plot_Junctions.svg	31328	2024930988	\N	f	2022-09-27 09:32:29.214+00
1407	21	1140	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/svg/mqc_rseqc_junction_annotation_junctions_plot_Junctions_pc.svg	mqc_rseqc_junction_annotation_junctions_plot_Junctions_pc.svg	29054	1232591970	\N	f	2022-09-27 09:32:29.21+00
1408	21	1140	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/svg/mqc_rseqc_junction_saturation_plot_All_Junctions.svg	mqc_rseqc_junction_saturation_plot_All_Junctions.svg	29455	394677373	\N	f	2022-09-27 09:32:29.21+00
1409	21	1140	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/svg/mqc_rseqc_junction_saturation_plot_Known_Junctions.svg	mqc_rseqc_junction_saturation_plot_Known_Junctions.svg	29452	920221198	\N	f	2022-09-27 09:32:29.214+00
1410	21	1140	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/svg/mqc_rseqc_junction_saturation_plot_Novel_Junctions.svg	mqc_rseqc_junction_saturation_plot_Novel_Junctions.svg	28186	1831952383	\N	f	2022-09-27 09:32:29.21+00
1411	21	1140	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/svg/mqc_rseqc_read_distribution_plot_1.svg	mqc_rseqc_read_distribution_plot_1.svg	41151	958388645	\N	f	2022-09-27 09:32:29.214+00
1412	21	1140	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/svg/mqc_rseqc_read_distribution_plot_1_pc.svg	mqc_rseqc_read_distribution_plot_1_pc.svg	41157	-1298431656	\N	f	2022-09-27 09:32:29.21+00
1413	21	1140	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/svg/mqc_rseqc_read_dups_plot_1.svg	mqc_rseqc_read_dups_plot_1.svg	31428	666674638	\N	f	2022-09-27 09:32:29.214+00
1414	21	1140	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/svg/mqc_samtools-idxstats-mapped-reads-plot_Normalised_Counts.svg	mqc_samtools-idxstats-mapped-reads-plot_Normalised_Counts.svg	31957	1579486319	\N	f	2022-09-27 09:32:29.21+00
1415	21	1140	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/svg/mqc_samtools-idxstats-mapped-reads-plot_Observed_over_Expected_Counts.svg	mqc_samtools-idxstats-mapped-reads-plot_Observed_over_Expected_Counts.svg	35195	1273882816	\N	f	2022-09-27 09:32:29.21+00
1416	21	1140	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/svg/mqc_samtools-idxstats-mapped-reads-plot_Raw_Counts.svg	mqc_samtools-idxstats-mapped-reads-plot_Raw_Counts.svg	33137	1215326933	\N	f	2022-09-27 09:32:29.21+00
1417	21	1140	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/svg/mqc_samtools_alignment_plot_1.svg	mqc_samtools_alignment_plot_1.svg	22456	1650790273	\N	f	2022-09-27 09:32:29.214+00
1418	21	1140	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/svg/mqc_samtools_alignment_plot_1_pc.svg	mqc_samtools_alignment_plot_1_pc.svg	22469	928202588	\N	f	2022-09-27 09:32:29.214+00
1419	21	1140	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/svg/mqc_star_alignment_plot_1.svg	mqc_star_alignment_plot_1.svg	31881	-1098426897	\N	f	2022-09-27 09:32:29.21+00
1420	21	1140	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_plots/svg/mqc_star_alignment_plot_1_pc.svg	mqc_star_alignment_plot_1_pc.svg	30979	1077992058	\N	f	2022-09-27 09:32:29.21+00
1421	21	1135	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/multiqc/star_salmon/multiqc_report.html	multiqc_report.html	1489909	-973424844	\N	f	2022-09-27 09:32:29.206+00
1422	21	1141	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/pipeline_info/execution_report_2022-09-16_12-13-52.html	execution_report_2022-09-16_12-13-52.html	3235144	359771005	\N	f	2022-09-27 09:32:28.53+00
1423	21	1141	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/pipeline_info/execution_timeline_2022-09-16_12-13-52.html	execution_timeline_2022-09-16_12-13-52.html	277030	500664260	\N	f	2022-09-27 09:32:28.534+00
1424	21	1141	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/pipeline_info/execution_trace_2022-09-16_12-13-52.txt	execution_trace_2022-09-16_12-13-52.txt	13601	-1292555991	\N	f	2022-09-27 09:32:28.53+00
1425	21	1141	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/pipeline_info/pipeline_dag_2022-09-16_12-13-52.html	pipeline_dag_2022-09-16_12-13-52.html	65918	-199815327	\N	f	2022-09-27 09:32:28.534+00
1426	21	1141	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/pipeline_info/samplesheet.valid.csv	samplesheet.valid.csv	253	744357876	\N	f	2022-09-27 09:32:28.53+00
1427	21	1141	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/pipeline_info/software_versions.yml	software_versions.yml	1640	286666980	\N	f	2022-09-27 09:32:28.53+00
1428	21	1143	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/bigwig/mutant.forward.bigWig	mutant.forward.bigWig	6465625	440845101	\N	f	2022-09-27 09:32:29.158+00
1429	21	1143	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/bigwig/mutant.reverse.bigWig	mutant.reverse.bigWig	6469366	627016806	\N	f	2022-09-27 09:32:29.146+00
1430	21	1143	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/bigwig/wildtype.forward.bigWig	wildtype.forward.bigWig	5492187	-1993882982	\N	f	2022-09-27 09:32:29.15+00
1431	21	1143	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/bigwig/wildtype.reverse.bigWig	wildtype.reverse.bigWig	5496001	1729640232	\N	f	2022-09-27 09:32:29.138+00
1432	21	1144	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/deseq2_qc/R_sessionInfo.log	R_sessionInfo.log	2006	-395270275	\N	f	2022-09-27 09:32:29.206+00
1433	21	1144	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/deseq2_qc/deseq2.dds.RData	deseq2.dds.RData	554950	-700231147	\N	f	2022-09-27 09:32:29.206+00
1434	21	1144	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/deseq2_qc/deseq2.pca.vals.txt	deseq2.pca.vals.txt	173	1214581152	\N	f	2022-09-27 09:32:29.206+00
1435	21	1144	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/deseq2_qc/deseq2.plots.pdf	deseq2.plots.pdf	8686	-1260798983	\N	f	2022-09-27 09:32:29.206+00
1436	21	1144	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/deseq2_qc/deseq2.sample.dists.txt	deseq2.sample.dists.txt	103	1335821886	\N	f	2022-09-27 09:32:29.206+00
1437	21	1145	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/deseq2_qc/size_factors/deseq2.size_factors.RData	deseq2.size_factors.RData	166	741615304	\N	f	2022-09-27 09:32:29.206+00
1438	21	1145	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/deseq2_qc/size_factors/mutant.txt	mutant.txt	37	-1604375521	\N	f	2022-09-27 09:32:29.206+00
1439	21	1145	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/deseq2_qc/size_factors/wildtype.txt	wildtype.txt	38	-618541197	\N	f	2022-09-27 09:32:29.206+00
1440	21	1147	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/dupradar/box_plot/mutant_duprateExpBoxplot.pdf	mutant_duprateExpBoxplot.pdf	11360	-1959712415	\N	f	2022-09-27 09:32:29.174+00
1441	21	1147	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/dupradar/box_plot/wildtype_duprateExpBoxplot.pdf	wildtype_duprateExpBoxplot.pdf	15878	-2135304542	\N	f	2022-09-27 09:32:29.174+00
1442	21	1148	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/dupradar/gene_data/mutant_dupMatrix.txt	mutant_dupMatrix.txt	2646907	-188870978	\N	f	2022-09-27 09:32:29.17+00
1443	21	1148	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/dupradar/gene_data/wildtype_dupMatrix.txt	wildtype_dupMatrix.txt	2652677	352298641	\N	f	2022-09-27 09:32:29.17+00
1444	21	1149	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/dupradar/histogram/mutant_expressionHist.pdf	mutant_expressionHist.pdf	5244	54960713	\N	f	2022-09-27 09:32:29.17+00
1445	21	1149	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/dupradar/histogram/wildtype_expressionHist.pdf	wildtype_expressionHist.pdf	5327	881909086	\N	f	2022-09-27 09:32:29.17+00
1446	21	1150	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/dupradar/intercepts_slope/mutant_intercept_slope.txt	mutant_intercept_slope.txt	178	-314116543	\N	f	2022-09-27 09:32:29.174+00
1447	21	1150	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/dupradar/intercepts_slope/wildtype_intercept_slope.txt	wildtype_intercept_slope.txt	182	-1654609024	\N	f	2022-09-27 09:32:29.174+00
1448	21	1151	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/dupradar/scatter_plot/mutant_duprateExpDens.pdf	mutant_duprateExpDens.pdf	936758	-1654940330	\N	f	2022-09-27 09:32:29.174+00
1449	21	1151	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/dupradar/scatter_plot/wildtype_duprateExpDens.pdf	wildtype_duprateExpDens.pdf	933162	-1670494576	\N	f	2022-09-27 09:32:29.174+00
1450	21	1152	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/featurecounts/mutant.biotype_counts_mqc.tsv	mutant.biotype_counts_mqc.tsv	537	486252431	\N	f	2022-09-27 09:32:28.69+00
1451	21	1152	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/featurecounts/mutant.biotype_counts_rrna_mqc.tsv	mutant.biotype_counts_rrna_mqc.tsv	361	-658124085	\N	f	2022-09-27 09:32:28.686+00
1452	21	1152	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/featurecounts/mutant.featureCounts.txt	mutant.featureCounts.txt	10066308	-1000060263	\N	f	2022-09-27 09:32:28.686+00
1453	21	1152	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/featurecounts/mutant.featureCounts.txt.summary	mutant.featureCounts.txt.summary	408	187050344	\N	f	2022-09-27 09:32:28.69+00
1454	21	1152	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/featurecounts/wildtype.biotype_counts_mqc.tsv	wildtype.biotype_counts_mqc.tsv	537	-277703731	\N	f	2022-09-27 09:32:28.678+00
1455	21	1152	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/featurecounts/wildtype.biotype_counts_rrna_mqc.tsv	wildtype.biotype_counts_rrna_mqc.tsv	363	-1105245943	\N	f	2022-09-27 09:32:28.678+00
1456	21	1152	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/featurecounts/wildtype.featureCounts.txt	wildtype.featureCounts.txt	10066314	-1647612575	\N	f	2022-09-27 09:32:28.674+00
1457	21	1152	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/featurecounts/wildtype.featureCounts.txt.summary	wildtype.featureCounts.txt.summary	411	-174082941	\N	f	2022-09-27 09:32:28.678+00
1458	21	1153	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/log/mutant.Log.final.out	mutant.Log.final.out	2032	1946703113	\N	f	2022-09-27 09:32:29.158+00
1459	21	1153	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/log/mutant.Log.out	mutant.Log.out	10557	1070854037	\N	f	2022-09-27 09:32:29.158+00
1460	21	1153	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/log/mutant.Log.progress.out	mutant.Log.progress.out	475	321604654	\N	f	2022-09-27 09:32:29.162+00
1461	21	1153	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/log/mutant.SJ.out.tab	mutant.SJ.out.tab	3112713	-957231242	\N	f	2022-09-27 09:32:29.162+00
1462	21	1153	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/log/wildtype.Log.final.out	wildtype.Log.final.out	2036	-1378956271	\N	f	2022-09-27 09:32:29.162+00
1463	21	1153	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/log/wildtype.Log.out	wildtype.Log.out	10637	-809736011	\N	f	2022-09-27 09:32:29.158+00
1464	21	1153	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/log/wildtype.Log.progress.out	wildtype.Log.progress.out	475	-1042060439	\N	f	2022-09-27 09:32:29.162+00
1465	21	1153	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/log/wildtype.SJ.out.tab	wildtype.SJ.out.tab	2914467	-56873526	\N	f	2022-09-27 09:32:29.166+00
1466	21	1155	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/mutant/aux_info/ambig_info.tsv	ambig_info.tsv	252855	1559561002	\N	f	2022-09-27 09:32:29.186+00
1467	21	1155	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/mutant/aux_info/expected_bias.gz	expected_bias.gz	117	-1915792985	\N	f	2022-09-27 09:32:29.186+00
1468	21	1155	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/mutant/aux_info/fld.gz	fld.gz	474	-1475782615	\N	f	2022-09-27 09:32:29.186+00
1703	31	1702	original	original	64759986	\N	\N	t	2022-09-27 12:37:44.956+00
1469	21	1155	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/mutant/aux_info/meta_info.json	meta_info.json	1305	-438883453	\N	f	2022-09-27 09:32:29.186+00
1470	21	1155	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/mutant/aux_info/observed_bias.gz	observed_bias.gz	82	-1395782294	\N	f	2022-09-27 09:32:29.186+00
1471	21	1155	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/mutant/aux_info/observed_bias_3p.gz	observed_bias_3p.gz	82	242801513	\N	f	2022-09-27 09:32:29.186+00
1472	21	1154	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/mutant/cmd_info.json	cmd_info.json	279	1527899354	\N	f	2022-09-27 09:32:29.182+00
1473	21	1156	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/mutant/libParams/flenDist.txt	flenDist.txt	11762	-307721672	\N	f	2022-09-27 09:32:29.186+00
1474	21	1154	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/mutant/quant.genes.sf	quant.genes.sf	1984054	-700285651	\N	f	2022-09-27 09:32:29.182+00
1475	21	1154	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/mutant/quant.sf	quant.sf	2584982	481721109	\N	f	2022-09-27 09:32:29.186+00
1476	21	1142	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/mutant.markdup.sorted.bam	mutant.markdup.sorted.bam	123615116	1934164048	\N	f	2022-09-27 09:32:28.65+00
1477	21	1142	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/mutant.markdup.sorted.bam.bai	mutant.markdup.sorted.bam.bai	109736	175996451	\N	f	2022-09-27 09:32:28.666+00
1478	21	1157	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/picard_metrics/mutant.markdup.sorted.MarkDuplicates.metrics.txt	mutant.markdup.sorted.MarkDuplicates.metrics.txt	3408	-70215529	\N	f	2022-09-27 09:32:28.666+00
1479	21	1157	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/picard_metrics/wildtype.markdup.sorted.MarkDuplicates.metrics.txt	wildtype.markdup.sorted.MarkDuplicates.metrics.txt	3442	-1804284628	\N	f	2022-09-27 09:32:28.666+00
1480	21	1159	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/preseq/log/mutant.command.log	mutant.command.log	553	-73272518	\N	f	2022-09-27 09:32:28.794+00
1481	21	1159	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/preseq/log/wildtype.command.log	wildtype.command.log	680	-1449040157	\N	f	2022-09-27 09:32:28.794+00
1482	21	1158	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/preseq/mutant.lc_extrap.txt	mutant.lc_extrap.txt	488626	-1732500565	\N	f	2022-09-27 09:32:28.794+00
1483	21	1158	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/preseq/wildtype.lc_extrap.txt	wildtype.lc_extrap.txt	468945	-1603131292	\N	f	2022-09-27 09:32:28.794+00
1484	21	1162	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/qualimap/mutant/css/agogo.css	agogo.css	7158	80960622	\N	f	2022-09-27 09:32:29.198+00
1485	21	1162	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/qualimap/mutant/css/ajax-loader.gif	ajax-loader.gif	701	970458942	\N	f	2022-09-27 09:32:29.198+00
1486	21	1162	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/qualimap/mutant/css/basic.css	basic.css	8489	629599937	\N	f	2022-09-27 09:32:29.198+00
1487	21	1162	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/qualimap/mutant/css/bgfooter.png	bgfooter.png	462	-419193038	\N	f	2022-09-27 09:32:29.198+00
1488	21	1162	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/qualimap/mutant/css/bgtop.png	bgtop.png	458	982620120	\N	f	2022-09-27 09:32:29.198+00
1489	21	1162	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/qualimap/mutant/css/comment-bright.png	comment-bright.png	3528	691224031	\N	f	2022-09-27 09:32:29.198+00
1490	21	1162	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/qualimap/mutant/css/comment-close.png	comment-close.png	3606	-1566454948	\N	f	2022-09-27 09:32:29.198+00
1491	21	1162	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/qualimap/mutant/css/comment.png	comment.png	3473	-1323529081	\N	f	2022-09-27 09:32:29.198+00
1492	21	1162	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/qualimap/mutant/css/doctools.js	doctools.js	6868	-1634646783	\N	f	2022-09-27 09:32:29.198+00
1493	21	1162	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/qualimap/mutant/css/down-pressed.png	down-pressed.png	396	-1173398330	\N	f	2022-09-27 09:32:29.198+00
1494	21	1162	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/qualimap/mutant/css/down.png	down.png	391	-1686729361	\N	f	2022-09-27 09:32:29.198+00
1495	21	1162	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/qualimap/mutant/css/file.png	file.png	420	-1274949961	\N	f	2022-09-27 09:32:29.198+00
1496	21	1162	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/qualimap/mutant/css/jquery.js	jquery.js	72230	732225299	\N	f	2022-09-27 09:32:29.198+00
1497	21	1162	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/qualimap/mutant/css/minus.png	minus.png	227	-78421646	\N	f	2022-09-27 09:32:29.198+00
1498	21	1162	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/qualimap/mutant/css/plus.png	plus.png	227	-1147098190	\N	f	2022-09-27 09:32:29.198+00
1499	21	1162	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/qualimap/mutant/css/pygments.css	pygments.css	3960	-1646335182	\N	f	2022-09-27 09:32:29.198+00
1500	21	1162	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/qualimap/mutant/css/qualimap_logo_small.png	qualimap_logo_small.png	2950	-772989721	\N	f	2022-09-27 09:32:29.198+00
1501	21	1162	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/qualimap/mutant/css/report.css	report.css	636	-1838891742	\N	f	2022-09-27 09:32:29.198+00
1502	21	1162	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/qualimap/mutant/css/searchtools.js	searchtools.js	16071	-855730289	\N	f	2022-09-27 09:32:29.198+00
1503	21	1162	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/qualimap/mutant/css/underscore.js	underscore.js	8602	-954454649	\N	f	2022-09-27 09:32:29.198+00
1504	21	1162	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/qualimap/mutant/css/up-pressed.png	up-pressed.png	400	-1306745931	\N	f	2022-09-27 09:32:29.198+00
1505	21	1162	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/qualimap/mutant/css/up.png	up.png	391	-367032288	\N	f	2022-09-27 09:32:29.198+00
1506	21	1162	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/qualimap/mutant/css/websupport.js	websupport.js	25274	-1021426057	\N	f	2022-09-27 09:32:29.198+00
1704	31	1703	original/annotation.gff	annotation.gff	64759986	1421088022	\N	f	2022-09-27 12:37:44.804+00
1507	21	1163	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/qualimap/mutant/images_qualimapReport/Coverage Profile Along Genes (High).png	Coverage Profile Along Genes (High).png	50703	557377496	\N	f	2022-09-27 09:32:29.198+00
1508	21	1163	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/qualimap/mutant/images_qualimapReport/Coverage Profile Along Genes (Low).png	Coverage Profile Along Genes (Low).png	75915	8665080	\N	f	2022-09-27 09:32:29.198+00
1509	21	1163	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/qualimap/mutant/images_qualimapReport/Coverage Profile Along Genes (Total).png	Coverage Profile Along Genes (Total).png	52939	1000750042	\N	f	2022-09-27 09:32:29.198+00
1510	21	1163	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/qualimap/mutant/images_qualimapReport/Junction Analysis.png	Junction Analysis.png	36232	265420732	\N	f	2022-09-27 09:32:29.198+00
1511	21	1163	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/qualimap/mutant/images_qualimapReport/Reads Genomic Origin.png	Reads Genomic Origin.png	34899	1946770318	\N	f	2022-09-27 09:32:29.198+00
1512	21	1163	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/qualimap/mutant/images_qualimapReport/Transcript coverage histogram.png	Transcript coverage histogram.png	66162	1169055798	\N	f	2022-09-27 09:32:29.198+00
1513	21	1161	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/qualimap/mutant/qualimapReport.html	qualimapReport.html	11585	1175090646	\N	f	2022-09-27 09:32:29.198+00
1514	21	1164	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/qualimap/mutant/raw_data_qualimapReport/coverage_profile_along_genes_(high).txt	coverage_profile_along_genes_(high).txt	2358	-899728832	\N	f	2022-09-27 09:32:29.202+00
1515	21	1164	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/qualimap/mutant/raw_data_qualimapReport/coverage_profile_along_genes_(low).txt	coverage_profile_along_genes_(low).txt	2517	-1444515680	\N	f	2022-09-27 09:32:29.202+00
1516	21	1164	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/qualimap/mutant/raw_data_qualimapReport/coverage_profile_along_genes_(total).txt	coverage_profile_along_genes_(total).txt	2430	-112973608	\N	f	2022-09-27 09:32:29.202+00
1517	21	1161	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/qualimap/mutant/rnaseq_qc_results.txt	rnaseq_qc_results.txt	1176	1242797915	\N	f	2022-09-27 09:32:29.194+00
1518	21	1166	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/qualimap/wildtype/css/agogo.css	agogo.css	7158	-787691684	\N	f	2022-09-27 09:32:29.194+00
1519	21	1166	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/qualimap/wildtype/css/ajax-loader.gif	ajax-loader.gif	701	-794462894	\N	f	2022-09-27 09:32:29.194+00
1520	21	1166	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/qualimap/wildtype/css/basic.css	basic.css	8489	-1264435118	\N	f	2022-09-27 09:32:29.194+00
1521	21	1166	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/qualimap/wildtype/css/bgfooter.png	bgfooter.png	462	-1569683923	\N	f	2022-09-27 09:32:29.194+00
1522	21	1166	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/qualimap/wildtype/css/bgtop.png	bgtop.png	458	-708556243	\N	f	2022-09-27 09:32:29.194+00
1523	21	1166	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/qualimap/wildtype/css/comment-bright.png	comment-bright.png	3528	-1388247534	\N	f	2022-09-27 09:32:29.194+00
1524	21	1166	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/qualimap/wildtype/css/comment-close.png	comment-close.png	3606	601893997	\N	f	2022-09-27 09:32:29.194+00
1525	21	1166	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/qualimap/wildtype/css/comment.png	comment.png	3473	758022197	\N	f	2022-09-27 09:32:29.194+00
1526	21	1166	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/qualimap/wildtype/css/doctools.js	doctools.js	6868	-452941203	\N	f	2022-09-27 09:32:29.194+00
1527	21	1166	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/qualimap/wildtype/css/down-pressed.png	down-pressed.png	396	833033287	\N	f	2022-09-27 09:32:29.194+00
1528	21	1166	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/qualimap/wildtype/css/down.png	down.png	391	175781223	\N	f	2022-09-27 09:32:29.194+00
1529	21	1166	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/qualimap/wildtype/css/file.png	file.png	420	-1884406867	\N	f	2022-09-27 09:32:29.194+00
1530	21	1166	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/qualimap/wildtype/css/jquery.js	jquery.js	72230	-1360357678	\N	f	2022-09-27 09:32:29.194+00
1531	21	1166	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/qualimap/wildtype/css/minus.png	minus.png	227	-1791492791	\N	f	2022-09-27 09:32:29.194+00
1532	21	1166	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/qualimap/wildtype/css/plus.png	plus.png	227	177888552	\N	f	2022-09-27 09:32:29.194+00
1533	21	1166	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/qualimap/wildtype/css/pygments.css	pygments.css	3960	41199441	\N	f	2022-09-27 09:32:29.194+00
1534	21	1166	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/qualimap/wildtype/css/qualimap_logo_small.png	qualimap_logo_small.png	2950	-2110098966	\N	f	2022-09-27 09:32:29.194+00
1535	21	1166	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/qualimap/wildtype/css/report.css	report.css	636	-974760798	\N	f	2022-09-27 09:32:29.194+00
1536	21	1166	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/qualimap/wildtype/css/searchtools.js	searchtools.js	16071	99639937	\N	f	2022-09-27 09:32:29.194+00
1537	21	1166	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/qualimap/wildtype/css/underscore.js	underscore.js	8602	-403104960	\N	f	2022-09-27 09:32:29.194+00
1538	21	1166	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/qualimap/wildtype/css/up-pressed.png	up-pressed.png	400	-1584156042	\N	f	2022-09-27 09:32:29.194+00
1539	21	1166	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/qualimap/wildtype/css/up.png	up.png	391	-1597480191	\N	f	2022-09-27 09:32:29.194+00
1540	21	1166	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/qualimap/wildtype/css/websupport.js	websupport.js	25274	-415918126	\N	f	2022-09-27 09:32:29.194+00
1541	21	1167	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/qualimap/wildtype/images_qualimapReport/Coverage Profile Along Genes (High).png	Coverage Profile Along Genes (High).png	50620	748447998	\N	f	2022-09-27 09:32:29.194+00
1705	32	\N		20220927123746366-145	392536877	\N	\N	t	2022-09-27 12:37:46.824+00
1542	21	1167	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/qualimap/wildtype/images_qualimapReport/Coverage Profile Along Genes (Low).png	Coverage Profile Along Genes (Low).png	79191	-1157969318	\N	f	2022-09-27 09:32:29.19+00
1543	21	1167	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/qualimap/wildtype/images_qualimapReport/Coverage Profile Along Genes (Total).png	Coverage Profile Along Genes (Total).png	52115	1138879603	\N	f	2022-09-27 09:32:29.194+00
1544	21	1167	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/qualimap/wildtype/images_qualimapReport/Junction Analysis.png	Junction Analysis.png	35244	-985152732	\N	f	2022-09-27 09:32:29.194+00
1545	21	1167	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/qualimap/wildtype/images_qualimapReport/Reads Genomic Origin.png	Reads Genomic Origin.png	37519	257991816	\N	f	2022-09-27 09:32:29.19+00
1546	21	1167	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/qualimap/wildtype/images_qualimapReport/Transcript coverage histogram.png	Transcript coverage histogram.png	57424	1714309249	\N	f	2022-09-27 09:32:29.19+00
1547	21	1165	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/qualimap/wildtype/qualimapReport.html	qualimapReport.html	11587	-2055386302	\N	f	2022-09-27 09:32:29.194+00
1548	21	1168	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/qualimap/wildtype/raw_data_qualimapReport/coverage_profile_along_genes_(high).txt	coverage_profile_along_genes_(high).txt	2364	-1071251082	\N	f	2022-09-27 09:32:29.194+00
1549	21	1168	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/qualimap/wildtype/raw_data_qualimapReport/coverage_profile_along_genes_(low).txt	coverage_profile_along_genes_(low).txt	2525	-985816375	\N	f	2022-09-27 09:32:29.194+00
1550	21	1168	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/qualimap/wildtype/raw_data_qualimapReport/coverage_profile_along_genes_(total).txt	coverage_profile_along_genes_(total).txt	2437	1684325544	\N	f	2022-09-27 09:32:29.194+00
1551	21	1165	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/qualimap/wildtype/rnaseq_qc_results.txt	rnaseq_qc_results.txt	1178	1080183602	\N	f	2022-09-27 09:32:29.19+00
1552	21	1170	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/rseqc/bam_stat/mutant.bam_stat.txt	mutant.bam_stat.txt	856	-756878498	\N	f	2022-09-27 09:32:28.85+00
1553	21	1170	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/rseqc/bam_stat/wildtype.bam_stat.txt	wildtype.bam_stat.txt	855	-2039887394	\N	f	2022-09-27 09:32:28.85+00
1554	21	1171	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/rseqc/infer_experiment/mutant.infer_experiment.txt	mutant.infer_experiment.txt	211	1696108703	\N	f	2022-09-27 09:32:28.902+00
1555	21	1171	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/rseqc/infer_experiment/wildtype.infer_experiment.txt	wildtype.infer_experiment.txt	211	1984035085	\N	f	2022-09-27 09:32:28.902+00
1556	21	1173	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/rseqc/inner_distance/pdf/mutant.inner_distance_plot.pdf	mutant.inner_distance_plot.pdf	8595	1783918387	\N	f	2022-09-27 09:32:28.846+00
1557	21	1173	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/rseqc/inner_distance/pdf/wildtype.inner_distance_plot.pdf	wildtype.inner_distance_plot.pdf	8589	-1243144090	\N	f	2022-09-27 09:32:28.846+00
1558	21	1174	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/rseqc/inner_distance/rscript/mutant.inner_distance_plot.r	mutant.inner_distance_plot.r	1579	-1605590519	\N	f	2022-09-27 09:32:28.846+00
1559	21	1174	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/rseqc/inner_distance/rscript/wildtype.inner_distance_plot.r	wildtype.inner_distance_plot.r	1578	487914140	\N	f	2022-09-27 09:32:28.846+00
1560	21	1175	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/rseqc/inner_distance/txt/mutant.inner_distance.txt	mutant.inner_distance.txt	25865340	-494321059	\N	f	2022-09-27 09:32:28.846+00
1561	21	1175	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/rseqc/inner_distance/txt/mutant.inner_distance_freq.txt	mutant.inner_distance_freq.txt	1268	2117434576	\N	f	2022-09-27 09:32:28.822+00
1562	21	1175	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/rseqc/inner_distance/txt/mutant.inner_distance_mean.txt	mutant.inner_distance_mean.txt	96	2089519303	\N	f	2022-09-27 09:32:28.798+00
1563	21	1175	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/rseqc/inner_distance/txt/wildtype.inner_distance.txt	wildtype.inner_distance.txt	21373849	428159085	\N	f	2022-09-27 09:32:28.818+00
1564	21	1175	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/rseqc/inner_distance/txt/wildtype.inner_distance_freq.txt	wildtype.inner_distance_freq.txt	1263	-915122735	\N	f	2022-09-27 09:32:28.798+00
1565	21	1175	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/rseqc/inner_distance/txt/wildtype.inner_distance_mean.txt	wildtype.inner_distance_mean.txt	98	-1019380822	\N	f	2022-09-27 09:32:28.798+00
1566	21	1177	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/rseqc/junction_annotation/bed/mutant.junction.Interact.bed	mutant.junction.Interact.bed	16060997	-1247203032	\N	f	2022-09-27 09:32:28.878+00
1567	21	1177	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/rseqc/junction_annotation/bed/mutant.junction.bed	mutant.junction.bed	5864284	1024153815	\N	f	2022-09-27 09:32:28.854+00
1568	21	1177	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/rseqc/junction_annotation/bed/wildtype.junction.Interact.bed	wildtype.junction.Interact.bed	15049046	384200862	\N	f	2022-09-27 09:32:28.894+00
1569	21	1177	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/rseqc/junction_annotation/bed/wildtype.junction.bed	wildtype.junction.bed	5498103	432584177	\N	f	2022-09-27 09:32:28.862+00
1570	21	1178	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/rseqc/junction_annotation/log/mutant.junction_annotation.log	mutant.junction_annotation.log	570	1524647967	\N	f	2022-09-27 09:32:28.902+00
1571	21	1178	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/rseqc/junction_annotation/log/wildtype.junction_annotation.log	wildtype.junction_annotation.log	574	1359197262	\N	f	2022-09-27 09:32:28.902+00
1572	21	1179	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/rseqc/junction_annotation/pdf/mutant.splice_events.pdf	mutant.splice_events.pdf	13270	1970097464	\N	f	2022-09-27 09:32:28.902+00
1573	21	1179	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/rseqc/junction_annotation/pdf/mutant.splice_junction.pdf	mutant.splice_junction.pdf	13301	688446556	\N	f	2022-09-27 09:32:28.902+00
1574	21	1179	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/rseqc/junction_annotation/pdf/wildtype.splice_events.pdf	wildtype.splice_events.pdf	13360	-1944983666	\N	f	2022-09-27 09:32:28.902+00
1575	21	1179	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/rseqc/junction_annotation/pdf/wildtype.splice_junction.pdf	wildtype.splice_junction.pdf	13295	-1960988494	\N	f	2022-09-27 09:32:28.902+00
1576	21	1180	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/rseqc/junction_annotation/rscript/mutant.junction_plot.r	mutant.junction_plot.r	583	-1285040346	\N	f	2022-09-27 09:32:28.902+00
1577	21	1180	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/rseqc/junction_annotation/rscript/wildtype.junction_plot.r	wildtype.junction_plot.r	581	-1435463439	\N	f	2022-09-27 09:32:28.902+00
1578	21	1181	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/rseqc/junction_annotation/xls/mutant.junction.xls	mutant.junction.xls	3103125	-376956071	\N	f	2022-09-27 09:32:28.902+00
1579	21	1181	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/rseqc/junction_annotation/xls/wildtype.junction.xls	wildtype.junction.xls	2911792	-324648596	\N	f	2022-09-27 09:32:28.898+00
1580	21	1183	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/rseqc/junction_saturation/pdf/mutant.junctionSaturation_plot.pdf	mutant.junctionSaturation_plot.pdf	5531	1032083173	\N	f	2022-09-27 09:32:28.85+00
1581	21	1183	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/rseqc/junction_saturation/pdf/wildtype.junctionSaturation_plot.pdf	wildtype.junctionSaturation_plot.pdf	5643	1909177039	\N	f	2022-09-27 09:32:28.85+00
1582	21	1184	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/rseqc/junction_saturation/rscript/mutant.junctionSaturation_plot.r	mutant.junctionSaturation_plot.r	820	-1388866949	\N	f	2022-09-27 09:32:28.85+00
1583	21	1184	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/rseqc/junction_saturation/rscript/wildtype.junctionSaturation_plot.r	wildtype.junctionSaturation_plot.r	837	-64532260	\N	f	2022-09-27 09:32:28.85+00
1584	21	1185	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/rseqc/read_distribution/mutant.read_distribution.txt	mutant.read_distribution.txt	1153	-1091626565	\N	f	2022-09-27 09:32:28.846+00
1585	21	1185	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/rseqc/read_distribution/wildtype.read_distribution.txt	wildtype.read_distribution.txt	1153	-1497190749	\N	f	2022-09-27 09:32:28.85+00
1586	21	1187	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/rseqc/read_duplication/pdf/mutant.DupRate_plot.pdf	mutant.DupRate_plot.pdf	5430	1118648231	\N	f	2022-09-27 09:32:28.85+00
1587	21	1187	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/rseqc/read_duplication/pdf/wildtype.DupRate_plot.pdf	wildtype.DupRate_plot.pdf	7475	-2002285277	\N	f	2022-09-27 09:32:28.85+00
1588	21	1188	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/rseqc/read_duplication/rscript/mutant.DupRate_plot.r	mutant.DupRate_plot.r	1142	-313398824	\N	f	2022-09-27 09:32:28.85+00
1589	21	1188	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/rseqc/read_duplication/rscript/wildtype.DupRate_plot.r	wildtype.DupRate_plot.r	2115	140252168	\N	f	2022-09-27 09:32:28.85+00
1590	21	1189	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/rseqc/read_duplication/xls/mutant.pos.DupRate.xls	mutant.pos.DupRate.xls	203	561120119	\N	f	2022-09-27 09:32:28.85+00
1591	21	1189	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/rseqc/read_duplication/xls/mutant.seq.DupRate.xls	mutant.seq.DupRate.xls	169	269263320	\N	f	2022-09-27 09:32:28.85+00
1592	21	1189	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/rseqc/read_duplication/xls/wildtype.pos.DupRate.xls	wildtype.pos.DupRate.xls	707	-1473210017	\N	f	2022-09-27 09:32:28.85+00
1593	21	1189	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/rseqc/read_duplication/xls/wildtype.seq.DupRate.xls	wildtype.seq.DupRate.xls	636	684963762	\N	f	2022-09-27 09:32:28.85+00
1594	21	1142	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/salmon.merged.gene_counts.rds	salmon.merged.gene_counts.rds	819646	1278295187	\N	f	2022-09-27 09:32:28.538+00
1595	21	1142	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/salmon.merged.gene_counts.tsv	salmon.merged.gene_counts.tsv	925921	958130257	\N	f	2022-09-27 09:32:28.798+00
1596	21	1142	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/salmon.merged.gene_counts_length_scaled.rds	salmon.merged.gene_counts_length_scaled.rds	1038808	1122664079	\N	f	2022-09-27 09:32:29.19+00
1597	21	1142	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/salmon.merged.gene_counts_length_scaled.tsv	salmon.merged.gene_counts_length_scaled.tsv	1436278	456842590	\N	f	2022-09-27 09:32:29.202+00
1598	21	1142	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/salmon.merged.gene_counts_scaled.rds	salmon.merged.gene_counts_scaled.rds	1039908	98950385	\N	f	2022-09-27 09:32:29.19+00
1599	21	1142	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/salmon.merged.gene_counts_scaled.tsv	salmon.merged.gene_counts_scaled.tsv	1436180	-1089564625	\N	f	2022-09-27 09:32:28.906+00
1600	21	1142	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/salmon.merged.gene_tpm.tsv	salmon.merged.gene_tpm.tsv	1180531	-1051377071	\N	f	2022-09-27 09:32:29.202+00
1601	21	1142	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/salmon.merged.transcript_counts.rds	salmon.merged.transcript_counts.rds	1444158	-856908448	\N	f	2022-09-27 09:32:29.106+00
1602	21	1142	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/salmon.merged.transcript_counts.tsv	salmon.merged.transcript_counts.tsv	1739966	1720078603	\N	f	2022-09-27 09:32:29.158+00
1603	21	1142	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/salmon.merged.transcript_tpm.tsv	salmon.merged.transcript_tpm.tsv	1994886	-71922273	\N	f	2022-09-27 09:32:28.798+00
1604	21	1142	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/salmon_tx2gene.tsv	salmon_tx2gene.tsv	2070112	-868538373	\N	f	2022-09-27 09:32:28.906+00
1605	21	1190	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/samtools_stats/mutant.markdup.sorted.bam.flagstat	mutant.markdup.sorted.bam.flagstat	548	1104698654	\N	f	2022-09-27 09:32:29.19+00
1606	21	1190	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/samtools_stats/mutant.markdup.sorted.bam.idxstats	mutant.markdup.sorted.bam.idxstats	237	-717041441	\N	f	2022-09-27 09:32:29.19+00
1706	32	1705	original	original	392536877	\N	\N	t	2022-09-27 12:37:46.48+00
1607	21	1190	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/samtools_stats/mutant.markdup.sorted.bam.stats	mutant.markdup.sorted.bam.stats	137478	1858481368	\N	f	2022-09-27 09:32:29.19+00
1608	21	1190	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/samtools_stats/mutant.sorted.bam.flagstat	mutant.sorted.bam.flagstat	542	1897509056	\N	f	2022-09-27 09:32:29.19+00
1609	21	1190	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/samtools_stats/mutant.sorted.bam.idxstats	mutant.sorted.bam.idxstats	237	-1757126398	\N	f	2022-09-27 09:32:29.19+00
1610	21	1190	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/samtools_stats/mutant.sorted.bam.stats	mutant.sorted.bam.stats	137462	-559993036	\N	f	2022-09-27 09:32:29.19+00
1611	21	1190	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/samtools_stats/wildtype.markdup.sorted.bam.flagstat	wildtype.markdup.sorted.bam.flagstat	551	-175953516	\N	f	2022-09-27 09:32:29.19+00
1612	21	1190	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/samtools_stats/wildtype.markdup.sorted.bam.idxstats	wildtype.markdup.sorted.bam.idxstats	237	1434055868	\N	f	2022-09-27 09:32:29.19+00
1613	21	1190	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/samtools_stats/wildtype.markdup.sorted.bam.stats	wildtype.markdup.sorted.bam.stats	133457	2033637349	\N	f	2022-09-27 09:32:29.19+00
1614	21	1190	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/samtools_stats/wildtype.sorted.bam.flagstat	wildtype.sorted.bam.flagstat	543	858808743	\N	f	2022-09-27 09:32:29.19+00
1615	21	1190	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/samtools_stats/wildtype.sorted.bam.idxstats	wildtype.sorted.bam.idxstats	237	-1426243349	\N	f	2022-09-27 09:32:29.19+00
1616	21	1190	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/samtools_stats/wildtype.sorted.bam.stats	wildtype.sorted.bam.stats	133439	-695087212	\N	f	2022-09-27 09:32:29.19+00
1617	21	1192	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/stringtie/mutant.ballgown/e2t.ctab	e2t.ctab	3976704	1056811991	\N	f	2022-09-27 09:32:29.046+00
1618	21	1192	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/stringtie/mutant.ballgown/e_data.ctab	e_data.ctab	15207714	-530982729	\N	f	2022-09-27 09:32:29.034+00
1619	21	1192	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/stringtie/mutant.ballgown/i2t.ctab	i2t.ctab	3170677	1417348958	\N	f	2022-09-27 09:32:29.058+00
1620	21	1192	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/stringtie/mutant.ballgown/i_data.ctab	i_data.ctab	6314350	-846611262	\N	f	2022-09-27 09:32:29.042+00
1621	21	1192	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/stringtie/mutant.ballgown/t_data.ctab	t_data.ctab	5380892	957963090	\N	f	2022-09-27 09:32:29.054+00
1622	21	1191	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/stringtie/mutant.coverage.gtf	mutant.coverage.gtf	3325056	812414161	\N	f	2022-09-27 09:32:29.062+00
1623	21	1191	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/stringtie/mutant.gene.abundance.txt	mutant.gene.abundance.txt	2602044	656339146	\N	f	2022-09-27 09:32:29.062+00
1624	21	1191	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/stringtie/mutant.transcripts.gtf	mutant.transcripts.gtf	55514828	1804140620	\N	f	2022-09-27 09:32:29.014+00
1625	21	1193	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/stringtie/wildtype.ballgown/e2t.ctab	e2t.ctab	3976704	1716448209	\N	f	2022-09-27 09:32:29.09+00
1626	21	1193	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/stringtie/wildtype.ballgown/e_data.ctab	e_data.ctab	15194625	932701348	\N	f	2022-09-27 09:32:29.078+00
1627	21	1193	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/stringtie/wildtype.ballgown/i2t.ctab	i2t.ctab	3170677	-1210770482	\N	f	2022-09-27 09:32:29.098+00
1628	21	1193	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/stringtie/wildtype.ballgown/i_data.ctab	i_data.ctab	6313244	-69820083	\N	f	2022-09-27 09:32:29.086+00
1629	21	1193	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/stringtie/wildtype.ballgown/t_data.ctab	t_data.ctab	5380794	-20422728	\N	f	2022-09-27 09:32:29.094+00
1630	21	1191	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/stringtie/wildtype.coverage.gtf	wildtype.coverage.gtf	2653473	-678942344	\N	f	2022-09-27 09:32:29.102+00
1631	21	1191	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/stringtie/wildtype.gene.abundance.txt	wildtype.gene.abundance.txt	2539715	345784706	\N	f	2022-09-27 09:32:29.106+00
1632	21	1191	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/stringtie/wildtype.transcripts.gtf	wildtype.transcripts.gtf	55354944	-1093886455	\N	f	2022-09-27 09:32:28.958+00
1633	21	1195	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/wildtype/aux_info/ambig_info.tsv	ambig_info.tsv	250491	-1539251315	\N	f	2022-09-27 09:32:29.182+00
1634	21	1195	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/wildtype/aux_info/expected_bias.gz	expected_bias.gz	117	1728794861	\N	f	2022-09-27 09:32:29.182+00
1635	21	1195	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/wildtype/aux_info/fld.gz	fld.gz	538	-802119413	\N	f	2022-09-27 09:32:29.182+00
1636	21	1195	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/wildtype/aux_info/meta_info.json	meta_info.json	1304	73958535	\N	f	2022-09-27 09:32:29.182+00
1637	21	1195	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/wildtype/aux_info/observed_bias.gz	observed_bias.gz	82	-771172874	\N	f	2022-09-27 09:32:29.182+00
1638	21	1195	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/wildtype/aux_info/observed_bias_3p.gz	observed_bias_3p.gz	82	-1586160099	\N	f	2022-09-27 09:32:29.182+00
1639	21	1194	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/wildtype/cmd_info.json	cmd_info.json	283	-485566545	\N	f	2022-09-27 09:32:29.178+00
1640	21	1196	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/wildtype/libParams/flenDist.txt	flenDist.txt	11777	-201700918	\N	f	2022-09-27 09:32:29.178+00
1641	21	1194	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/wildtype/quant.genes.sf	quant.genes.sf	1983471	-1896387028	\N	f	2022-09-27 09:32:29.178+00
1642	21	1194	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/wildtype/quant.sf	quant.sf	2582265	250013920	\N	f	2022-09-27 09:32:29.178+00
1643	21	1142	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/wildtype.markdup.sorted.bam	wildtype.markdup.sorted.bam	100770444	-1197367661	\N	f	2022-09-27 09:32:28.782+00
1644	21	1142	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/star_salmon/wildtype.markdup.sorted.bam.bai	wildtype.markdup.sorted.bam.bai	104208	1861296028	\N	f	2022-09-27 09:32:28.906+00
1645	21	1198	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/trimgalore/fastqc/mutant_1_val_1_fastqc.html	mutant_1_val_1_fastqc.html	592858	-389894084	\N	f	2022-09-27 09:32:28.526+00
1646	21	1198	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/trimgalore/fastqc/mutant_1_val_1_fastqc.zip	mutant_1_val_1_fastqc.zip	300154	637624008	\N	f	2022-09-27 09:32:28.526+00
1647	21	1198	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/trimgalore/fastqc/mutant_2_val_2_fastqc.html	mutant_2_val_2_fastqc.html	592713	1759715307	\N	f	2022-09-27 09:32:28.526+00
1648	21	1198	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/trimgalore/fastqc/mutant_2_val_2_fastqc.zip	mutant_2_val_2_fastqc.zip	298572	2145292057	\N	f	2022-09-27 09:32:28.526+00
1649	21	1198	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/trimgalore/fastqc/wildtype_1_val_1_fastqc.html	wildtype_1_val_1_fastqc.html	612913	-1999160148	\N	f	2022-09-27 09:32:28.522+00
1650	21	1198	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/trimgalore/fastqc/wildtype_1_val_1_fastqc.zip	wildtype_1_val_1_fastqc.zip	352736	-295420337	\N	f	2022-09-27 09:32:28.526+00
1651	21	1198	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/trimgalore/fastqc/wildtype_2_val_2_fastqc.html	wildtype_2_val_2_fastqc.html	606686	1380212735	\N	f	2022-09-27 09:32:28.526+00
1652	21	1198	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/trimgalore/fastqc/wildtype_2_val_2_fastqc.zip	wildtype_2_val_2_fastqc.zip	345373	1797969583	\N	f	2022-09-27 09:32:28.526+00
1653	21	1197	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/trimgalore/mutant_1.fastq.gz_trimming_report.txt	mutant_1.fastq.gz_trimming_report.txt	3944	73722079	\N	f	2022-09-27 09:32:28.526+00
1654	21	1197	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/trimgalore/mutant_2.fastq.gz_trimming_report.txt	mutant_2.fastq.gz_trimming_report.txt	3570	-945496254	\N	f	2022-09-27 09:32:28.526+00
1655	21	1197	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/trimgalore/wildtype_1.fastq.gz_trimming_report.txt	wildtype_1.fastq.gz_trimming_report.txt	3755	-1343932335	\N	f	2022-09-27 09:32:28.526+00
1656	21	1197	original/baccfc0c-7766-4806-acdb-a80d6ff648a6/results/results/trimgalore/wildtype_2.fastq.gz_trimming_report.txt	wildtype_2.fastq.gz_trimming_report.txt	3689	-862370885	\N	f	2022-09-27 09:32:28.526+00
1657	22	\N		20220927103713198-119	6131912744	\N	\N	t	2022-09-27 10:37:14.272+00
1658	22	1657	original	original	6131912744	\N	\N	t	2022-09-27 10:37:13.472+00
1659	22	1658	original/upload	upload	6131912744	\N	\N	t	2022-09-27 10:37:05.66+00
1660	22	1659	original/upload/S1R1_1.fq.gz	S1R1_1.fq.gz	2986520047	544571323	\N	f	2022-09-27 10:37:05.656+00
1661	22	1659	original/upload/S1R1_2.fq.gz	S1R1_2.fq.gz	3145392697	-226369040	\N	f	2022-09-27 10:37:13.14+00
1662	23	\N		20220927104912276-122	5689608193	\N	\N	t	2022-09-27 10:49:13.13+00
1663	23	1662	original	original	5689608193	\N	\N	t	2022-09-27 10:49:12.498+00
1664	23	1663	original/upload	upload	5689608193	\N	\N	t	2022-09-27 10:49:05.453+00
1665	23	1664	original/upload/S1R2_1.fq.gz	S1R2_1.fq.gz	2784529405	1929750517	\N	f	2022-09-27 10:49:05.449+00
1666	23	1664	original/upload/S1R2_2.fq.gz	S1R2_2.fq.gz	2905078788	-1906703003	\N	f	2022-09-27 10:49:12.234+00
1667	24	\N		20220927105045929-125	560743138	\N	\N	t	2022-09-27 10:50:46.745+00
1668	24	1667	original	original	560743138	\N	\N	t	2022-09-27 10:50:46.168+00
1669	24	1668	original/upload	upload	560743138	\N	\N	t	2022-09-27 10:50:45.176+00
1670	24	1669	original/upload/S1R3_1.fq.gz	S1R3_1.fq.gz	258536764	-1103977410	\N	f	2022-09-27 10:50:45.172+00
1671	24	1669	original/upload/S1R3_2.fq.gz	S1R3_2.fq.gz	302206374	955346732	\N	f	2022-09-27 10:50:45.888+00
1672	25	\N		20220927111304581-128	10761099431	\N	\N	t	2022-09-27 11:13:05.179+00
1673	25	1672	original	original	10761099431	\N	\N	t	2022-09-27 11:13:04.811+00
1674	25	1673	original/upload	upload	10761099431	\N	\N	t	2022-09-27 11:12:49.702+00
1675	25	1674	original/upload/S2R1_1.fq.gz	S2R1_1.fq.gz	5298820695	-2078571974	\N	f	2022-09-27 11:12:49.698+00
1676	25	1674	original/upload/S2R1_2.fq.gz	S2R1_2.fq.gz	5462278736	-2069630667	\N	f	2022-09-27 11:13:04.435+00
1677	26	\N		20220927114625096-131	9261327324	\N	\N	t	2022-09-27 11:46:26.065+00
1678	26	1677	original	original	9261327324	\N	\N	t	2022-09-27 11:46:25.369+00
1679	26	1678	original/upload	upload	9261327324	\N	\N	t	2022-09-27 11:46:14.308+00
1680	26	1679	original/upload/S2R2_1.fq.gz	S2R2_1.fq.gz	4597169793	1158870443	\N	f	2022-09-27 11:46:14.304+00
1681	26	1679	original/upload/S2R2_2.fq.gz	S2R2_2.fq.gz	4664157531	190375164	\N	f	2022-09-27 11:46:25.053+00
1682	27	\N		20220927120757138-134	9432093141	\N	\N	t	2022-09-27 12:07:58.092+00
1683	27	1682	original	original	9432093141	\N	\N	t	2022-09-27 12:07:57.408+00
1684	27	1683	original/upload	upload	9432093141	\N	\N	t	2022-09-27 12:07:46.247+00
1685	27	1684	original/upload/S2R3_1.fq.gz	S2R3_1.fq.gz	4792720492	562663192	\N	f	2022-09-27 12:07:46.243+00
1686	27	1684	original/upload/S2R3_2.fq.gz	S2R3_2.fq.gz	4639372649	-1980859338	\N	f	2022-09-27 12:07:57.092+00
1687	28	\N		20220927122151806-137	6691661147	\N	\N	t	2022-09-27 12:21:52.878+00
1688	28	1687	original	original	6691661147	\N	\N	t	2022-09-27 12:21:52.078+00
1689	28	1688	original/upload	upload	6691661147	\N	\N	t	2022-09-27 12:21:43.809+00
1690	28	1689	original/upload/S3R1_1.fq.gz	S3R1_1.fq.gz	3287800559	829750779	\N	f	2022-09-27 12:21:43.805+00
1691	28	1689	original/upload/S3R1_2.fq.gz	S3R1_2.fq.gz	3403860588	-894448741	\N	f	2022-09-27 12:21:51.77+00
1692	29	\N		20220927122613289-140	668930750	\N	\N	t	2022-09-27 12:26:14.329+00
1693	29	1692	original	original	668930750	\N	\N	t	2022-09-27 12:26:13.693+00
1694	29	1693	original/upload	upload	668930750	\N	\N	t	2022-09-27 12:26:12.449+00
1695	29	1694	original/upload/S3R2_1.fq.gz	S3R2_1.fq.gz	307134609	1370719577	\N	f	2022-09-27 12:26:12.441+00
1696	29	1694	original/upload/S3R2_2.fq.gz	S3R2_2.fq.gz	361796141	-2143174686	\N	f	2022-09-27 12:26:13.253+00
1697	30	\N		20220927123024021-143	1609964730	\N	\N	t	2022-09-27 12:30:24.836+00
1698	30	1697	original	original	1609964730	\N	\N	t	2022-09-27 12:30:24.284+00
1699	30	1698	original/upload	upload	1609964730	\N	\N	t	2022-09-27 12:30:21.987+00
1700	30	1699	original/upload/S3R3_1.fq.gz	S3R3_1.fq.gz	706125768	1961737500	\N	f	2022-09-27 12:30:21.987+00
1759	44	\N		20220929095430350-208	9472	\N	\N	t	2022-09-29 09:54:33.185+00
1760	44	1759	original	original	9472	\N	\N	t	2022-09-29 09:54:32.269+00
1761	44	1760	original/logs	logs	9472	\N	\N	t	2022-09-29 09:54:30.317+00
1762	44	1761	original/logs/salmon_quant.log	salmon_quant.log	9472	-2062072532	\N	f	2022-09-29 09:54:30.317+00
1763	45	\N		20220929095432198-209	1634564542	\N	\N	t	2022-09-29 09:54:33.185+00
1764	45	1763	original	original	1634564542	\N	\N	t	2022-09-29 09:54:32.269+00
1765	45	1764	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1	35edf4a8-e094-487f-bdb7-a6891e42eaa1	1634564542	\N	\N	t	2022-09-29 09:54:20.872+00
1766	45	1765	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results	results	1634564542	\N	\N	t	2022-09-29 08:40:33+00
1767	45	1766	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/fastqc	fastqc	8832903	\N	\N	t	2022-09-29 09:54:30.397+00
1768	45	1766	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc	multiqc	10352775	\N	\N	t	2022-09-29 08:40:05+00
1769	45	1768	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon	star_salmon	10352775	\N	\N	t	2022-09-29 09:54:32.145+00
1770	45	1769	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_data	multiqc_data	4420592	\N	\N	t	2022-09-29 09:54:32.173+00
1771	45	1769	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots	multiqc_plots	4177411	\N	\N	t	2022-09-29 08:40:08+00
1772	45	1771	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/pdf	pdf	835942	\N	\N	t	2022-09-29 09:54:32.165+00
1773	45	1771	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/png	png	1501880	\N	\N	t	2022-09-29 09:54:32.161+00
1774	45	1771	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/svg	svg	1839589	\N	\N	t	2022-09-29 09:54:32.153+00
1775	45	1766	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/pipeline_info	pipeline_info	17735592	\N	\N	t	2022-09-29 09:54:30.389+00
1776	45	1766	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon	star_salmon	1588615339	\N	\N	t	2022-09-29 09:54:32.141+00
1777	45	1776	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/bigwig	bigwig	744647771	\N	\N	t	2022-09-29 09:54:32.037+00
1778	45	1776	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/deseq2_qc	deseq2_qc	1919769	\N	\N	t	2022-09-29 09:54:32.145+00
1779	45	1778	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/deseq2_qc/size_factors	size_factors	283	\N	\N	t	2022-09-29 09:54:32.145+00
1780	45	1776	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/dupradar	dupradar	26416063	\N	\N	t	2022-09-29 08:40:27+00
1781	45	1780	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/dupradar/box_plot	box_plot	167836	\N	\N	t	2022-09-29 09:54:32.117+00
1782	45	1780	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/dupradar/gene_data	gene_data	19312098	\N	\N	t	2022-09-29 09:54:32.109+00
1783	45	1780	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/dupradar/histogram	histogram	15641	\N	\N	t	2022-09-29 09:54:32.109+00
1784	45	1780	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/dupradar/intercepts_slope	intercepts_slope	541	\N	\N	t	2022-09-29 09:54:32.117+00
1785	45	1780	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/dupradar/scatter_plot	scatter_plot	6919947	\N	\N	t	2022-09-29 09:54:32.117+00
1786	45	1776	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/log	log	26446497	\N	\N	t	2022-09-29 09:54:32.089+00
1787	45	1776	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/picard_metrics	picard_metrics	65046	\N	\N	t	2022-09-29 09:54:30.401+00
1788	45	1776	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/preseq	preseq	1500477	\N	\N	t	2022-09-29 09:54:30.405+00
1789	45	1788	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/preseq/log	log	42586	\N	\N	t	2022-09-29 09:54:30.409+00
1790	45	1776	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap	qualimap	1607219	\N	\N	t	2022-09-29 08:40:25+00
1791	45	1790	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_1	sample_1	534933	\N	\N	t	2022-09-29 09:54:32.133+00
1792	45	1791	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_1/css	css	166918	\N	\N	t	2022-09-29 09:54:32.137+00
1793	45	1791	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_1/images_qualimapReport	images_qualimapReport	347698	\N	\N	t	2022-09-29 09:54:32.133+00
1794	45	1791	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_1/raw_data_qualimapReport	raw_data_qualimapReport	7452	\N	\N	t	2022-09-29 09:54:32.137+00
1795	45	1790	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_2	sample_2	534665	\N	\N	t	2022-09-29 09:54:32.129+00
1796	45	1795	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_2/css	css	166918	\N	\N	t	2022-09-29 09:54:32.129+00
1797	45	1795	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_2/images_qualimapReport	images_qualimapReport	347173	\N	\N	t	2022-09-29 09:54:32.129+00
1798	45	1795	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_2/raw_data_qualimapReport	raw_data_qualimapReport	7465	\N	\N	t	2022-09-29 09:54:32.129+00
1799	45	1790	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_3	sample_3	537621	\N	\N	t	2022-09-29 09:54:32.133+00
1800	45	1799	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_3/css	css	166918	\N	\N	t	2022-09-29 09:54:32.133+00
1801	45	1799	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_3/images_qualimapReport	images_qualimapReport	350402	\N	\N	t	2022-09-29 09:54:32.129+00
1802	45	1799	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_3/raw_data_qualimapReport	raw_data_qualimapReport	7434	\N	\N	t	2022-09-29 09:54:32.133+00
1803	45	1776	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/rseqc	rseqc	447404866	\N	\N	t	2022-09-29 08:40:33+00
1804	45	1803	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/rseqc/bam_stat	bam_stat	2648	\N	\N	t	2022-09-29 09:54:30.645+00
1805	45	1803	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/rseqc/infer_experiment	infer_experiment	633	\N	\N	t	2022-09-29 09:54:30.909+00
1806	45	1803	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/rseqc/inner_distance	inner_distance	205317350	\N	\N	t	2022-09-29 08:40:29+00
1807	45	1806	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/rseqc/inner_distance/pdf	pdf	25867	\N	\N	t	2022-09-29 09:54:30.641+00
1808	45	1806	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/rseqc/inner_distance/rscript	rscript	4843	\N	\N	t	2022-09-29 09:54:30.641+00
1809	45	1806	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/rseqc/inner_distance/txt	txt	205286640	\N	\N	t	2022-09-29 09:54:30.641+00
1810	45	1803	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/rseqc/junction_annotation	junction_annotation	241776375	\N	\N	t	2022-09-29 08:40:32+00
1811	45	1810	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/rseqc/junction_annotation/bed	bed	210406986	\N	\N	t	2022-09-29 09:54:30.865+00
1812	45	1810	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/rseqc/junction_annotation/log	log	1791	\N	\N	t	2022-09-29 09:54:30.909+00
1813	45	1810	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/rseqc/junction_annotation/pdf	pdf	79848	\N	\N	t	2022-09-29 09:54:30.909+00
1814	45	1810	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/rseqc/junction_annotation/rscript	rscript	1744	\N	\N	t	2022-09-29 09:54:30.905+00
1815	45	1810	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/rseqc/junction_annotation/xls	xls	31286006	\N	\N	t	2022-09-29 09:54:30.905+00
1816	45	1803	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/rseqc/junction_saturation	junction_saturation	19546	\N	\N	t	2022-09-29 08:40:33+00
1817	45	1816	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/rseqc/junction_saturation/pdf	pdf	16779	\N	\N	t	2022-09-29 09:54:30.645+00
1818	45	1816	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/rseqc/junction_saturation/rscript	rscript	2767	\N	\N	t	2022-09-29 09:54:30.645+00
3122	58	3121	original	original	95823	\N	\N	t	2022-09-29 13:47:08.866+00
1819	45	1803	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/rseqc/read_distribution	read_distribution	3474	\N	\N	t	2022-09-29 09:54:30.641+00
1820	45	1803	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/rseqc/read_duplication	read_duplication	284840	\N	\N	t	2022-09-29 08:40:32+00
1821	45	1820	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/rseqc/read_duplication/pdf	pdf	64008	\N	\N	t	2022-09-29 09:54:30.645+00
1822	45	1820	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/rseqc/read_duplication/rscript	rscript	111574	\N	\N	t	2022-09-29 09:54:30.645+00
1823	45	1820	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/rseqc/read_duplication/xls	xls	109258	\N	\N	t	2022-09-29 09:54:30.641+00
1824	45	1776	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/sample_1	sample_1	5225181	\N	\N	t	2022-09-29 09:54:32.057+00
1825	45	1824	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/sample_1/aux_info	aux_info	375135	\N	\N	t	2022-09-29 09:54:32.057+00
1826	45	1824	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/sample_1/libParams	libParams	11697	\N	\N	t	2022-09-29 09:54:32.057+00
1827	45	1776	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/sample_2	sample_2	5200658	\N	\N	t	2022-09-29 09:54:30.413+00
1828	45	1827	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/sample_2/aux_info	aux_info	363982	\N	\N	t	2022-09-29 09:54:30.413+00
1829	45	1827	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/sample_2/libParams	libParams	11611	\N	\N	t	2022-09-29 09:54:30.413+00
1830	45	1827	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/sample_2/logs	logs	6561	\N	\N	t	2022-09-29 09:54:30.413+00
1831	45	1767	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/fastqc/sample_1_1_fastqc.html	sample_1_1_fastqc.html	639037	-229929816	\N	f	2022-09-29 09:54:30.393+00
1832	45	1767	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/fastqc/sample_1_1_fastqc.zip	sample_1_1_fastqc.zip	795284	1992609204	\N	f	2022-09-29 09:54:30.393+00
1833	45	1767	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/fastqc/sample_1_2_fastqc.html	sample_1_2_fastqc.html	644973	-1474904215	\N	f	2022-09-29 09:54:30.397+00
1834	45	1767	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/fastqc/sample_1_2_fastqc.zip	sample_1_2_fastqc.zip	805496	-2028327929	\N	f	2022-09-29 09:54:30.397+00
1835	45	1767	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/fastqc/sample_2_1_fastqc.html	sample_2_1_fastqc.html	647543	-1405594998	\N	f	2022-09-29 09:54:30.389+00
1836	45	1767	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/fastqc/sample_2_1_fastqc.zip	sample_2_1_fastqc.zip	873117	1676652339	\N	f	2022-09-29 09:54:30.389+00
1837	45	1767	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/fastqc/sample_2_2_fastqc.html	sample_2_2_fastqc.html	652819	1000364081	\N	f	2022-09-29 09:54:30.393+00
1838	45	1767	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/fastqc/sample_2_2_fastqc.zip	sample_2_2_fastqc.zip	872804	236164475	\N	f	2022-09-29 09:54:30.389+00
1839	45	1767	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/fastqc/sample_3_1_fastqc.html	sample_3_1_fastqc.html	646936	-798636588	\N	f	2022-09-29 09:54:30.397+00
1840	45	1767	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/fastqc/sample_3_1_fastqc.zip	sample_3_1_fastqc.zip	808733	1504329489	\N	f	2022-09-29 09:54:30.397+00
1841	45	1767	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/fastqc/sample_3_2_fastqc.html	sample_3_2_fastqc.html	643045	102036971	\N	f	2022-09-29 09:54:30.393+00
1842	45	1767	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/fastqc/sample_3_2_fastqc.zip	sample_3_2_fastqc.zip	803116	-51640373	\N	f	2022-09-29 09:54:30.393+00
1843	45	1770	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_data/mqc_cutadapt_filtered_reads_plot_1.txt	mqc_cutadapt_filtered_reads_plot_1.txt	193	1753381434	\N	f	2022-09-29 09:54:32.173+00
1844	45	1770	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_data/mqc_cutadapt_trimmed_sequences_plot_3_Counts.txt	mqc_cutadapt_trimmed_sequences_plot_3_Counts.txt	6767	803836650	\N	f	2022-09-29 09:54:32.173+00
1845	45	1770	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_data/mqc_cutadapt_trimmed_sequences_plot_3_Obs_Exp.txt	mqc_cutadapt_trimmed_sequences_plot_3_Obs_Exp.txt	16781	990448980	\N	f	2022-09-29 09:54:32.173+00
1846	45	1770	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_data/mqc_fastqc_adapter_content_plot_1.txt	mqc_fastqc_adapter_content_plot_1.txt	9401	1272625660	\N	f	2022-09-29 09:54:32.173+00
1847	45	1770	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_data/mqc_fastqc_overrepresented_sequences_plot-2_1.txt	mqc_fastqc_overrepresented_sequences_plot-2_1.txt	316	965876783	\N	f	2022-09-29 09:54:32.173+00
1848	45	1770	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_data/mqc_fastqc_overrepresented_sequences_plot_1.txt	mqc_fastqc_overrepresented_sequences_plot_1.txt	313	-431937961	\N	f	2022-09-29 09:54:32.173+00
1849	45	1770	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_data/mqc_fastqc_per_base_n_content_plot-2_1.txt	mqc_fastqc_per_base_n_content_plot-2_1.txt	5475	535265834	\N	f	2022-09-29 09:54:32.165+00
1850	45	1770	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_data/mqc_fastqc_per_base_n_content_plot_1.txt	mqc_fastqc_per_base_n_content_plot_1.txt	5551	1713676506	\N	f	2022-09-29 09:54:32.165+00
1851	45	1770	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_data/mqc_fastqc_per_base_sequence_quality_plot-2_1.txt	mqc_fastqc_per_base_sequence_quality_plot-2_1.txt	5650	-883856998	\N	f	2022-09-29 09:54:32.173+00
1852	45	1770	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_data/mqc_fastqc_per_base_sequence_quality_plot_1.txt	mqc_fastqc_per_base_sequence_quality_plot_1.txt	5637	-2134522018	\N	f	2022-09-29 09:54:32.173+00
1853	45	1770	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_data/mqc_fastqc_per_sequence_gc_content_plot-2_Counts.txt	mqc_fastqc_per_sequence_gc_content_plot-2_Counts.txt	5714	1393381379	\N	f	2022-09-29 09:54:32.165+00
1854	45	1770	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_data/mqc_fastqc_per_sequence_gc_content_plot-2_Percentages.txt	mqc_fastqc_per_sequence_gc_content_plot-2_Percentages.txt	12769	-367483367	\N	f	2022-09-29 09:54:32.173+00
1855	45	1770	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_data/mqc_fastqc_per_sequence_gc_content_plot_Counts.txt	mqc_fastqc_per_sequence_gc_content_plot_Counts.txt	5653	-1461894178	\N	f	2022-09-29 09:54:32.173+00
1856	45	1770	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_data/mqc_fastqc_per_sequence_gc_content_plot_Percentages.txt	mqc_fastqc_per_sequence_gc_content_plot_Percentages.txt	12749	1161524155	\N	f	2022-09-29 09:54:32.165+00
1857	45	1770	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_data/mqc_fastqc_per_sequence_quality_scores_plot-2_1.txt	mqc_fastqc_per_sequence_quality_scores_plot-2_1.txt	2197	1201938939	\N	f	2022-09-29 09:54:32.165+00
1858	45	1770	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_data/mqc_fastqc_per_sequence_quality_scores_plot_1.txt	mqc_fastqc_per_sequence_quality_scores_plot_1.txt	2251	-2072457596	\N	f	2022-09-29 09:54:32.173+00
1859	45	1770	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_data/mqc_fastqc_sequence_counts_plot-2_1.txt	mqc_fastqc_sequence_counts_plot-2_1.txt	264	-462459235	\N	f	2022-09-29 09:54:32.165+00
1860	45	1770	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_data/mqc_fastqc_sequence_counts_plot_1.txt	mqc_fastqc_sequence_counts_plot_1.txt	264	303266212	\N	f	2022-09-29 09:54:32.173+00
1861	45	1770	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_data/mqc_fastqc_sequence_duplication_levels_plot-2_1.txt	mqc_fastqc_sequence_duplication_levels_plot-2_1.txt	1455	-1203932733	\N	f	2022-09-29 09:54:32.165+00
1862	45	1770	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_data/mqc_fastqc_sequence_duplication_levels_plot_1.txt	mqc_fastqc_sequence_duplication_levels_plot_1.txt	1452	-2061310937	\N	f	2022-09-29 09:54:32.173+00
1863	45	1770	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_data/mqc_fastqc_sequence_length_distribution_plot-2_1.txt	mqc_fastqc_sequence_length_distribution_plot-2_1.txt	2492	42235774	\N	f	2022-09-29 09:54:32.165+00
1864	45	1770	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_data/mqc_fastqc_sequence_length_distribution_plot_1.txt	mqc_fastqc_sequence_length_distribution_plot_1.txt	1183	1852409374	\N	f	2022-09-29 09:54:32.165+00
1865	45	1770	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_data/mqc_mqc_mplplot_zxqfwhjbcr_1.txt	mqc_mqc_mplplot_zxqfwhjbcr_1.txt	369185	1844649495	\N	f	2022-09-29 09:54:32.173+00
1866	45	1770	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_data/mqc_picard_deduplication_1.txt	mqc_picard_deduplication_1.txt	310	1832124531	\N	f	2022-09-29 09:54:32.173+00
1867	45	1770	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_data/mqc_preseq_plot_1.txt	mqc_preseq_plot_1.txt	86441	772896457	\N	f	2022-09-29 09:54:32.173+00
1868	45	1770	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_data/mqc_qualimap_gene_coverage_profile_Counts.txt	mqc_qualimap_gene_coverage_profile_Counts.txt	5907	1991454555	\N	f	2022-09-29 09:54:32.173+00
1869	45	1770	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_data/mqc_qualimap_gene_coverage_profile_Normalised.txt	mqc_qualimap_gene_coverage_profile_Normalised.txt	5998	674232941	\N	f	2022-09-29 09:54:32.173+00
1870	45	1770	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_data/mqc_qualimap_genomic_origin_1.txt	mqc_qualimap_genomic_origin_1.txt	190	-158302924	\N	f	2022-09-29 09:54:32.165+00
1871	45	1770	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_data/mqc_rseqc_infer_experiment_plot_1.txt	mqc_rseqc_infer_experiment_plot_1.txt	178	1848800172	\N	f	2022-09-29 09:54:32.173+00
1872	45	1770	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_data/mqc_rseqc_inner_distance_plot_Counts.txt	mqc_rseqc_inner_distance_plot_Counts.txt	2637	-697432415	\N	f	2022-09-29 09:54:32.173+00
1873	45	1770	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_data/mqc_rseqc_inner_distance_plot_Percentages.txt	mqc_rseqc_inner_distance_plot_Percentages.txt	5386	-165135244	\N	f	2022-09-29 09:54:32.165+00
1874	45	1770	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_data/mqc_rseqc_junction_annotation_junctions_plot_Events.txt	mqc_rseqc_junction_annotation_junctions_plot_Events.txt	226	-742175946	\N	f	2022-09-29 09:54:32.173+00
1875	45	1770	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_data/mqc_rseqc_junction_annotation_junctions_plot_Junctions.txt	mqc_rseqc_junction_annotation_junctions_plot_Junctions.txt	221	-1257015539	\N	f	2022-09-29 09:54:32.165+00
1876	45	1770	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_data/mqc_rseqc_junction_saturation_plot_All_Junctions.txt	mqc_rseqc_junction_saturation_plot_All_Junctions.txt	702	-374008582	\N	f	2022-09-29 09:54:32.165+00
1877	45	1770	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_data/mqc_rseqc_junction_saturation_plot_Known_Junctions.txt	mqc_rseqc_junction_saturation_plot_Known_Junctions.txt	697	558804072	\N	f	2022-09-29 09:54:32.173+00
1878	45	1770	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_data/mqc_rseqc_junction_saturation_plot_Novel_Junctions.txt	mqc_rseqc_junction_saturation_plot_Novel_Junctions.txt	679	507355626	\N	f	2022-09-29 09:54:32.173+00
1879	45	1770	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_data/mqc_rseqc_read_distribution_plot_1.txt	mqc_rseqc_read_distribution_plot_1.txt	452	1565869400	\N	f	2022-09-29 09:54:32.173+00
1880	45	1770	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_data/mqc_rseqc_read_dups_plot_1.txt	mqc_rseqc_read_dups_plot_1.txt	3199	66019748	\N	f	2022-09-29 09:54:32.173+00
1881	45	1770	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_data/mqc_samtools-idxstats-mapped-reads-plot_Normalised_Counts.txt	mqc_samtools-idxstats-mapped-reads-plot_Normalised_Counts.txt	594	-1537437328	\N	f	2022-09-29 09:54:32.173+00
1882	45	1770	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_data/mqc_samtools-idxstats-mapped-reads-plot_Observed_over_Expected_Counts.txt	mqc_samtools-idxstats-mapped-reads-plot_Observed_over_Expected_Counts.txt	570	-1220623945	\N	f	2022-09-29 09:54:32.173+00
1883	45	1770	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_data/mqc_samtools-idxstats-mapped-reads-plot_Raw_Counts.txt	mqc_samtools-idxstats-mapped-reads-plot_Raw_Counts.txt	324	218150770	\N	f	2022-09-29 09:54:32.165+00
1884	45	1770	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_data/mqc_samtools_alignment_plot_1.txt	mqc_samtools_alignment_plot_1.txt	105	-997291752	\N	f	2022-09-29 09:54:32.173+00
1885	45	1770	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_data/mqc_star_alignment_plot_1.txt	mqc_star_alignment_plot_1.txt	314	-1405115173	\N	f	2022-09-29 09:54:32.165+00
1886	45	1770	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_data/multiqc.log	multiqc.log	22448	-302423225	\N	f	2022-09-29 09:54:32.173+00
1887	45	1770	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_data/multiqc_cutadapt.txt	multiqc_cutadapt.txt	718	1007347554	\N	f	2022-09-29 09:54:32.165+00
1888	45	1770	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_data/multiqc_data.json	multiqc_data.json	3779057	1518570952	\N	f	2022-09-29 09:54:32.169+00
1889	45	1770	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_data/multiqc_fastqc.txt	multiqc_fastqc.txt	1603	-980407758	\N	f	2022-09-29 09:54:32.173+00
1890	45	1770	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_data/multiqc_fastqc_1.txt	multiqc_fastqc_1.txt	1646	1792412719	\N	f	2022-09-29 09:54:32.173+00
1891	45	1770	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_data/multiqc_general_stats.txt	multiqc_general_stats.txt	3252	-656626316	\N	f	2022-09-29 09:54:32.165+00
1892	45	1770	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_data/multiqc_picard_dups.txt	multiqc_picard_dups.txt	582	-1678712989	\N	f	2022-09-29 09:54:32.165+00
1893	45	1770	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_data/multiqc_rseqc_bam_stat.txt	multiqc_rseqc_bam_stat.txt	844	1726607601	\N	f	2022-09-29 09:54:32.173+00
1894	45	1770	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_data/multiqc_rseqc_infer_experiment.txt	multiqc_rseqc_infer_experiment.txt	148	2076388865	\N	f	2022-09-29 09:54:32.165+00
1895	45	1770	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_data/multiqc_rseqc_junction_annotation.txt	multiqc_rseqc_junction_annotation.txt	954	-699815149	\N	f	2022-09-29 09:54:32.165+00
1896	45	1770	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_data/multiqc_rseqc_read_distribution.txt	multiqc_rseqc_read_distribution.txt	2267	-398181307	\N	f	2022-09-29 09:54:32.173+00
1897	45	1770	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_data/multiqc_samtools_flagstat.txt	multiqc_samtools_flagstat.txt	1328	1006689788	\N	f	2022-09-29 09:54:32.173+00
1898	45	1770	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_data/multiqc_samtools_idxstats.txt	multiqc_samtools_idxstats.txt	629	101917076	\N	f	2022-09-29 09:54:32.165+00
1899	45	1770	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_data/multiqc_samtools_stats.txt	multiqc_samtools_stats.txt	2349	2030637103	\N	f	2022-09-29 09:54:32.173+00
1900	45	1770	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_data/multiqc_sources.txt	multiqc_sources.txt	12812	258695569	\N	f	2022-09-29 09:54:32.173+00
1901	45	1770	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_data/multiqc_star.txt	multiqc_star.txt	1113	-1689208354	\N	f	2022-09-29 09:54:32.165+00
1902	45	1772	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_cutadapt_filtered_reads_plot_1.pdf	mqc_cutadapt_filtered_reads_plot_1.pdf	12124	1062236988	\N	f	2022-09-29 09:54:32.165+00
1903	45	1772	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_cutadapt_filtered_reads_plot_1_pc.pdf	mqc_cutadapt_filtered_reads_plot_1_pc.pdf	12699	2017681291	\N	f	2022-09-29 09:54:32.161+00
1904	45	1772	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_cutadapt_trimmed_sequences_plot_3_Counts.pdf	mqc_cutadapt_trimmed_sequences_plot_3_Counts.pdf	17935	1887140954	\N	f	2022-09-29 09:54:32.161+00
1905	45	1772	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_cutadapt_trimmed_sequences_plot_3_Obs_Exp.pdf	mqc_cutadapt_trimmed_sequences_plot_3_Obs_Exp.pdf	20287	575147736	\N	f	2022-09-29 09:54:32.161+00
1906	45	1772	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_fastqc_adapter_content_plot_1.pdf	mqc_fastqc_adapter_content_plot_1.pdf	18841	-2021291756	\N	f	2022-09-29 09:54:32.165+00
1907	45	1772	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_fastqc_overrepresented_sequences_plot-2_1.pdf	mqc_fastqc_overrepresented_sequences_plot-2_1.pdf	14126	-226857590	\N	f	2022-09-29 09:54:32.165+00
1908	45	1772	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_fastqc_overrepresented_sequences_plot_1.pdf	mqc_fastqc_overrepresented_sequences_plot_1.pdf	14789	308327334	\N	f	2022-09-29 09:54:32.165+00
1909	45	1772	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_fastqc_per_base_n_content_plot-2_1.pdf	mqc_fastqc_per_base_n_content_plot-2_1.pdf	16726	854283236	\N	f	2022-09-29 09:54:32.161+00
1910	45	1772	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_fastqc_per_base_n_content_plot_1.pdf	mqc_fastqc_per_base_n_content_plot_1.pdf	16740	487547042	\N	f	2022-09-29 09:54:32.165+00
1911	45	1772	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_fastqc_per_base_sequence_quality_plot-2_1.pdf	mqc_fastqc_per_base_sequence_quality_plot-2_1.pdf	17031	2046184464	\N	f	2022-09-29 09:54:32.161+00
1912	45	1772	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_fastqc_per_base_sequence_quality_plot_1.pdf	mqc_fastqc_per_base_sequence_quality_plot_1.pdf	17066	1492756209	\N	f	2022-09-29 09:54:32.161+00
1913	45	1772	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_fastqc_per_sequence_gc_content_plot-2_Counts.pdf	mqc_fastqc_per_sequence_gc_content_plot-2_Counts.pdf	18648	821443377	\N	f	2022-09-29 09:54:32.165+00
1914	45	1772	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_fastqc_per_sequence_gc_content_plot-2_Percentages.pdf	mqc_fastqc_per_sequence_gc_content_plot-2_Percentages.pdf	18839	-114821122	\N	f	2022-09-29 09:54:32.161+00
1915	45	1772	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_fastqc_per_sequence_gc_content_plot_Counts.pdf	mqc_fastqc_per_sequence_gc_content_plot_Counts.pdf	18329	2105735612	\N	f	2022-09-29 09:54:32.161+00
1916	45	1772	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_fastqc_per_sequence_gc_content_plot_Percentages.pdf	mqc_fastqc_per_sequence_gc_content_plot_Percentages.pdf	18828	-18108787	\N	f	2022-09-29 09:54:32.161+00
1917	45	1772	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_fastqc_per_sequence_quality_scores_plot-2_1.pdf	mqc_fastqc_per_sequence_quality_scores_plot-2_1.pdf	16179	-792519065	\N	f	2022-09-29 09:54:32.161+00
1918	45	1772	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_fastqc_per_sequence_quality_scores_plot_1.pdf	mqc_fastqc_per_sequence_quality_scores_plot_1.pdf	15699	-360961775	\N	f	2022-09-29 09:54:32.161+00
1919	45	1772	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_fastqc_sequence_counts_plot-2_1.pdf	mqc_fastqc_sequence_counts_plot-2_1.pdf	14443	-1260783374	\N	f	2022-09-29 09:54:32.161+00
1920	45	1772	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_fastqc_sequence_counts_plot-2_1_pc.pdf	mqc_fastqc_sequence_counts_plot-2_1_pc.pdf	15015	-1310479849	\N	f	2022-09-29 09:54:32.165+00
1921	45	1772	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_fastqc_sequence_counts_plot_1.pdf	mqc_fastqc_sequence_counts_plot_1.pdf	14436	1181495675	\N	f	2022-09-29 09:54:32.165+00
1922	45	1772	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_fastqc_sequence_counts_plot_1_pc.pdf	mqc_fastqc_sequence_counts_plot_1_pc.pdf	15014	-602700666	\N	f	2022-09-29 09:54:32.161+00
1923	45	1772	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_fastqc_sequence_duplication_levels_plot-2_1.pdf	mqc_fastqc_sequence_duplication_levels_plot-2_1.pdf	16988	-975964224	\N	f	2022-09-29 09:54:32.165+00
1924	45	1772	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_fastqc_sequence_duplication_levels_plot_1.pdf	mqc_fastqc_sequence_duplication_levels_plot_1.pdf	16974	1062856733	\N	f	2022-09-29 09:54:32.165+00
1925	45	1772	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_fastqc_sequence_length_distribution_plot-2_1.pdf	mqc_fastqc_sequence_length_distribution_plot-2_1.pdf	17421	213521893	\N	f	2022-09-29 09:54:32.161+00
1926	45	1772	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_fastqc_sequence_length_distribution_plot_1.pdf	mqc_fastqc_sequence_length_distribution_plot_1.pdf	16280	-1744323143	\N	f	2022-09-29 09:54:32.161+00
1927	45	1772	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_mqc_mplplot_zxqfwhjbcr_1.pdf	mqc_mqc_mplplot_zxqfwhjbcr_1.pdf	15593	-620442645	\N	f	2022-09-29 09:54:32.165+00
1928	45	1772	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_picard_deduplication_1.pdf	mqc_picard_deduplication_1.pdf	14074	183545191	\N	f	2022-09-29 09:54:32.165+00
1929	45	1772	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_picard_deduplication_1_pc.pdf	mqc_picard_deduplication_1_pc.pdf	14675	881933310	\N	f	2022-09-29 09:54:32.161+00
1930	45	1772	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_preseq_plot_1.pdf	mqc_preseq_plot_1.pdf	17602	-436859768	\N	f	2022-09-29 09:54:32.161+00
1931	45	1772	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_qualimap_gene_coverage_profile_Counts.pdf	mqc_qualimap_gene_coverage_profile_Counts.pdf	18894	2073898679	\N	f	2022-09-29 09:54:32.165+00
1932	45	1772	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_qualimap_gene_coverage_profile_Normalised.pdf	mqc_qualimap_gene_coverage_profile_Normalised.pdf	18964	836478670	\N	f	2022-09-29 09:54:32.161+00
1933	45	1772	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_qualimap_genomic_origin_1.pdf	mqc_qualimap_genomic_origin_1.pdf	15056	-278850662	\N	f	2022-09-29 09:54:32.161+00
1934	45	1772	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_qualimap_genomic_origin_1_pc.pdf	mqc_qualimap_genomic_origin_1_pc.pdf	15369	221913243	\N	f	2022-09-29 09:54:32.161+00
1935	45	1772	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_rseqc_infer_experiment_plot_1.pdf	mqc_rseqc_infer_experiment_plot_1.pdf	13859	-790611114	\N	f	2022-09-29 09:54:32.165+00
1936	45	1772	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_rseqc_inner_distance_plot_Counts.pdf	mqc_rseqc_inner_distance_plot_Counts.pdf	15171	-1132902597	\N	f	2022-09-29 09:54:32.161+00
1937	45	1772	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_rseqc_inner_distance_plot_Percentages.pdf	mqc_rseqc_inner_distance_plot_Percentages.pdf	15687	-1674930266	\N	f	2022-09-29 09:54:32.161+00
1938	45	1772	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_rseqc_junction_annotation_junctions_plot_Events.pdf	mqc_rseqc_junction_annotation_junctions_plot_Events.pdf	14352	-1441556480	\N	f	2022-09-29 09:54:32.165+00
1939	45	1772	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_rseqc_junction_annotation_junctions_plot_Events_pc.pdf	mqc_rseqc_junction_annotation_junctions_plot_Events_pc.pdf	14699	-1709022518	\N	f	2022-09-29 09:54:32.165+00
1940	45	1772	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_rseqc_junction_annotation_junctions_plot_Junctions.pdf	mqc_rseqc_junction_annotation_junctions_plot_Junctions.pdf	13759	53312994	\N	f	2022-09-29 09:54:32.161+00
1941	45	1772	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_rseqc_junction_annotation_junctions_plot_Junctions_pc.pdf	mqc_rseqc_junction_annotation_junctions_plot_Junctions_pc.pdf	14501	1522559508	\N	f	2022-09-29 09:54:32.161+00
1942	45	1772	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_rseqc_junction_saturation_plot_All_Junctions.pdf	mqc_rseqc_junction_saturation_plot_All_Junctions.pdf	14667	-1696464294	\N	f	2022-09-29 09:54:32.161+00
1943	45	1772	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_rseqc_junction_saturation_plot_Known_Junctions.pdf	mqc_rseqc_junction_saturation_plot_Known_Junctions.pdf	14311	965340169	\N	f	2022-09-29 09:54:32.161+00
1944	45	1772	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_rseqc_junction_saturation_plot_Novel_Junctions.pdf	mqc_rseqc_junction_saturation_plot_Novel_Junctions.pdf	14397	-763764054	\N	f	2022-09-29 09:54:32.161+00
1945	45	1772	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_rseqc_read_distribution_plot_1.pdf	mqc_rseqc_read_distribution_plot_1.pdf	16788	-1288716777	\N	f	2022-09-29 09:54:32.161+00
1946	45	1772	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_rseqc_read_distribution_plot_1_pc.pdf	mqc_rseqc_read_distribution_plot_1_pc.pdf	17462	1388416513	\N	f	2022-09-29 09:54:32.161+00
1947	45	1772	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_rseqc_read_dups_plot_1.pdf	mqc_rseqc_read_dups_plot_1.pdf	15009	1371728551	\N	f	2022-09-29 09:54:32.161+00
1948	45	1772	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_samtools-idxstats-mapped-reads-plot_Normalised_Counts.pdf	mqc_samtools-idxstats-mapped-reads-plot_Normalised_Counts.pdf	14536	516036690	\N	f	2022-09-29 09:54:32.161+00
1949	45	1772	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_samtools-idxstats-mapped-reads-plot_Observed_over_Expected_Counts.pdf	mqc_samtools-idxstats-mapped-reads-plot_Observed_over_Expected_Counts.pdf	15522	1867428636	\N	f	2022-09-29 09:54:32.165+00
1950	45	1772	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_samtools-idxstats-mapped-reads-plot_Raw_Counts.pdf	mqc_samtools-idxstats-mapped-reads-plot_Raw_Counts.pdf	14367	-1319640566	\N	f	2022-09-29 09:54:32.161+00
1951	45	1772	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_samtools_alignment_plot_1.pdf	mqc_samtools_alignment_plot_1.pdf	12415	-880106985	\N	f	2022-09-29 09:54:32.161+00
1952	45	1772	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_samtools_alignment_plot_1_pc.pdf	mqc_samtools_alignment_plot_1_pc.pdf	13023	-769706220	\N	f	2022-09-29 09:54:32.161+00
1953	45	1772	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_star_alignment_plot_1.pdf	mqc_star_alignment_plot_1.pdf	14576	970444958	\N	f	2022-09-29 09:54:32.161+00
1954	45	1772	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_star_alignment_plot_1_pc.pdf	mqc_star_alignment_plot_1_pc.pdf	15157	2129563862	\N	f	2022-09-29 09:54:32.165+00
1955	45	1773	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/png/mqc_cutadapt_filtered_reads_plot_1.png	mqc_cutadapt_filtered_reads_plot_1.png	12310	-1633864538	\N	f	2022-09-29 09:54:32.153+00
1956	45	1773	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/png/mqc_cutadapt_filtered_reads_plot_1_pc.png	mqc_cutadapt_filtered_reads_plot_1_pc.png	12629	1121284932	\N	f	2022-09-29 09:54:32.157+00
1957	45	1773	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/png/mqc_cutadapt_trimmed_sequences_plot_3_Counts.png	mqc_cutadapt_trimmed_sequences_plot_3_Counts.png	29935	-575670001	\N	f	2022-09-29 09:54:32.157+00
1958	45	1773	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/png/mqc_cutadapt_trimmed_sequences_plot_3_Obs_Exp.png	mqc_cutadapt_trimmed_sequences_plot_3_Obs_Exp.png	71346	-1853044662	\N	f	2022-09-29 09:54:32.153+00
1959	45	1773	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/png/mqc_fastqc_adapter_content_plot_1.png	mqc_fastqc_adapter_content_plot_1.png	32501	721160907	\N	f	2022-09-29 09:54:32.157+00
1960	45	1773	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/png/mqc_fastqc_overrepresented_sequences_plot-2_1.png	mqc_fastqc_overrepresented_sequences_plot-2_1.png	16054	-1982690306	\N	f	2022-09-29 09:54:32.161+00
1961	45	1773	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/png/mqc_fastqc_overrepresented_sequences_plot_1.png	mqc_fastqc_overrepresented_sequences_plot_1.png	16337	-685319803	\N	f	2022-09-29 09:54:32.157+00
1962	45	1773	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/png/mqc_fastqc_per_base_n_content_plot-2_1.png	mqc_fastqc_per_base_n_content_plot-2_1.png	17235	-646240718	\N	f	2022-09-29 09:54:32.153+00
1963	45	1773	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/png/mqc_fastqc_per_base_n_content_plot_1.png	mqc_fastqc_per_base_n_content_plot_1.png	17232	-898984346	\N	f	2022-09-29 09:54:32.157+00
1964	45	1773	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/png/mqc_fastqc_per_base_sequence_quality_plot-2_1.png	mqc_fastqc_per_base_sequence_quality_plot-2_1.png	23639	-1460794683	\N	f	2022-09-29 09:54:32.157+00
1965	45	1773	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/png/mqc_fastqc_per_base_sequence_quality_plot_1.png	mqc_fastqc_per_base_sequence_quality_plot_1.png	23541	-178686918	\N	f	2022-09-29 09:54:32.157+00
1966	45	1773	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/png/mqc_fastqc_per_sequence_gc_content_plot-2_Counts.png	mqc_fastqc_per_sequence_gc_content_plot-2_Counts.png	49284	73476762	\N	f	2022-09-29 09:54:32.157+00
1967	45	1773	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/png/mqc_fastqc_per_sequence_gc_content_plot-2_Percentages.png	mqc_fastqc_per_sequence_gc_content_plot-2_Percentages.png	61367	1361144038	\N	f	2022-09-29 09:54:32.157+00
1968	45	1773	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/png/mqc_fastqc_per_sequence_gc_content_plot_Counts.png	mqc_fastqc_per_sequence_gc_content_plot_Counts.png	51400	2122243119	\N	f	2022-09-29 09:54:32.157+00
1969	45	1773	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/png/mqc_fastqc_per_sequence_gc_content_plot_Percentages.png	mqc_fastqc_per_sequence_gc_content_plot_Percentages.png	63175	1670555802	\N	f	2022-09-29 09:54:32.157+00
1970	45	1773	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/png/mqc_fastqc_per_sequence_quality_scores_plot-2_1.png	mqc_fastqc_per_sequence_quality_scores_plot-2_1.png	38431	-1640998989	\N	f	2022-09-29 09:54:32.157+00
1971	45	1773	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/png/mqc_fastqc_per_sequence_quality_scores_plot_1.png	mqc_fastqc_per_sequence_quality_scores_plot_1.png	37725	805950312	\N	f	2022-09-29 09:54:32.157+00
1972	45	1773	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/png/mqc_fastqc_sequence_counts_plot-2_1.png	mqc_fastqc_sequence_counts_plot-2_1.png	13425	-670946781	\N	f	2022-09-29 09:54:32.157+00
1973	45	1773	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/png/mqc_fastqc_sequence_counts_plot-2_1_pc.png	mqc_fastqc_sequence_counts_plot-2_1_pc.png	13770	-1092578163	\N	f	2022-09-29 09:54:32.157+00
1974	45	1773	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/png/mqc_fastqc_sequence_counts_plot_1.png	mqc_fastqc_sequence_counts_plot_1.png	13425	1562623819	\N	f	2022-09-29 09:54:32.157+00
1975	45	1773	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/png/mqc_fastqc_sequence_counts_plot_1_pc.png	mqc_fastqc_sequence_counts_plot_1_pc.png	13768	688312177	\N	f	2022-09-29 09:54:32.157+00
1976	45	1773	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/png/mqc_fastqc_sequence_duplication_levels_plot-2_1.png	mqc_fastqc_sequence_duplication_levels_plot-2_1.png	46291	286819044	\N	f	2022-09-29 09:54:32.153+00
3123	58	3122	original/upload	upload	95823	\N	\N	t	2022-09-29 13:47:08.134+00
1977	45	1773	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/png/mqc_fastqc_sequence_duplication_levels_plot_1.png	mqc_fastqc_sequence_duplication_levels_plot_1.png	45604	-1208121649	\N	f	2022-09-29 09:54:32.157+00
1978	45	1773	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/png/mqc_fastqc_sequence_length_distribution_plot-2_1.png	mqc_fastqc_sequence_length_distribution_plot-2_1.png	33465	89401353	\N	f	2022-09-29 09:54:32.153+00
1979	45	1773	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/png/mqc_fastqc_sequence_length_distribution_plot_1.png	mqc_fastqc_sequence_length_distribution_plot_1.png	25266	1467614260	\N	f	2022-09-29 09:54:32.153+00
1980	45	1773	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/png/mqc_mqc_mplplot_zxqfwhjbcr_1.png	mqc_mqc_mplplot_zxqfwhjbcr_1.png	25653	-356662372	\N	f	2022-09-29 09:54:32.153+00
1981	45	1773	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/png/mqc_picard_deduplication_1.png	mqc_picard_deduplication_1.png	11999	-2109850869	\N	f	2022-09-29 09:54:32.153+00
1982	45	1773	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/png/mqc_picard_deduplication_1_pc.png	mqc_picard_deduplication_1_pc.png	12483	397669256	\N	f	2022-09-29 09:54:32.157+00
1983	45	1773	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/png/mqc_preseq_plot_1.png	mqc_preseq_plot_1.png	47684	-343212461	\N	f	2022-09-29 09:54:32.157+00
1984	45	1773	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/png/mqc_qualimap_gene_coverage_profile_Counts.png	mqc_qualimap_gene_coverage_profile_Counts.png	57134	1358519598	\N	f	2022-09-29 09:54:32.157+00
1985	45	1773	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/png/mqc_qualimap_gene_coverage_profile_Normalised.png	mqc_qualimap_gene_coverage_profile_Normalised.png	61968	67217571	\N	f	2022-09-29 09:54:32.157+00
1986	45	1773	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/png/mqc_qualimap_genomic_origin_1.png	mqc_qualimap_genomic_origin_1.png	10800	843041967	\N	f	2022-09-29 09:54:32.157+00
1987	45	1773	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/png/mqc_qualimap_genomic_origin_1_pc.png	mqc_qualimap_genomic_origin_1_pc.png	10660	-1445929489	\N	f	2022-09-29 09:54:32.157+00
1988	45	1773	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/png/mqc_rseqc_infer_experiment_plot_1.png	mqc_rseqc_infer_experiment_plot_1.png	10286	-2081740291	\N	f	2022-09-29 09:54:32.157+00
1989	45	1773	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/png/mqc_rseqc_inner_distance_plot_Counts.png	mqc_rseqc_inner_distance_plot_Counts.png	49669	-1940278212	\N	f	2022-09-29 09:54:32.153+00
1990	45	1773	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/png/mqc_rseqc_inner_distance_plot_Percentages.png	mqc_rseqc_inner_distance_plot_Percentages.png	48913	-604064809	\N	f	2022-09-29 09:54:32.161+00
1991	45	1773	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/png/mqc_rseqc_junction_annotation_junctions_plot_Events.png	mqc_rseqc_junction_annotation_junctions_plot_Events.png	12444	-1144705009	\N	f	2022-09-29 09:54:32.157+00
1992	45	1773	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/png/mqc_rseqc_junction_annotation_junctions_plot_Events_pc.png	mqc_rseqc_junction_annotation_junctions_plot_Events_pc.png	13007	-870332004	\N	f	2022-09-29 09:54:32.157+00
1993	45	1773	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/png/mqc_rseqc_junction_annotation_junctions_plot_Junctions.png	mqc_rseqc_junction_annotation_junctions_plot_Junctions.png	12637	1848648209	\N	f	2022-09-29 09:54:32.157+00
1994	45	1773	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/png/mqc_rseqc_junction_annotation_junctions_plot_Junctions_pc.png	mqc_rseqc_junction_annotation_junctions_plot_Junctions_pc.png	13146	1963742541	\N	f	2022-09-29 09:54:32.157+00
1995	45	1773	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/png/mqc_rseqc_junction_saturation_plot_All_Junctions.png	mqc_rseqc_junction_saturation_plot_All_Junctions.png	35125	275958742	\N	f	2022-09-29 09:54:32.157+00
1996	45	1773	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/png/mqc_rseqc_junction_saturation_plot_Known_Junctions.png	mqc_rseqc_junction_saturation_plot_Known_Junctions.png	26460	-827961297	\N	f	2022-09-29 09:54:32.153+00
1997	45	1773	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/png/mqc_rseqc_junction_saturation_plot_Novel_Junctions.png	mqc_rseqc_junction_saturation_plot_Novel_Junctions.png	42646	-1935450170	\N	f	2022-09-29 09:54:32.157+00
1998	45	1773	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/png/mqc_rseqc_read_distribution_plot_1.png	mqc_rseqc_read_distribution_plot_1.png	15381	-108517229	\N	f	2022-09-29 09:54:32.153+00
1999	45	1773	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/png/mqc_rseqc_read_distribution_plot_1_pc.png	mqc_rseqc_read_distribution_plot_1_pc.png	15221	-807864214	\N	f	2022-09-29 09:54:32.157+00
2000	45	1773	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/png/mqc_rseqc_read_dups_plot_1.png	mqc_rseqc_read_dups_plot_1.png	20822	1276862618	\N	f	2022-09-29 09:54:32.157+00
2001	45	1773	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/png/mqc_samtools-idxstats-mapped-reads-plot_Normalised_Counts.png	mqc_samtools-idxstats-mapped-reads-plot_Normalised_Counts.png	42239	150508200	\N	f	2022-09-29 09:54:32.153+00
2002	45	1773	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/png/mqc_samtools-idxstats-mapped-reads-plot_Observed_over_Expected_Counts.png	mqc_samtools-idxstats-mapped-reads-plot_Observed_over_Expected_Counts.png	43508	1697056116	\N	f	2022-09-29 09:54:32.153+00
2003	45	1773	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/png/mqc_samtools-idxstats-mapped-reads-plot_Raw_Counts.png	mqc_samtools-idxstats-mapped-reads-plot_Raw_Counts.png	39151	2140903712	\N	f	2022-09-29 09:54:32.157+00
2004	45	1773	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/png/mqc_samtools_alignment_plot_1.png	mqc_samtools_alignment_plot_1.png	8995	1887867677	\N	f	2022-09-29 09:54:32.157+00
2005	45	1773	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/png/mqc_samtools_alignment_plot_1_pc.png	mqc_samtools_alignment_plot_1_pc.png	9450	-1633894018	\N	f	2022-09-29 09:54:32.153+00
2139	45	1792	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_1/css/bgtop.png	bgtop.png	458	1452213310	\N	f	2022-09-29 09:54:32.137+00
2006	45	1773	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/png/mqc_star_alignment_plot_1.png	mqc_star_alignment_plot_1.png	12397	791826825	\N	f	2022-09-29 09:54:32.161+00
2007	45	1773	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/png/mqc_star_alignment_plot_1_pc.png	mqc_star_alignment_plot_1_pc.png	12847	-491668817	\N	f	2022-09-29 09:54:32.157+00
2008	45	1774	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/svg/mqc_cutadapt_filtered_reads_plot_1.svg	mqc_cutadapt_filtered_reads_plot_1.svg	25010	-44065896	\N	f	2022-09-29 09:54:32.149+00
2009	45	1774	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/svg/mqc_cutadapt_filtered_reads_plot_1_pc.svg	mqc_cutadapt_filtered_reads_plot_1_pc.svg	25956	-1855212413	\N	f	2022-09-29 09:54:32.149+00
2010	45	1774	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/svg/mqc_cutadapt_trimmed_sequences_plot_3_Counts.svg	mqc_cutadapt_trimmed_sequences_plot_3_Counts.svg	43498	-884149825	\N	f	2022-09-29 09:54:32.153+00
2011	45	1774	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/svg/mqc_cutadapt_trimmed_sequences_plot_3_Obs_Exp.svg	mqc_cutadapt_trimmed_sequences_plot_3_Obs_Exp.svg	52556	-1202604896	\N	f	2022-09-29 09:54:32.153+00
2012	45	1774	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/svg/mqc_fastqc_adapter_content_plot_1.svg	mqc_fastqc_adapter_content_plot_1.svg	52670	-586800187	\N	f	2022-09-29 09:54:32.145+00
2013	45	1774	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/svg/mqc_fastqc_overrepresented_sequences_plot-2_1.svg	mqc_fastqc_overrepresented_sequences_plot-2_1.svg	32453	2132826189	\N	f	2022-09-29 09:54:32.153+00
2014	45	1774	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/svg/mqc_fastqc_overrepresented_sequences_plot_1.svg	mqc_fastqc_overrepresented_sequences_plot_1.svg	34086	672074184	\N	f	2022-09-29 09:54:32.153+00
2015	45	1774	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/svg/mqc_fastqc_per_base_n_content_plot-2_1.svg	mqc_fastqc_per_base_n_content_plot-2_1.svg	38536	1090833418	\N	f	2022-09-29 09:54:32.149+00
2016	45	1774	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/svg/mqc_fastqc_per_base_n_content_plot_1.svg	mqc_fastqc_per_base_n_content_plot_1.svg	38536	-441259603	\N	f	2022-09-29 09:54:32.149+00
2017	45	1774	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/svg/mqc_fastqc_per_base_sequence_quality_plot-2_1.svg	mqc_fastqc_per_base_sequence_quality_plot-2_1.svg	38155	-1010040737	\N	f	2022-09-29 09:54:32.153+00
2018	45	1774	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/svg/mqc_fastqc_per_base_sequence_quality_plot_1.svg	mqc_fastqc_per_base_sequence_quality_plot_1.svg	38160	1032705534	\N	f	2022-09-29 09:54:32.149+00
2019	45	1774	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/svg/mqc_fastqc_per_sequence_gc_content_plot-2_Counts.svg	mqc_fastqc_per_sequence_gc_content_plot-2_Counts.svg	46091	-830705433	\N	f	2022-09-29 09:54:32.149+00
2020	45	1774	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/svg/mqc_fastqc_per_sequence_gc_content_plot-2_Percentages.svg	mqc_fastqc_per_sequence_gc_content_plot-2_Percentages.svg	44606	-183436473	\N	f	2022-09-29 09:54:32.149+00
2021	45	1774	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/svg/mqc_fastqc_per_sequence_gc_content_plot_Counts.svg	mqc_fastqc_per_sequence_gc_content_plot_Counts.svg	45550	1894285750	\N	f	2022-09-29 09:54:32.153+00
2022	45	1774	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/svg/mqc_fastqc_per_sequence_gc_content_plot_Percentages.svg	mqc_fastqc_per_sequence_gc_content_plot_Percentages.svg	44580	-621386562	\N	f	2022-09-29 09:54:32.149+00
2023	45	1774	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/svg/mqc_fastqc_per_sequence_quality_scores_plot-2_1.svg	mqc_fastqc_per_sequence_quality_scores_plot-2_1.svg	38412	1043694289	\N	f	2022-09-29 09:54:32.149+00
2024	45	1774	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/svg/mqc_fastqc_per_sequence_quality_scores_plot_1.svg	mqc_fastqc_per_sequence_quality_scores_plot_1.svg	37635	-1428970931	\N	f	2022-09-29 09:54:32.153+00
2025	45	1774	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/svg/mqc_fastqc_sequence_counts_plot-2_1.svg	mqc_fastqc_sequence_counts_plot-2_1.svg	30051	-2051751327	\N	f	2022-09-29 09:54:32.149+00
2026	45	1774	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/svg/mqc_fastqc_sequence_counts_plot-2_1_pc.svg	mqc_fastqc_sequence_counts_plot-2_1_pc.svg	30991	-227339267	\N	f	2022-09-29 09:54:32.149+00
2027	45	1774	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/svg/mqc_fastqc_sequence_counts_plot_1.svg	mqc_fastqc_sequence_counts_plot_1.svg	30046	-259137769	\N	f	2022-09-29 09:54:32.149+00
2028	45	1774	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/svg/mqc_fastqc_sequence_counts_plot_1_pc.svg	mqc_fastqc_sequence_counts_plot_1_pc.svg	30995	-143417835	\N	f	2022-09-29 09:54:32.153+00
2029	45	1774	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/svg/mqc_fastqc_sequence_duplication_levels_plot-2_1.svg	mqc_fastqc_sequence_duplication_levels_plot-2_1.svg	39368	-139391945	\N	f	2022-09-29 09:54:32.149+00
2030	45	1774	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/svg/mqc_fastqc_sequence_duplication_levels_plot_1.svg	mqc_fastqc_sequence_duplication_levels_plot_1.svg	39376	-2144377101	\N	f	2022-09-29 09:54:32.149+00
2031	45	1774	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/svg/mqc_fastqc_sequence_length_distribution_plot-2_1.svg	mqc_fastqc_sequence_length_distribution_plot-2_1.svg	39630	379975380	\N	f	2022-09-29 09:54:32.153+00
2032	45	1774	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/svg/mqc_fastqc_sequence_length_distribution_plot_1.svg	mqc_fastqc_sequence_length_distribution_plot_1.svg	34961	-1889377743	\N	f	2022-09-29 09:54:32.153+00
2033	45	1774	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/svg/mqc_mqc_mplplot_zxqfwhjbcr_1.svg	mqc_mqc_mplplot_zxqfwhjbcr_1.svg	31355	-1480243935	\N	f	2022-09-29 09:54:32.149+00
2034	45	1774	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/svg/mqc_picard_deduplication_1.svg	mqc_picard_deduplication_1.svg	31379	1830602713	\N	f	2022-09-29 09:54:32.149+00
2035	45	1774	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/svg/mqc_picard_deduplication_1_pc.svg	mqc_picard_deduplication_1_pc.svg	32813	-376010308	\N	f	2022-09-29 09:54:32.149+00
2036	45	1774	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/svg/mqc_preseq_plot_1.svg	mqc_preseq_plot_1.svg	39037	-1324906324	\N	f	2022-09-29 09:54:32.149+00
2037	45	1774	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/svg/mqc_qualimap_gene_coverage_profile_Counts.svg	mqc_qualimap_gene_coverage_profile_Counts.svg	41789	-1382091029	\N	f	2022-09-29 09:54:32.153+00
2038	45	1774	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/svg/mqc_qualimap_gene_coverage_profile_Normalised.svg	mqc_qualimap_gene_coverage_profile_Normalised.svg	40792	-1279236192	\N	f	2022-09-29 09:54:32.149+00
2039	45	1774	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/svg/mqc_qualimap_genomic_origin_1.svg	mqc_qualimap_genomic_origin_1.svg	30190	-1282985906	\N	f	2022-09-29 09:54:32.153+00
2040	45	1774	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/svg/mqc_qualimap_genomic_origin_1_pc.svg	mqc_qualimap_genomic_origin_1_pc.svg	28973	1378390571	\N	f	2022-09-29 09:54:32.153+00
2041	45	1774	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/svg/mqc_rseqc_infer_experiment_plot_1.svg	mqc_rseqc_infer_experiment_plot_1.svg	25685	-340233668	\N	f	2022-09-29 09:54:32.149+00
2042	45	1774	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/svg/mqc_rseqc_inner_distance_plot_Counts.svg	mqc_rseqc_inner_distance_plot_Counts.svg	31044	1515291719	\N	f	2022-09-29 09:54:32.149+00
2043	45	1774	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/svg/mqc_rseqc_inner_distance_plot_Percentages.svg	mqc_rseqc_inner_distance_plot_Percentages.svg	31521	268451611	\N	f	2022-09-29 09:54:32.149+00
2044	45	1774	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/svg/mqc_rseqc_junction_annotation_junctions_plot_Events.svg	mqc_rseqc_junction_annotation_junctions_plot_Events.svg	28846	-2130009326	\N	f	2022-09-29 09:54:32.149+00
2045	45	1774	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/svg/mqc_rseqc_junction_annotation_junctions_plot_Events_pc.svg	mqc_rseqc_junction_annotation_junctions_plot_Events_pc.svg	30050	1390008262	\N	f	2022-09-29 09:54:32.149+00
2046	45	1774	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/svg/mqc_rseqc_junction_annotation_junctions_plot_Junctions.svg	mqc_rseqc_junction_annotation_junctions_plot_Junctions.svg	29755	-1628426480	\N	f	2022-09-29 09:54:32.153+00
2047	45	1774	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/svg/mqc_rseqc_junction_annotation_junctions_plot_Junctions_pc.svg	mqc_rseqc_junction_annotation_junctions_plot_Junctions_pc.svg	30341	-1864587779	\N	f	2022-09-29 09:54:32.149+00
2048	45	1774	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/svg/mqc_rseqc_junction_saturation_plot_All_Junctions.svg	mqc_rseqc_junction_saturation_plot_All_Junctions.svg	29330	-1347354226	\N	f	2022-09-29 09:54:32.149+00
2049	45	1774	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/svg/mqc_rseqc_junction_saturation_plot_Known_Junctions.svg	mqc_rseqc_junction_saturation_plot_Known_Junctions.svg	29280	-1667974367	\N	f	2022-09-29 09:54:32.153+00
2050	45	1774	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/svg/mqc_rseqc_junction_saturation_plot_Novel_Junctions.svg	mqc_rseqc_junction_saturation_plot_Novel_Junctions.svg	30675	607613241	\N	f	2022-09-29 09:54:32.149+00
2051	45	1774	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/svg/mqc_rseqc_read_distribution_plot_1.svg	mqc_rseqc_read_distribution_plot_1.svg	40933	1941714529	\N	f	2022-09-29 09:54:32.153+00
2052	45	1774	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/svg/mqc_rseqc_read_distribution_plot_1_pc.svg	mqc_rseqc_read_distribution_plot_1_pc.svg	40215	-54603386	\N	f	2022-09-29 09:54:32.149+00
2053	45	1774	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/svg/mqc_rseqc_read_dups_plot_1.svg	mqc_rseqc_read_dups_plot_1.svg	29023	521987406	\N	f	2022-09-29 09:54:32.153+00
2054	45	1774	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/svg/mqc_samtools-idxstats-mapped-reads-plot_Normalised_Counts.svg	mqc_samtools-idxstats-mapped-reads-plot_Normalised_Counts.svg	30896	-1719372309	\N	f	2022-09-29 09:54:32.149+00
2055	45	1774	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/svg/mqc_samtools-idxstats-mapped-reads-plot_Observed_over_Expected_Counts.svg	mqc_samtools-idxstats-mapped-reads-plot_Observed_over_Expected_Counts.svg	32086	1424985428	\N	f	2022-09-29 09:54:32.149+00
2056	45	1774	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/svg/mqc_samtools-idxstats-mapped-reads-plot_Raw_Counts.svg	mqc_samtools-idxstats-mapped-reads-plot_Raw_Counts.svg	31085	-1818599781	\N	f	2022-09-29 09:54:32.149+00
2057	45	1774	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/svg/mqc_samtools_alignment_plot_1.svg	mqc_samtools_alignment_plot_1.svg	21831	1625034808	\N	f	2022-09-29 09:54:32.153+00
2058	45	1774	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/svg/mqc_samtools_alignment_plot_1_pc.svg	mqc_samtools_alignment_plot_1_pc.svg	23269	1779233190	\N	f	2022-09-29 09:54:32.153+00
2059	45	1774	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/svg/mqc_star_alignment_plot_1.svg	mqc_star_alignment_plot_1.svg	32270	39238255	\N	f	2022-09-29 09:54:32.149+00
2060	45	1774	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_plots/svg/mqc_star_alignment_plot_1_pc.svg	mqc_star_alignment_plot_1_pc.svg	33218	-1627470080	\N	f	2022-09-29 09:54:32.149+00
2061	45	1769	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/multiqc/star_salmon/multiqc_report.html	multiqc_report.html	1754772	1448160576	\N	f	2022-09-29 09:54:32.145+00
2062	45	1775	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/pipeline_info/execution_report_2022-09-26_12-18-55.html	execution_report_2022-09-26_12-18-55.html	3165239	1660739626	\N	f	2022-09-29 09:54:30.373+00
2063	45	1775	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/pipeline_info/execution_report_2022-09-26_19-28-20.html	execution_report_2022-09-26_19-28-20.html	3248896	407214826	\N	f	2022-09-29 09:54:30.377+00
2064	45	1775	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/pipeline_info/execution_report_2022-09-27_09-37-47.html	execution_report_2022-09-27_09-37-47.html	3249050	-129619230	\N	f	2022-09-29 09:54:30.381+00
2065	45	1775	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/pipeline_info/execution_report_2022-09-27_10-55-33.html	execution_report_2022-09-27_10-55-33.html	2996632	1551740397	\N	f	2022-09-29 09:54:30.369+00
3124	58	3123	original/upload/S3R3_1.fq.gz	S3R3_1.fq.gz	45909	-385117493	\N	f	2022-09-29 13:47:08.13+00
2066	45	1775	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/pipeline_info/execution_report_2022-09-27_12-15-28.html	execution_report_2022-09-27_12-15-28.html	3305705	750016105	\N	f	2022-09-29 09:54:30.389+00
2067	45	1775	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/pipeline_info/execution_timeline_2022-09-26_12-18-55.html	execution_timeline_2022-09-26_12-18-55.html	272666	1656551506	\N	f	2022-09-29 09:54:30.385+00
2068	45	1775	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/pipeline_info/execution_timeline_2022-09-26_19-28-20.html	execution_timeline_2022-09-26_19-28-20.html	278979	316649028	\N	f	2022-09-29 09:54:30.381+00
2069	45	1775	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/pipeline_info/execution_timeline_2022-09-27_09-37-47.html	execution_timeline_2022-09-27_09-37-47.html	279252	803955792	\N	f	2022-09-29 09:54:30.377+00
2070	45	1775	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/pipeline_info/execution_timeline_2022-09-27_10-55-33.html	execution_timeline_2022-09-27_10-55-33.html	256808	-651706410	\N	f	2022-09-29 09:54:30.377+00
2071	45	1775	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/pipeline_info/execution_timeline_2022-09-27_12-15-28.html	execution_timeline_2022-09-27_12-15-28.html	287572	687842330	\N	f	2022-09-29 09:54:30.377+00
2072	45	1775	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/pipeline_info/execution_trace_2022-09-26_12-18-55.txt	execution_trace_2022-09-26_12-18-55.txt	11074	-2140907091	\N	f	2022-09-29 09:54:30.377+00
2073	45	1775	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/pipeline_info/execution_trace_2022-09-26_19-28-20.txt	execution_trace_2022-09-26_19-28-20.txt	14376	-1456048743	\N	f	2022-09-29 09:54:30.377+00
2074	45	1775	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/pipeline_info/execution_trace_2022-09-27_09-37-47.txt	execution_trace_2022-09-27_09-37-47.txt	14436	-52017795	\N	f	2022-09-29 09:54:30.373+00
2075	45	1775	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/pipeline_info/execution_trace_2022-09-27_10-55-33.txt	execution_trace_2022-09-27_10-55-33.txt	2767	-708917848	\N	f	2022-09-29 09:54:30.369+00
2076	45	1775	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/pipeline_info/execution_trace_2022-09-27_12-15-28.txt	execution_trace_2022-09-27_12-15-28.txt	19454	1035573036	\N	f	2022-09-29 09:54:30.377+00
2077	45	1775	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/pipeline_info/pipeline_dag_2022-09-26_12-18-55.html	pipeline_dag_2022-09-26_12-18-55.html	66090	559702358	\N	f	2022-09-29 09:54:30.377+00
2078	45	1775	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/pipeline_info/pipeline_dag_2022-09-26_19-28-20.html	pipeline_dag_2022-09-26_19-28-20.html	66090	648965193	\N	f	2022-09-29 09:54:30.377+00
2079	45	1775	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/pipeline_info/pipeline_dag_2022-09-27_09-37-47.html	pipeline_dag_2022-09-27_09-37-47.html	66090	-214810797	\N	f	2022-09-29 09:54:30.385+00
2080	45	1775	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/pipeline_info/pipeline_dag_2022-09-27_10-55-33.html	pipeline_dag_2022-09-27_10-55-33.html	66090	-862113537	\N	f	2022-09-29 09:54:30.385+00
2081	45	1775	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/pipeline_info/pipeline_dag_2022-09-27_12-15-28.html	pipeline_dag_2022-09-27_12-15-28.html	66090	-1553792134	\N	f	2022-09-29 09:54:30.373+00
2082	45	1775	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/pipeline_info/samplesheet.valid.csv	samplesheet.valid.csv	624	779152488	\N	f	2022-09-29 09:54:30.365+00
2083	45	1775	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/pipeline_info/software_versions.yml	software_versions.yml	1612	270346053	\N	f	2022-09-29 09:54:30.369+00
2084	45	1777	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/bigwig/sample_1.forward.bigWig	sample_1.forward.bigWig	116083857	1967331789	\N	f	2022-09-29 09:54:32.037+00
2085	45	1777	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/bigwig/sample_1.reverse.bigWig	sample_1.reverse.bigWig	114647598	-1304130758	\N	f	2022-09-29 09:54:31.353+00
2086	45	1777	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/bigwig/sample_2.forward.bigWig	sample_2.forward.bigWig	146427090	-1234690069	\N	f	2022-09-29 09:54:31.665+00
2087	45	1777	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/bigwig/sample_2.reverse.bigWig	sample_2.reverse.bigWig	146289618	926031412	\N	f	2022-09-29 09:54:31.509+00
2088	45	1777	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/bigwig/sample_3.forward.bigWig	sample_3.forward.bigWig	111391440	-513907644	\N	f	2022-09-29 09:54:31.789+00
2089	45	1777	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/bigwig/sample_3.reverse.bigWig	sample_3.reverse.bigWig	109808168	226780407	\N	f	2022-09-29 09:54:31.909+00
2090	45	1778	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/deseq2_qc/R_sessionInfo.log	R_sessionInfo.log	2006	1159852003	\N	f	2022-09-29 09:54:32.145+00
2091	45	1778	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/deseq2_qc/deseq2.dds.RData	deseq2.dds.RData	1908184	1765429287	\N	f	2022-09-29 09:54:32.145+00
2092	45	1778	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/deseq2_qc/deseq2.pca.vals.txt	deseq2.pca.vals.txt	216	-119830910	\N	f	2022-09-29 09:54:32.145+00
2093	45	1778	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/deseq2_qc/deseq2.plots.pdf	deseq2.plots.pdf	8883	475587290	\N	f	2022-09-29 09:54:32.145+00
2094	45	1778	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/deseq2_qc/deseq2.sample.dists.txt	deseq2.sample.dists.txt	197	704772103	\N	f	2022-09-29 09:54:32.145+00
2095	45	1779	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/deseq2_qc/size_factors/deseq2.size_factors.RData	deseq2.size_factors.RData	171	-804133273	\N	f	2022-09-29 09:54:32.145+00
2096	45	1779	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/deseq2_qc/size_factors/sample_1.txt	sample_1.txt	37	1718270944	\N	f	2022-09-29 09:54:32.145+00
2097	45	1779	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/deseq2_qc/size_factors/sample_2.txt	sample_2.txt	38	1344984759	\N	f	2022-09-29 09:54:32.145+00
2098	45	1779	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/deseq2_qc/size_factors/sample_3.txt	sample_3.txt	37	-620879642	\N	f	2022-09-29 09:54:32.145+00
2099	45	1781	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/dupradar/box_plot/sample_1_duprateExpBoxplot.pdf	sample_1_duprateExpBoxplot.pdf	57724	-1128970114	\N	f	2022-09-29 09:54:32.117+00
2100	45	1781	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/dupradar/box_plot/sample_2_duprateExpBoxplot.pdf	sample_2_duprateExpBoxplot.pdf	50735	821426788	\N	f	2022-09-29 09:54:32.117+00
2101	45	1781	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/dupradar/box_plot/sample_3_duprateExpBoxplot.pdf	sample_3_duprateExpBoxplot.pdf	59377	-448991882	\N	f	2022-09-29 09:54:32.117+00
3125	58	3123	original/upload/S3R3_2.fq.gz	S3R3_2.fq.gz	49914	-1418131865	\N	f	2022-09-29 13:47:08.134+00
2102	45	1782	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/dupradar/gene_data/sample_1_dupMatrix.txt	sample_1_dupMatrix.txt	6406831	856372159	\N	f	2022-09-29 09:54:32.101+00
2103	45	1782	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/dupradar/gene_data/sample_2_dupMatrix.txt	sample_2_dupMatrix.txt	6489626	-1738694713	\N	f	2022-09-29 09:54:32.109+00
2104	45	1782	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/dupradar/gene_data/sample_3_dupMatrix.txt	sample_3_dupMatrix.txt	6415641	1379559738	\N	f	2022-09-29 09:54:32.097+00
2105	45	1783	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/dupradar/histogram/sample_1_expressionHist.pdf	sample_1_expressionHist.pdf	5161	-508503786	\N	f	2022-09-29 09:54:32.109+00
2106	45	1783	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/dupradar/histogram/sample_2_expressionHist.pdf	sample_2_expressionHist.pdf	5214	252729942	\N	f	2022-09-29 09:54:32.109+00
2107	45	1783	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/dupradar/histogram/sample_3_expressionHist.pdf	sample_3_expressionHist.pdf	5266	-718286569	\N	f	2022-09-29 09:54:32.109+00
2108	45	1784	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/dupradar/intercepts_slope/sample_1_intercept_slope.txt	sample_1_intercept_slope.txt	181	618414330	\N	f	2022-09-29 09:54:32.117+00
2109	45	1784	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/dupradar/intercepts_slope/sample_2_intercept_slope.txt	sample_2_intercept_slope.txt	179	-1167963732	\N	f	2022-09-29 09:54:32.117+00
2110	45	1784	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/dupradar/intercepts_slope/sample_3_intercept_slope.txt	sample_3_intercept_slope.txt	181	-761000766	\N	f	2022-09-29 09:54:32.117+00
2111	45	1785	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/dupradar/scatter_plot/sample_1_duprateExpDens.pdf	sample_1_duprateExpDens.pdf	2315024	818197427	\N	f	2022-09-29 09:54:32.113+00
2112	45	1785	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/dupradar/scatter_plot/sample_2_duprateExpDens.pdf	sample_2_duprateExpDens.pdf	2272021	285762655	\N	f	2022-09-29 09:54:32.117+00
2113	45	1785	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/dupradar/scatter_plot/sample_3_duprateExpDens.pdf	sample_3_duprateExpDens.pdf	2332902	-96875171	\N	f	2022-09-29 09:54:32.113+00
2114	45	1786	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/log/sample_1.Log.final.out	sample_1.Log.final.out	2066	285890359	\N	f	2022-09-29 09:54:32.073+00
2115	45	1786	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/log/sample_1.Log.out	sample_1.Log.out	10252	630398346	\N	f	2022-09-29 09:54:32.073+00
2116	45	1786	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/log/sample_1.Log.progress.out	sample_1.Log.progress.out	10741	-1283796895	\N	f	2022-09-29 09:54:32.073+00
2117	45	1786	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/log/sample_1.SJ.out.tab	sample_1.SJ.out.tab	9778101	1632837072	\N	f	2022-09-29 09:54:32.089+00
2118	45	1786	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/log/sample_2.Log.final.out	sample_2.Log.final.out	2074	1397700007	\N	f	2022-09-29 09:54:32.069+00
2119	45	1786	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/log/sample_2.Log.out	sample_2.Log.out	10256	1717883404	\N	f	2022-09-29 09:54:32.073+00
2120	45	1786	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/log/sample_2.Log.progress.out	sample_2.Log.progress.out	24429	773733158	\N	f	2022-09-29 09:54:32.073+00
2121	45	1786	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/log/sample_2.SJ.out.tab	sample_2.SJ.out.tab	6957343	-709148794	\N	f	2022-09-29 09:54:32.077+00
2122	45	1786	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/log/sample_3.Log.final.out	sample_3.Log.final.out	2063	1643529023	\N	f	2022-09-29 09:54:32.073+00
2123	45	1786	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/log/sample_3.Log.out	sample_3.Log.out	10253	-929699325	\N	f	2022-09-29 09:54:32.073+00
2124	45	1786	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/log/sample_3.Log.progress.out	sample_3.Log.progress.out	10859	-1534677802	\N	f	2022-09-29 09:54:32.089+00
2125	45	1786	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/log/sample_3.SJ.out.tab	sample_3.SJ.out.tab	9628060	74910948	\N	f	2022-09-29 09:54:32.069+00
2126	45	1787	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/picard_metrics/sample_1.markdup.sorted.MarkDuplicates.metrics.txt	sample_1.markdup.sorted.MarkDuplicates.metrics.txt	9714	1785159828	\N	f	2022-09-29 09:54:30.401+00
2127	45	1787	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/picard_metrics/sample_2.markdup.sorted.MarkDuplicates.metrics.txt	sample_2.markdup.sorted.MarkDuplicates.metrics.txt	45906	1067589183	\N	f	2022-09-29 09:54:30.401+00
2128	45	1787	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/picard_metrics/sample_3.markdup.sorted.MarkDuplicates.metrics.txt	sample_3.markdup.sorted.MarkDuplicates.metrics.txt	9426	-1207363869	\N	f	2022-09-29 09:54:30.401+00
2129	45	1789	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/preseq/log/sample_1.command.log	sample_1.command.log	9969	-1480825597	\N	f	2022-09-29 09:54:30.409+00
2130	45	1789	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/preseq/log/sample_2.command.log	sample_2.command.log	24119	-471237910	\N	f	2022-09-29 09:54:30.405+00
2131	45	1789	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/preseq/log/sample_3.command.log	sample_3.command.log	8498	1499865450	\N	f	2022-09-29 09:54:30.409+00
2132	45	1788	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/preseq/sample_1.lc_extrap.txt	sample_1.lc_extrap.txt	488559	678980182	\N	f	2022-09-29 09:54:30.405+00
2133	45	1788	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/preseq/sample_2.lc_extrap.txt	sample_2.lc_extrap.txt	480797	1366266636	\N	f	2022-09-29 09:54:30.405+00
2134	45	1788	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/preseq/sample_3.lc_extrap.txt	sample_3.lc_extrap.txt	488535	-1304957126	\N	f	2022-09-29 09:54:30.405+00
2135	45	1792	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_1/css/agogo.css	agogo.css	7158	-1819042663	\N	f	2022-09-29 09:54:32.137+00
2136	45	1792	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_1/css/ajax-loader.gif	ajax-loader.gif	701	457227398	\N	f	2022-09-29 09:54:32.133+00
2137	45	1792	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_1/css/basic.css	basic.css	8489	-1214106200	\N	f	2022-09-29 09:54:32.133+00
2138	45	1792	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_1/css/bgfooter.png	bgfooter.png	462	-230990605	\N	f	2022-09-29 09:54:32.137+00
3126	59	\N		20220929134758760-264	40188	\N	\N	t	2022-09-29 13:47:59.742+00
2140	45	1792	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_1/css/comment-bright.png	comment-bright.png	3528	637089544	\N	f	2022-09-29 09:54:32.137+00
2141	45	1792	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_1/css/comment-close.png	comment-close.png	3606	-1455673316	\N	f	2022-09-29 09:54:32.137+00
2142	45	1792	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_1/css/comment.png	comment.png	3473	71771289	\N	f	2022-09-29 09:54:32.133+00
2143	45	1792	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_1/css/doctools.js	doctools.js	6868	-185869495	\N	f	2022-09-29 09:54:32.137+00
2144	45	1792	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_1/css/down-pressed.png	down-pressed.png	396	2130575043	\N	f	2022-09-29 09:54:32.133+00
2145	45	1792	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_1/css/down.png	down.png	391	1132599794	\N	f	2022-09-29 09:54:32.137+00
2146	45	1792	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_1/css/file.png	file.png	420	-313495017	\N	f	2022-09-29 09:54:32.137+00
2147	45	1792	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_1/css/jquery.js	jquery.js	72230	2034685179	\N	f	2022-09-29 09:54:32.137+00
2148	45	1792	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_1/css/minus.png	minus.png	227	-894015614	\N	f	2022-09-29 09:54:32.133+00
2149	45	1792	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_1/css/plus.png	plus.png	227	1014861211	\N	f	2022-09-29 09:54:32.133+00
2150	45	1792	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_1/css/pygments.css	pygments.css	3960	323909406	\N	f	2022-09-29 09:54:32.133+00
2151	45	1792	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_1/css/qualimap_logo_small.png	qualimap_logo_small.png	2950	-251404211	\N	f	2022-09-29 09:54:32.137+00
2152	45	1792	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_1/css/report.css	report.css	636	-1728314163	\N	f	2022-09-29 09:54:32.133+00
2153	45	1792	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_1/css/searchtools.js	searchtools.js	16071	1251075761	\N	f	2022-09-29 09:54:32.137+00
2154	45	1792	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_1/css/underscore.js	underscore.js	8602	-1967681647	\N	f	2022-09-29 09:54:32.133+00
2155	45	1792	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_1/css/up-pressed.png	up-pressed.png	400	1213058415	\N	f	2022-09-29 09:54:32.137+00
2156	45	1792	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_1/css/up.png	up.png	391	-555797539	\N	f	2022-09-29 09:54:32.137+00
2157	45	1792	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_1/css/websupport.js	websupport.js	25274	2804485	\N	f	2022-09-29 09:54:32.133+00
2158	45	1793	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_1/images_qualimapReport/Coverage Profile Along Genes (High).png	Coverage Profile Along Genes (High).png	54144	-151426031	\N	f	2022-09-29 09:54:32.133+00
2159	45	1793	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_1/images_qualimapReport/Coverage Profile Along Genes (Low).png	Coverage Profile Along Genes (Low).png	106968	-25904310	\N	f	2022-09-29 09:54:32.133+00
2160	45	1793	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_1/images_qualimapReport/Coverage Profile Along Genes (Total).png	Coverage Profile Along Genes (Total).png	53156	-115568753	\N	f	2022-09-29 09:54:32.133+00
2161	45	1793	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_1/images_qualimapReport/Junction Analysis.png	Junction Analysis.png	36456	-1058934390	\N	f	2022-09-29 09:54:32.133+00
2162	45	1793	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_1/images_qualimapReport/Reads Genomic Origin.png	Reads Genomic Origin.png	36869	-1626114181	\N	f	2022-09-29 09:54:32.133+00
2163	45	1793	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_1/images_qualimapReport/Transcript coverage histogram.png	Transcript coverage histogram.png	60105	42963934	\N	f	2022-09-29 09:54:32.133+00
2164	45	1791	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_1/qualimapReport.html	qualimapReport.html	11637	163569198	\N	f	2022-09-29 09:54:32.133+00
2165	45	1794	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_1/raw_data_qualimapReport/coverage_profile_along_genes_(high).txt	coverage_profile_along_genes_(high).txt	2395	-1127273352	\N	f	2022-09-29 09:54:32.137+00
2166	45	1794	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_1/raw_data_qualimapReport/coverage_profile_along_genes_(low).txt	coverage_profile_along_genes_(low).txt	2629	-1119569550	\N	f	2022-09-29 09:54:32.137+00
2167	45	1794	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_1/raw_data_qualimapReport/coverage_profile_along_genes_(total).txt	coverage_profile_along_genes_(total).txt	2428	-1419629466	\N	f	2022-09-29 09:54:32.137+00
2168	45	1791	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_1/rnaseq_qc_results.txt	rnaseq_qc_results.txt	1228	-1878163253	\N	f	2022-09-29 09:54:32.133+00
2169	45	1796	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_2/css/agogo.css	agogo.css	7158	1392075138	\N	f	2022-09-29 09:54:32.129+00
2170	45	1796	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_2/css/ajax-loader.gif	ajax-loader.gif	701	-661065457	\N	f	2022-09-29 09:54:32.129+00
2171	45	1796	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_2/css/basic.css	basic.css	8489	394199571	\N	f	2022-09-29 09:54:32.129+00
2172	45	1796	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_2/css/bgfooter.png	bgfooter.png	462	-1671080381	\N	f	2022-09-29 09:54:32.129+00
2173	45	1796	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_2/css/bgtop.png	bgtop.png	458	1305656003	\N	f	2022-09-29 09:54:32.129+00
2174	45	1796	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_2/css/comment-bright.png	comment-bright.png	3528	-1705719488	\N	f	2022-09-29 09:54:32.129+00
2175	45	1796	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_2/css/comment-close.png	comment-close.png	3606	-351725065	\N	f	2022-09-29 09:54:32.129+00
2176	45	1796	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_2/css/comment.png	comment.png	3473	1663653615	\N	f	2022-09-29 09:54:32.129+00
2177	45	1796	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_2/css/doctools.js	doctools.js	6868	1641479594	\N	f	2022-09-29 09:54:32.129+00
2178	45	1796	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_2/css/down-pressed.png	down-pressed.png	396	-1758696801	\N	f	2022-09-29 09:54:32.129+00
2179	45	1796	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_2/css/down.png	down.png	391	1695326110	\N	f	2022-09-29 09:54:32.129+00
2180	45	1796	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_2/css/file.png	file.png	420	-791773090	\N	f	2022-09-29 09:54:32.129+00
2181	45	1796	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_2/css/jquery.js	jquery.js	72230	371394674	\N	f	2022-09-29 09:54:32.129+00
2182	45	1796	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_2/css/minus.png	minus.png	227	-450275838	\N	f	2022-09-29 09:54:32.129+00
2183	45	1796	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_2/css/plus.png	plus.png	227	-1746706512	\N	f	2022-09-29 09:54:32.129+00
2184	45	1796	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_2/css/pygments.css	pygments.css	3960	-1343480677	\N	f	2022-09-29 09:54:32.129+00
2185	45	1796	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_2/css/qualimap_logo_small.png	qualimap_logo_small.png	2950	-1649549937	\N	f	2022-09-29 09:54:32.129+00
2186	45	1796	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_2/css/report.css	report.css	636	-1448456205	\N	f	2022-09-29 09:54:32.129+00
2187	45	1796	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_2/css/searchtools.js	searchtools.js	16071	-1030045655	\N	f	2022-09-29 09:54:32.129+00
2188	45	1796	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_2/css/underscore.js	underscore.js	8602	440014722	\N	f	2022-09-29 09:54:32.129+00
2189	45	1796	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_2/css/up-pressed.png	up-pressed.png	400	-709422320	\N	f	2022-09-29 09:54:32.129+00
2190	45	1796	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_2/css/up.png	up.png	391	767344916	\N	f	2022-09-29 09:54:32.129+00
2191	45	1796	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_2/css/websupport.js	websupport.js	25274	-1148565951	\N	f	2022-09-29 09:54:32.129+00
2192	45	1797	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_2/images_qualimapReport/Coverage Profile Along Genes (High).png	Coverage Profile Along Genes (High).png	51478	437274807	\N	f	2022-09-29 09:54:32.129+00
2193	45	1797	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_2/images_qualimapReport/Coverage Profile Along Genes (Low).png	Coverage Profile Along Genes (Low).png	111449	-1111561691	\N	f	2022-09-29 09:54:32.129+00
2194	45	1797	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_2/images_qualimapReport/Coverage Profile Along Genes (Total).png	Coverage Profile Along Genes (Total).png	52397	1313294147	\N	f	2022-09-29 09:54:32.129+00
2195	45	1797	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_2/images_qualimapReport/Junction Analysis.png	Junction Analysis.png	35475	644655686	\N	f	2022-09-29 09:54:32.129+00
2196	45	1797	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_2/images_qualimapReport/Reads Genomic Origin.png	Reads Genomic Origin.png	36521	-1085154575	\N	f	2022-09-29 09:54:32.129+00
2197	45	1797	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_2/images_qualimapReport/Transcript coverage histogram.png	Transcript coverage histogram.png	59853	131685327	\N	f	2022-09-29 09:54:32.129+00
2198	45	1795	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_2/qualimapReport.html	qualimapReport.html	11844	886394557	\N	f	2022-09-29 09:54:32.129+00
2199	45	1798	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_2/raw_data_qualimapReport/coverage_profile_along_genes_(high).txt	coverage_profile_along_genes_(high).txt	2428	-983877245	\N	f	2022-09-29 09:54:32.129+00
2200	45	1798	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_2/raw_data_qualimapReport/coverage_profile_along_genes_(low).txt	coverage_profile_along_genes_(low).txt	2637	-2137672991	\N	f	2022-09-29 09:54:32.129+00
2201	45	1798	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_2/raw_data_qualimapReport/coverage_profile_along_genes_(total).txt	coverage_profile_along_genes_(total).txt	2400	897582515	\N	f	2022-09-29 09:54:32.129+00
2202	45	1795	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_2/rnaseq_qc_results.txt	rnaseq_qc_results.txt	1265	-1816069303	\N	f	2022-09-29 09:54:32.125+00
2203	45	1800	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_3/css/agogo.css	agogo.css	7158	652580385	\N	f	2022-09-29 09:54:32.133+00
2204	45	1800	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_3/css/ajax-loader.gif	ajax-loader.gif	701	-17596788	\N	f	2022-09-29 09:54:32.133+00
2205	45	1800	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_3/css/basic.css	basic.css	8489	-1991597521	\N	f	2022-09-29 09:54:32.133+00
2206	45	1800	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_3/css/bgfooter.png	bgfooter.png	462	-1988253317	\N	f	2022-09-29 09:54:32.133+00
2207	45	1800	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_3/css/bgtop.png	bgtop.png	458	352168900	\N	f	2022-09-29 09:54:32.133+00
2208	45	1800	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_3/css/comment-bright.png	comment-bright.png	3528	-850316243	\N	f	2022-09-29 09:54:32.133+00
2209	45	1800	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_3/css/comment-close.png	comment-close.png	3606	-1234900295	\N	f	2022-09-29 09:54:32.133+00
2210	45	1800	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_3/css/comment.png	comment.png	3473	-1868684812	\N	f	2022-09-29 09:54:32.133+00
2211	45	1800	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_3/css/doctools.js	doctools.js	6868	-2011220968	\N	f	2022-09-29 09:54:32.133+00
2212	45	1800	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_3/css/down-pressed.png	down-pressed.png	396	997847102	\N	f	2022-09-29 09:54:32.133+00
2213	45	1800	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_3/css/down.png	down.png	391	-298728523	\N	f	2022-09-29 09:54:32.133+00
2214	45	1800	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_3/css/file.png	file.png	420	-974803056	\N	f	2022-09-29 09:54:32.133+00
2215	45	1800	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_3/css/jquery.js	jquery.js	72230	-957804607	\N	f	2022-09-29 09:54:32.133+00
2216	45	1800	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_3/css/minus.png	minus.png	227	-1322154767	\N	f	2022-09-29 09:54:32.133+00
2217	45	1800	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_3/css/plus.png	plus.png	227	1796588264	\N	f	2022-09-29 09:54:32.133+00
2218	45	1800	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_3/css/pygments.css	pygments.css	3960	-1184790359	\N	f	2022-09-29 09:54:32.133+00
2219	45	1800	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_3/css/qualimap_logo_small.png	qualimap_logo_small.png	2950	1511503024	\N	f	2022-09-29 09:54:32.133+00
2220	45	1800	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_3/css/report.css	report.css	636	-1207767214	\N	f	2022-09-29 09:54:32.133+00
2221	45	1800	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_3/css/searchtools.js	searchtools.js	16071	891751334	\N	f	2022-09-29 09:54:32.133+00
2222	45	1800	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_3/css/underscore.js	underscore.js	8602	-1776999424	\N	f	2022-09-29 09:54:32.133+00
2223	45	1800	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_3/css/up-pressed.png	up-pressed.png	400	1116392109	\N	f	2022-09-29 09:54:32.133+00
2224	45	1800	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_3/css/up.png	up.png	391	719738186	\N	f	2022-09-29 09:54:32.133+00
2225	45	1800	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_3/css/websupport.js	websupport.js	25274	-2086293135	\N	f	2022-09-29 09:54:32.133+00
2226	45	1801	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_3/images_qualimapReport/Coverage Profile Along Genes (High).png	Coverage Profile Along Genes (High).png	53157	-1951342108	\N	f	2022-09-29 09:54:32.129+00
2227	45	1801	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_3/images_qualimapReport/Coverage Profile Along Genes (Low).png	Coverage Profile Along Genes (Low).png	113430	-1526845626	\N	f	2022-09-29 09:54:32.129+00
2228	45	1801	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_3/images_qualimapReport/Coverage Profile Along Genes (Total).png	Coverage Profile Along Genes (Total).png	50965	-480815620	\N	f	2022-09-29 09:54:32.129+00
2229	45	1801	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_3/images_qualimapReport/Junction Analysis.png	Junction Analysis.png	35285	-652497932	\N	f	2022-09-29 09:54:32.129+00
2230	45	1801	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_3/images_qualimapReport/Reads Genomic Origin.png	Reads Genomic Origin.png	37476	-1582143536	\N	f	2022-09-29 09:54:32.129+00
2231	45	1801	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_3/images_qualimapReport/Transcript coverage histogram.png	Transcript coverage histogram.png	60089	-1542787858	\N	f	2022-09-29 09:54:32.129+00
2232	45	1799	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_3/qualimapReport.html	qualimapReport.html	11638	466004772	\N	f	2022-09-29 09:54:32.133+00
2233	45	1802	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_3/raw_data_qualimapReport/coverage_profile_along_genes_(high).txt	coverage_profile_along_genes_(high).txt	2391	-1291522367	\N	f	2022-09-29 09:54:32.133+00
2234	45	1802	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_3/raw_data_qualimapReport/coverage_profile_along_genes_(low).txt	coverage_profile_along_genes_(low).txt	2615	1540505302	\N	f	2022-09-29 09:54:32.133+00
2235	45	1802	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_3/raw_data_qualimapReport/coverage_profile_along_genes_(total).txt	coverage_profile_along_genes_(total).txt	2428	2102328871	\N	f	2022-09-29 09:54:32.133+00
2236	45	1799	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/qualimap/sample_3/rnaseq_qc_results.txt	rnaseq_qc_results.txt	1229	-188158316	\N	f	2022-09-29 09:54:32.129+00
2237	45	1804	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/rseqc/bam_stat/sample_1.bam_stat.txt	sample_1.bam_stat.txt	883	-1005402120	\N	f	2022-09-29 09:54:30.645+00
2238	45	1804	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/rseqc/bam_stat/sample_2.bam_stat.txt	sample_2.bam_stat.txt	882	1492317073	\N	f	2022-09-29 09:54:30.645+00
2239	45	1804	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/rseqc/bam_stat/sample_3.bam_stat.txt	sample_3.bam_stat.txt	883	152940950	\N	f	2022-09-29 09:54:30.645+00
2240	45	1805	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/rseqc/infer_experiment/sample_1.infer_experiment.txt	sample_1.infer_experiment.txt	211	1326373681	\N	f	2022-09-29 09:54:30.909+00
2241	45	1805	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/rseqc/infer_experiment/sample_2.infer_experiment.txt	sample_2.infer_experiment.txt	211	1248226283	\N	f	2022-09-29 09:54:30.909+00
2242	45	1805	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/rseqc/infer_experiment/sample_3.infer_experiment.txt	sample_3.infer_experiment.txt	211	1201777790	\N	f	2022-09-29 09:54:30.909+00
2243	45	1807	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/rseqc/inner_distance/pdf/sample_1.inner_distance_plot.pdf	sample_1.inner_distance_plot.pdf	8625	1338353911	\N	f	2022-09-29 09:54:30.641+00
2244	45	1807	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/rseqc/inner_distance/pdf/sample_2.inner_distance_plot.pdf	sample_2.inner_distance_plot.pdf	8605	-1780547798	\N	f	2022-09-29 09:54:30.641+00
2245	45	1807	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/rseqc/inner_distance/pdf/sample_3.inner_distance_plot.pdf	sample_3.inner_distance_plot.pdf	8637	-1981466811	\N	f	2022-09-29 09:54:30.641+00
2246	45	1808	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/rseqc/inner_distance/rscript/sample_1.inner_distance_plot.r	sample_1.inner_distance_plot.r	1613	1958315387	\N	f	2022-09-29 09:54:30.641+00
2247	45	1808	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/rseqc/inner_distance/rscript/sample_2.inner_distance_plot.r	sample_2.inner_distance_plot.r	1600	-2133557919	\N	f	2022-09-29 09:54:30.641+00
2248	45	1808	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/rseqc/inner_distance/rscript/sample_3.inner_distance_plot.r	sample_3.inner_distance_plot.r	1630	351486982	\N	f	2022-09-29 09:54:30.641+00
2249	45	1809	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/rseqc/inner_distance/txt/sample_1.inner_distance.txt	sample_1.inner_distance.txt	67476938	1051481307	\N	f	2022-09-29 09:54:30.481+00
2250	45	1809	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/rseqc/inner_distance/txt/sample_1.inner_distance_freq.txt	sample_1.inner_distance_freq.txt	1298	274887816	\N	f	2022-09-29 09:54:30.641+00
2251	45	1809	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/rseqc/inner_distance/txt/sample_1.inner_distance_mean.txt	sample_1.inner_distance_mean.txt	98	4596787	\N	f	2022-09-29 09:54:30.641+00
2252	45	1809	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/rseqc/inner_distance/txt/sample_2.inner_distance.txt	sample_2.inner_distance.txt	70303361	-1860885787	\N	f	2022-09-29 09:54:30.633+00
2253	45	1809	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/rseqc/inner_distance/txt/sample_2.inner_distance_freq.txt	sample_2.inner_distance_freq.txt	1285	-882285743	\N	f	2022-09-29 09:54:30.641+00
2254	45	1809	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/rseqc/inner_distance/txt/sample_2.inner_distance_mean.txt	sample_2.inner_distance_mean.txt	97	-1157327764	\N	f	2022-09-29 09:54:30.565+00
2255	45	1809	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/rseqc/inner_distance/txt/sample_3.inner_distance.txt	sample_3.inner_distance.txt	67502150	1140201137	\N	f	2022-09-29 09:54:30.557+00
2256	45	1809	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/rseqc/inner_distance/txt/sample_3.inner_distance_freq.txt	sample_3.inner_distance_freq.txt	1315	-1625341828	\N	f	2022-09-29 09:54:30.641+00
2257	45	1809	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/rseqc/inner_distance/txt/sample_3.inner_distance_mean.txt	sample_3.inner_distance_mean.txt	98	177017006	\N	f	2022-09-29 09:54:30.641+00
2258	45	1811	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/rseqc/junction_annotation/bed/sample_1.junction.Interact.bed	sample_1.junction.Interact.bed	52851297	-1699572616	\N	f	2022-09-29 09:54:30.809+00
2259	45	1811	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/rseqc/junction_annotation/bed/sample_1.junction.bed	sample_1.junction.bed	21992208	1080245197	\N	f	2022-09-29 09:54:30.713+00
2260	45	1811	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/rseqc/junction_annotation/bed/sample_2.junction.Interact.bed	sample_2.junction.Interact.bed	43701729	-1606763689	\N	f	2022-09-29 09:54:30.685+00
2261	45	1811	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/rseqc/junction_annotation/bed/sample_2.junction.bed	sample_2.junction.bed	18273887	1311666279	\N	f	2022-09-29 09:54:30.733+00
2262	45	1811	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/rseqc/junction_annotation/bed/sample_3.junction.Interact.bed	sample_3.junction.Interact.bed	51970798	-1186877322	\N	f	2022-09-29 09:54:30.865+00
2263	45	1811	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/rseqc/junction_annotation/bed/sample_3.junction.bed	sample_3.junction.bed	21617067	757177692	\N	f	2022-09-29 09:54:30.757+00
2264	45	1812	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/rseqc/junction_annotation/log/sample_1.junction_annotation.log	sample_1.junction_annotation.log	597	-83378805	\N	f	2022-09-29 09:54:30.909+00
2265	45	1812	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/rseqc/junction_annotation/log/sample_2.junction_annotation.log	sample_2.junction_annotation.log	597	-552615409	\N	f	2022-09-29 09:54:30.909+00
2266	45	1812	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/rseqc/junction_annotation/log/sample_3.junction_annotation.log	sample_3.junction_annotation.log	597	314483756	\N	f	2022-09-29 09:54:30.909+00
2267	45	1813	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/rseqc/junction_annotation/pdf/sample_1.splice_events.pdf	sample_1.splice_events.pdf	13329	838275517	\N	f	2022-09-29 09:54:30.909+00
2268	45	1813	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/rseqc/junction_annotation/pdf/sample_1.splice_junction.pdf	sample_1.splice_junction.pdf	13285	-1369086937	\N	f	2022-09-29 09:54:30.909+00
2269	45	1813	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/rseqc/junction_annotation/pdf/sample_2.splice_events.pdf	sample_2.splice_events.pdf	13371	1613803558	\N	f	2022-09-29 09:54:30.909+00
2270	45	1813	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/rseqc/junction_annotation/pdf/sample_2.splice_junction.pdf	sample_2.splice_junction.pdf	13231	-1820699999	\N	f	2022-09-29 09:54:30.909+00
2271	45	1813	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/rseqc/junction_annotation/pdf/sample_3.splice_events.pdf	sample_3.splice_events.pdf	13363	-355479235	\N	f	2022-09-29 09:54:30.909+00
2272	45	1813	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/rseqc/junction_annotation/pdf/sample_3.splice_junction.pdf	sample_3.splice_junction.pdf	13269	1146778497	\N	f	2022-09-29 09:54:30.909+00
2273	45	1814	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/rseqc/junction_annotation/rscript/sample_1.junction_plot.r	sample_1.junction_plot.r	583	966847735	\N	f	2022-09-29 09:54:30.905+00
2274	45	1814	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/rseqc/junction_annotation/rscript/sample_2.junction_plot.r	sample_2.junction_plot.r	581	1893871428	\N	f	2022-09-29 09:54:30.905+00
2275	45	1814	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/rseqc/junction_annotation/rscript/sample_3.junction_plot.r	sample_3.junction_plot.r	580	1211474494	\N	f	2022-09-29 09:54:30.905+00
2276	45	1815	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/rseqc/junction_annotation/xls/sample_1.junction.xls	sample_1.junction.xls	11141659	-607178677	\N	f	2022-09-29 09:54:30.905+00
2277	45	1815	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/rseqc/junction_annotation/xls/sample_2.junction.xls	sample_2.junction.xls	9194308	32631549	\N	f	2022-09-29 09:54:30.893+00
2278	45	1815	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/rseqc/junction_annotation/xls/sample_3.junction.xls	sample_3.junction.xls	10950039	1629540658	\N	f	2022-09-29 09:54:30.885+00
2279	45	1817	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/rseqc/junction_saturation/pdf/sample_1.junctionSaturation_plot.pdf	sample_1.junctionSaturation_plot.pdf	5603	303050984	\N	f	2022-09-29 09:54:30.645+00
2280	45	1817	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/rseqc/junction_saturation/pdf/sample_2.junctionSaturation_plot.pdf	sample_2.junctionSaturation_plot.pdf	5589	-34165253	\N	f	2022-09-29 09:54:30.645+00
2281	45	1817	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/rseqc/junction_saturation/pdf/sample_3.junctionSaturation_plot.pdf	sample_3.junctionSaturation_plot.pdf	5587	538451662	\N	f	2022-09-29 09:54:30.645+00
2318	45	1826	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/sample_1/libParams/flenDist.txt	flenDist.txt	11697	-938171353	\N	f	2022-09-29 09:54:32.057+00
2282	45	1818	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/rseqc/junction_saturation/rscript/sample_1.junctionSaturation_plot.r	sample_1.junctionSaturation_plot.r	926	-1731333464	\N	f	2022-09-29 09:54:30.645+00
2283	45	1818	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/rseqc/junction_saturation/rscript/sample_2.junctionSaturation_plot.r	sample_2.junctionSaturation_plot.r	915	-764103913	\N	f	2022-09-29 09:54:30.645+00
2284	45	1818	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/rseqc/junction_saturation/rscript/sample_3.junctionSaturation_plot.r	sample_3.junctionSaturation_plot.r	926	-1627621151	\N	f	2022-09-29 09:54:30.645+00
2285	45	1819	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/rseqc/read_distribution/sample_1.read_distribution.txt	sample_1.read_distribution.txt	1159	-1440446276	\N	f	2022-09-29 09:54:30.641+00
2286	45	1819	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/rseqc/read_distribution/sample_2.read_distribution.txt	sample_2.read_distribution.txt	1156	-786176134	\N	f	2022-09-29 09:54:30.641+00
2287	45	1819	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/rseqc/read_distribution/sample_3.read_distribution.txt	sample_3.read_distribution.txt	1159	-579874137	\N	f	2022-09-29 09:54:30.641+00
2288	45	1821	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/rseqc/read_duplication/pdf/sample_1.DupRate_plot.pdf	sample_1.DupRate_plot.pdf	21556	-1435386822	\N	f	2022-09-29 09:54:30.645+00
2289	45	1821	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/rseqc/read_duplication/pdf/sample_2.DupRate_plot.pdf	sample_2.DupRate_plot.pdf	21186	-754278793	\N	f	2022-09-29 09:54:30.645+00
2290	45	1821	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/rseqc/read_duplication/pdf/sample_3.DupRate_plot.pdf	sample_3.DupRate_plot.pdf	21266	-1602064213	\N	f	2022-09-29 09:54:30.645+00
2291	45	1822	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/rseqc/read_duplication/rscript/sample_1.DupRate_plot.r	sample_1.DupRate_plot.r	31326	739449279	\N	f	2022-09-29 09:54:30.645+00
2292	45	1822	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/rseqc/read_duplication/rscript/sample_2.DupRate_plot.r	sample_2.DupRate_plot.r	54192	1322099712	\N	f	2022-09-29 09:54:30.645+00
2293	45	1822	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/rseqc/read_duplication/rscript/sample_3.DupRate_plot.r	sample_3.DupRate_plot.r	26056	594366229	\N	f	2022-09-29 09:54:30.645+00
2294	45	1823	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/rseqc/read_duplication/xls/sample_1.pos.DupRate.xls	sample_1.pos.DupRate.xls	16971	-1431310905	\N	f	2022-09-29 09:54:30.641+00
2295	45	1823	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/rseqc/read_duplication/xls/sample_1.seq.DupRate.xls	sample_1.seq.DupRate.xls	13583	334222502	\N	f	2022-09-29 09:54:30.641+00
2296	45	1823	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/rseqc/read_duplication/xls/sample_2.pos.DupRate.xls	sample_2.pos.DupRate.xls	27781	955485534	\N	f	2022-09-29 09:54:30.641+00
2297	45	1823	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/rseqc/read_duplication/xls/sample_2.seq.DupRate.xls	sample_2.seq.DupRate.xls	25639	-785777956	\N	f	2022-09-29 09:54:30.641+00
2298	45	1823	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/rseqc/read_duplication/xls/sample_3.pos.DupRate.xls	sample_3.pos.DupRate.xls	14226	-803367597	\N	f	2022-09-29 09:54:30.641+00
2299	45	1823	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/rseqc/read_duplication/xls/sample_3.seq.DupRate.xls	sample_3.seq.DupRate.xls	11058	824597107	\N	f	2022-09-29 09:54:30.641+00
2300	45	1776	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/salmon.merged.gene_counts.rds	salmon.merged.gene_counts.rds	2041669	-1624405320	\N	f	2022-09-29 09:54:30.401+00
2301	45	1776	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/salmon.merged.gene_counts.tsv	salmon.merged.gene_counts.tsv	1697349	1884921426	\N	f	2022-09-29 09:54:30.417+00
2302	45	1776	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/salmon.merged.gene_counts_length_scaled.rds	salmon.merged.gene_counts_length_scaled.rds	2523227	-316212043	\N	f	2022-09-29 09:54:32.121+00
2303	45	1776	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/salmon.merged.gene_counts_length_scaled.tsv	salmon.merged.gene_counts_length_scaled.tsv	2957831	-1741486492	\N	f	2022-09-29 09:54:32.141+00
2304	45	1776	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/salmon.merged.gene_counts_scaled.rds	salmon.merged.gene_counts_scaled.rds	2515613	-2104947719	\N	f	2022-09-29 09:54:32.125+00
2305	45	1776	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/salmon.merged.gene_counts_scaled.tsv	salmon.merged.gene_counts_scaled.tsv	2959826	-1446795332	\N	f	2022-09-29 09:54:30.913+00
2306	45	1776	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/salmon.merged.gene_tpm.tsv	salmon.merged.gene_tpm.tsv	2166288	-919056219	\N	f	2022-09-29 09:54:32.141+00
2307	45	1776	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/salmon.merged.transcript_counts.rds	salmon.merged.transcript_counts.rds	2333318	918150208	\N	f	2022-09-29 09:54:31.241+00
2308	45	1776	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/salmon.merged.transcript_counts.tsv	salmon.merged.transcript_counts.tsv	2006923	1464444435	\N	f	2022-09-29 09:54:32.061+00
2309	45	1776	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/salmon.merged.transcript_tpm.tsv	salmon.merged.transcript_tpm.tsv	2472747	-1637726121	\N	f	2022-09-29 09:54:30.417+00
2310	45	1776	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/salmon_tx2gene.tsv	salmon_tx2gene.tsv	1757786	-983854931	\N	f	2022-09-29 09:54:30.913+00
2311	45	1825	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/sample_1/aux_info/ambig_info.tsv	ambig_info.tsv	373014	-1428754822	\N	f	2022-09-29 09:54:32.057+00
2312	45	1825	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/sample_1/aux_info/expected_bias.gz	expected_bias.gz	117	-1966068918	\N	f	2022-09-29 09:54:32.057+00
2313	45	1825	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/sample_1/aux_info/fld.gz	fld.gz	532	-635930378	\N	f	2022-09-29 09:54:32.057+00
2314	45	1825	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/sample_1/aux_info/meta_info.json	meta_info.json	1308	-812227569	\N	f	2022-09-29 09:54:32.057+00
2315	45	1825	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/sample_1/aux_info/observed_bias.gz	observed_bias.gz	82	-953844012	\N	f	2022-09-29 09:54:32.057+00
2316	45	1825	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/sample_1/aux_info/observed_bias_3p.gz	observed_bias_3p.gz	82	63101874	\N	f	2022-09-29 09:54:32.057+00
2317	45	1824	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/sample_1/cmd_info.json	cmd_info.json	290	-1519989858	\N	f	2022-09-29 09:54:32.053+00
2319	45	1824	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/sample_1/quant.genes.sf	quant.genes.sf	1953889	-2082885802	\N	f	2022-09-29 09:54:32.053+00
2320	45	1824	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/sample_1/quant.sf	quant.sf	2884170	-599505072	\N	f	2022-09-29 09:54:32.057+00
2321	45	1776	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/sample_1.markdup.sorted.bam.bai	sample_1.markdup.sorted.bam.bai	2766364	1744641896	\N	f	2022-09-29 09:54:30.405+00
2322	45	1828	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/sample_2/aux_info/ambig_info.tsv	ambig_info.tsv	361687	641997507	\N	f	2022-09-29 09:54:30.413+00
2323	45	1828	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/sample_2/aux_info/expected_bias.gz	expected_bias.gz	117	21389779	\N	f	2022-09-29 09:54:30.413+00
2324	45	1828	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/sample_2/aux_info/fld.gz	fld.gz	707	-265071269	\N	f	2022-09-29 09:54:30.413+00
2325	45	1828	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/sample_2/aux_info/meta_info.json	meta_info.json	1307	-699825575	\N	f	2022-09-29 09:54:30.413+00
2326	45	1828	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/sample_2/aux_info/observed_bias.gz	observed_bias.gz	82	225008144	\N	f	2022-09-29 09:54:30.413+00
2327	45	1828	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/sample_2/aux_info/observed_bias_3p.gz	observed_bias_3p.gz	82	-1847744212	\N	f	2022-09-29 09:54:30.413+00
2328	45	1827	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/sample_2/cmd_info.json	cmd_info.json	289	141412882	\N	f	2022-09-29 09:54:30.409+00
2329	45	1829	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/sample_2/libParams/flenDist.txt	flenDist.txt	11611	1359070044	\N	f	2022-09-29 09:54:30.413+00
2330	45	1830	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/sample_2/logs/salmon_quant.log	salmon_quant.log	6561	56793339	\N	f	2022-09-29 09:54:30.413+00
2331	45	1776	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/sample_3	sample_3	5251614	\N	\N	t	2022-09-29 09:54:30.917+00
2332	45	2331	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/sample_3/aux_info	aux_info	372108	\N	\N	t	2022-09-29 09:54:30.921+00
2333	45	2331	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/sample_3/libParams	libParams	11741	\N	\N	t	2022-09-29 09:54:30.921+00
2334	45	2331	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/sample_3/logs	logs	8411	\N	\N	t	2022-09-29 09:54:30.917+00
2335	45	1776	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/samtools_stats	samtools_stats	1571640	\N	\N	t	2022-09-29 09:54:32.125+00
2336	45	1776	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/stringtie	stringtie	281712433	\N	\N	t	2022-09-29 09:54:31.237+00
2337	45	2336	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/stringtie/sample_1.ballgown	sample_1.ballgown	38065227	\N	\N	t	2022-09-29 09:54:31.149+00
2338	45	2336	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/stringtie/sample_2.ballgown	sample_2.ballgown	37508698	\N	\N	t	2022-09-29 09:54:31.109+00
2339	45	2336	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/stringtie/sample_3.ballgown	sample_3.ballgown	38004694	\N	\N	t	2022-09-29 09:54:30.969+00
2340	45	1766	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/trimgalore	trimgalore	9027933	\N	\N	t	2022-09-29 09:54:30.365+00
2341	45	2340	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/trimgalore/fastqc	fastqc	8997907	\N	\N	t	2022-09-29 09:54:30.365+00
2342	45	1827	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/sample_2/quant.genes.sf	quant.genes.sf	1946937	-1486835727	\N	f	2022-09-29 09:54:30.409+00
2343	45	1827	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/sample_2/quant.sf	quant.sf	2871278	1177322425	\N	f	2022-09-29 09:54:30.413+00
2344	45	1776	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/sample_2.markdup.sorted.bam.bai	sample_2.markdup.sorted.bam.bai	8636952	2097324409	\N	f	2022-09-29 09:54:30.929+00
2345	45	2332	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/sample_3/aux_info/ambig_info.tsv	ambig_info.tsv	369990	181449029	\N	f	2022-09-29 09:54:30.921+00
2346	45	2332	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/sample_3/aux_info/expected_bias.gz	expected_bias.gz	117	1500380401	\N	f	2022-09-29 09:54:30.921+00
2347	45	2332	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/sample_3/aux_info/fld.gz	fld.gz	529	942854284	\N	f	2022-09-29 09:54:30.921+00
2348	45	2332	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/sample_3/aux_info/meta_info.json	meta_info.json	1308	-279648351	\N	f	2022-09-29 09:54:30.921+00
2349	45	2332	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/sample_3/aux_info/observed_bias.gz	observed_bias.gz	82	-1062886475	\N	f	2022-09-29 09:54:30.921+00
2350	45	2332	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/sample_3/aux_info/observed_bias_3p.gz	observed_bias_3p.gz	82	-1869336305	\N	f	2022-09-29 09:54:30.921+00
2351	45	2331	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/sample_3/cmd_info.json	cmd_info.json	290	-717436964	\N	f	2022-09-29 09:54:30.917+00
2352	45	2333	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/sample_3/libParams/flenDist.txt	flenDist.txt	11741	894317229	\N	f	2022-09-29 09:54:30.921+00
2353	45	2334	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/sample_3/logs/salmon_quant.log	salmon_quant.log	8411	-1181030972	\N	f	2022-09-29 09:54:30.917+00
2354	45	2331	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/sample_3/quant.genes.sf	quant.genes.sf	1976642	-1513730631	\N	f	2022-09-29 09:54:30.917+00
2355	45	2331	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/sample_3/quant.sf	quant.sf	2882422	-1946746958	\N	f	2022-09-29 09:54:30.917+00
2356	45	1776	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/sample_3.markdup.sorted.bam.bai	sample_3.markdup.sorted.bam.bai	2810212	-1136835734	\N	f	2022-09-29 09:54:31.241+00
2357	45	2335	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/samtools_stats/sample_1.markdup.sorted.bam.flagstat	sample_1.markdup.sorted.bam.flagstat	582	1537529516	\N	f	2022-09-29 09:54:32.125+00
2358	45	2335	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/samtools_stats/sample_1.markdup.sorted.bam.idxstats	sample_1.markdup.sorted.bam.idxstats	243	-387420898	\N	f	2022-09-29 09:54:32.125+00
2359	45	2335	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/samtools_stats/sample_1.markdup.sorted.bam.stats	sample_1.markdup.sorted.bam.stats	265373	-2106135950	\N	f	2022-09-29 09:54:32.125+00
2360	45	2335	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/samtools_stats/sample_1.sorted.bam.flagstat	sample_1.sorted.bam.flagstat	568	437521727	\N	f	2022-09-29 09:54:32.125+00
2361	45	2335	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/samtools_stats/sample_1.sorted.bam.idxstats	sample_1.sorted.bam.idxstats	243	-1755560317	\N	f	2022-09-29 09:54:32.125+00
2362	45	2335	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/samtools_stats/sample_1.sorted.bam.stats	sample_1.sorted.bam.stats	265349	-250628304	\N	f	2022-09-29 09:54:32.125+00
2363	45	2335	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/samtools_stats/sample_2.markdup.sorted.bam.flagstat	sample_2.markdup.sorted.bam.flagstat	581	1422504331	\N	f	2022-09-29 09:54:32.125+00
2364	45	2335	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/samtools_stats/sample_2.markdup.sorted.bam.idxstats	sample_2.markdup.sorted.bam.idxstats	248	-117968024	\N	f	2022-09-29 09:54:32.125+00
2365	45	2335	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/samtools_stats/sample_2.markdup.sorted.bam.stats	sample_2.markdup.sorted.bam.stats	245270	1358158294	\N	f	2022-09-29 09:54:32.125+00
2366	45	2335	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/samtools_stats/sample_2.sorted.bam.flagstat	sample_2.sorted.bam.flagstat	567	1900557726	\N	f	2022-09-29 09:54:32.125+00
2367	45	2335	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/samtools_stats/sample_2.sorted.bam.idxstats	sample_2.sorted.bam.idxstats	248	389292251	\N	f	2022-09-29 09:54:32.125+00
2368	45	2335	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/samtools_stats/sample_2.sorted.bam.stats	sample_2.sorted.bam.stats	245246	1018463120	\N	f	2022-09-29 09:54:32.125+00
2369	45	2335	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/samtools_stats/sample_3.markdup.sorted.bam.flagstat	sample_3.markdup.sorted.bam.flagstat	580	643401212	\N	f	2022-09-29 09:54:32.125+00
2370	45	2335	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/samtools_stats/sample_3.markdup.sorted.bam.idxstats	sample_3.markdup.sorted.bam.idxstats	243	-2024225198	\N	f	2022-09-29 09:54:32.125+00
2371	45	2335	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/samtools_stats/sample_3.markdup.sorted.bam.stats	sample_3.markdup.sorted.bam.stats	272757	2086547681	\N	f	2022-09-29 09:54:32.125+00
2372	45	2335	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/samtools_stats/sample_3.sorted.bam.flagstat	sample_3.sorted.bam.flagstat	566	1198170493	\N	f	2022-09-29 09:54:32.125+00
2373	45	2335	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/samtools_stats/sample_3.sorted.bam.idxstats	sample_3.sorted.bam.idxstats	243	459872004	\N	f	2022-09-29 09:54:32.125+00
2374	45	2335	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/samtools_stats/sample_3.sorted.bam.stats	sample_3.sorted.bam.stats	272733	-329203133	\N	f	2022-09-29 09:54:32.125+00
2375	45	2337	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/stringtie/sample_1.ballgown/e2t.ctab	e2t.ctab	3254120	-1373340168	\N	f	2022-09-29 09:54:31.141+00
2376	45	2337	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/stringtie/sample_1.ballgown/e_data.ctab	e_data.ctab	19040042	1893220268	\N	f	2022-09-29 09:54:31.129+00
2377	45	2337	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/stringtie/sample_1.ballgown/i2t.ctab	i2t.ctab	2293658	1986821710	\N	f	2022-09-29 09:54:31.149+00
2378	45	2337	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/stringtie/sample_1.ballgown/i_data.ctab	i_data.ctab	7847989	1909563716	\N	f	2022-09-29 09:54:31.137+00
2379	45	2337	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/stringtie/sample_1.ballgown/t_data.ctab	t_data.ctab	5629418	-689774495	\N	f	2022-09-29 09:54:31.149+00
2380	45	2336	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/stringtie/sample_1.coverage.gtf	sample_1.coverage.gtf	9384917	1465402241	\N	f	2022-09-29 09:54:31.233+00
2381	45	2336	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/stringtie/sample_1.gene.abundance.txt	sample_1.gene.abundance.txt	4466399	242935265	\N	f	2022-09-29 09:54:31.021+00
2382	45	2336	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/stringtie/sample_1.transcripts.gtf	sample_1.transcripts.gtf	42683723	927196025	\N	f	2022-09-29 09:54:31.061+00
2383	45	2338	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/stringtie/sample_2.ballgown/e2t.ctab	e2t.ctab	3254120	-1596958303	\N	f	2022-09-29 09:54:31.101+00
2384	45	2338	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/stringtie/sample_2.ballgown/e_data.ctab	e_data.ctab	18667110	1586366565	\N	f	2022-09-29 09:54:31.085+00
2385	45	2338	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/stringtie/sample_2.ballgown/i2t.ctab	i2t.ctab	2293658	-1030697112	\N	f	2022-09-29 09:54:31.109+00
2386	45	2338	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/stringtie/sample_2.ballgown/i_data.ctab	i_data.ctab	7676864	1282461282	\N	f	2022-09-29 09:54:31.097+00
2387	45	2338	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/stringtie/sample_2.ballgown/t_data.ctab	t_data.ctab	5616946	-1141059395	\N	f	2022-09-29 09:54:31.105+00
2388	45	2336	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/stringtie/sample_2.coverage.gtf	sample_2.coverage.gtf	8189228	791072033	\N	f	2022-09-29 09:54:31.161+00
2389	45	2336	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/stringtie/sample_2.gene.abundance.txt	sample_2.gene.abundance.txt	4452849	549869883	\N	f	2022-09-29 09:54:31.237+00
2390	45	2336	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/stringtie/sample_2.transcripts.gtf	sample_2.transcripts.gtf	42481181	1983756487	\N	f	2022-09-29 09:54:31.201+00
2391	45	2339	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/stringtie/sample_3.ballgown/e2t.ctab	e2t.ctab	3254120	-996585240	\N	f	2022-09-29 09:54:30.961+00
2392	45	2339	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/stringtie/sample_3.ballgown/e_data.ctab	e_data.ctab	18990360	-850290138	\N	f	2022-09-29 09:54:30.949+00
2393	45	2339	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/stringtie/sample_3.ballgown/i2t.ctab	i2t.ctab	2293658	642324015	\N	f	2022-09-29 09:54:30.969+00
2394	45	2339	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/stringtie/sample_3.ballgown/i_data.ctab	i_data.ctab	7838274	-1894667544	\N	f	2022-09-29 09:54:30.957+00
2395	45	2339	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/stringtie/sample_3.ballgown/t_data.ctab	t_data.ctab	5628282	439981141	\N	f	2022-09-29 09:54:30.965+00
2396	45	2336	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/stringtie/sample_3.coverage.gtf	sample_3.coverage.gtf	9317712	1148212769	\N	f	2022-09-29 09:54:31.221+00
2440	47	2438	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/dupradar/gene_data	gene_data	19312098	\N	\N	t	2022-09-29 10:54:46.086+00
2397	45	2336	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/stringtie/sample_3.gene.abundance.txt	sample_3.gene.abundance.txt	4466275	1057320096	\N	f	2022-09-29 09:54:31.213+00
2398	45	2336	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/star_salmon/stringtie/sample_3.transcripts.gtf	sample_3.transcripts.gtf	42691530	466282503	\N	f	2022-09-29 09:54:31.009+00
2399	45	2341	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/trimgalore/fastqc/sample_1_1_val_1_fastqc.html	sample_1_1_val_1_fastqc.html	651502	-1021137953	\N	f	2022-09-29 09:54:30.365+00
2400	45	2341	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/trimgalore/fastqc/sample_1_1_val_1_fastqc.zip	sample_1_1_val_1_fastqc.zip	814675	1048159357	\N	f	2022-09-29 09:54:30.357+00
2401	45	2341	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/trimgalore/fastqc/sample_1_2_val_2_fastqc.html	sample_1_2_val_2_fastqc.html	653692	-250742050	\N	f	2022-09-29 09:54:30.361+00
2402	45	2341	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/trimgalore/fastqc/sample_1_2_val_2_fastqc.zip	sample_1_2_val_2_fastqc.zip	818144	409792143	\N	f	2022-09-29 09:54:30.365+00
2403	45	2341	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/trimgalore/fastqc/sample_2_1_val_1_fastqc.html	sample_2_1_val_1_fastqc.html	690259	1958661421	\N	f	2022-09-29 09:54:30.357+00
2404	45	2341	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/trimgalore/fastqc/sample_2_1_val_1_fastqc.zip	sample_2_1_val_1_fastqc.zip	869256	-392444846	\N	f	2022-09-29 09:54:30.357+00
2405	45	2341	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/trimgalore/fastqc/sample_2_2_val_2_fastqc.html	sample_2_2_val_2_fastqc.html	694918	-1499497146	\N	f	2022-09-29 09:54:30.365+00
2406	45	2341	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/trimgalore/fastqc/sample_2_2_val_2_fastqc.zip	sample_2_2_val_2_fastqc.zip	868888	-1192259022	\N	f	2022-09-29 09:54:30.361+00
2407	45	2341	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/trimgalore/fastqc/sample_3_1_val_1_fastqc.html	sample_3_1_val_1_fastqc.html	649993	-636602835	\N	f	2022-09-29 09:54:30.361+00
2408	45	2341	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/trimgalore/fastqc/sample_3_1_val_1_fastqc.zip	sample_3_1_val_1_fastqc.zip	811967	-96019121	\N	f	2022-09-29 09:54:30.361+00
2409	45	2341	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/trimgalore/fastqc/sample_3_2_val_2_fastqc.html	sample_3_2_val_2_fastqc.html	655079	-1342676471	\N	f	2022-09-29 09:54:30.357+00
2410	45	2341	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/trimgalore/fastqc/sample_3_2_val_2_fastqc.zip	sample_3_2_val_2_fastqc.zip	819534	14388579	\N	f	2022-09-29 09:54:30.357+00
2411	45	2340	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/trimgalore/sample_1_1.fastq.gz_trimming_report.txt	sample_1_1.fastq.gz_trimming_report.txt	4906	-929218195	\N	f	2022-09-29 09:54:30.365+00
2412	45	2340	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/trimgalore/sample_1_2.fastq.gz_trimming_report.txt	sample_1_2.fastq.gz_trimming_report.txt	5189	-236140524	\N	f	2022-09-29 09:54:30.365+00
2413	45	2340	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/trimgalore/sample_2_1.fastq.gz_trimming_report.txt	sample_2_1.fastq.gz_trimming_report.txt	4736	-1057908914	\N	f	2022-09-29 09:54:30.365+00
2414	45	2340	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/trimgalore/sample_2_2.fastq.gz_trimming_report.txt	sample_2_2.fastq.gz_trimming_report.txt	4931	-1878792074	\N	f	2022-09-29 09:54:30.365+00
2415	45	2340	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/trimgalore/sample_3_1.fastq.gz_trimming_report.txt	sample_3_1.fastq.gz_trimming_report.txt	5022	-1402941802	\N	f	2022-09-29 09:54:30.365+00
2416	45	2340	original/35edf4a8-e094-487f-bdb7-a6891e42eaa1/results/trimgalore/sample_3_2.fastq.gz_trimming_report.txt	sample_3_2.fastq.gz_trimming_report.txt	5242	-87002154	\N	f	2022-09-29 09:54:30.365+00
2417	46	\N		20220929105444307-213	9472	\N	\N	t	2022-09-29 10:54:47.754+00
2418	46	2417	original	original	9472	\N	\N	t	2022-09-29 10:54:46.418+00
2419	46	2418	original/logs	logs	9472	\N	\N	t	2022-09-29 10:54:44.294+00
2420	46	2419	original/logs/salmon_quant.log	salmon_quant.log	9472	1581092143	\N	f	2022-09-29 10:54:44.294+00
2421	47	\N		20220929105446165-214	1634564542	\N	\N	t	2022-09-29 10:54:47.754+00
2422	47	2421	original	original	1634564542	\N	\N	t	2022-09-29 10:54:46.418+00
2423	47	2422	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5	7daba86f-560b-4dfb-9dae-8e66edf7fbd5	1634564542	\N	\N	t	2022-09-29 10:54:33.813+00
2424	47	2423	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results	results	1634564542	\N	\N	t	2022-09-29 10:18:30+00
2425	47	2424	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/fastqc	fastqc	8832903	\N	\N	t	2022-09-29 10:54:44.354+00
2426	47	2424	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc	multiqc	10352775	\N	\N	t	2022-09-29 10:18:27+00
2427	47	2426	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon	star_salmon	10352775	\N	\N	t	2022-09-29 10:54:46.122+00
2428	47	2427	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_data	multiqc_data	4420592	\N	\N	t	2022-09-29 10:54:46.146+00
2429	47	2427	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots	multiqc_plots	4177411	\N	\N	t	2022-09-29 10:18:29+00
2430	47	2429	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/pdf	pdf	835942	\N	\N	t	2022-09-29 10:54:46.138+00
2431	47	2429	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/png	png	1501880	\N	\N	t	2022-09-29 10:54:46.134+00
2432	47	2429	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/svg	svg	1839589	\N	\N	t	2022-09-29 10:54:46.126+00
2433	47	2424	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/pipeline_info	pipeline_info	17735592	\N	\N	t	2022-09-29 10:54:44.346+00
2434	47	2424	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon	star_salmon	1588615339	\N	\N	t	2022-09-29 10:54:46.118+00
2435	47	2434	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/bigwig	bigwig	744647771	\N	\N	t	2022-09-29 10:54:46.014+00
2436	47	2434	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/deseq2_qc	deseq2_qc	1919769	\N	\N	t	2022-09-29 10:54:46.118+00
2437	47	2436	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/deseq2_qc/size_factors	size_factors	283	\N	\N	t	2022-09-29 10:54:46.118+00
2438	47	2434	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/dupradar	dupradar	26416063	\N	\N	t	2022-09-29 10:18:43+00
2439	47	2438	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/dupradar/box_plot	box_plot	167836	\N	\N	t	2022-09-29 10:54:46.094+00
3127	59	3126	original	original	40188	\N	\N	t	2022-09-29 13:47:59.054+00
2441	47	2438	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/dupradar/histogram	histogram	15641	\N	\N	t	2022-09-29 10:54:46.086+00
2442	47	2438	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/dupradar/intercepts_slope	intercepts_slope	541	\N	\N	t	2022-09-29 10:54:46.094+00
2443	47	2438	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/dupradar/scatter_plot	scatter_plot	6919947	\N	\N	t	2022-09-29 10:54:46.094+00
2444	47	2434	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/log	log	26446497	\N	\N	t	2022-09-29 10:54:46.066+00
2445	47	2434	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/picard_metrics	picard_metrics	65046	\N	\N	t	2022-09-29 10:54:44.358+00
2446	47	2434	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/preseq	preseq	1500477	\N	\N	t	2022-09-29 10:54:44.362+00
2447	47	2446	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/preseq/log	log	42586	\N	\N	t	2022-09-29 10:54:44.362+00
2448	47	2434	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap	qualimap	1607219	\N	\N	t	2022-09-29 10:18:32+00
2449	47	2448	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_1	sample_1	534933	\N	\N	t	2022-09-29 10:54:46.11+00
2450	47	2449	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_1/css	css	166918	\N	\N	t	2022-09-29 10:54:46.11+00
2451	47	2449	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_1/images_qualimapReport	images_qualimapReport	347698	\N	\N	t	2022-09-29 10:54:46.11+00
2452	47	2449	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_1/raw_data_qualimapReport	raw_data_qualimapReport	7452	\N	\N	t	2022-09-29 10:54:46.11+00
2453	47	2448	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_2	sample_2	534665	\N	\N	t	2022-09-29 10:54:46.102+00
2454	47	2453	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_2/css	css	166918	\N	\N	t	2022-09-29 10:54:46.106+00
2455	47	2453	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_2/images_qualimapReport	images_qualimapReport	347173	\N	\N	t	2022-09-29 10:54:46.102+00
2456	47	2453	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_2/raw_data_qualimapReport	raw_data_qualimapReport	7465	\N	\N	t	2022-09-29 10:54:46.106+00
2457	47	2448	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_3	sample_3	537621	\N	\N	t	2022-09-29 10:54:46.106+00
2458	47	2457	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_3/css	css	166918	\N	\N	t	2022-09-29 10:54:46.11+00
2459	47	2457	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_3/images_qualimapReport	images_qualimapReport	350402	\N	\N	t	2022-09-29 10:54:46.106+00
2460	47	2457	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_3/raw_data_qualimapReport	raw_data_qualimapReport	7434	\N	\N	t	2022-09-29 10:54:46.11+00
2461	47	2434	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/rseqc	rseqc	447404866	\N	\N	t	2022-09-29 10:18:36+00
2462	47	2461	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/rseqc/bam_stat	bam_stat	2648	\N	\N	t	2022-09-29 10:54:44.602+00
2463	47	2461	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/rseqc/infer_experiment	infer_experiment	633	\N	\N	t	2022-09-29 10:54:44.862+00
2464	47	2461	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/rseqc/inner_distance	inner_distance	205317350	\N	\N	t	2022-09-29 10:18:36+00
2465	47	2464	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/rseqc/inner_distance/pdf	pdf	25867	\N	\N	t	2022-09-29 10:54:44.602+00
2466	47	2464	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/rseqc/inner_distance/rscript	rscript	4843	\N	\N	t	2022-09-29 10:54:44.598+00
2467	47	2464	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/rseqc/inner_distance/txt	txt	205286640	\N	\N	t	2022-09-29 10:54:44.598+00
2468	47	2461	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/rseqc/junction_annotation	junction_annotation	241776375	\N	\N	t	2022-09-29 10:18:36+00
2469	47	2468	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/rseqc/junction_annotation/bed	bed	210406986	\N	\N	t	2022-09-29 10:54:44.822+00
2470	47	2468	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/rseqc/junction_annotation/log	log	1791	\N	\N	t	2022-09-29 10:54:44.862+00
2471	47	2468	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/rseqc/junction_annotation/pdf	pdf	79848	\N	\N	t	2022-09-29 10:54:44.862+00
2472	47	2468	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/rseqc/junction_annotation/rscript	rscript	1744	\N	\N	t	2022-09-29 10:54:44.862+00
2473	47	2468	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/rseqc/junction_annotation/xls	xls	31286006	\N	\N	t	2022-09-29 10:54:44.858+00
2474	47	2461	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/rseqc/junction_saturation	junction_saturation	19546	\N	\N	t	2022-09-29 10:18:36+00
2475	47	2474	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/rseqc/junction_saturation/pdf	pdf	16779	\N	\N	t	2022-09-29 10:54:44.602+00
2476	47	2474	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/rseqc/junction_saturation/rscript	rscript	2767	\N	\N	t	2022-09-29 10:54:44.602+00
2477	47	2461	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/rseqc/read_distribution	read_distribution	3474	\N	\N	t	2022-09-29 10:54:44.602+00
2478	47	2461	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/rseqc/read_duplication	read_duplication	284840	\N	\N	t	2022-09-29 10:18:33+00
2479	47	2478	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/rseqc/read_duplication/pdf	pdf	64008	\N	\N	t	2022-09-29 10:54:44.602+00
2480	47	2478	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/rseqc/read_duplication/rscript	rscript	111574	\N	\N	t	2022-09-29 10:54:44.602+00
2481	47	2478	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/rseqc/read_duplication/xls	xls	109258	\N	\N	t	2022-09-29 10:54:44.602+00
2482	47	2434	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/sample_1	sample_1	5225181	\N	\N	t	2022-09-29 10:54:46.034+00
2483	47	2482	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/sample_1/aux_info	aux_info	375135	\N	\N	t	2022-09-29 10:54:46.034+00
2484	47	2482	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/sample_1/libParams	libParams	11697	\N	\N	t	2022-09-29 10:54:46.034+00
2485	47	2434	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/sample_2	sample_2	5200658	\N	\N	t	2022-09-29 10:54:44.37+00
2486	47	2485	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/sample_2/aux_info	aux_info	363982	\N	\N	t	2022-09-29 10:54:44.37+00
2487	47	2485	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/sample_2/libParams	libParams	11611	\N	\N	t	2022-09-29 10:54:44.37+00
2488	47	2485	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/sample_2/logs	logs	6561	\N	\N	t	2022-09-29 10:54:44.37+00
2489	47	2425	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/fastqc/sample_1_1_fastqc.html	sample_1_1_fastqc.html	639037	-1286085476	\N	f	2022-09-29 10:54:44.35+00
2490	47	2425	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/fastqc/sample_1_1_fastqc.zip	sample_1_1_fastqc.zip	795284	1617492036	\N	f	2022-09-29 10:54:44.35+00
2491	47	2425	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/fastqc/sample_1_2_fastqc.html	sample_1_2_fastqc.html	644973	217188180	\N	f	2022-09-29 10:54:44.354+00
2492	47	2425	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/fastqc/sample_1_2_fastqc.zip	sample_1_2_fastqc.zip	805496	-951892842	\N	f	2022-09-29 10:54:44.354+00
2493	47	2425	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/fastqc/sample_2_1_fastqc.html	sample_2_1_fastqc.html	647543	-75190030	\N	f	2022-09-29 10:54:44.346+00
2494	47	2425	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/fastqc/sample_2_1_fastqc.zip	sample_2_1_fastqc.zip	873117	148374326	\N	f	2022-09-29 10:54:44.346+00
2495	47	2425	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/fastqc/sample_2_2_fastqc.html	sample_2_2_fastqc.html	652819	780181365	\N	f	2022-09-29 10:54:44.35+00
2496	47	2425	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/fastqc/sample_2_2_fastqc.zip	sample_2_2_fastqc.zip	872804	1618255422	\N	f	2022-09-29 10:54:44.346+00
2497	47	2425	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/fastqc/sample_3_1_fastqc.html	sample_3_1_fastqc.html	646936	-190795236	\N	f	2022-09-29 10:54:44.354+00
2498	47	2425	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/fastqc/sample_3_1_fastqc.zip	sample_3_1_fastqc.zip	808733	-1575481324	\N	f	2022-09-29 10:54:44.354+00
2499	47	2425	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/fastqc/sample_3_2_fastqc.html	sample_3_2_fastqc.html	643045	2124846425	\N	f	2022-09-29 10:54:44.35+00
2500	47	2425	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/fastqc/sample_3_2_fastqc.zip	sample_3_2_fastqc.zip	803116	1782121499	\N	f	2022-09-29 10:54:44.35+00
2501	47	2428	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_data/mqc_cutadapt_filtered_reads_plot_1.txt	mqc_cutadapt_filtered_reads_plot_1.txt	193	-981698075	\N	f	2022-09-29 10:54:46.146+00
2502	47	2428	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_data/mqc_cutadapt_trimmed_sequences_plot_3_Counts.txt	mqc_cutadapt_trimmed_sequences_plot_3_Counts.txt	6767	-1081075168	\N	f	2022-09-29 10:54:46.146+00
2503	47	2428	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_data/mqc_cutadapt_trimmed_sequences_plot_3_Obs_Exp.txt	mqc_cutadapt_trimmed_sequences_plot_3_Obs_Exp.txt	16781	1907110956	\N	f	2022-09-29 10:54:46.146+00
2504	47	2428	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_data/mqc_fastqc_adapter_content_plot_1.txt	mqc_fastqc_adapter_content_plot_1.txt	9401	-232412809	\N	f	2022-09-29 10:54:46.146+00
2505	47	2428	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_data/mqc_fastqc_overrepresented_sequences_plot-2_1.txt	mqc_fastqc_overrepresented_sequences_plot-2_1.txt	316	972099134	\N	f	2022-09-29 10:54:46.146+00
2506	47	2428	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_data/mqc_fastqc_overrepresented_sequences_plot_1.txt	mqc_fastqc_overrepresented_sequences_plot_1.txt	313	65254753	\N	f	2022-09-29 10:54:46.146+00
2507	47	2428	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_data/mqc_fastqc_per_base_n_content_plot-2_1.txt	mqc_fastqc_per_base_n_content_plot-2_1.txt	5475	1228279625	\N	f	2022-09-29 10:54:46.138+00
2508	47	2428	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_data/mqc_fastqc_per_base_n_content_plot_1.txt	mqc_fastqc_per_base_n_content_plot_1.txt	5551	-100471464	\N	f	2022-09-29 10:54:46.138+00
2509	47	2428	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_data/mqc_fastqc_per_base_sequence_quality_plot-2_1.txt	mqc_fastqc_per_base_sequence_quality_plot-2_1.txt	5650	1842933182	\N	f	2022-09-29 10:54:46.146+00
2510	47	2428	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_data/mqc_fastqc_per_base_sequence_quality_plot_1.txt	mqc_fastqc_per_base_sequence_quality_plot_1.txt	5637	-416434196	\N	f	2022-09-29 10:54:46.146+00
2511	47	2428	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_data/mqc_fastqc_per_sequence_gc_content_plot-2_Counts.txt	mqc_fastqc_per_sequence_gc_content_plot-2_Counts.txt	5714	1527661144	\N	f	2022-09-29 10:54:46.138+00
2512	47	2428	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_data/mqc_fastqc_per_sequence_gc_content_plot-2_Percentages.txt	mqc_fastqc_per_sequence_gc_content_plot-2_Percentages.txt	12769	1199756996	\N	f	2022-09-29 10:54:46.146+00
2513	47	2428	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_data/mqc_fastqc_per_sequence_gc_content_plot_Counts.txt	mqc_fastqc_per_sequence_gc_content_plot_Counts.txt	5653	-603154072	\N	f	2022-09-29 10:54:46.146+00
2514	47	2428	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_data/mqc_fastqc_per_sequence_gc_content_plot_Percentages.txt	mqc_fastqc_per_sequence_gc_content_plot_Percentages.txt	12749	-1124935880	\N	f	2022-09-29 10:54:46.138+00
2515	47	2428	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_data/mqc_fastqc_per_sequence_quality_scores_plot-2_1.txt	mqc_fastqc_per_sequence_quality_scores_plot-2_1.txt	2197	-496385185	\N	f	2022-09-29 10:54:46.138+00
2516	47	2428	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_data/mqc_fastqc_per_sequence_quality_scores_plot_1.txt	mqc_fastqc_per_sequence_quality_scores_plot_1.txt	2251	1830481222	\N	f	2022-09-29 10:54:46.146+00
2517	47	2428	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_data/mqc_fastqc_sequence_counts_plot-2_1.txt	mqc_fastqc_sequence_counts_plot-2_1.txt	264	-649913624	\N	f	2022-09-29 10:54:46.138+00
2518	47	2428	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_data/mqc_fastqc_sequence_counts_plot_1.txt	mqc_fastqc_sequence_counts_plot_1.txt	264	-1309764125	\N	f	2022-09-29 10:54:46.146+00
2519	47	2428	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_data/mqc_fastqc_sequence_duplication_levels_plot-2_1.txt	mqc_fastqc_sequence_duplication_levels_plot-2_1.txt	1455	-77541120	\N	f	2022-09-29 10:54:46.138+00
2520	47	2428	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_data/mqc_fastqc_sequence_duplication_levels_plot_1.txt	mqc_fastqc_sequence_duplication_levels_plot_1.txt	1452	-720248770	\N	f	2022-09-29 10:54:46.146+00
2521	47	2428	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_data/mqc_fastqc_sequence_length_distribution_plot-2_1.txt	mqc_fastqc_sequence_length_distribution_plot-2_1.txt	2492	1213845806	\N	f	2022-09-29 10:54:46.138+00
2522	47	2428	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_data/mqc_fastqc_sequence_length_distribution_plot_1.txt	mqc_fastqc_sequence_length_distribution_plot_1.txt	1183	-107035386	\N	f	2022-09-29 10:54:46.138+00
2523	47	2428	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_data/mqc_mqc_mplplot_zxqfwhjbcr_1.txt	mqc_mqc_mplplot_zxqfwhjbcr_1.txt	369185	1247509436	\N	f	2022-09-29 10:54:46.146+00
2524	47	2428	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_data/mqc_picard_deduplication_1.txt	mqc_picard_deduplication_1.txt	310	-1734837397	\N	f	2022-09-29 10:54:46.146+00
2525	47	2428	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_data/mqc_preseq_plot_1.txt	mqc_preseq_plot_1.txt	86441	57066414	\N	f	2022-09-29 10:54:46.146+00
2526	47	2428	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_data/mqc_qualimap_gene_coverage_profile_Counts.txt	mqc_qualimap_gene_coverage_profile_Counts.txt	5907	-893767737	\N	f	2022-09-29 10:54:46.146+00
2527	47	2428	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_data/mqc_qualimap_gene_coverage_profile_Normalised.txt	mqc_qualimap_gene_coverage_profile_Normalised.txt	5998	-652235716	\N	f	2022-09-29 10:54:46.146+00
2528	47	2428	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_data/mqc_qualimap_genomic_origin_1.txt	mqc_qualimap_genomic_origin_1.txt	190	2114688517	\N	f	2022-09-29 10:54:46.138+00
2529	47	2428	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_data/mqc_rseqc_infer_experiment_plot_1.txt	mqc_rseqc_infer_experiment_plot_1.txt	178	1606282427	\N	f	2022-09-29 10:54:46.146+00
2530	47	2428	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_data/mqc_rseqc_inner_distance_plot_Counts.txt	mqc_rseqc_inner_distance_plot_Counts.txt	2637	-1088222837	\N	f	2022-09-29 10:54:46.146+00
2531	47	2428	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_data/mqc_rseqc_inner_distance_plot_Percentages.txt	mqc_rseqc_inner_distance_plot_Percentages.txt	5386	483091739	\N	f	2022-09-29 10:54:46.138+00
2532	47	2428	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_data/mqc_rseqc_junction_annotation_junctions_plot_Events.txt	mqc_rseqc_junction_annotation_junctions_plot_Events.txt	226	813498572	\N	f	2022-09-29 10:54:46.146+00
2533	47	2428	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_data/mqc_rseqc_junction_annotation_junctions_plot_Junctions.txt	mqc_rseqc_junction_annotation_junctions_plot_Junctions.txt	221	717573797	\N	f	2022-09-29 10:54:46.138+00
2534	47	2428	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_data/mqc_rseqc_junction_saturation_plot_All_Junctions.txt	mqc_rseqc_junction_saturation_plot_All_Junctions.txt	702	2080846703	\N	f	2022-09-29 10:54:46.142+00
2535	47	2428	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_data/mqc_rseqc_junction_saturation_plot_Known_Junctions.txt	mqc_rseqc_junction_saturation_plot_Known_Junctions.txt	697	1690106047	\N	f	2022-09-29 10:54:46.146+00
2536	47	2428	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_data/mqc_rseqc_junction_saturation_plot_Novel_Junctions.txt	mqc_rseqc_junction_saturation_plot_Novel_Junctions.txt	679	729677352	\N	f	2022-09-29 10:54:46.146+00
2537	47	2428	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_data/mqc_rseqc_read_distribution_plot_1.txt	mqc_rseqc_read_distribution_plot_1.txt	452	-1574182615	\N	f	2022-09-29 10:54:46.146+00
2538	47	2428	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_data/mqc_rseqc_read_dups_plot_1.txt	mqc_rseqc_read_dups_plot_1.txt	3199	-149103187	\N	f	2022-09-29 10:54:46.146+00
2539	47	2428	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_data/mqc_samtools-idxstats-mapped-reads-plot_Normalised_Counts.txt	mqc_samtools-idxstats-mapped-reads-plot_Normalised_Counts.txt	594	-756924988	\N	f	2022-09-29 10:54:46.146+00
2540	47	2428	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_data/mqc_samtools-idxstats-mapped-reads-plot_Observed_over_Expected_Counts.txt	mqc_samtools-idxstats-mapped-reads-plot_Observed_over_Expected_Counts.txt	570	83001990	\N	f	2022-09-29 10:54:46.146+00
2541	47	2428	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_data/mqc_samtools-idxstats-mapped-reads-plot_Raw_Counts.txt	mqc_samtools-idxstats-mapped-reads-plot_Raw_Counts.txt	324	-538695629	\N	f	2022-09-29 10:54:46.138+00
2542	47	2428	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_data/mqc_samtools_alignment_plot_1.txt	mqc_samtools_alignment_plot_1.txt	105	994196115	\N	f	2022-09-29 10:54:46.146+00
2543	47	2428	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_data/mqc_star_alignment_plot_1.txt	mqc_star_alignment_plot_1.txt	314	2122160091	\N	f	2022-09-29 10:54:46.138+00
2544	47	2428	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_data/multiqc.log	multiqc.log	22448	17557314	\N	f	2022-09-29 10:54:46.146+00
2545	47	2428	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_data/multiqc_cutadapt.txt	multiqc_cutadapt.txt	718	750634017	\N	f	2022-09-29 10:54:46.138+00
2546	47	2428	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_data/multiqc_data.json	multiqc_data.json	3779057	1997818401	\N	f	2022-09-29 10:54:46.142+00
2547	47	2428	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_data/multiqc_fastqc.txt	multiqc_fastqc.txt	1603	-935181832	\N	f	2022-09-29 10:54:46.146+00
2548	47	2428	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_data/multiqc_fastqc_1.txt	multiqc_fastqc_1.txt	1646	326762218	\N	f	2022-09-29 10:54:46.146+00
2549	47	2428	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_data/multiqc_general_stats.txt	multiqc_general_stats.txt	3252	-1998888392	\N	f	2022-09-29 10:54:46.138+00
3128	59	3127	original/annotation.gff	annotation.gff	40188	1069412892	\N	f	2022-09-29 13:47:58.726+00
2550	47	2428	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_data/multiqc_picard_dups.txt	multiqc_picard_dups.txt	582	-15048217	\N	f	2022-09-29 10:54:46.138+00
2551	47	2428	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_data/multiqc_rseqc_bam_stat.txt	multiqc_rseqc_bam_stat.txt	844	2018215466	\N	f	2022-09-29 10:54:46.146+00
2552	47	2428	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_data/multiqc_rseqc_infer_experiment.txt	multiqc_rseqc_infer_experiment.txt	148	706937436	\N	f	2022-09-29 10:54:46.138+00
2553	47	2428	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_data/multiqc_rseqc_junction_annotation.txt	multiqc_rseqc_junction_annotation.txt	954	-349862921	\N	f	2022-09-29 10:54:46.142+00
2554	47	2428	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_data/multiqc_rseqc_read_distribution.txt	multiqc_rseqc_read_distribution.txt	2267	-1427511838	\N	f	2022-09-29 10:54:46.146+00
2555	47	2428	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_data/multiqc_samtools_flagstat.txt	multiqc_samtools_flagstat.txt	1328	898161035	\N	f	2022-09-29 10:54:46.146+00
2556	47	2428	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_data/multiqc_samtools_idxstats.txt	multiqc_samtools_idxstats.txt	629	-566869535	\N	f	2022-09-29 10:54:46.138+00
2557	47	2428	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_data/multiqc_samtools_stats.txt	multiqc_samtools_stats.txt	2349	1721437199	\N	f	2022-09-29 10:54:46.146+00
2558	47	2428	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_data/multiqc_sources.txt	multiqc_sources.txt	12812	1623333671	\N	f	2022-09-29 10:54:46.146+00
2559	47	2428	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_data/multiqc_star.txt	multiqc_star.txt	1113	-2120567567	\N	f	2022-09-29 10:54:46.138+00
2560	47	2430	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_cutadapt_filtered_reads_plot_1.pdf	mqc_cutadapt_filtered_reads_plot_1.pdf	12124	-924729504	\N	f	2022-09-29 10:54:46.138+00
2561	47	2430	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_cutadapt_filtered_reads_plot_1_pc.pdf	mqc_cutadapt_filtered_reads_plot_1_pc.pdf	12699	-2080681115	\N	f	2022-09-29 10:54:46.134+00
2562	47	2430	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_cutadapt_trimmed_sequences_plot_3_Counts.pdf	mqc_cutadapt_trimmed_sequences_plot_3_Counts.pdf	17935	226096510	\N	f	2022-09-29 10:54:46.138+00
2563	47	2430	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_cutadapt_trimmed_sequences_plot_3_Obs_Exp.pdf	mqc_cutadapt_trimmed_sequences_plot_3_Obs_Exp.pdf	20287	1155612789	\N	f	2022-09-29 10:54:46.138+00
2564	47	2430	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_fastqc_adapter_content_plot_1.pdf	mqc_fastqc_adapter_content_plot_1.pdf	18841	-1704696748	\N	f	2022-09-29 10:54:46.138+00
2565	47	2430	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_fastqc_overrepresented_sequences_plot-2_1.pdf	mqc_fastqc_overrepresented_sequences_plot-2_1.pdf	14126	290293113	\N	f	2022-09-29 10:54:46.138+00
2566	47	2430	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_fastqc_overrepresented_sequences_plot_1.pdf	mqc_fastqc_overrepresented_sequences_plot_1.pdf	14789	409012846	\N	f	2022-09-29 10:54:46.138+00
2567	47	2430	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_fastqc_per_base_n_content_plot-2_1.pdf	mqc_fastqc_per_base_n_content_plot-2_1.pdf	16726	-26280636	\N	f	2022-09-29 10:54:46.134+00
2568	47	2430	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_fastqc_per_base_n_content_plot_1.pdf	mqc_fastqc_per_base_n_content_plot_1.pdf	16740	842860274	\N	f	2022-09-29 10:54:46.138+00
2569	47	2430	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_fastqc_per_base_sequence_quality_plot-2_1.pdf	mqc_fastqc_per_base_sequence_quality_plot-2_1.pdf	17031	1520207281	\N	f	2022-09-29 10:54:46.134+00
2570	47	2430	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_fastqc_per_base_sequence_quality_plot_1.pdf	mqc_fastqc_per_base_sequence_quality_plot_1.pdf	17066	237866225	\N	f	2022-09-29 10:54:46.134+00
2571	47	2430	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_fastqc_per_sequence_gc_content_plot-2_Counts.pdf	mqc_fastqc_per_sequence_gc_content_plot-2_Counts.pdf	18648	-1097212065	\N	f	2022-09-29 10:54:46.138+00
2572	47	2430	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_fastqc_per_sequence_gc_content_plot-2_Percentages.pdf	mqc_fastqc_per_sequence_gc_content_plot-2_Percentages.pdf	18839	1836248522	\N	f	2022-09-29 10:54:46.134+00
2573	47	2430	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_fastqc_per_sequence_gc_content_plot_Counts.pdf	mqc_fastqc_per_sequence_gc_content_plot_Counts.pdf	18329	-215012099	\N	f	2022-09-29 10:54:46.138+00
2574	47	2430	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_fastqc_per_sequence_gc_content_plot_Percentages.pdf	mqc_fastqc_per_sequence_gc_content_plot_Percentages.pdf	18828	2094562464	\N	f	2022-09-29 10:54:46.134+00
2575	47	2430	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_fastqc_per_sequence_quality_scores_plot-2_1.pdf	mqc_fastqc_per_sequence_quality_scores_plot-2_1.pdf	16179	12438685	\N	f	2022-09-29 10:54:46.134+00
2576	47	2430	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_fastqc_per_sequence_quality_scores_plot_1.pdf	mqc_fastqc_per_sequence_quality_scores_plot_1.pdf	15699	650505397	\N	f	2022-09-29 10:54:46.134+00
2577	47	2430	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_fastqc_sequence_counts_plot-2_1.pdf	mqc_fastqc_sequence_counts_plot-2_1.pdf	14443	1685774979	\N	f	2022-09-29 10:54:46.134+00
2578	47	2430	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_fastqc_sequence_counts_plot-2_1_pc.pdf	mqc_fastqc_sequence_counts_plot-2_1_pc.pdf	15015	888875321	\N	f	2022-09-29 10:54:46.138+00
2579	47	2430	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_fastqc_sequence_counts_plot_1.pdf	mqc_fastqc_sequence_counts_plot_1.pdf	14436	535282662	\N	f	2022-09-29 10:54:46.138+00
2580	47	2430	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_fastqc_sequence_counts_plot_1_pc.pdf	mqc_fastqc_sequence_counts_plot_1_pc.pdf	15014	-1362738238	\N	f	2022-09-29 10:54:46.134+00
2581	47	2430	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_fastqc_sequence_duplication_levels_plot-2_1.pdf	mqc_fastqc_sequence_duplication_levels_plot-2_1.pdf	16988	904301170	\N	f	2022-09-29 10:54:46.138+00
2582	47	2430	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_fastqc_sequence_duplication_levels_plot_1.pdf	mqc_fastqc_sequence_duplication_levels_plot_1.pdf	16974	999725607	\N	f	2022-09-29 10:54:46.138+00
2583	47	2430	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_fastqc_sequence_length_distribution_plot-2_1.pdf	mqc_fastqc_sequence_length_distribution_plot-2_1.pdf	17421	123671178	\N	f	2022-09-29 10:54:46.138+00
2584	47	2430	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_fastqc_sequence_length_distribution_plot_1.pdf	mqc_fastqc_sequence_length_distribution_plot_1.pdf	16280	-1676030077	\N	f	2022-09-29 10:54:46.134+00
2585	47	2430	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_mqc_mplplot_zxqfwhjbcr_1.pdf	mqc_mqc_mplplot_zxqfwhjbcr_1.pdf	15593	-1394316326	\N	f	2022-09-29 10:54:46.138+00
2586	47	2430	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_picard_deduplication_1.pdf	mqc_picard_deduplication_1.pdf	14074	124706771	\N	f	2022-09-29 10:54:46.138+00
2587	47	2430	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_picard_deduplication_1_pc.pdf	mqc_picard_deduplication_1_pc.pdf	14675	-1111995462	\N	f	2022-09-29 10:54:46.134+00
2588	47	2430	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_preseq_plot_1.pdf	mqc_preseq_plot_1.pdf	17602	-919341106	\N	f	2022-09-29 10:54:46.134+00
2589	47	2430	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_qualimap_gene_coverage_profile_Counts.pdf	mqc_qualimap_gene_coverage_profile_Counts.pdf	18894	-1926706202	\N	f	2022-09-29 10:54:46.138+00
2590	47	2430	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_qualimap_gene_coverage_profile_Normalised.pdf	mqc_qualimap_gene_coverage_profile_Normalised.pdf	18964	-1552777981	\N	f	2022-09-29 10:54:46.138+00
2591	47	2430	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_qualimap_genomic_origin_1.pdf	mqc_qualimap_genomic_origin_1.pdf	15056	-667448416	\N	f	2022-09-29 10:54:46.134+00
2592	47	2430	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_qualimap_genomic_origin_1_pc.pdf	mqc_qualimap_genomic_origin_1_pc.pdf	15369	469270013	\N	f	2022-09-29 10:54:46.134+00
2593	47	2430	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_rseqc_infer_experiment_plot_1.pdf	mqc_rseqc_infer_experiment_plot_1.pdf	13859	1976044061	\N	f	2022-09-29 10:54:46.138+00
2594	47	2430	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_rseqc_inner_distance_plot_Counts.pdf	mqc_rseqc_inner_distance_plot_Counts.pdf	15171	-292826498	\N	f	2022-09-29 10:54:46.134+00
2595	47	2430	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_rseqc_inner_distance_plot_Percentages.pdf	mqc_rseqc_inner_distance_plot_Percentages.pdf	15687	-1633988100	\N	f	2022-09-29 10:54:46.134+00
2596	47	2430	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_rseqc_junction_annotation_junctions_plot_Events.pdf	mqc_rseqc_junction_annotation_junctions_plot_Events.pdf	14352	266136115	\N	f	2022-09-29 10:54:46.138+00
2597	47	2430	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_rseqc_junction_annotation_junctions_plot_Events_pc.pdf	mqc_rseqc_junction_annotation_junctions_plot_Events_pc.pdf	14699	-1812368174	\N	f	2022-09-29 10:54:46.138+00
2598	47	2430	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_rseqc_junction_annotation_junctions_plot_Junctions.pdf	mqc_rseqc_junction_annotation_junctions_plot_Junctions.pdf	13759	1953561848	\N	f	2022-09-29 10:54:46.138+00
2599	47	2430	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_rseqc_junction_annotation_junctions_plot_Junctions_pc.pdf	mqc_rseqc_junction_annotation_junctions_plot_Junctions_pc.pdf	14501	-1916509033	\N	f	2022-09-29 10:54:46.138+00
2600	47	2430	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_rseqc_junction_saturation_plot_All_Junctions.pdf	mqc_rseqc_junction_saturation_plot_All_Junctions.pdf	14667	-815741899	\N	f	2022-09-29 10:54:46.134+00
2601	47	2430	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_rseqc_junction_saturation_plot_Known_Junctions.pdf	mqc_rseqc_junction_saturation_plot_Known_Junctions.pdf	14311	-983296740	\N	f	2022-09-29 10:54:46.134+00
2602	47	2430	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_rseqc_junction_saturation_plot_Novel_Junctions.pdf	mqc_rseqc_junction_saturation_plot_Novel_Junctions.pdf	14397	596499339	\N	f	2022-09-29 10:54:46.134+00
2603	47	2430	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_rseqc_read_distribution_plot_1.pdf	mqc_rseqc_read_distribution_plot_1.pdf	16788	315965108	\N	f	2022-09-29 10:54:46.134+00
2604	47	2430	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_rseqc_read_distribution_plot_1_pc.pdf	mqc_rseqc_read_distribution_plot_1_pc.pdf	17462	-1319025941	\N	f	2022-09-29 10:54:46.134+00
2605	47	2430	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_rseqc_read_dups_plot_1.pdf	mqc_rseqc_read_dups_plot_1.pdf	15009	-2013756793	\N	f	2022-09-29 10:54:46.138+00
2606	47	2430	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_samtools-idxstats-mapped-reads-plot_Normalised_Counts.pdf	mqc_samtools-idxstats-mapped-reads-plot_Normalised_Counts.pdf	14536	180402686	\N	f	2022-09-29 10:54:46.134+00
2607	47	2430	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_samtools-idxstats-mapped-reads-plot_Observed_over_Expected_Counts.pdf	mqc_samtools-idxstats-mapped-reads-plot_Observed_over_Expected_Counts.pdf	15522	871508061	\N	f	2022-09-29 10:54:46.138+00
2608	47	2430	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_samtools-idxstats-mapped-reads-plot_Raw_Counts.pdf	mqc_samtools-idxstats-mapped-reads-plot_Raw_Counts.pdf	14367	1758209321	\N	f	2022-09-29 10:54:46.134+00
2609	47	2430	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_samtools_alignment_plot_1.pdf	mqc_samtools_alignment_plot_1.pdf	12415	972987573	\N	f	2022-09-29 10:54:46.134+00
3129	60	\N		20220929134800095-265	50984	\N	\N	t	2022-09-29 13:48:01.218+00
2610	47	2430	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_samtools_alignment_plot_1_pc.pdf	mqc_samtools_alignment_plot_1_pc.pdf	13023	1031348125	\N	f	2022-09-29 10:54:46.134+00
2611	47	2430	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_star_alignment_plot_1.pdf	mqc_star_alignment_plot_1.pdf	14576	-1270279804	\N	f	2022-09-29 10:54:46.138+00
2612	47	2430	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/pdf/mqc_star_alignment_plot_1_pc.pdf	mqc_star_alignment_plot_1_pc.pdf	15157	-380473439	\N	f	2022-09-29 10:54:46.138+00
2613	47	2431	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/png/mqc_cutadapt_filtered_reads_plot_1.png	mqc_cutadapt_filtered_reads_plot_1.png	12310	1600049302	\N	f	2022-09-29 10:54:46.13+00
2614	47	2431	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/png/mqc_cutadapt_filtered_reads_plot_1_pc.png	mqc_cutadapt_filtered_reads_plot_1_pc.png	12629	17575454	\N	f	2022-09-29 10:54:46.134+00
2615	47	2431	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/png/mqc_cutadapt_trimmed_sequences_plot_3_Counts.png	mqc_cutadapt_trimmed_sequences_plot_3_Counts.png	29935	-879504401	\N	f	2022-09-29 10:54:46.13+00
2616	47	2431	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/png/mqc_cutadapt_trimmed_sequences_plot_3_Obs_Exp.png	mqc_cutadapt_trimmed_sequences_plot_3_Obs_Exp.png	71346	-1859824234	\N	f	2022-09-29 10:54:46.13+00
2617	47	2431	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/png/mqc_fastqc_adapter_content_plot_1.png	mqc_fastqc_adapter_content_plot_1.png	32501	-48480481	\N	f	2022-09-29 10:54:46.13+00
2618	47	2431	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/png/mqc_fastqc_overrepresented_sequences_plot-2_1.png	mqc_fastqc_overrepresented_sequences_plot-2_1.png	16054	632482818	\N	f	2022-09-29 10:54:46.134+00
2619	47	2431	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/png/mqc_fastqc_overrepresented_sequences_plot_1.png	mqc_fastqc_overrepresented_sequences_plot_1.png	16337	1191258299	\N	f	2022-09-29 10:54:46.13+00
2620	47	2431	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/png/mqc_fastqc_per_base_n_content_plot-2_1.png	mqc_fastqc_per_base_n_content_plot-2_1.png	17235	-614408787	\N	f	2022-09-29 10:54:46.13+00
2621	47	2431	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/png/mqc_fastqc_per_base_n_content_plot_1.png	mqc_fastqc_per_base_n_content_plot_1.png	17232	2137589326	\N	f	2022-09-29 10:54:46.13+00
2622	47	2431	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/png/mqc_fastqc_per_base_sequence_quality_plot-2_1.png	mqc_fastqc_per_base_sequence_quality_plot-2_1.png	23639	-696210227	\N	f	2022-09-29 10:54:46.13+00
2623	47	2431	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/png/mqc_fastqc_per_base_sequence_quality_plot_1.png	mqc_fastqc_per_base_sequence_quality_plot_1.png	23541	1552208520	\N	f	2022-09-29 10:54:46.134+00
2624	47	2431	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/png/mqc_fastqc_per_sequence_gc_content_plot-2_Counts.png	mqc_fastqc_per_sequence_gc_content_plot-2_Counts.png	49284	-1552398426	\N	f	2022-09-29 10:54:46.13+00
2625	47	2431	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/png/mqc_fastqc_per_sequence_gc_content_plot-2_Percentages.png	mqc_fastqc_per_sequence_gc_content_plot-2_Percentages.png	61367	-807815047	\N	f	2022-09-29 10:54:46.13+00
2626	47	2431	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/png/mqc_fastqc_per_sequence_gc_content_plot_Counts.png	mqc_fastqc_per_sequence_gc_content_plot_Counts.png	51400	2040241303	\N	f	2022-09-29 10:54:46.134+00
2627	47	2431	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/png/mqc_fastqc_per_sequence_gc_content_plot_Percentages.png	mqc_fastqc_per_sequence_gc_content_plot_Percentages.png	63175	413657584	\N	f	2022-09-29 10:54:46.134+00
2628	47	2431	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/png/mqc_fastqc_per_sequence_quality_scores_plot-2_1.png	mqc_fastqc_per_sequence_quality_scores_plot-2_1.png	38431	-380249912	\N	f	2022-09-29 10:54:46.134+00
2629	47	2431	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/png/mqc_fastqc_per_sequence_quality_scores_plot_1.png	mqc_fastqc_per_sequence_quality_scores_plot_1.png	37725	1569181275	\N	f	2022-09-29 10:54:46.13+00
2630	47	2431	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/png/mqc_fastqc_sequence_counts_plot-2_1.png	mqc_fastqc_sequence_counts_plot-2_1.png	13425	1171540378	\N	f	2022-09-29 10:54:46.134+00
2631	47	2431	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/png/mqc_fastqc_sequence_counts_plot-2_1_pc.png	mqc_fastqc_sequence_counts_plot-2_1_pc.png	13770	1248320402	\N	f	2022-09-29 10:54:46.134+00
2632	47	2431	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/png/mqc_fastqc_sequence_counts_plot_1.png	mqc_fastqc_sequence_counts_plot_1.png	13425	-544228432	\N	f	2022-09-29 10:54:46.13+00
2633	47	2431	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/png/mqc_fastqc_sequence_counts_plot_1_pc.png	mqc_fastqc_sequence_counts_plot_1_pc.png	13768	1063863456	\N	f	2022-09-29 10:54:46.13+00
2634	47	2431	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/png/mqc_fastqc_sequence_duplication_levels_plot-2_1.png	mqc_fastqc_sequence_duplication_levels_plot-2_1.png	46291	-589381749	\N	f	2022-09-29 10:54:46.13+00
2635	47	2431	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/png/mqc_fastqc_sequence_duplication_levels_plot_1.png	mqc_fastqc_sequence_duplication_levels_plot_1.png	45604	-1875278725	\N	f	2022-09-29 10:54:46.13+00
2636	47	2431	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/png/mqc_fastqc_sequence_length_distribution_plot-2_1.png	mqc_fastqc_sequence_length_distribution_plot-2_1.png	33465	560340504	\N	f	2022-09-29 10:54:46.13+00
2637	47	2431	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/png/mqc_fastqc_sequence_length_distribution_plot_1.png	mqc_fastqc_sequence_length_distribution_plot_1.png	25266	1054486607	\N	f	2022-09-29 10:54:46.13+00
2638	47	2431	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/png/mqc_mqc_mplplot_zxqfwhjbcr_1.png	mqc_mqc_mplplot_zxqfwhjbcr_1.png	25653	-437859886	\N	f	2022-09-29 10:54:46.13+00
2804	47	2450	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_1/css/file.png	file.png	420	-531122909	\N	f	2022-09-29 10:54:46.11+00
2639	47	2431	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/png/mqc_picard_deduplication_1.png	mqc_picard_deduplication_1.png	11999	1821641819	\N	f	2022-09-29 10:54:46.13+00
2640	47	2431	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/png/mqc_picard_deduplication_1_pc.png	mqc_picard_deduplication_1_pc.png	12483	-1348413105	\N	f	2022-09-29 10:54:46.13+00
2641	47	2431	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/png/mqc_preseq_plot_1.png	mqc_preseq_plot_1.png	47684	672382818	\N	f	2022-09-29 10:54:46.13+00
2642	47	2431	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/png/mqc_qualimap_gene_coverage_profile_Counts.png	mqc_qualimap_gene_coverage_profile_Counts.png	57134	-139140562	\N	f	2022-09-29 10:54:46.13+00
2643	47	2431	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/png/mqc_qualimap_gene_coverage_profile_Normalised.png	mqc_qualimap_gene_coverage_profile_Normalised.png	61968	-1416915136	\N	f	2022-09-29 10:54:46.13+00
2644	47	2431	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/png/mqc_qualimap_genomic_origin_1.png	mqc_qualimap_genomic_origin_1.png	10800	1460893652	\N	f	2022-09-29 10:54:46.134+00
2645	47	2431	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/png/mqc_qualimap_genomic_origin_1_pc.png	mqc_qualimap_genomic_origin_1_pc.png	10660	1052958824	\N	f	2022-09-29 10:54:46.134+00
2646	47	2431	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/png/mqc_rseqc_infer_experiment_plot_1.png	mqc_rseqc_infer_experiment_plot_1.png	10286	-819319247	\N	f	2022-09-29 10:54:46.134+00
2647	47	2431	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/png/mqc_rseqc_inner_distance_plot_Counts.png	mqc_rseqc_inner_distance_plot_Counts.png	49669	700709431	\N	f	2022-09-29 10:54:46.13+00
2648	47	2431	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/png/mqc_rseqc_inner_distance_plot_Percentages.png	mqc_rseqc_inner_distance_plot_Percentages.png	48913	-2031104949	\N	f	2022-09-29 10:54:46.134+00
2649	47	2431	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/png/mqc_rseqc_junction_annotation_junctions_plot_Events.png	mqc_rseqc_junction_annotation_junctions_plot_Events.png	12444	1184726338	\N	f	2022-09-29 10:54:46.13+00
2650	47	2431	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/png/mqc_rseqc_junction_annotation_junctions_plot_Events_pc.png	mqc_rseqc_junction_annotation_junctions_plot_Events_pc.png	13007	-1076447309	\N	f	2022-09-29 10:54:46.13+00
2651	47	2431	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/png/mqc_rseqc_junction_annotation_junctions_plot_Junctions.png	mqc_rseqc_junction_annotation_junctions_plot_Junctions.png	12637	463902949	\N	f	2022-09-29 10:54:46.134+00
2652	47	2431	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/png/mqc_rseqc_junction_annotation_junctions_plot_Junctions_pc.png	mqc_rseqc_junction_annotation_junctions_plot_Junctions_pc.png	13146	10060041	\N	f	2022-09-29 10:54:46.13+00
2653	47	2431	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/png/mqc_rseqc_junction_saturation_plot_All_Junctions.png	mqc_rseqc_junction_saturation_plot_All_Junctions.png	35125	-885665071	\N	f	2022-09-29 10:54:46.13+00
2654	47	2431	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/png/mqc_rseqc_junction_saturation_plot_Known_Junctions.png	mqc_rseqc_junction_saturation_plot_Known_Junctions.png	26460	-977745114	\N	f	2022-09-29 10:54:46.13+00
2655	47	2431	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/png/mqc_rseqc_junction_saturation_plot_Novel_Junctions.png	mqc_rseqc_junction_saturation_plot_Novel_Junctions.png	42646	985383398	\N	f	2022-09-29 10:54:46.134+00
2656	47	2431	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/png/mqc_rseqc_read_distribution_plot_1.png	mqc_rseqc_read_distribution_plot_1.png	15381	-1361087995	\N	f	2022-09-29 10:54:46.13+00
2657	47	2431	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/png/mqc_rseqc_read_distribution_plot_1_pc.png	mqc_rseqc_read_distribution_plot_1_pc.png	15221	-1529802196	\N	f	2022-09-29 10:54:46.13+00
2658	47	2431	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/png/mqc_rseqc_read_dups_plot_1.png	mqc_rseqc_read_dups_plot_1.png	20822	1791445069	\N	f	2022-09-29 10:54:46.134+00
2659	47	2431	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/png/mqc_samtools-idxstats-mapped-reads-plot_Normalised_Counts.png	mqc_samtools-idxstats-mapped-reads-plot_Normalised_Counts.png	42239	517464844	\N	f	2022-09-29 10:54:46.13+00
2660	47	2431	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/png/mqc_samtools-idxstats-mapped-reads-plot_Observed_over_Expected_Counts.png	mqc_samtools-idxstats-mapped-reads-plot_Observed_over_Expected_Counts.png	43508	1102409374	\N	f	2022-09-29 10:54:46.13+00
2661	47	2431	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/png/mqc_samtools-idxstats-mapped-reads-plot_Raw_Counts.png	mqc_samtools-idxstats-mapped-reads-plot_Raw_Counts.png	39151	2087489859	\N	f	2022-09-29 10:54:46.13+00
2662	47	2431	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/png/mqc_samtools_alignment_plot_1.png	mqc_samtools_alignment_plot_1.png	8995	-1130524009	\N	f	2022-09-29 10:54:46.13+00
2663	47	2431	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/png/mqc_samtools_alignment_plot_1_pc.png	mqc_samtools_alignment_plot_1_pc.png	9450	-1400029035	\N	f	2022-09-29 10:54:46.13+00
2664	47	2431	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/png/mqc_star_alignment_plot_1.png	mqc_star_alignment_plot_1.png	12397	1704166368	\N	f	2022-09-29 10:54:46.134+00
2665	47	2431	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/png/mqc_star_alignment_plot_1_pc.png	mqc_star_alignment_plot_1_pc.png	12847	1050567474	\N	f	2022-09-29 10:54:46.13+00
2666	47	2432	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/svg/mqc_cutadapt_filtered_reads_plot_1.svg	mqc_cutadapt_filtered_reads_plot_1.svg	25010	-1414547692	\N	f	2022-09-29 10:54:46.122+00
2667	47	2432	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/svg/mqc_cutadapt_filtered_reads_plot_1_pc.svg	mqc_cutadapt_filtered_reads_plot_1_pc.svg	25956	23670200	\N	f	2022-09-29 10:54:46.122+00
2668	47	2432	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/svg/mqc_cutadapt_trimmed_sequences_plot_3_Counts.svg	mqc_cutadapt_trimmed_sequences_plot_3_Counts.svg	43498	-663795659	\N	f	2022-09-29 10:54:46.126+00
2669	47	2432	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/svg/mqc_cutadapt_trimmed_sequences_plot_3_Obs_Exp.svg	mqc_cutadapt_trimmed_sequences_plot_3_Obs_Exp.svg	52556	-1208273048	\N	f	2022-09-29 10:54:46.126+00
2670	47	2432	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/svg/mqc_fastqc_adapter_content_plot_1.svg	mqc_fastqc_adapter_content_plot_1.svg	52670	9565031	\N	f	2022-09-29 10:54:46.122+00
2671	47	2432	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/svg/mqc_fastqc_overrepresented_sequences_plot-2_1.svg	mqc_fastqc_overrepresented_sequences_plot-2_1.svg	32453	-1360039116	\N	f	2022-09-29 10:54:46.126+00
2672	47	2432	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/svg/mqc_fastqc_overrepresented_sequences_plot_1.svg	mqc_fastqc_overrepresented_sequences_plot_1.svg	34086	137551251	\N	f	2022-09-29 10:54:46.126+00
2673	47	2432	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/svg/mqc_fastqc_per_base_n_content_plot-2_1.svg	mqc_fastqc_per_base_n_content_plot-2_1.svg	38536	1952334554	\N	f	2022-09-29 10:54:46.122+00
2674	47	2432	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/svg/mqc_fastqc_per_base_n_content_plot_1.svg	mqc_fastqc_per_base_n_content_plot_1.svg	38536	-1969900449	\N	f	2022-09-29 10:54:46.126+00
2675	47	2432	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/svg/mqc_fastqc_per_base_sequence_quality_plot-2_1.svg	mqc_fastqc_per_base_sequence_quality_plot-2_1.svg	38155	1886860779	\N	f	2022-09-29 10:54:46.126+00
2676	47	2432	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/svg/mqc_fastqc_per_base_sequence_quality_plot_1.svg	mqc_fastqc_per_base_sequence_quality_plot_1.svg	38160	1663139902	\N	f	2022-09-29 10:54:46.122+00
2677	47	2432	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/svg/mqc_fastqc_per_sequence_gc_content_plot-2_Counts.svg	mqc_fastqc_per_sequence_gc_content_plot-2_Counts.svg	46091	416874027	\N	f	2022-09-29 10:54:46.126+00
2678	47	2432	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/svg/mqc_fastqc_per_sequence_gc_content_plot-2_Percentages.svg	mqc_fastqc_per_sequence_gc_content_plot-2_Percentages.svg	44606	-1229673355	\N	f	2022-09-29 10:54:46.122+00
2679	47	2432	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/svg/mqc_fastqc_per_sequence_gc_content_plot_Counts.svg	mqc_fastqc_per_sequence_gc_content_plot_Counts.svg	45550	712339813	\N	f	2022-09-29 10:54:46.126+00
2680	47	2432	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/svg/mqc_fastqc_per_sequence_gc_content_plot_Percentages.svg	mqc_fastqc_per_sequence_gc_content_plot_Percentages.svg	44580	484317518	\N	f	2022-09-29 10:54:46.126+00
2681	47	2432	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/svg/mqc_fastqc_per_sequence_quality_scores_plot-2_1.svg	mqc_fastqc_per_sequence_quality_scores_plot-2_1.svg	38412	-219733408	\N	f	2022-09-29 10:54:46.126+00
2682	47	2432	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/svg/mqc_fastqc_per_sequence_quality_scores_plot_1.svg	mqc_fastqc_per_sequence_quality_scores_plot_1.svg	37635	814983565	\N	f	2022-09-29 10:54:46.126+00
2683	47	2432	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/svg/mqc_fastqc_sequence_counts_plot-2_1.svg	mqc_fastqc_sequence_counts_plot-2_1.svg	30051	1395224721	\N	f	2022-09-29 10:54:46.126+00
2684	47	2432	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/svg/mqc_fastqc_sequence_counts_plot-2_1_pc.svg	mqc_fastqc_sequence_counts_plot-2_1_pc.svg	30991	-284331453	\N	f	2022-09-29 10:54:46.122+00
2685	47	2432	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/svg/mqc_fastqc_sequence_counts_plot_1.svg	mqc_fastqc_sequence_counts_plot_1.svg	30046	1841610538	\N	f	2022-09-29 10:54:46.126+00
2686	47	2432	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/svg/mqc_fastqc_sequence_counts_plot_1_pc.svg	mqc_fastqc_sequence_counts_plot_1_pc.svg	30995	2090566055	\N	f	2022-09-29 10:54:46.126+00
2687	47	2432	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/svg/mqc_fastqc_sequence_duplication_levels_plot-2_1.svg	mqc_fastqc_sequence_duplication_levels_plot-2_1.svg	39368	-1094145887	\N	f	2022-09-29 10:54:46.122+00
2688	47	2432	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/svg/mqc_fastqc_sequence_duplication_levels_plot_1.svg	mqc_fastqc_sequence_duplication_levels_plot_1.svg	39376	956966987	\N	f	2022-09-29 10:54:46.122+00
2689	47	2432	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/svg/mqc_fastqc_sequence_length_distribution_plot-2_1.svg	mqc_fastqc_sequence_length_distribution_plot-2_1.svg	39630	-892112584	\N	f	2022-09-29 10:54:46.126+00
2690	47	2432	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/svg/mqc_fastqc_sequence_length_distribution_plot_1.svg	mqc_fastqc_sequence_length_distribution_plot_1.svg	34961	1358621945	\N	f	2022-09-29 10:54:46.126+00
2691	47	2432	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/svg/mqc_mqc_mplplot_zxqfwhjbcr_1.svg	mqc_mqc_mplplot_zxqfwhjbcr_1.svg	31355	-1764106454	\N	f	2022-09-29 10:54:46.126+00
2692	47	2432	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/svg/mqc_picard_deduplication_1.svg	mqc_picard_deduplication_1.svg	31379	2105491319	\N	f	2022-09-29 10:54:46.122+00
2693	47	2432	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/svg/mqc_picard_deduplication_1_pc.svg	mqc_picard_deduplication_1_pc.svg	32813	1889411007	\N	f	2022-09-29 10:54:46.122+00
2694	47	2432	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/svg/mqc_preseq_plot_1.svg	mqc_preseq_plot_1.svg	39037	1117800290	\N	f	2022-09-29 10:54:46.126+00
2695	47	2432	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/svg/mqc_qualimap_gene_coverage_profile_Counts.svg	mqc_qualimap_gene_coverage_profile_Counts.svg	41789	-235013167	\N	f	2022-09-29 10:54:46.126+00
2696	47	2432	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/svg/mqc_qualimap_gene_coverage_profile_Normalised.svg	mqc_qualimap_gene_coverage_profile_Normalised.svg	40792	-1233010438	\N	f	2022-09-29 10:54:46.122+00
2697	47	2432	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/svg/mqc_qualimap_genomic_origin_1.svg	mqc_qualimap_genomic_origin_1.svg	30190	334553490	\N	f	2022-09-29 10:54:46.126+00
2698	47	2432	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/svg/mqc_qualimap_genomic_origin_1_pc.svg	mqc_qualimap_genomic_origin_1_pc.svg	28973	1802573529	\N	f	2022-09-29 10:54:46.126+00
2699	47	2432	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/svg/mqc_rseqc_infer_experiment_plot_1.svg	mqc_rseqc_infer_experiment_plot_1.svg	25685	225511544	\N	f	2022-09-29 10:54:46.126+00
2700	47	2432	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/svg/mqc_rseqc_inner_distance_plot_Counts.svg	mqc_rseqc_inner_distance_plot_Counts.svg	31044	1813309939	\N	f	2022-09-29 10:54:46.126+00
2701	47	2432	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/svg/mqc_rseqc_inner_distance_plot_Percentages.svg	mqc_rseqc_inner_distance_plot_Percentages.svg	31521	2061519477	\N	f	2022-09-29 10:54:46.122+00
2702	47	2432	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/svg/mqc_rseqc_junction_annotation_junctions_plot_Events.svg	mqc_rseqc_junction_annotation_junctions_plot_Events.svg	28846	1768314914	\N	f	2022-09-29 10:54:46.122+00
2703	47	2432	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/svg/mqc_rseqc_junction_annotation_junctions_plot_Events_pc.svg	mqc_rseqc_junction_annotation_junctions_plot_Events_pc.svg	30050	-1811591889	\N	f	2022-09-29 10:54:46.122+00
2704	47	2432	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/svg/mqc_rseqc_junction_annotation_junctions_plot_Junctions.svg	mqc_rseqc_junction_annotation_junctions_plot_Junctions.svg	29755	-1876470634	\N	f	2022-09-29 10:54:46.126+00
2705	47	2432	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/svg/mqc_rseqc_junction_annotation_junctions_plot_Junctions_pc.svg	mqc_rseqc_junction_annotation_junctions_plot_Junctions_pc.svg	30341	-276167835	\N	f	2022-09-29 10:54:46.126+00
2706	47	2432	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/svg/mqc_rseqc_junction_saturation_plot_All_Junctions.svg	mqc_rseqc_junction_saturation_plot_All_Junctions.svg	29330	1719138789	\N	f	2022-09-29 10:54:46.122+00
2707	47	2432	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/svg/mqc_rseqc_junction_saturation_plot_Known_Junctions.svg	mqc_rseqc_junction_saturation_plot_Known_Junctions.svg	29280	-1155077813	\N	f	2022-09-29 10:54:46.126+00
2708	47	2432	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/svg/mqc_rseqc_junction_saturation_plot_Novel_Junctions.svg	mqc_rseqc_junction_saturation_plot_Novel_Junctions.svg	30675	1384229295	\N	f	2022-09-29 10:54:46.122+00
2709	47	2432	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/svg/mqc_rseqc_read_distribution_plot_1.svg	mqc_rseqc_read_distribution_plot_1.svg	40933	1714404812	\N	f	2022-09-29 10:54:46.126+00
2710	47	2432	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/svg/mqc_rseqc_read_distribution_plot_1_pc.svg	mqc_rseqc_read_distribution_plot_1_pc.svg	40215	1992134764	\N	f	2022-09-29 10:54:46.126+00
2711	47	2432	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/svg/mqc_rseqc_read_dups_plot_1.svg	mqc_rseqc_read_dups_plot_1.svg	29023	-1650900308	\N	f	2022-09-29 10:54:46.126+00
2712	47	2432	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/svg/mqc_samtools-idxstats-mapped-reads-plot_Normalised_Counts.svg	mqc_samtools-idxstats-mapped-reads-plot_Normalised_Counts.svg	30896	-594964483	\N	f	2022-09-29 10:54:46.122+00
2713	47	2432	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/svg/mqc_samtools-idxstats-mapped-reads-plot_Observed_over_Expected_Counts.svg	mqc_samtools-idxstats-mapped-reads-plot_Observed_over_Expected_Counts.svg	32086	-100911033	\N	f	2022-09-29 10:54:46.126+00
2714	47	2432	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/svg/mqc_samtools-idxstats-mapped-reads-plot_Raw_Counts.svg	mqc_samtools-idxstats-mapped-reads-plot_Raw_Counts.svg	31085	-1254310554	\N	f	2022-09-29 10:54:46.126+00
2715	47	2432	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/svg/mqc_samtools_alignment_plot_1.svg	mqc_samtools_alignment_plot_1.svg	21831	-1159709866	\N	f	2022-09-29 10:54:46.126+00
2716	47	2432	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/svg/mqc_samtools_alignment_plot_1_pc.svg	mqc_samtools_alignment_plot_1_pc.svg	23269	-1827874553	\N	f	2022-09-29 10:54:46.126+00
2717	47	2432	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/svg/mqc_star_alignment_plot_1.svg	mqc_star_alignment_plot_1.svg	32270	969593853	\N	f	2022-09-29 10:54:46.122+00
2718	47	2432	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_plots/svg/mqc_star_alignment_plot_1_pc.svg	mqc_star_alignment_plot_1_pc.svg	33218	-586635519	\N	f	2022-09-29 10:54:46.122+00
2719	47	2427	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/multiqc/star_salmon/multiqc_report.html	multiqc_report.html	1754772	1520943930	\N	f	2022-09-29 10:54:46.122+00
2720	47	2433	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/pipeline_info/execution_report_2022-09-26_12-18-55.html	execution_report_2022-09-26_12-18-55.html	3165239	818461226	\N	f	2022-09-29 10:54:44.33+00
2721	47	2433	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/pipeline_info/execution_report_2022-09-26_19-28-20.html	execution_report_2022-09-26_19-28-20.html	3248896	-545696456	\N	f	2022-09-29 10:54:44.334+00
2722	47	2433	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/pipeline_info/execution_report_2022-09-27_09-37-47.html	execution_report_2022-09-27_09-37-47.html	3249050	733307381	\N	f	2022-09-29 10:54:44.338+00
2723	47	2433	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/pipeline_info/execution_report_2022-09-27_10-55-33.html	execution_report_2022-09-27_10-55-33.html	2996632	-943321792	\N	f	2022-09-29 10:54:44.326+00
2724	47	2433	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/pipeline_info/execution_report_2022-09-27_12-15-28.html	execution_report_2022-09-27_12-15-28.html	3305705	-10297877	\N	f	2022-09-29 10:54:44.346+00
2725	47	2433	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/pipeline_info/execution_timeline_2022-09-26_12-18-55.html	execution_timeline_2022-09-26_12-18-55.html	272666	-1390123333	\N	f	2022-09-29 10:54:44.342+00
2726	47	2433	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/pipeline_info/execution_timeline_2022-09-26_19-28-20.html	execution_timeline_2022-09-26_19-28-20.html	278979	-850326156	\N	f	2022-09-29 10:54:44.338+00
2727	47	2433	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/pipeline_info/execution_timeline_2022-09-27_09-37-47.html	execution_timeline_2022-09-27_09-37-47.html	279252	-137117219	\N	f	2022-09-29 10:54:44.334+00
2728	47	2433	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/pipeline_info/execution_timeline_2022-09-27_10-55-33.html	execution_timeline_2022-09-27_10-55-33.html	256808	1959820396	\N	f	2022-09-29 10:54:44.338+00
2805	47	2450	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_1/css/jquery.js	jquery.js	72230	1815961016	\N	f	2022-09-29 10:54:46.11+00
2729	47	2433	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/pipeline_info/execution_timeline_2022-09-27_12-15-28.html	execution_timeline_2022-09-27_12-15-28.html	287572	-246202986	\N	f	2022-09-29 10:54:44.334+00
2730	47	2433	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/pipeline_info/execution_trace_2022-09-26_12-18-55.txt	execution_trace_2022-09-26_12-18-55.txt	11074	-149135790	\N	f	2022-09-29 10:54:44.334+00
2731	47	2433	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/pipeline_info/execution_trace_2022-09-26_19-28-20.txt	execution_trace_2022-09-26_19-28-20.txt	14376	-1623327859	\N	f	2022-09-29 10:54:44.334+00
2732	47	2433	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/pipeline_info/execution_trace_2022-09-27_09-37-47.txt	execution_trace_2022-09-27_09-37-47.txt	14436	708886058	\N	f	2022-09-29 10:54:44.33+00
2733	47	2433	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/pipeline_info/execution_trace_2022-09-27_10-55-33.txt	execution_trace_2022-09-27_10-55-33.txt	2767	1367921282	\N	f	2022-09-29 10:54:44.326+00
2734	47	2433	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/pipeline_info/execution_trace_2022-09-27_12-15-28.txt	execution_trace_2022-09-27_12-15-28.txt	19454	932358450	\N	f	2022-09-29 10:54:44.334+00
2735	47	2433	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/pipeline_info/pipeline_dag_2022-09-26_12-18-55.html	pipeline_dag_2022-09-26_12-18-55.html	66090	-1443047581	\N	f	2022-09-29 10:54:44.338+00
2736	47	2433	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/pipeline_info/pipeline_dag_2022-09-26_19-28-20.html	pipeline_dag_2022-09-26_19-28-20.html	66090	1658430878	\N	f	2022-09-29 10:54:44.334+00
2737	47	2433	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/pipeline_info/pipeline_dag_2022-09-27_09-37-47.html	pipeline_dag_2022-09-27_09-37-47.html	66090	-1568873982	\N	f	2022-09-29 10:54:44.342+00
2738	47	2433	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/pipeline_info/pipeline_dag_2022-09-27_10-55-33.html	pipeline_dag_2022-09-27_10-55-33.html	66090	1389337262	\N	f	2022-09-29 10:54:44.342+00
2739	47	2433	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/pipeline_info/pipeline_dag_2022-09-27_12-15-28.html	pipeline_dag_2022-09-27_12-15-28.html	66090	498269769	\N	f	2022-09-29 10:54:44.33+00
2740	47	2433	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/pipeline_info/samplesheet.valid.csv	samplesheet.valid.csv	624	-1000397310	\N	f	2022-09-29 10:54:44.322+00
2741	47	2433	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/pipeline_info/software_versions.yml	software_versions.yml	1612	-1441829069	\N	f	2022-09-29 10:54:44.326+00
2742	47	2435	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/bigwig/sample_1.forward.bigWig	sample_1.forward.bigWig	116083857	407868832	\N	f	2022-09-29 10:54:46.014+00
2743	47	2435	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/bigwig/sample_1.reverse.bigWig	sample_1.reverse.bigWig	114647598	945774382	\N	f	2022-09-29 10:54:45.302+00
2744	47	2435	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/bigwig/sample_2.forward.bigWig	sample_2.forward.bigWig	146427090	741235951	\N	f	2022-09-29 10:54:45.634+00
2745	47	2435	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/bigwig/sample_2.reverse.bigWig	sample_2.reverse.bigWig	146289618	1088782413	\N	f	2022-09-29 10:54:45.466+00
2746	47	2435	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/bigwig/sample_3.forward.bigWig	sample_3.forward.bigWig	111391440	-169788233	\N	f	2022-09-29 10:54:45.77+00
2747	47	2435	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/bigwig/sample_3.reverse.bigWig	sample_3.reverse.bigWig	109808168	11383816	\N	f	2022-09-29 10:54:45.89+00
2748	47	2436	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/deseq2_qc/R_sessionInfo.log	R_sessionInfo.log	2006	783327114	\N	f	2022-09-29 10:54:46.118+00
2749	47	2436	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/deseq2_qc/deseq2.dds.RData	deseq2.dds.RData	1908184	229469158	\N	f	2022-09-29 10:54:46.118+00
2750	47	2436	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/deseq2_qc/deseq2.pca.vals.txt	deseq2.pca.vals.txt	216	-424428708	\N	f	2022-09-29 10:54:46.118+00
2751	47	2436	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/deseq2_qc/deseq2.plots.pdf	deseq2.plots.pdf	8883	-1258763486	\N	f	2022-09-29 10:54:46.118+00
2752	47	2436	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/deseq2_qc/deseq2.sample.dists.txt	deseq2.sample.dists.txt	197	1733931085	\N	f	2022-09-29 10:54:46.118+00
2753	47	2437	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/deseq2_qc/size_factors/deseq2.size_factors.RData	deseq2.size_factors.RData	171	-421509831	\N	f	2022-09-29 10:54:46.118+00
2754	47	2437	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/deseq2_qc/size_factors/sample_1.txt	sample_1.txt	37	-1417693185	\N	f	2022-09-29 10:54:46.118+00
2755	47	2437	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/deseq2_qc/size_factors/sample_2.txt	sample_2.txt	38	-1967701526	\N	f	2022-09-29 10:54:46.118+00
2756	47	2437	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/deseq2_qc/size_factors/sample_3.txt	sample_3.txt	37	-1908474572	\N	f	2022-09-29 10:54:46.118+00
2757	47	2439	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/dupradar/box_plot/sample_1_duprateExpBoxplot.pdf	sample_1_duprateExpBoxplot.pdf	57724	-1742710434	\N	f	2022-09-29 10:54:46.094+00
2758	47	2439	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/dupradar/box_plot/sample_2_duprateExpBoxplot.pdf	sample_2_duprateExpBoxplot.pdf	50735	-1180608456	\N	f	2022-09-29 10:54:46.094+00
2759	47	2439	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/dupradar/box_plot/sample_3_duprateExpBoxplot.pdf	sample_3_duprateExpBoxplot.pdf	59377	-501384651	\N	f	2022-09-29 10:54:46.094+00
2760	47	2440	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/dupradar/gene_data/sample_1_dupMatrix.txt	sample_1_dupMatrix.txt	6406831	-1400087058	\N	f	2022-09-29 10:54:46.078+00
2761	47	2440	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/dupradar/gene_data/sample_2_dupMatrix.txt	sample_2_dupMatrix.txt	6489626	-289322675	\N	f	2022-09-29 10:54:46.086+00
2762	47	2440	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/dupradar/gene_data/sample_3_dupMatrix.txt	sample_3_dupMatrix.txt	6415641	-1472281662	\N	f	2022-09-29 10:54:46.074+00
2763	47	2441	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/dupradar/histogram/sample_1_expressionHist.pdf	sample_1_expressionHist.pdf	5161	-1516489735	\N	f	2022-09-29 10:54:46.086+00
2764	47	2441	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/dupradar/histogram/sample_2_expressionHist.pdf	sample_2_expressionHist.pdf	5214	-1918490384	\N	f	2022-09-29 10:54:46.086+00
2765	47	2441	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/dupradar/histogram/sample_3_expressionHist.pdf	sample_3_expressionHist.pdf	5266	1482483697	\N	f	2022-09-29 10:54:46.086+00
2766	47	2442	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/dupradar/intercepts_slope/sample_1_intercept_slope.txt	sample_1_intercept_slope.txt	181	-2125084411	\N	f	2022-09-29 10:54:46.094+00
2767	47	2442	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/dupradar/intercepts_slope/sample_2_intercept_slope.txt	sample_2_intercept_slope.txt	179	1030465272	\N	f	2022-09-29 10:54:46.094+00
2768	47	2442	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/dupradar/intercepts_slope/sample_3_intercept_slope.txt	sample_3_intercept_slope.txt	181	1348668048	\N	f	2022-09-29 10:54:46.094+00
2769	47	2443	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/dupradar/scatter_plot/sample_1_duprateExpDens.pdf	sample_1_duprateExpDens.pdf	2315024	-2344077	\N	f	2022-09-29 10:54:46.09+00
2770	47	2443	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/dupradar/scatter_plot/sample_2_duprateExpDens.pdf	sample_2_duprateExpDens.pdf	2272021	-1583787446	\N	f	2022-09-29 10:54:46.094+00
2771	47	2443	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/dupradar/scatter_plot/sample_3_duprateExpDens.pdf	sample_3_duprateExpDens.pdf	2332902	1782451747	\N	f	2022-09-29 10:54:46.09+00
2772	47	2444	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/log/sample_1.Log.final.out	sample_1.Log.final.out	2066	1160124707	\N	f	2022-09-29 10:54:46.046+00
2773	47	2444	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/log/sample_1.Log.out	sample_1.Log.out	10252	-1172334429	\N	f	2022-09-29 10:54:46.046+00
2774	47	2444	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/log/sample_1.Log.progress.out	sample_1.Log.progress.out	10741	1298993321	\N	f	2022-09-29 10:54:46.046+00
2775	47	2444	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/log/sample_1.SJ.out.tab	sample_1.SJ.out.tab	9778101	-156455608	\N	f	2022-09-29 10:54:46.066+00
2776	47	2444	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/log/sample_2.Log.final.out	sample_2.Log.final.out	2074	832236836	\N	f	2022-09-29 10:54:46.046+00
2777	47	2444	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/log/sample_2.Log.out	sample_2.Log.out	10256	1493992196	\N	f	2022-09-29 10:54:46.05+00
2778	47	2444	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/log/sample_2.Log.progress.out	sample_2.Log.progress.out	24429	1211592889	\N	f	2022-09-29 10:54:46.05+00
2779	47	2444	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/log/sample_2.SJ.out.tab	sample_2.SJ.out.tab	6957343	-1552703468	\N	f	2022-09-29 10:54:46.054+00
2780	47	2444	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/log/sample_3.Log.final.out	sample_3.Log.final.out	2063	1510997728	\N	f	2022-09-29 10:54:46.05+00
2781	47	2444	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/log/sample_3.Log.out	sample_3.Log.out	10253	-1947671441	\N	f	2022-09-29 10:54:46.046+00
2782	47	2444	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/log/sample_3.Log.progress.out	sample_3.Log.progress.out	10859	-1404756574	\N	f	2022-09-29 10:54:46.066+00
2783	47	2444	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/log/sample_3.SJ.out.tab	sample_3.SJ.out.tab	9628060	1111953148	\N	f	2022-09-29 10:54:46.046+00
2784	47	2445	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/picard_metrics/sample_1.markdup.sorted.MarkDuplicates.metrics.txt	sample_1.markdup.sorted.MarkDuplicates.metrics.txt	9714	1593106529	\N	f	2022-09-29 10:54:44.358+00
2785	47	2445	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/picard_metrics/sample_2.markdup.sorted.MarkDuplicates.metrics.txt	sample_2.markdup.sorted.MarkDuplicates.metrics.txt	45906	-1004974030	\N	f	2022-09-29 10:54:44.358+00
2786	47	2445	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/picard_metrics/sample_3.markdup.sorted.MarkDuplicates.metrics.txt	sample_3.markdup.sorted.MarkDuplicates.metrics.txt	9426	-164247481	\N	f	2022-09-29 10:54:44.358+00
2787	47	2447	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/preseq/log/sample_1.command.log	sample_1.command.log	9969	-1757704786	\N	f	2022-09-29 10:54:44.362+00
2788	47	2447	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/preseq/log/sample_2.command.log	sample_2.command.log	24119	349746264	\N	f	2022-09-29 10:54:44.362+00
2789	47	2447	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/preseq/log/sample_3.command.log	sample_3.command.log	8498	-1872106899	\N	f	2022-09-29 10:54:44.362+00
2790	47	2446	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/preseq/sample_1.lc_extrap.txt	sample_1.lc_extrap.txt	488559	-95566019	\N	f	2022-09-29 10:54:44.362+00
2791	47	2446	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/preseq/sample_2.lc_extrap.txt	sample_2.lc_extrap.txt	480797	571268265	\N	f	2022-09-29 10:54:44.362+00
2792	47	2446	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/preseq/sample_3.lc_extrap.txt	sample_3.lc_extrap.txt	488535	-65435737	\N	f	2022-09-29 10:54:44.362+00
2793	47	2450	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_1/css/agogo.css	agogo.css	7158	-65698801	\N	f	2022-09-29 10:54:46.11+00
2794	47	2450	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_1/css/ajax-loader.gif	ajax-loader.gif	701	740165080	\N	f	2022-09-29 10:54:46.11+00
2795	47	2450	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_1/css/basic.css	basic.css	8489	-1555226095	\N	f	2022-09-29 10:54:46.11+00
2796	47	2450	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_1/css/bgfooter.png	bgfooter.png	462	-1213159984	\N	f	2022-09-29 10:54:46.11+00
2797	47	2450	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_1/css/bgtop.png	bgtop.png	458	-535157031	\N	f	2022-09-29 10:54:46.11+00
2798	47	2450	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_1/css/comment-bright.png	comment-bright.png	3528	163848074	\N	f	2022-09-29 10:54:46.11+00
2799	47	2450	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_1/css/comment-close.png	comment-close.png	3606	-1973571828	\N	f	2022-09-29 10:54:46.11+00
2800	47	2450	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_1/css/comment.png	comment.png	3473	1900413768	\N	f	2022-09-29 10:54:46.11+00
2801	47	2450	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_1/css/doctools.js	doctools.js	6868	671391281	\N	f	2022-09-29 10:54:46.11+00
2802	47	2450	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_1/css/down-pressed.png	down-pressed.png	396	-655488723	\N	f	2022-09-29 10:54:46.11+00
2803	47	2450	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_1/css/down.png	down.png	391	-1851171846	\N	f	2022-09-29 10:54:46.11+00
2806	47	2450	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_1/css/minus.png	minus.png	227	982857934	\N	f	2022-09-29 10:54:46.11+00
2807	47	2450	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_1/css/plus.png	plus.png	227	157643550	\N	f	2022-09-29 10:54:46.11+00
2808	47	2450	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_1/css/pygments.css	pygments.css	3960	-137545881	\N	f	2022-09-29 10:54:46.11+00
2809	47	2450	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_1/css/qualimap_logo_small.png	qualimap_logo_small.png	2950	-1674717839	\N	f	2022-09-29 10:54:46.11+00
2810	47	2450	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_1/css/report.css	report.css	636	-1015692235	\N	f	2022-09-29 10:54:46.11+00
2811	47	2450	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_1/css/searchtools.js	searchtools.js	16071	230629843	\N	f	2022-09-29 10:54:46.11+00
2812	47	2450	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_1/css/underscore.js	underscore.js	8602	44866523	\N	f	2022-09-29 10:54:46.11+00
2813	47	2450	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_1/css/up-pressed.png	up-pressed.png	400	-1977165975	\N	f	2022-09-29 10:54:46.11+00
2814	47	2450	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_1/css/up.png	up.png	391	-245820877	\N	f	2022-09-29 10:54:46.11+00
2815	47	2450	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_1/css/websupport.js	websupport.js	25274	-253393510	\N	f	2022-09-29 10:54:46.11+00
2816	47	2451	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_1/images_qualimapReport/Coverage Profile Along Genes (High).png	Coverage Profile Along Genes (High).png	54144	-1272641384	\N	f	2022-09-29 10:54:46.11+00
2817	47	2451	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_1/images_qualimapReport/Coverage Profile Along Genes (Low).png	Coverage Profile Along Genes (Low).png	106968	465282249	\N	f	2022-09-29 10:54:46.11+00
2818	47	2451	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_1/images_qualimapReport/Coverage Profile Along Genes (Total).png	Coverage Profile Along Genes (Total).png	53156	-1485368641	\N	f	2022-09-29 10:54:46.11+00
2819	47	2451	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_1/images_qualimapReport/Junction Analysis.png	Junction Analysis.png	36456	293931774	\N	f	2022-09-29 10:54:46.11+00
2820	47	2451	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_1/images_qualimapReport/Reads Genomic Origin.png	Reads Genomic Origin.png	36869	-64649317	\N	f	2022-09-29 10:54:46.11+00
2821	47	2451	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_1/images_qualimapReport/Transcript coverage histogram.png	Transcript coverage histogram.png	60105	580509127	\N	f	2022-09-29 10:54:46.11+00
2822	47	2449	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_1/qualimapReport.html	qualimapReport.html	11637	-353750491	\N	f	2022-09-29 10:54:46.11+00
2823	47	2452	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_1/raw_data_qualimapReport/coverage_profile_along_genes_(high).txt	coverage_profile_along_genes_(high).txt	2395	1964336251	\N	f	2022-09-29 10:54:46.11+00
2824	47	2452	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_1/raw_data_qualimapReport/coverage_profile_along_genes_(low).txt	coverage_profile_along_genes_(low).txt	2629	1528069843	\N	f	2022-09-29 10:54:46.11+00
2825	47	2452	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_1/raw_data_qualimapReport/coverage_profile_along_genes_(total).txt	coverage_profile_along_genes_(total).txt	2428	-1116156525	\N	f	2022-09-29 10:54:46.11+00
2826	47	2449	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_1/rnaseq_qc_results.txt	rnaseq_qc_results.txt	1228	1783764778	\N	f	2022-09-29 10:54:46.11+00
2827	47	2454	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_2/css/agogo.css	agogo.css	7158	1036401471	\N	f	2022-09-29 10:54:46.106+00
2828	47	2454	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_2/css/ajax-loader.gif	ajax-loader.gif	701	872192893	\N	f	2022-09-29 10:54:46.106+00
2829	47	2454	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_2/css/basic.css	basic.css	8489	-969931020	\N	f	2022-09-29 10:54:46.106+00
2830	47	2454	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_2/css/bgfooter.png	bgfooter.png	462	877252076	\N	f	2022-09-29 10:54:46.106+00
2831	47	2454	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_2/css/bgtop.png	bgtop.png	458	1676492640	\N	f	2022-09-29 10:54:46.106+00
2832	47	2454	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_2/css/comment-bright.png	comment-bright.png	3528	-917853647	\N	f	2022-09-29 10:54:46.106+00
2833	47	2454	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_2/css/comment-close.png	comment-close.png	3606	-295620283	\N	f	2022-09-29 10:54:46.106+00
2834	47	2454	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_2/css/comment.png	comment.png	3473	63108046	\N	f	2022-09-29 10:54:46.106+00
2835	47	2454	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_2/css/doctools.js	doctools.js	6868	1191471231	\N	f	2022-09-29 10:54:46.106+00
2836	47	2454	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_2/css/down-pressed.png	down-pressed.png	396	-1384134921	\N	f	2022-09-29 10:54:46.106+00
2837	47	2454	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_2/css/down.png	down.png	391	-1182349948	\N	f	2022-09-29 10:54:46.106+00
2838	47	2454	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_2/css/file.png	file.png	420	-17216182	\N	f	2022-09-29 10:54:46.106+00
2839	47	2454	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_2/css/jquery.js	jquery.js	72230	-1459890655	\N	f	2022-09-29 10:54:46.106+00
2840	47	2454	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_2/css/minus.png	minus.png	227	-555797118	\N	f	2022-09-29 10:54:46.106+00
2841	47	2454	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_2/css/plus.png	plus.png	227	1612941176	\N	f	2022-09-29 10:54:46.106+00
2842	47	2454	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_2/css/pygments.css	pygments.css	3960	1560543567	\N	f	2022-09-29 10:54:46.106+00
2843	47	2454	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_2/css/qualimap_logo_small.png	qualimap_logo_small.png	2950	-1724201523	\N	f	2022-09-29 10:54:46.106+00
2844	47	2454	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_2/css/report.css	report.css	636	932179332	\N	f	2022-09-29 10:54:46.106+00
2845	47	2454	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_2/css/searchtools.js	searchtools.js	16071	67844936	\N	f	2022-09-29 10:54:46.106+00
2846	47	2454	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_2/css/underscore.js	underscore.js	8602	-1027348641	\N	f	2022-09-29 10:54:46.106+00
2847	47	2454	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_2/css/up-pressed.png	up-pressed.png	400	-930118673	\N	f	2022-09-29 10:54:46.106+00
2848	47	2454	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_2/css/up.png	up.png	391	561903021	\N	f	2022-09-29 10:54:46.106+00
2849	47	2454	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_2/css/websupport.js	websupport.js	25274	-937253365	\N	f	2022-09-29 10:54:46.106+00
2850	47	2455	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_2/images_qualimapReport/Coverage Profile Along Genes (High).png	Coverage Profile Along Genes (High).png	51478	2087149520	\N	f	2022-09-29 10:54:46.102+00
2851	47	2455	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_2/images_qualimapReport/Coverage Profile Along Genes (Low).png	Coverage Profile Along Genes (Low).png	111449	-1074021110	\N	f	2022-09-29 10:54:46.102+00
2852	47	2455	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_2/images_qualimapReport/Coverage Profile Along Genes (Total).png	Coverage Profile Along Genes (Total).png	52397	521693482	\N	f	2022-09-29 10:54:46.102+00
2853	47	2455	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_2/images_qualimapReport/Junction Analysis.png	Junction Analysis.png	35475	-1421474105	\N	f	2022-09-29 10:54:46.102+00
2854	47	2455	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_2/images_qualimapReport/Reads Genomic Origin.png	Reads Genomic Origin.png	36521	-222952599	\N	f	2022-09-29 10:54:46.102+00
2855	47	2455	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_2/images_qualimapReport/Transcript coverage histogram.png	Transcript coverage histogram.png	59853	690907938	\N	f	2022-09-29 10:54:46.102+00
2856	47	2453	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_2/qualimapReport.html	qualimapReport.html	11844	-1302916491	\N	f	2022-09-29 10:54:46.102+00
2857	47	2456	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_2/raw_data_qualimapReport/coverage_profile_along_genes_(high).txt	coverage_profile_along_genes_(high).txt	2428	1756605493	\N	f	2022-09-29 10:54:46.106+00
2858	47	2456	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_2/raw_data_qualimapReport/coverage_profile_along_genes_(low).txt	coverage_profile_along_genes_(low).txt	2637	406435506	\N	f	2022-09-29 10:54:46.106+00
2859	47	2456	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_2/raw_data_qualimapReport/coverage_profile_along_genes_(total).txt	coverage_profile_along_genes_(total).txt	2400	-713048096	\N	f	2022-09-29 10:54:46.106+00
2860	47	2453	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_2/rnaseq_qc_results.txt	rnaseq_qc_results.txt	1265	-1404240692	\N	f	2022-09-29 10:54:46.102+00
2861	47	2458	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_3/css/agogo.css	agogo.css	7158	1917189192	\N	f	2022-09-29 10:54:46.11+00
2862	47	2458	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_3/css/ajax-loader.gif	ajax-loader.gif	701	-262694860	\N	f	2022-09-29 10:54:46.106+00
2863	47	2458	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_3/css/basic.css	basic.css	8489	-1096943705	\N	f	2022-09-29 10:54:46.106+00
2864	47	2458	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_3/css/bgfooter.png	bgfooter.png	462	-750563975	\N	f	2022-09-29 10:54:46.106+00
2865	47	2458	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_3/css/bgtop.png	bgtop.png	458	1605120655	\N	f	2022-09-29 10:54:46.11+00
2866	47	2458	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_3/css/comment-bright.png	comment-bright.png	3528	-1210661570	\N	f	2022-09-29 10:54:46.106+00
2867	47	2458	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_3/css/comment-close.png	comment-close.png	3606	-993958404	\N	f	2022-09-29 10:54:46.11+00
2868	47	2458	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_3/css/comment.png	comment.png	3473	882988325	\N	f	2022-09-29 10:54:46.106+00
2869	47	2458	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_3/css/doctools.js	doctools.js	6868	857413940	\N	f	2022-09-29 10:54:46.11+00
2870	47	2458	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_3/css/down-pressed.png	down-pressed.png	396	1098420005	\N	f	2022-09-29 10:54:46.106+00
2871	47	2458	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_3/css/down.png	down.png	391	-448215338	\N	f	2022-09-29 10:54:46.106+00
2872	47	2458	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_3/css/file.png	file.png	420	1317549924	\N	f	2022-09-29 10:54:46.106+00
2873	47	2458	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_3/css/jquery.js	jquery.js	72230	277772241	\N	f	2022-09-29 10:54:46.11+00
2874	47	2458	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_3/css/minus.png	minus.png	227	-2012112720	\N	f	2022-09-29 10:54:46.106+00
2875	47	2458	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_3/css/plus.png	plus.png	227	-2036699017	\N	f	2022-09-29 10:54:46.106+00
2876	47	2458	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_3/css/pygments.css	pygments.css	3960	-439944510	\N	f	2022-09-29 10:54:46.106+00
2877	47	2458	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_3/css/qualimap_logo_small.png	qualimap_logo_small.png	2950	1846525448	\N	f	2022-09-29 10:54:46.106+00
2878	47	2458	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_3/css/report.css	report.css	636	1055129191	\N	f	2022-09-29 10:54:46.106+00
2879	47	2458	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_3/css/searchtools.js	searchtools.js	16071	1535692138	\N	f	2022-09-29 10:54:46.106+00
2880	47	2458	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_3/css/underscore.js	underscore.js	8602	-1533576359	\N	f	2022-09-29 10:54:46.106+00
2881	47	2458	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_3/css/up-pressed.png	up-pressed.png	400	-277568864	\N	f	2022-09-29 10:54:46.11+00
2882	47	2458	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_3/css/up.png	up.png	391	-1454765905	\N	f	2022-09-29 10:54:46.106+00
2883	47	2458	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_3/css/websupport.js	websupport.js	25274	809219324	\N	f	2022-09-29 10:54:46.106+00
2884	47	2459	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_3/images_qualimapReport/Coverage Profile Along Genes (High).png	Coverage Profile Along Genes (High).png	53157	-1263478768	\N	f	2022-09-29 10:54:46.106+00
2885	47	2459	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_3/images_qualimapReport/Coverage Profile Along Genes (Low).png	Coverage Profile Along Genes (Low).png	113430	1650171852	\N	f	2022-09-29 10:54:46.106+00
2886	47	2459	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_3/images_qualimapReport/Coverage Profile Along Genes (Total).png	Coverage Profile Along Genes (Total).png	50965	947681832	\N	f	2022-09-29 10:54:46.106+00
2887	47	2459	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_3/images_qualimapReport/Junction Analysis.png	Junction Analysis.png	35285	436736178	\N	f	2022-09-29 10:54:46.106+00
2888	47	2459	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_3/images_qualimapReport/Reads Genomic Origin.png	Reads Genomic Origin.png	37476	-606404054	\N	f	2022-09-29 10:54:46.106+00
2889	47	2459	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_3/images_qualimapReport/Transcript coverage histogram.png	Transcript coverage histogram.png	60089	-1486170596	\N	f	2022-09-29 10:54:46.106+00
2890	47	2457	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_3/qualimapReport.html	qualimapReport.html	11638	-1775335303	\N	f	2022-09-29 10:54:46.106+00
2891	47	2460	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_3/raw_data_qualimapReport/coverage_profile_along_genes_(high).txt	coverage_profile_along_genes_(high).txt	2391	-1794378277	\N	f	2022-09-29 10:54:46.11+00
2892	47	2460	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_3/raw_data_qualimapReport/coverage_profile_along_genes_(low).txt	coverage_profile_along_genes_(low).txt	2615	1537288890	\N	f	2022-09-29 10:54:46.11+00
2893	47	2460	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_3/raw_data_qualimapReport/coverage_profile_along_genes_(total).txt	coverage_profile_along_genes_(total).txt	2428	1465842020	\N	f	2022-09-29 10:54:46.11+00
2894	47	2457	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/qualimap/sample_3/rnaseq_qc_results.txt	rnaseq_qc_results.txt	1229	1554887551	\N	f	2022-09-29 10:54:46.106+00
2895	47	2462	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/rseqc/bam_stat/sample_1.bam_stat.txt	sample_1.bam_stat.txt	883	1000864014	\N	f	2022-09-29 10:54:44.602+00
2896	47	2462	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/rseqc/bam_stat/sample_2.bam_stat.txt	sample_2.bam_stat.txt	882	-1638629291	\N	f	2022-09-29 10:54:44.602+00
2897	47	2462	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/rseqc/bam_stat/sample_3.bam_stat.txt	sample_3.bam_stat.txt	883	1413931555	\N	f	2022-09-29 10:54:44.602+00
2898	47	2463	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/rseqc/infer_experiment/sample_1.infer_experiment.txt	sample_1.infer_experiment.txt	211	-491732859	\N	f	2022-09-29 10:54:44.862+00
2899	47	2463	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/rseqc/infer_experiment/sample_2.infer_experiment.txt	sample_2.infer_experiment.txt	211	-140771279	\N	f	2022-09-29 10:54:44.862+00
2900	47	2463	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/rseqc/infer_experiment/sample_3.infer_experiment.txt	sample_3.infer_experiment.txt	211	1797212426	\N	f	2022-09-29 10:54:44.862+00
2901	47	2465	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/rseqc/inner_distance/pdf/sample_1.inner_distance_plot.pdf	sample_1.inner_distance_plot.pdf	8625	1675095893	\N	f	2022-09-29 10:54:44.602+00
2902	47	2465	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/rseqc/inner_distance/pdf/sample_2.inner_distance_plot.pdf	sample_2.inner_distance_plot.pdf	8605	1889596450	\N	f	2022-09-29 10:54:44.602+00
2903	47	2465	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/rseqc/inner_distance/pdf/sample_3.inner_distance_plot.pdf	sample_3.inner_distance_plot.pdf	8637	-1282913127	\N	f	2022-09-29 10:54:44.602+00
2904	47	2466	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/rseqc/inner_distance/rscript/sample_1.inner_distance_plot.r	sample_1.inner_distance_plot.r	1613	2121554835	\N	f	2022-09-29 10:54:44.598+00
2905	47	2466	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/rseqc/inner_distance/rscript/sample_2.inner_distance_plot.r	sample_2.inner_distance_plot.r	1600	1208016544	\N	f	2022-09-29 10:54:44.598+00
2906	47	2466	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/rseqc/inner_distance/rscript/sample_3.inner_distance_plot.r	sample_3.inner_distance_plot.r	1630	1036182943	\N	f	2022-09-29 10:54:44.598+00
2907	47	2467	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/rseqc/inner_distance/txt/sample_1.inner_distance.txt	sample_1.inner_distance.txt	67476938	-1375257842	\N	f	2022-09-29 10:54:44.442+00
2908	47	2467	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/rseqc/inner_distance/txt/sample_1.inner_distance_freq.txt	sample_1.inner_distance_freq.txt	1298	1785012067	\N	f	2022-09-29 10:54:44.598+00
2909	47	2467	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/rseqc/inner_distance/txt/sample_1.inner_distance_mean.txt	sample_1.inner_distance_mean.txt	98	-1199677314	\N	f	2022-09-29 10:54:44.598+00
2910	47	2467	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/rseqc/inner_distance/txt/sample_2.inner_distance.txt	sample_2.inner_distance.txt	70303361	-806448240	\N	f	2022-09-29 10:54:44.59+00
2911	47	2467	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/rseqc/inner_distance/txt/sample_2.inner_distance_freq.txt	sample_2.inner_distance_freq.txt	1285	-409238101	\N	f	2022-09-29 10:54:44.598+00
2912	47	2467	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/rseqc/inner_distance/txt/sample_2.inner_distance_mean.txt	sample_2.inner_distance_mean.txt	97	-802203996	\N	f	2022-09-29 10:54:44.522+00
2913	47	2467	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/rseqc/inner_distance/txt/sample_3.inner_distance.txt	sample_3.inner_distance.txt	67502150	1536518669	\N	f	2022-09-29 10:54:44.514+00
2914	47	2467	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/rseqc/inner_distance/txt/sample_3.inner_distance_freq.txt	sample_3.inner_distance_freq.txt	1315	1100660543	\N	f	2022-09-29 10:54:44.598+00
2915	47	2467	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/rseqc/inner_distance/txt/sample_3.inner_distance_mean.txt	sample_3.inner_distance_mean.txt	98	1355725255	\N	f	2022-09-29 10:54:44.598+00
2916	47	2469	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/rseqc/junction_annotation/bed/sample_1.junction.Interact.bed	sample_1.junction.Interact.bed	52851297	-972754185	\N	f	2022-09-29 10:54:44.766+00
2917	47	2469	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/rseqc/junction_annotation/bed/sample_1.junction.bed	sample_1.junction.bed	21992208	-1542879515	\N	f	2022-09-29 10:54:44.67+00
2918	47	2469	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/rseqc/junction_annotation/bed/sample_2.junction.Interact.bed	sample_2.junction.Interact.bed	43701729	466191126	\N	f	2022-09-29 10:54:44.642+00
2919	47	2469	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/rseqc/junction_annotation/bed/sample_2.junction.bed	sample_2.junction.bed	18273887	-1264681476	\N	f	2022-09-29 10:54:44.69+00
2920	47	2469	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/rseqc/junction_annotation/bed/sample_3.junction.Interact.bed	sample_3.junction.Interact.bed	51970798	-260376006	\N	f	2022-09-29 10:54:44.822+00
2921	47	2469	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/rseqc/junction_annotation/bed/sample_3.junction.bed	sample_3.junction.bed	21617067	-312471427	\N	f	2022-09-29 10:54:44.714+00
2922	47	2470	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/rseqc/junction_annotation/log/sample_1.junction_annotation.log	sample_1.junction_annotation.log	597	973584680	\N	f	2022-09-29 10:54:44.862+00
2923	47	2470	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/rseqc/junction_annotation/log/sample_2.junction_annotation.log	sample_2.junction_annotation.log	597	1057367134	\N	f	2022-09-29 10:54:44.862+00
2924	47	2470	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/rseqc/junction_annotation/log/sample_3.junction_annotation.log	sample_3.junction_annotation.log	597	1654427511	\N	f	2022-09-29 10:54:44.862+00
2925	47	2471	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/rseqc/junction_annotation/pdf/sample_1.splice_events.pdf	sample_1.splice_events.pdf	13329	210911071	\N	f	2022-09-29 10:54:44.862+00
2926	47	2471	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/rseqc/junction_annotation/pdf/sample_1.splice_junction.pdf	sample_1.splice_junction.pdf	13285	929969539	\N	f	2022-09-29 10:54:44.862+00
2927	47	2471	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/rseqc/junction_annotation/pdf/sample_2.splice_events.pdf	sample_2.splice_events.pdf	13371	529989483	\N	f	2022-09-29 10:54:44.862+00
2928	47	2471	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/rseqc/junction_annotation/pdf/sample_2.splice_junction.pdf	sample_2.splice_junction.pdf	13231	-1585963325	\N	f	2022-09-29 10:54:44.862+00
2929	47	2471	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/rseqc/junction_annotation/pdf/sample_3.splice_events.pdf	sample_3.splice_events.pdf	13363	1800980016	\N	f	2022-09-29 10:54:44.862+00
2930	47	2471	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/rseqc/junction_annotation/pdf/sample_3.splice_junction.pdf	sample_3.splice_junction.pdf	13269	608484431	\N	f	2022-09-29 10:54:44.862+00
2931	47	2472	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/rseqc/junction_annotation/rscript/sample_1.junction_plot.r	sample_1.junction_plot.r	583	-1178720374	\N	f	2022-09-29 10:54:44.862+00
2932	47	2472	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/rseqc/junction_annotation/rscript/sample_2.junction_plot.r	sample_2.junction_plot.r	581	1391370897	\N	f	2022-09-29 10:54:44.862+00
2933	47	2472	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/rseqc/junction_annotation/rscript/sample_3.junction_plot.r	sample_3.junction_plot.r	580	-963164767	\N	f	2022-09-29 10:54:44.862+00
2934	47	2473	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/rseqc/junction_annotation/xls/sample_1.junction.xls	sample_1.junction.xls	11141659	1584661532	\N	f	2022-09-29 10:54:44.858+00
2935	47	2473	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/rseqc/junction_annotation/xls/sample_2.junction.xls	sample_2.junction.xls	9194308	343857474	\N	f	2022-09-29 10:54:44.846+00
2936	47	2473	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/rseqc/junction_annotation/xls/sample_3.junction.xls	sample_3.junction.xls	10950039	-1418924040	\N	f	2022-09-29 10:54:44.838+00
2937	47	2475	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/rseqc/junction_saturation/pdf/sample_1.junctionSaturation_plot.pdf	sample_1.junctionSaturation_plot.pdf	5603	132674291	\N	f	2022-09-29 10:54:44.602+00
2938	47	2475	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/rseqc/junction_saturation/pdf/sample_2.junctionSaturation_plot.pdf	sample_2.junctionSaturation_plot.pdf	5589	1950800362	\N	f	2022-09-29 10:54:44.602+00
2939	47	2475	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/rseqc/junction_saturation/pdf/sample_3.junctionSaturation_plot.pdf	sample_3.junctionSaturation_plot.pdf	5587	2079485174	\N	f	2022-09-29 10:54:44.602+00
2940	47	2476	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/rseqc/junction_saturation/rscript/sample_1.junctionSaturation_plot.r	sample_1.junctionSaturation_plot.r	926	1968421588	\N	f	2022-09-29 10:54:44.602+00
2941	47	2476	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/rseqc/junction_saturation/rscript/sample_2.junctionSaturation_plot.r	sample_2.junctionSaturation_plot.r	915	1913237765	\N	f	2022-09-29 10:54:44.602+00
2942	47	2476	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/rseqc/junction_saturation/rscript/sample_3.junctionSaturation_plot.r	sample_3.junctionSaturation_plot.r	926	174213058	\N	f	2022-09-29 10:54:44.602+00
2943	47	2477	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/rseqc/read_distribution/sample_1.read_distribution.txt	sample_1.read_distribution.txt	1159	-1482541159	\N	f	2022-09-29 10:54:44.602+00
2944	47	2477	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/rseqc/read_distribution/sample_2.read_distribution.txt	sample_2.read_distribution.txt	1156	910928270	\N	f	2022-09-29 10:54:44.602+00
2945	47	2477	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/rseqc/read_distribution/sample_3.read_distribution.txt	sample_3.read_distribution.txt	1159	-440657301	\N	f	2022-09-29 10:54:44.602+00
2946	47	2479	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/rseqc/read_duplication/pdf/sample_1.DupRate_plot.pdf	sample_1.DupRate_plot.pdf	21556	-535551735	\N	f	2022-09-29 10:54:44.602+00
3120	57	3118	original/upload/S3R2_2.fq.gz	S3R2_2.fq.gz	32806	-526646960	\N	f	2022-09-29 13:45:32.575+00
2947	47	2479	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/rseqc/read_duplication/pdf/sample_2.DupRate_plot.pdf	sample_2.DupRate_plot.pdf	21186	-1755845708	\N	f	2022-09-29 10:54:44.602+00
2948	47	2479	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/rseqc/read_duplication/pdf/sample_3.DupRate_plot.pdf	sample_3.DupRate_plot.pdf	21266	1254515124	\N	f	2022-09-29 10:54:44.602+00
2949	47	2480	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/rseqc/read_duplication/rscript/sample_1.DupRate_plot.r	sample_1.DupRate_plot.r	31326	998916456	\N	f	2022-09-29 10:54:44.602+00
2950	47	2480	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/rseqc/read_duplication/rscript/sample_2.DupRate_plot.r	sample_2.DupRate_plot.r	54192	534390417	\N	f	2022-09-29 10:54:44.602+00
2951	47	2480	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/rseqc/read_duplication/rscript/sample_3.DupRate_plot.r	sample_3.DupRate_plot.r	26056	-880293628	\N	f	2022-09-29 10:54:44.602+00
2952	47	2481	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/rseqc/read_duplication/xls/sample_1.pos.DupRate.xls	sample_1.pos.DupRate.xls	16971	-452297870	\N	f	2022-09-29 10:54:44.602+00
2953	47	2481	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/rseqc/read_duplication/xls/sample_1.seq.DupRate.xls	sample_1.seq.DupRate.xls	13583	591430402	\N	f	2022-09-29 10:54:44.602+00
2954	47	2481	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/rseqc/read_duplication/xls/sample_2.pos.DupRate.xls	sample_2.pos.DupRate.xls	27781	2105099307	\N	f	2022-09-29 10:54:44.602+00
2955	47	2481	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/rseqc/read_duplication/xls/sample_2.seq.DupRate.xls	sample_2.seq.DupRate.xls	25639	1353968153	\N	f	2022-09-29 10:54:44.602+00
2956	47	2481	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/rseqc/read_duplication/xls/sample_3.pos.DupRate.xls	sample_3.pos.DupRate.xls	14226	406711132	\N	f	2022-09-29 10:54:44.602+00
2957	47	2481	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/rseqc/read_duplication/xls/sample_3.seq.DupRate.xls	sample_3.seq.DupRate.xls	11058	-847689845	\N	f	2022-09-29 10:54:44.602+00
2958	47	2434	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/salmon.merged.gene_counts.rds	salmon.merged.gene_counts.rds	2041669	234992581	\N	f	2022-09-29 10:54:44.358+00
2959	47	2434	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/salmon.merged.gene_counts.tsv	salmon.merged.gene_counts.tsv	1697349	370134866	\N	f	2022-09-29 10:54:44.374+00
2960	47	2434	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/salmon.merged.gene_counts_length_scaled.rds	salmon.merged.gene_counts_length_scaled.rds	2523227	-149575736	\N	f	2022-09-29 10:54:46.098+00
2961	47	2434	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/salmon.merged.gene_counts_length_scaled.tsv	salmon.merged.gene_counts_length_scaled.tsv	2957831	268107946	\N	f	2022-09-29 10:54:46.114+00
2962	47	2434	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/salmon.merged.gene_counts_scaled.rds	salmon.merged.gene_counts_scaled.rds	2515613	-1609070652	\N	f	2022-09-29 10:54:46.098+00
2963	47	2434	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/salmon.merged.gene_counts_scaled.tsv	salmon.merged.gene_counts_scaled.tsv	2959826	-407257925	\N	f	2022-09-29 10:54:44.866+00
2964	47	2434	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/salmon.merged.gene_tpm.tsv	salmon.merged.gene_tpm.tsv	2166288	1507891891	\N	f	2022-09-29 10:54:46.118+00
2965	47	2434	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/salmon.merged.transcript_counts.rds	salmon.merged.transcript_counts.rds	2333318	765091423	\N	f	2022-09-29 10:54:45.19+00
2966	47	2434	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/salmon.merged.transcript_counts.tsv	salmon.merged.transcript_counts.tsv	2006923	-1156012300	\N	f	2022-09-29 10:54:46.038+00
2967	47	2434	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/salmon.merged.transcript_tpm.tsv	salmon.merged.transcript_tpm.tsv	2472747	283341838	\N	f	2022-09-29 10:54:44.374+00
2968	47	2434	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/salmon_tx2gene.tsv	salmon_tx2gene.tsv	1757786	1341076080	\N	f	2022-09-29 10:54:44.866+00
2969	47	2483	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/sample_1/aux_info/ambig_info.tsv	ambig_info.tsv	373014	1971676302	\N	f	2022-09-29 10:54:46.034+00
2970	47	2483	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/sample_1/aux_info/expected_bias.gz	expected_bias.gz	117	648000688	\N	f	2022-09-29 10:54:46.034+00
2971	47	2483	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/sample_1/aux_info/fld.gz	fld.gz	532	1027644612	\N	f	2022-09-29 10:54:46.034+00
2972	47	2483	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/sample_1/aux_info/meta_info.json	meta_info.json	1308	-1588728904	\N	f	2022-09-29 10:54:46.034+00
2973	47	2483	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/sample_1/aux_info/observed_bias.gz	observed_bias.gz	82	92255311	\N	f	2022-09-29 10:54:46.034+00
2974	47	2483	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/sample_1/aux_info/observed_bias_3p.gz	observed_bias_3p.gz	82	1303968442	\N	f	2022-09-29 10:54:46.034+00
2975	47	2482	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/sample_1/cmd_info.json	cmd_info.json	290	1785145431	\N	f	2022-09-29 10:54:46.03+00
2976	47	2484	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/sample_1/libParams/flenDist.txt	flenDist.txt	11697	1346373163	\N	f	2022-09-29 10:54:46.034+00
2977	47	2482	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/sample_1/quant.genes.sf	quant.genes.sf	1953889	-1377312831	\N	f	2022-09-29 10:54:46.03+00
2978	47	2482	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/sample_1/quant.sf	quant.sf	2884170	328307547	\N	f	2022-09-29 10:54:46.034+00
2979	47	2434	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/sample_1.markdup.sorted.bam.bai	sample_1.markdup.sorted.bam.bai	2766364	595436542	\N	f	2022-09-29 10:54:44.362+00
2980	47	2486	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/sample_2/aux_info/ambig_info.tsv	ambig_info.tsv	361687	2061555992	\N	f	2022-09-29 10:54:44.37+00
2981	47	2486	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/sample_2/aux_info/expected_bias.gz	expected_bias.gz	117	-599422588	\N	f	2022-09-29 10:54:44.37+00
2982	47	2486	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/sample_2/aux_info/fld.gz	fld.gz	707	-1047309198	\N	f	2022-09-29 10:54:44.37+00
2983	47	2486	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/sample_2/aux_info/meta_info.json	meta_info.json	1307	-721544739	\N	f	2022-09-29 10:54:44.37+00
3121	58	\N		20220929134708170-263	95823	\N	\N	t	2022-09-29 13:47:09.566+00
2984	47	2486	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/sample_2/aux_info/observed_bias.gz	observed_bias.gz	82	517110021	\N	f	2022-09-29 10:54:44.37+00
2985	47	2486	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/sample_2/aux_info/observed_bias_3p.gz	observed_bias_3p.gz	82	-109033501	\N	f	2022-09-29 10:54:44.37+00
2986	47	2485	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/sample_2/cmd_info.json	cmd_info.json	289	500169902	\N	f	2022-09-29 10:54:44.366+00
2987	47	2487	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/sample_2/libParams/flenDist.txt	flenDist.txt	11611	906662886	\N	f	2022-09-29 10:54:44.37+00
2988	47	2488	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/sample_2/logs/salmon_quant.log	salmon_quant.log	6561	-392365200	\N	f	2022-09-29 10:54:44.37+00
2989	47	2434	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/sample_3	sample_3	5251614	\N	\N	t	2022-09-29 10:54:44.87+00
2990	47	2989	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/sample_3/aux_info	aux_info	372108	\N	\N	t	2022-09-29 10:54:44.874+00
2991	47	2989	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/sample_3/libParams	libParams	11741	\N	\N	t	2022-09-29 10:54:44.874+00
2992	47	2989	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/sample_3/logs	logs	8411	\N	\N	t	2022-09-29 10:54:44.874+00
2993	47	2434	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/samtools_stats	samtools_stats	1571640	\N	\N	t	2022-09-29 10:54:46.102+00
2994	47	2434	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/stringtie	stringtie	281712433	\N	\N	t	2022-09-29 10:54:45.182+00
2995	47	2994	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/stringtie/sample_1.ballgown	sample_1.ballgown	38065227	\N	\N	t	2022-09-29 10:54:45.098+00
2996	47	2994	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/stringtie/sample_2.ballgown	sample_2.ballgown	37508698	\N	\N	t	2022-09-29 10:54:45.058+00
2997	47	2994	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/stringtie/sample_3.ballgown	sample_3.ballgown	38004694	\N	\N	t	2022-09-29 10:54:44.922+00
2998	47	2424	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/trimgalore	trimgalore	9027933	\N	\N	t	2022-09-29 10:54:44.322+00
2999	47	2998	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/trimgalore/fastqc	fastqc	8997907	\N	\N	t	2022-09-29 10:54:44.322+00
3000	47	2485	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/sample_2/quant.genes.sf	quant.genes.sf	1946937	-770851684	\N	f	2022-09-29 10:54:44.366+00
3001	47	2485	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/sample_2/quant.sf	quant.sf	2871278	-339020416	\N	f	2022-09-29 10:54:44.37+00
3002	47	2434	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/sample_2.markdup.sorted.bam.bai	sample_2.markdup.sorted.bam.bai	8636952	-914685520	\N	f	2022-09-29 10:54:44.882+00
3003	47	2990	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/sample_3/aux_info/ambig_info.tsv	ambig_info.tsv	369990	-1636144214	\N	f	2022-09-29 10:54:44.874+00
3004	47	2990	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/sample_3/aux_info/expected_bias.gz	expected_bias.gz	117	-232937348	\N	f	2022-09-29 10:54:44.874+00
3005	47	2990	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/sample_3/aux_info/fld.gz	fld.gz	529	-1363117954	\N	f	2022-09-29 10:54:44.874+00
3006	47	2990	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/sample_3/aux_info/meta_info.json	meta_info.json	1308	-516392446	\N	f	2022-09-29 10:54:44.874+00
3007	47	2990	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/sample_3/aux_info/observed_bias.gz	observed_bias.gz	82	1895875064	\N	f	2022-09-29 10:54:44.874+00
3008	47	2990	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/sample_3/aux_info/observed_bias_3p.gz	observed_bias_3p.gz	82	-1587527512	\N	f	2022-09-29 10:54:44.874+00
3009	47	2989	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/sample_3/cmd_info.json	cmd_info.json	290	-1889054287	\N	f	2022-09-29 10:54:44.87+00
3010	47	2991	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/sample_3/libParams/flenDist.txt	flenDist.txt	11741	-140547560	\N	f	2022-09-29 10:54:44.874+00
3011	47	2992	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/sample_3/logs/salmon_quant.log	salmon_quant.log	8411	-1923626209	\N	f	2022-09-29 10:54:44.874+00
3012	47	2989	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/sample_3/quant.genes.sf	quant.genes.sf	1976642	918526714	\N	f	2022-09-29 10:54:44.87+00
3013	47	2989	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/sample_3/quant.sf	quant.sf	2882422	-1163554963	\N	f	2022-09-29 10:54:44.87+00
3014	47	2434	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/sample_3.markdup.sorted.bam.bai	sample_3.markdup.sorted.bam.bai	2810212	1916415193	\N	f	2022-09-29 10:54:45.186+00
3015	47	2993	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/samtools_stats/sample_1.markdup.sorted.bam.flagstat	sample_1.markdup.sorted.bam.flagstat	582	-1210799039	\N	f	2022-09-29 10:54:46.102+00
3016	47	2993	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/samtools_stats/sample_1.markdup.sorted.bam.idxstats	sample_1.markdup.sorted.bam.idxstats	243	821659378	\N	f	2022-09-29 10:54:46.102+00
3017	47	2993	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/samtools_stats/sample_1.markdup.sorted.bam.stats	sample_1.markdup.sorted.bam.stats	265373	1592082299	\N	f	2022-09-29 10:54:46.102+00
3018	47	2993	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/samtools_stats/sample_1.sorted.bam.flagstat	sample_1.sorted.bam.flagstat	568	-1293550481	\N	f	2022-09-29 10:54:46.102+00
3019	47	2993	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/samtools_stats/sample_1.sorted.bam.idxstats	sample_1.sorted.bam.idxstats	243	2122138771	\N	f	2022-09-29 10:54:46.102+00
3020	47	2993	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/samtools_stats/sample_1.sorted.bam.stats	sample_1.sorted.bam.stats	265349	-1761132527	\N	f	2022-09-29 10:54:46.102+00
3021	47	2993	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/samtools_stats/sample_2.markdup.sorted.bam.flagstat	sample_2.markdup.sorted.bam.flagstat	581	-1061240120	\N	f	2022-09-29 10:54:46.102+00
3022	47	2993	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/samtools_stats/sample_2.markdup.sorted.bam.idxstats	sample_2.markdup.sorted.bam.idxstats	248	979996437	\N	f	2022-09-29 10:54:46.102+00
3023	47	2993	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/samtools_stats/sample_2.markdup.sorted.bam.stats	sample_2.markdup.sorted.bam.stats	245270	494330399	\N	f	2022-09-29 10:54:46.102+00
3024	47	2993	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/samtools_stats/sample_2.sorted.bam.flagstat	sample_2.sorted.bam.flagstat	567	1931502860	\N	f	2022-09-29 10:54:46.102+00
3025	47	2993	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/samtools_stats/sample_2.sorted.bam.idxstats	sample_2.sorted.bam.idxstats	248	795814564	\N	f	2022-09-29 10:54:46.102+00
3026	47	2993	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/samtools_stats/sample_2.sorted.bam.stats	sample_2.sorted.bam.stats	245246	-553388407	\N	f	2022-09-29 10:54:46.102+00
3027	47	2993	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/samtools_stats/sample_3.markdup.sorted.bam.flagstat	sample_3.markdup.sorted.bam.flagstat	580	-1192400970	\N	f	2022-09-29 10:54:46.102+00
3028	47	2993	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/samtools_stats/sample_3.markdup.sorted.bam.idxstats	sample_3.markdup.sorted.bam.idxstats	243	-1782516047	\N	f	2022-09-29 10:54:46.102+00
3029	47	2993	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/samtools_stats/sample_3.markdup.sorted.bam.stats	sample_3.markdup.sorted.bam.stats	272757	-2130812077	\N	f	2022-09-29 10:54:46.102+00
3030	47	2993	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/samtools_stats/sample_3.sorted.bam.flagstat	sample_3.sorted.bam.flagstat	566	94634254	\N	f	2022-09-29 10:54:46.102+00
3031	47	2993	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/samtools_stats/sample_3.sorted.bam.idxstats	sample_3.sorted.bam.idxstats	243	196341811	\N	f	2022-09-29 10:54:46.102+00
3032	47	2993	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/samtools_stats/sample_3.sorted.bam.stats	sample_3.sorted.bam.stats	272733	428603069	\N	f	2022-09-29 10:54:46.102+00
3033	47	2995	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/stringtie/sample_1.ballgown/e2t.ctab	e2t.ctab	3254120	-832583858	\N	f	2022-09-29 10:54:45.09+00
3034	47	2995	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/stringtie/sample_1.ballgown/e_data.ctab	e_data.ctab	19040042	-916581231	\N	f	2022-09-29 10:54:45.074+00
3035	47	2995	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/stringtie/sample_1.ballgown/i2t.ctab	i2t.ctab	2293658	1464479614	\N	f	2022-09-29 10:54:45.098+00
3036	47	2995	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/stringtie/sample_1.ballgown/i_data.ctab	i_data.ctab	7847989	-712886026	\N	f	2022-09-29 10:54:45.086+00
3037	47	2995	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/stringtie/sample_1.ballgown/t_data.ctab	t_data.ctab	5629418	1059070221	\N	f	2022-09-29 10:54:45.094+00
3038	47	2994	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/stringtie/sample_1.coverage.gtf	sample_1.coverage.gtf	9384917	-1707267399	\N	f	2022-09-29 10:54:45.178+00
3039	47	2994	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/stringtie/sample_1.gene.abundance.txt	sample_1.gene.abundance.txt	4466399	-1589522100	\N	f	2022-09-29 10:54:44.97+00
3040	47	2994	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/stringtie/sample_1.transcripts.gtf	sample_1.transcripts.gtf	42683723	-2005544811	\N	f	2022-09-29 10:54:45.014+00
3041	47	2996	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/stringtie/sample_2.ballgown/e2t.ctab	e2t.ctab	3254120	-214251734	\N	f	2022-09-29 10:54:45.05+00
3042	47	2996	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/stringtie/sample_2.ballgown/e_data.ctab	e_data.ctab	18667110	1002077750	\N	f	2022-09-29 10:54:45.034+00
3043	47	2996	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/stringtie/sample_2.ballgown/i2t.ctab	i2t.ctab	2293658	2008522787	\N	f	2022-09-29 10:54:45.058+00
3044	47	2996	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/stringtie/sample_2.ballgown/i_data.ctab	i_data.ctab	7676864	-608656271	\N	f	2022-09-29 10:54:45.046+00
3045	47	2996	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/stringtie/sample_2.ballgown/t_data.ctab	t_data.ctab	5616946	54601702	\N	f	2022-09-29 10:54:45.054+00
3046	47	2994	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/stringtie/sample_2.coverage.gtf	sample_2.coverage.gtf	8189228	92057241	\N	f	2022-09-29 10:54:45.106+00
3047	47	2994	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/stringtie/sample_2.gene.abundance.txt	sample_2.gene.abundance.txt	4452849	856412637	\N	f	2022-09-29 10:54:45.182+00
3048	47	2994	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/stringtie/sample_2.transcripts.gtf	sample_2.transcripts.gtf	42481181	1537628456	\N	f	2022-09-29 10:54:45.15+00
3049	47	2997	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/stringtie/sample_3.ballgown/e2t.ctab	e2t.ctab	3254120	-2030546220	\N	f	2022-09-29 10:54:44.914+00
3050	47	2997	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/stringtie/sample_3.ballgown/e_data.ctab	e_data.ctab	18990360	1288774733	\N	f	2022-09-29 10:54:44.898+00
3051	47	2997	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/stringtie/sample_3.ballgown/i2t.ctab	i2t.ctab	2293658	-1310879090	\N	f	2022-09-29 10:54:44.922+00
3052	47	2997	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/stringtie/sample_3.ballgown/i_data.ctab	i_data.ctab	7838274	-1404685321	\N	f	2022-09-29 10:54:44.91+00
3053	47	2997	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/stringtie/sample_3.ballgown/t_data.ctab	t_data.ctab	5628282	-1732265984	\N	f	2022-09-29 10:54:44.918+00
3054	47	2994	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/stringtie/sample_3.coverage.gtf	sample_3.coverage.gtf	9317712	1052203413	\N	f	2022-09-29 10:54:45.166+00
3055	47	2994	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/stringtie/sample_3.gene.abundance.txt	sample_3.gene.abundance.txt	4466275	315255241	\N	f	2022-09-29 10:54:45.158+00
3056	47	2994	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/star_salmon/stringtie/sample_3.transcripts.gtf	sample_3.transcripts.gtf	42691530	1692020241	\N	f	2022-09-29 10:54:44.962+00
3057	47	2999	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/trimgalore/fastqc/sample_1_1_val_1_fastqc.html	sample_1_1_val_1_fastqc.html	651502	42307300	\N	f	2022-09-29 10:54:44.322+00
3058	47	2999	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/trimgalore/fastqc/sample_1_1_val_1_fastqc.zip	sample_1_1_val_1_fastqc.zip	814675	-1885475653	\N	f	2022-09-29 10:54:44.314+00
3059	47	2999	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/trimgalore/fastqc/sample_1_2_val_2_fastqc.html	sample_1_2_val_2_fastqc.html	653692	1565309873	\N	f	2022-09-29 10:54:44.322+00
3060	47	2999	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/trimgalore/fastqc/sample_1_2_val_2_fastqc.zip	sample_1_2_val_2_fastqc.zip	818144	1714541160	\N	f	2022-09-29 10:54:44.322+00
3061	47	2999	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/trimgalore/fastqc/sample_2_1_val_1_fastqc.html	sample_2_1_val_1_fastqc.html	690259	292291304	\N	f	2022-09-29 10:54:44.314+00
3062	47	2999	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/trimgalore/fastqc/sample_2_1_val_1_fastqc.zip	sample_2_1_val_1_fastqc.zip	869256	-1109901901	\N	f	2022-09-29 10:54:44.314+00
3063	47	2999	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/trimgalore/fastqc/sample_2_2_val_2_fastqc.html	sample_2_2_val_2_fastqc.html	694918	1451535853	\N	f	2022-09-29 10:54:44.322+00
3064	47	2999	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/trimgalore/fastqc/sample_2_2_val_2_fastqc.zip	sample_2_2_val_2_fastqc.zip	868888	159058758	\N	f	2022-09-29 10:54:44.318+00
3065	47	2999	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/trimgalore/fastqc/sample_3_1_val_1_fastqc.html	sample_3_1_val_1_fastqc.html	649993	1234208990	\N	f	2022-09-29 10:54:44.318+00
3066	47	2999	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/trimgalore/fastqc/sample_3_1_val_1_fastqc.zip	sample_3_1_val_1_fastqc.zip	811967	-1738092359	\N	f	2022-09-29 10:54:44.318+00
3067	47	2999	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/trimgalore/fastqc/sample_3_2_val_2_fastqc.html	sample_3_2_val_2_fastqc.html	655079	-491969328	\N	f	2022-09-29 10:54:44.314+00
3068	47	2999	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/trimgalore/fastqc/sample_3_2_val_2_fastqc.zip	sample_3_2_val_2_fastqc.zip	819534	1431948408	\N	f	2022-09-29 10:54:44.318+00
3069	47	2998	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/trimgalore/sample_1_1.fastq.gz_trimming_report.txt	sample_1_1.fastq.gz_trimming_report.txt	4906	-934343623	\N	f	2022-09-29 10:54:44.322+00
3070	47	2998	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/trimgalore/sample_1_2.fastq.gz_trimming_report.txt	sample_1_2.fastq.gz_trimming_report.txt	5189	-1331601344	\N	f	2022-09-29 10:54:44.322+00
3071	47	2998	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/trimgalore/sample_2_1.fastq.gz_trimming_report.txt	sample_2_1.fastq.gz_trimming_report.txt	4736	-936794468	\N	f	2022-09-29 10:54:44.322+00
3072	47	2998	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/trimgalore/sample_2_2.fastq.gz_trimming_report.txt	sample_2_2.fastq.gz_trimming_report.txt	4931	-663900751	\N	f	2022-09-29 10:54:44.322+00
3073	47	2998	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/trimgalore/sample_3_1.fastq.gz_trimming_report.txt	sample_3_1.fastq.gz_trimming_report.txt	5022	-1473413419	\N	f	2022-09-29 10:54:44.322+00
3074	47	2998	original/7daba86f-560b-4dfb-9dae-8e66edf7fbd5/results/trimgalore/sample_3_2.fastq.gz_trimming_report.txt	sample_3_2.fastq.gz_trimming_report.txt	5242	635239664	\N	f	2022-09-29 10:54:44.322+00
3075	48	\N		20220929123528711-232	85048	\N	\N	t	2022-09-29 12:35:30.114+00
3076	48	3075	original	original	85048	\N	\N	t	2022-09-29 12:35:29.358+00
3077	48	3076	original/mathpron.pdf	mathpron.pdf	85048	-925028870	\N	f	2022-09-29 12:35:28.67+00
3078	49	\N		20220929123837937-235	1157787	\N	\N	t	2022-09-29 12:38:39.292+00
3079	49	3078	original	original	1157787	\N	\N	t	2022-09-29 12:38:38.54+00
3080	49	3079	original/ERR4147226_c1e4_R2_001.fastq.gz	ERR4147226_c1e4_R2_001.fastq.gz	1157787	260406162	\N	f	2022-09-29 12:38:37.9+00
3081	50	\N		20220929133507343-238	97730	\N	\N	t	2022-09-29 13:35:09.309+00
3082	50	3081	original	original	97730	\N	\N	t	2022-09-29 13:35:08.461+00
3083	50	3082	original/upload	upload	97730	\N	\N	t	2022-09-29 13:35:07.305+00
3084	50	3083	original/upload/S1R1_1.fq.gz	S1R1_1.fq.gz	47574	1623549321	\N	f	2022-09-29 13:35:07.305+00
3085	50	3083	original/upload/S1R1_2.fq.gz	S1R1_2.fq.gz	50156	-1133525137	\N	f	2022-09-29 13:35:07.305+00
3086	51	\N		20220929133835249-241	97355	\N	\N	t	2022-09-29 13:38:36.992+00
3087	51	3086	original	original	97355	\N	\N	t	2022-09-29 13:38:36.192+00
3088	51	3087	original/upload	upload	97355	\N	\N	t	2022-09-29 13:38:35.208+00
3089	51	3088	original/upload/S1R2_1.fq.gz	S1R2_1.fq.gz	47749	769901283	\N	f	2022-09-29 13:38:35.208+00
3090	51	3088	original/upload/S1R2_2.fq.gz	S1R2_2.fq.gz	49606	-703442282	\N	f	2022-09-29 13:38:35.208+00
3091	52	\N		20220929134055217-245	75556	\N	\N	t	2022-09-29 13:40:56.351+00
3092	52	3091	original	original	75556	\N	\N	t	2022-09-29 13:40:55.899+00
3093	52	3092	original/upload	upload	75556	\N	\N	t	2022-09-29 13:40:55.179+00
3094	52	3093	original/upload/S1R3_1.fq.gz	S1R3_1.fq.gz	36770	-1339433036	\N	f	2022-09-29 13:40:55.179+00
3095	52	3093	original/upload/S1R3_2.fq.gz	S1R3_2.fq.gz	38786	-482584375	\N	f	2022-09-29 13:40:55.179+00
3096	53	\N		20220929134124772-248	78254	\N	\N	t	2022-09-29 13:41:25.917+00
3097	53	3096	original	original	78254	\N	\N	t	2022-09-29 13:41:25.465+00
3098	53	3097	original/upload	upload	78254	\N	\N	t	2022-09-29 13:41:24.701+00
3099	53	3098	original/upload/S2R1_1.fq.gz	S2R1_1.fq.gz	38562	-77590369	\N	f	2022-09-29 13:41:24.697+00
3100	53	3098	original/upload/S2R1_2.fq.gz	S2R1_2.fq.gz	39692	-1224975521	\N	f	2022-09-29 13:41:24.701+00
3101	54	\N		20220929134316852-251	95699	\N	\N	t	2022-09-29 13:43:18.729+00
3102	54	3101	original	original	95699	\N	\N	t	2022-09-29 13:43:17.973+00
3103	54	3102	original/upload	upload	95699	\N	\N	t	2022-09-29 13:43:16.813+00
3104	54	3103	original/upload/S3R1_1.fq.gz	S3R1_1.fq.gz	47144	1186284025	\N	f	2022-09-29 13:43:16.813+00
3105	54	3103	original/upload/S3R1_2.fq.gz	S3R1_2.fq.gz	48555	2030023504	\N	f	2022-09-29 13:43:16.813+00
3106	55	\N		20220929134333235-254	77634	\N	\N	t	2022-09-29 13:43:34.106+00
3107	55	3106	original	original	77634	\N	\N	t	2022-09-29 13:43:33.706+00
3108	55	3107	original/upload	upload	77634	\N	\N	t	2022-09-29 13:43:33.17+00
3109	55	3108	original/upload/S2R2_1.fq.gz	S2R2_1.fq.gz	38652	-738739788	\N	f	2022-09-29 13:43:33.166+00
3110	55	3108	original/upload/S2R2_2.fq.gz	S2R2_2.fq.gz	38982	-62642461	\N	f	2022-09-29 13:43:33.17+00
3111	56	\N		20220929134517601-257	77907	\N	\N	t	2022-09-29 13:45:19.014+00
3112	56	3111	original	original	77907	\N	\N	t	2022-09-29 13:45:18.25+00
3113	56	3112	original/upload	upload	77907	\N	\N	t	2022-09-29 13:45:17.57+00
3114	56	3113	original/upload/S2R3_1.fq.gz	S2R3_1.fq.gz	40175	-589148371	\N	f	2022-09-29 13:45:17.566+00
3115	56	3113	original/upload/S2R3_2.fq.gz	S2R3_2.fq.gz	37732	-2140001066	\N	f	2022-09-29 13:45:17.57+00
3116	57	\N		20220929134532603-260	56240	\N	\N	t	2022-09-29 13:45:33.991+00
3117	57	3116	original	original	56240	\N	\N	t	2022-09-29 13:45:33.263+00
3118	57	3117	original/upload	upload	56240	\N	\N	t	2022-09-29 13:45:32.575+00
3119	57	3118	original/upload/S3R2_1.fq.gz	S3R2_1.fq.gz	23434	1238382730	\N	f	2022-09-29 13:45:32.571+00
3130	60	3129	original	original	50984	\N	\N	t	2022-09-29 13:48:00.758+00
3131	60	3130	original/genome.fasta	genome.fasta	50984	2129866519	\N	f	2022-09-29 13:48:00.05+00
3132	61	\N		20230614121938319-271	8786774	\N	\N	t	2023-06-14 12:19:40.485+00
3133	61	3132	original	original	8786774	\N	\N	t	2023-06-14 12:19:39.493+00
3134	61	3133	original/upload	upload	8786774	\N	\N	t	2023-06-14 12:19:38.105+00
3135	61	3134	original/upload/QLUNG005A0_jah89_1_scr_static-sample.fastq	QLUNG005A0_jah89_1_scr_static-sample.fastq	4220591	-2082109332	\N	f	2023-06-14 12:19:38.101+00
3136	61	3134	original/upload/QLUNG005A0_jah89_2_scr_static-sample.fastq	QLUNG005A0_jah89_2_scr_static-sample.fastq	4566183	-795400840	\N	f	2023-06-14 12:19:38.113+00
3143	64	\N		20230616120342632-276	8786774	\N	\N	t	2023-06-16 12:03:44.203+00
3144	64	3143	original	original	8786774	\N	\N	t	2023-06-16 12:03:43.347+00
3145	64	3144	original/upload	upload	8786774	\N	\N	t	2023-06-16 12:03:42.571+00
3146	64	3145	original/upload/QLUNG005A0_jah89_1_scr_static-sample.fastq	QLUNG005A0_jah89_1_scr_static-sample.fastq	4220591	233794382	\N	f	2023-06-16 12:03:42.567+00
3147	64	3145	original/upload/QLUNG005A0_jah89_2_scr_static-sample.fastq	QLUNG005A0_jah89_2_scr_static-sample.fastq	4566183	-957212919	\N	f	2023-06-16 12:03:42.587+00
3148	65	\N		20230718093749840-320	247375	\N	\N	t	2023-07-18 09:37:51.315+00
3149	65	3148	original	original	247375	\N	\N	t	2023-07-18 09:37:50.259+00
3150	65	3149	original/27459417_190473458208426_5952984366132391935_n.jpg	27459417_190473458208426_5952984366132391935_n.jpg	247375	-656733439	\N	f	2023-07-18 09:37:50.187+00
3151	66	\N		20240125084137156-341	189780371	\N	\N	t	2024-01-25 08:41:39.705+00
3152	66	3151	original	original	189780371	\N	\N	t	2024-01-25 08:41:38.62+00
3153	66	3152	original/sample.large.fastq	sample.large.fastq	189780371	-1548022622	\N	f	2024-01-25 08:41:36.94+00
3154	67	\N		20240125084141149-344	2958022	\N	\N	t	2024-01-25 08:41:42.873+00
3155	67	3154	original	original	2958022	\N	\N	t	2024-01-25 08:41:42.101+00
3156	67	3155	original/sample.medium.fastq	sample.medium.fastq	2958022	236029270	\N	f	2024-01-25 08:41:41.109+00
3157	68	\N		20240125084144342-347	173	\N	\N	t	2024-01-25 08:41:45.909+00
3158	68	3157	original	original	173	\N	\N	t	2024-01-25 08:41:45.113+00
3159	68	3158	original/secret_keyfile.sec	secret_keyfile.sec	173	-1066655285	\N	f	2024-01-25 08:41:44.305+00
3160	69	\N		20240125084147019-350	37632	\N	\N	t	2024-01-25 08:41:48.518+00
3161	69	3160	original	original	37632	\N	\N	t	2024-01-25 08:41:47.934+00
3162	69	3161	original/sample.small.fastq	sample.small.fastq	37632	299393762	\N	f	2024-01-25 08:41:46.982+00
3163	70	\N		20240125084424209-351	3184	\N	\N	t	2024-01-25 08:44:26.13+00
3164	70	3163	original	original	3184	\N	\N	t	2024-01-25 08:44:25.462+00
3165	70	3164	original/2023-11-29_VJ.v0.1_metadata.csv	2023-11-29_VJ.v0.1_metadata.csv	3184	-225491251	\N	f	2024-01-25 08:44:24.174+00
3166	71	\N		20240125085509644-352	15042825	\N	\N	t	2024-01-25 08:55:10.865+00
3167	71	3166	original	original	15042825	\N	\N	t	2024-01-25 08:55:10.245+00
3168	71	3167	original/38_Microbacterium.tar.gz	38_Microbacterium.tar.gz	15042825	245828359	\N	f	2024-01-25 08:55:09.597+00
3169	72	\N		20240125105136495-354	1655277	\N	\N	t	2024-01-25 10:51:37.727+00
3170	72	3169	original	original	1655277	\N	\N	t	2024-01-25 10:51:37.119+00
3171	72	3170	original/annot.faa	annot.faa	1655277	923916630	\N	f	2024-01-25 10:51:36.455+00
3172	73	\N		20240125105229725-355	10219323	\N	\N	t	2024-01-25 10:52:30.894+00
3173	73	3172	original	original	10219323	\N	\N	t	2024-01-25 10:52:30.302+00
3174	73	3173	original/annot.gbk	annot.gbk	10219323	-1351384031	\N	f	2024-01-25 10:52:29.686+00
3175	74	\N		20240126140501918-384	1731016	\N	\N	t	2024-01-26 14:05:03.079+00
3176	74	3175	original	original	1731016	\N	\N	t	2024-01-26 14:05:02.519+00
3177	74	3176	original/BC01.fastq.gz	BC01.fastq.gz	1731016	-473213330	\N	f	2024-01-26 14:05:01.823+00
3178	75	\N		20240126140503801-387	153645	\N	\N	t	2024-01-26 14:05:04.856+00
3179	75	3178	original	original	153645	\N	\N	t	2024-01-26 14:05:04.376+00
3180	75	3179	original/BC06.fastq.gz	BC06.fastq.gz	153645	1897704820	\N	f	2024-01-26 14:05:03.768+00
3181	76	\N		20240126140505796-390	1455306	\N	\N	t	2024-01-26 14:05:06.86+00
3182	76	3181	original	original	1455306	\N	\N	t	2024-01-26 14:05:06.364+00
3183	76	3182	original/BC04.fastq.gz	BC04.fastq.gz	1455306	-1629574487	\N	f	2024-01-26 14:05:05.768+00
3184	77	\N		20240126140507557-393	2304690	\N	\N	t	2024-01-26 14:05:08.22+00
3185	77	3184	original	original	2304690	\N	\N	t	2024-01-26 14:05:07.756+00
3186	77	3185	original/BC03.fastq.gz	BC03.fastq.gz	2304690	1264461735	\N	f	2024-01-26 14:05:07.528+00
3187	78	\N		20240126140508690-396	3498984	\N	\N	t	2024-01-26 14:05:09.38+00
3188	78	3187	original	original	3498984	\N	\N	t	2024-01-26 14:05:08.888+00
3189	78	3188	original/BC02.fastq.gz	BC02.fastq.gz	3498984	-20683924	\N	f	2024-01-26 14:05:08.66+00
3190	79	\N		20240126140509811-399	435942	\N	\N	t	2024-01-26 14:05:10.348+00
3191	79	3190	original	original	435942	\N	\N	t	2024-01-26 14:05:09.908+00
3192	79	3191	original/BC05.fastq.gz	BC05.fastq.gz	435942	-984807216	\N	f	2024-01-26 14:05:09.78+00
3193	80	\N		20240126140600399-400	5769310	\N	\N	t	2024-01-26 14:06:01.659+00
3194	80	3193	original	original	5769310	\N	\N	t	2024-01-26 14:06:00.951+00
3195	80	3194	original/GCF_000016305.1_ASM1630v1_genomic.fna	GCF_000016305.1_ASM1630v1_genomic.fna	5769310	-1164270958	\N	f	2024-01-26 14:06:00.363+00
3196	81	\N		20240126140601830-401	3222733	\N	\N	t	2024-01-26 14:06:03.683+00
3197	81	3196	original	original	3222733	\N	\N	t	2024-01-26 14:06:02.859+00
3198	81	3197	original/GCF_000016305.1_ASM1630v1_genomic.gff	GCF_000016305.1_ASM1630v1_genomic.gff	3222733	-1920043896	\N	f	2024-01-26 14:06:01.799+00
3199	82	\N		20240131150403511-412	5239732	\N	\N	t	2024-01-31 15:04:05.644+00
3200	82	3199	original	original	5239732	\N	\N	t	2024-01-31 15:04:03.788+00
3201	82	3200	original/0dc13bae-0cad-4fb9-8455-bb633dcacbf4	0dc13bae-0cad-4fb9-8455-bb633dcacbf4	5239732	\N	\N	t	2024-01-31 15:04:02.688+00
3202	82	3201	original/0dc13bae-0cad-4fb9-8455-bb633dcacbf4/analyses	analyses	3491534	\N	\N	t	2024-01-31 15:04:03.28+00
3203	82	3201	original/0dc13bae-0cad-4fb9-8455-bb633dcacbf4/multiqc	multiqc	1748198	\N	\N	t	2024-01-31 15:04:03.284+00
3204	82	3203	original/0dc13bae-0cad-4fb9-8455-bb633dcacbf4/multiqc/multiqc_data	multiqc_data	87565	\N	\N	t	2024-01-31 15:04:03.288+00
3205	82	3203	original/0dc13bae-0cad-4fb9-8455-bb633dcacbf4/multiqc/multiqc_plots	multiqc_plots	390018	\N	\N	t	2024-01-31 14:04:53+00
3206	82	3205	original/0dc13bae-0cad-4fb9-8455-bb633dcacbf4/multiqc/multiqc_plots/pdf	pdf	93655	\N	\N	t	2024-01-31 15:04:03.288+00
3207	82	3205	original/0dc13bae-0cad-4fb9-8455-bb633dcacbf4/multiqc/multiqc_plots/png	png	82144	\N	\N	t	2024-01-31 15:04:03.284+00
3208	82	3205	original/0dc13bae-0cad-4fb9-8455-bb633dcacbf4/multiqc/multiqc_plots/svg	svg	214219	\N	\N	t	2024-01-31 15:04:03.284+00
3209	82	3202	original/0dc13bae-0cad-4fb9-8455-bb633dcacbf4/analyses/1.tsv	1.tsv	901600	-1210427242	\N	f	2024-01-31 15:04:03.276+00
3210	82	3202	original/0dc13bae-0cad-4fb9-8455-bb633dcacbf4/analyses/2.tsv	2.tsv	906530	-864364379	\N	f	2024-01-31 15:04:03.28+00
3211	82	3202	original/0dc13bae-0cad-4fb9-8455-bb633dcacbf4/analyses/3.tsv	3.tsv	912017	-1585211597	\N	f	2024-01-31 15:04:03.28+00
3212	82	3202	original/0dc13bae-0cad-4fb9-8455-bb633dcacbf4/analyses/MAplot_1_label.pdf	MAplot_1_label.pdf	21602	210563166	\N	f	2024-01-31 15:04:03.276+00
3213	82	3202	original/0dc13bae-0cad-4fb9-8455-bb633dcacbf4/analyses/MAplot_1_label.png	MAplot_1_label.png	248651	-1958383435	\N	f	2024-01-31 15:04:03.28+00
3214	82	3202	original/0dc13bae-0cad-4fb9-8455-bb633dcacbf4/analyses/MAplot_2_label.pdf	MAplot_2_label.pdf	21407	-672975267	\N	f	2024-01-31 15:04:03.28+00
3215	82	3202	original/0dc13bae-0cad-4fb9-8455-bb633dcacbf4/analyses/MAplot_2_label.png	MAplot_2_label.png	248418	2114318321	\N	f	2024-01-31 15:04:03.276+00
3216	82	3202	original/0dc13bae-0cad-4fb9-8455-bb633dcacbf4/analyses/MAplot_3_label.pdf	MAplot_3_label.pdf	14274	-114006555	\N	f	2024-01-31 15:04:03.28+00
3217	82	3202	original/0dc13bae-0cad-4fb9-8455-bb633dcacbf4/analyses/MAplot_3_label.png	MAplot_3_label.png	217035	875610894	\N	f	2024-01-31 15:04:03.28+00
3218	82	3203	original/0dc13bae-0cad-4fb9-8455-bb633dcacbf4/multiqc/.snakemake_timestamp	.snakemake_timestamp	28	1452335327	\N	f	2024-01-31 15:04:03.284+00
3219	82	3204	original/0dc13bae-0cad-4fb9-8455-bb633dcacbf4/multiqc/multiqc_data/mqc_featureCounts_assignment_plot_1.txt	mqc_featureCounts_assignment_plot_1.txt	379	919001518	\N	f	2024-01-31 15:04:03.288+00
3220	82	3204	original/0dc13bae-0cad-4fb9-8455-bb633dcacbf4/multiqc/multiqc_data/mqc_nanostat_quality_dist_1.txt	mqc_nanostat_quality_dist_1.txt	339	-1075724191	\N	f	2024-01-31 15:04:03.288+00
3221	82	3204	original/0dc13bae-0cad-4fb9-8455-bb633dcacbf4/multiqc/multiqc_data/mqc_samtools_alignment_plot_1.txt	mqc_samtools_alignment_plot_1.txt	213	-1515062777	\N	f	2024-01-31 15:04:03.288+00
3222	82	3204	original/0dc13bae-0cad-4fb9-8455-bb633dcacbf4/multiqc/multiqc_data/multiqc.log	multiqc.log	5438	1868315988	\N	f	2024-01-31 15:04:03.288+00
3223	82	3204	original/0dc13bae-0cad-4fb9-8455-bb633dcacbf4/multiqc/multiqc_data/multiqc_citations.txt	multiqc_citations.txt	281	287947199	\N	f	2024-01-31 15:04:03.288+00
3224	82	3204	original/0dc13bae-0cad-4fb9-8455-bb633dcacbf4/multiqc/multiqc_data/multiqc_data.json	multiqc_data.json	73478	-2057215083	\N	f	2024-01-31 15:04:03.288+00
3225	82	3204	original/0dc13bae-0cad-4fb9-8455-bb633dcacbf4/multiqc/multiqc_data/multiqc_featureCounts.txt	multiqc_featureCounts.txt	801	-1504846149	\N	f	2024-01-31 15:04:03.288+00
3226	82	3204	original/0dc13bae-0cad-4fb9-8455-bb633dcacbf4/multiqc/multiqc_data/multiqc_general_stats.txt	multiqc_general_stats.txt	1251	-1279409857	\N	f	2024-01-31 15:04:03.288+00
3227	82	3204	original/0dc13bae-0cad-4fb9-8455-bb633dcacbf4/multiqc/multiqc_data/multiqc_nanostat.txt	multiqc_nanostat.txt	750	1803827555	\N	f	2024-01-31 15:04:03.288+00
3228	82	3204	original/0dc13bae-0cad-4fb9-8455-bb633dcacbf4/multiqc/multiqc_data/multiqc_samtools_stats.txt	multiqc_samtools_stats.txt	2816	-447182972	\N	f	2024-01-31 15:04:03.288+00
3229	82	3204	original/0dc13bae-0cad-4fb9-8455-bb633dcacbf4/multiqc/multiqc_data/multiqc_software_versions.txt	multiqc_software_versions.txt	74	-476434961	\N	f	2024-01-31 15:04:03.288+00
3230	82	3204	original/0dc13bae-0cad-4fb9-8455-bb633dcacbf4/multiqc/multiqc_data/multiqc_sources.txt	multiqc_sources.txt	1745	-1901872803	\N	f	2024-01-31 15:04:03.288+00
3231	82	3206	original/0dc13bae-0cad-4fb9-8455-bb633dcacbf4/multiqc/multiqc_plots/pdf/mqc_featureCounts_assignment_plot_1.pdf	mqc_featureCounts_assignment_plot_1.pdf	15421	-985056196	\N	f	2024-01-31 15:04:03.288+00
3232	82	3206	original/0dc13bae-0cad-4fb9-8455-bb633dcacbf4/multiqc/multiqc_plots/pdf/mqc_featureCounts_assignment_plot_1_pc.pdf	mqc_featureCounts_assignment_plot_1_pc.pdf	16340	-773503961	\N	f	2024-01-31 15:04:03.288+00
3233	82	3206	original/0dc13bae-0cad-4fb9-8455-bb633dcacbf4/multiqc/multiqc_plots/pdf/mqc_nanostat_quality_dist_1.pdf	mqc_nanostat_quality_dist_1.pdf	14742	-1849288685	\N	f	2024-01-31 15:04:03.288+00
3234	82	3206	original/0dc13bae-0cad-4fb9-8455-bb633dcacbf4/multiqc/multiqc_plots/pdf/mqc_nanostat_quality_dist_1_pc.pdf	mqc_nanostat_quality_dist_1_pc.pdf	15186	1912540303	\N	f	2024-01-31 15:04:03.288+00
3235	82	3206	original/0dc13bae-0cad-4fb9-8455-bb633dcacbf4/multiqc/multiqc_plots/pdf/mqc_samtools_alignment_plot_1.pdf	mqc_samtools_alignment_plot_1.pdf	15764	97043160	\N	f	2024-01-31 15:04:03.284+00
3236	82	3206	original/0dc13bae-0cad-4fb9-8455-bb633dcacbf4/multiqc/multiqc_plots/pdf/mqc_samtools_alignment_plot_1_pc.pdf	mqc_samtools_alignment_plot_1_pc.pdf	16202	1343259481	\N	f	2024-01-31 15:04:03.288+00
3237	82	3207	original/0dc13bae-0cad-4fb9-8455-bb633dcacbf4/multiqc/multiqc_plots/png/mqc_featureCounts_assignment_plot_1.png	mqc_featureCounts_assignment_plot_1.png	15527	-289421736	\N	f	2024-01-31 15:04:03.284+00
3238	82	3207	original/0dc13bae-0cad-4fb9-8455-bb633dcacbf4/multiqc/multiqc_plots/png/mqc_featureCounts_assignment_plot_1_pc.png	mqc_featureCounts_assignment_plot_1_pc.png	15848	1496541439	\N	f	2024-01-31 15:04:03.284+00
3239	82	3207	original/0dc13bae-0cad-4fb9-8455-bb633dcacbf4/multiqc/multiqc_plots/png/mqc_nanostat_quality_dist_1.png	mqc_nanostat_quality_dist_1.png	12985	-1655329868	\N	f	2024-01-31 15:04:03.284+00
3240	82	3207	original/0dc13bae-0cad-4fb9-8455-bb633dcacbf4/multiqc/multiqc_plots/png/mqc_nanostat_quality_dist_1_pc.png	mqc_nanostat_quality_dist_1_pc.png	13268	-1223686780	\N	f	2024-01-31 15:04:03.284+00
3241	82	3207	original/0dc13bae-0cad-4fb9-8455-bb633dcacbf4/multiqc/multiqc_plots/png/mqc_samtools_alignment_plot_1.png	mqc_samtools_alignment_plot_1.png	12147	1450926240	\N	f	2024-01-31 15:04:03.284+00
3242	82	3207	original/0dc13bae-0cad-4fb9-8455-bb633dcacbf4/multiqc/multiqc_plots/png/mqc_samtools_alignment_plot_1_pc.png	mqc_samtools_alignment_plot_1_pc.png	12369	-645525354	\N	f	2024-01-31 15:04:03.284+00
3336	92	3328	original/d1f1db0c-f50d-4f4b-a6d8-f211a94b3215/analyses/2.tsv	2.tsv	906533	569314226	\N	f	2024-02-14 15:17:24.727+00
3243	82	3208	original/0dc13bae-0cad-4fb9-8455-bb633dcacbf4/multiqc/multiqc_plots/svg/mqc_featureCounts_assignment_plot_1.svg	mqc_featureCounts_assignment_plot_1.svg	39594	-1875498438	\N	f	2024-01-31 15:04:03.284+00
3244	82	3208	original/0dc13bae-0cad-4fb9-8455-bb633dcacbf4/multiqc/multiqc_plots/svg/mqc_featureCounts_assignment_plot_1_pc.svg	mqc_featureCounts_assignment_plot_1_pc.svg	39702	1164479779	\N	f	2024-01-31 15:04:03.284+00
3245	82	3208	original/0dc13bae-0cad-4fb9-8455-bb633dcacbf4/multiqc/multiqc_plots/svg/mqc_nanostat_quality_dist_1.svg	mqc_nanostat_quality_dist_1.svg	35592	-1238548512	\N	f	2024-01-31 15:04:03.284+00
3246	82	3208	original/0dc13bae-0cad-4fb9-8455-bb633dcacbf4/multiqc/multiqc_plots/svg/mqc_nanostat_quality_dist_1_pc.svg	mqc_nanostat_quality_dist_1_pc.svg	35551	-590634456	\N	f	2024-01-31 15:04:03.284+00
3247	82	3208	original/0dc13bae-0cad-4fb9-8455-bb633dcacbf4/multiqc/multiqc_plots/svg/mqc_samtools_alignment_plot_1.svg	mqc_samtools_alignment_plot_1.svg	31873	1219190886	\N	f	2024-01-31 15:04:03.284+00
3248	82	3208	original/0dc13bae-0cad-4fb9-8455-bb633dcacbf4/multiqc/multiqc_plots/svg/mqc_samtools_alignment_plot_1_pc.svg	mqc_samtools_alignment_plot_1_pc.svg	31907	-996470975	\N	f	2024-01-31 15:04:03.284+00
3249	82	3203	original/0dc13bae-0cad-4fb9-8455-bb633dcacbf4/multiqc/multiqc_report.html	multiqc_report.html	1270587	-1233703604	\N	f	2024-01-31 15:04:03.284+00
3250	83	\N		20240131160327740-434	2304690	\N	\N	t	2024-01-31 16:03:29.067+00
3251	83	3250	original	original	2304690	\N	\N	t	2024-01-31 16:03:28.334+00
3252	83	3251	original/BC03.fastq.gz	BC03.fastq.gz	2304690	-988696362	\N	f	2024-01-31 16:03:27.694+00
3253	84	\N		20240131160330156-437	3498984	\N	\N	t	2024-01-31 16:03:31.407+00
3254	84	3253	original	original	3498984	\N	\N	t	2024-01-31 16:03:30.735+00
3255	84	3254	original/BC02.fastq.gz	BC02.fastq.gz	3498984	-1906937404	\N	f	2024-01-31 16:03:30.123+00
3256	85	\N		20240131160332312-440	153645	\N	\N	t	2024-01-31 16:03:34.231+00
3257	85	3256	original	original	153645	\N	\N	t	2024-01-31 16:03:33.339+00
3258	85	3257	original/BC06.fastq.gz	BC06.fastq.gz	153645	-152690263	\N	f	2024-01-31 16:03:32.279+00
3259	86	\N		20240131160335838-443	435942	\N	\N	t	2024-01-31 16:03:37.524+00
3260	86	3259	original	original	435942	\N	\N	t	2024-01-31 16:03:36.784+00
3261	86	3260	original/BC05.fastq.gz	BC05.fastq.gz	435942	-1452358331	\N	f	2024-01-31 16:03:35.799+00
3262	87	\N		20240131160338918-446	1455306	\N	\N	t	2024-01-31 16:03:40.612+00
3263	87	3262	original	original	1455306	\N	\N	t	2024-01-31 16:03:39.852+00
3264	87	3263	original/BC04.fastq.gz	BC04.fastq.gz	1455306	-607296365	\N	f	2024-01-31 16:03:38.88+00
3265	88	\N		20240131160341932-449	1731016	\N	\N	t	2024-01-31 16:03:43.22+00
3266	88	3265	original	original	1731016	\N	\N	t	2024-01-31 16:03:42.52+00
3267	88	3266	original/BC01.fastq.gz	BC01.fastq.gz	1731016	-77977568	\N	f	2024-01-31 16:03:41.892+00
3268	89	\N		20240131160923116-450	5769310	\N	\N	t	2024-01-31 16:09:24.213+00
3269	89	3268	original	original	5769310	\N	\N	t	2024-01-31 16:09:23.557+00
3270	89	3269	original/GCF_000016305.1_ASM1630v1_genomic.fna	GCF_000016305.1_ASM1630v1_genomic.fna	5769310	511574305	\N	f	2024-01-31 16:09:23.077+00
3271	90	\N		20240131160924390-451	3222733	\N	\N	t	2024-01-31 16:09:25.105+00
3272	90	3271	original	original	3222733	\N	\N	t	2024-01-31 16:09:24.525+00
3273	90	3272	original/GCF_000016305.1_ASM1630v1_genomic.gff	GCF_000016305.1_ASM1630v1_genomic.gff	3222733	-1466843301	\N	f	2024-01-31 16:09:24.357+00
3274	91	\N		20240131175847611-454	5240561	\N	\N	t	2024-01-31 17:58:48.86+00
3275	91	3274	original	original	5240561	\N	\N	t	2024-01-31 17:58:47.844+00
3276	91	3275	original/0ac0d995-996c-437b-a4bd-b651a781d88b	0ac0d995-996c-437b-a4bd-b651a781d88b	5240561	\N	\N	t	2024-01-31 17:58:47.336+00
3277	91	3276	original/0ac0d995-996c-437b-a4bd-b651a781d88b/analyses	analyses	3492398	\N	\N	t	2024-01-31 17:58:47.592+00
3278	91	3276	original/0ac0d995-996c-437b-a4bd-b651a781d88b/multiqc	multiqc	1748163	\N	\N	t	2024-01-31 17:58:47.592+00
3279	91	3278	original/0ac0d995-996c-437b-a4bd-b651a781d88b/multiqc/multiqc_data	multiqc_data	87565	\N	\N	t	2024-01-31 17:58:47.596+00
3280	91	3278	original/0ac0d995-996c-437b-a4bd-b651a781d88b/multiqc/multiqc_plots	multiqc_plots	390003	\N	\N	t	2024-01-31 17:58:03+00
3281	91	3280	original/0ac0d995-996c-437b-a4bd-b651a781d88b/multiqc/multiqc_plots/pdf	pdf	93661	\N	\N	t	2024-01-31 17:58:47.596+00
3282	91	3280	original/0ac0d995-996c-437b-a4bd-b651a781d88b/multiqc/multiqc_plots/png	png	82144	\N	\N	t	2024-01-31 17:58:47.596+00
3283	91	3280	original/0ac0d995-996c-437b-a4bd-b651a781d88b/multiqc/multiqc_plots/svg	svg	214198	\N	\N	t	2024-01-31 17:58:47.592+00
3284	91	3277	original/0ac0d995-996c-437b-a4bd-b651a781d88b/analyses/MAplot_run_1_label.pdf	MAplot_run_1_label.pdf	21614	-779351801	\N	f	2024-01-31 17:58:47.588+00
3285	91	3277	original/0ac0d995-996c-437b-a4bd-b651a781d88b/analyses/MAplot_run_1_label.png	MAplot_run_1_label.png	248942	2106850235	\N	f	2024-01-31 17:58:47.584+00
3286	91	3277	original/0ac0d995-996c-437b-a4bd-b651a781d88b/analyses/MAplot_run_2_label.pdf	MAplot_run_2_label.pdf	21419	178426642	\N	f	2024-01-31 17:58:47.588+00
3287	91	3277	original/0ac0d995-996c-437b-a4bd-b651a781d88b/analyses/MAplot_run_2_label.png	MAplot_run_2_label.png	248688	-1222246763	\N	f	2024-01-31 17:58:47.588+00
3288	91	3277	original/0ac0d995-996c-437b-a4bd-b651a781d88b/analyses/MAplot_run_3_label.pdf	MAplot_run_3_label.pdf	14284	1428260491	\N	f	2024-01-31 17:58:47.588+00
3289	91	3277	original/0ac0d995-996c-437b-a4bd-b651a781d88b/analyses/MAplot_run_3_label.png	MAplot_run_3_label.png	217304	-498617691	\N	f	2024-01-31 17:58:47.588+00
3290	91	3277	original/0ac0d995-996c-437b-a4bd-b651a781d88b/analyses/run_1.tsv	run_1.tsv	901600	-1589509260	\N	f	2024-01-31 17:58:47.592+00
3291	91	3277	original/0ac0d995-996c-437b-a4bd-b651a781d88b/analyses/run_2.tsv	run_2.tsv	906530	1571981135	\N	f	2024-01-31 17:58:47.588+00
3292	91	3277	original/0ac0d995-996c-437b-a4bd-b651a781d88b/analyses/run_3.tsv	run_3.tsv	912017	301212040	\N	f	2024-01-31 17:58:47.588+00
3293	91	3278	original/0ac0d995-996c-437b-a4bd-b651a781d88b/multiqc/.snakemake_timestamp	.snakemake_timestamp	28	-184816049	\N	f	2024-01-31 17:58:47.592+00
3294	91	3279	original/0ac0d995-996c-437b-a4bd-b651a781d88b/multiqc/multiqc_data/mqc_featureCounts_assignment_plot_1.txt	mqc_featureCounts_assignment_plot_1.txt	379	1608112099	\N	f	2024-01-31 17:58:47.596+00
3295	91	3279	original/0ac0d995-996c-437b-a4bd-b651a781d88b/multiqc/multiqc_data/mqc_nanostat_quality_dist_1.txt	mqc_nanostat_quality_dist_1.txt	339	1112045195	\N	f	2024-01-31 17:58:47.596+00
3296	91	3279	original/0ac0d995-996c-437b-a4bd-b651a781d88b/multiqc/multiqc_data/mqc_samtools_alignment_plot_1.txt	mqc_samtools_alignment_plot_1.txt	213	-11358954	\N	f	2024-01-31 17:58:47.596+00
3297	91	3279	original/0ac0d995-996c-437b-a4bd-b651a781d88b/multiqc/multiqc_data/multiqc.log	multiqc.log	5438	-193348969	\N	f	2024-01-31 17:58:47.596+00
3298	91	3279	original/0ac0d995-996c-437b-a4bd-b651a781d88b/multiqc/multiqc_data/multiqc_citations.txt	multiqc_citations.txt	281	-1846624025	\N	f	2024-01-31 17:58:47.596+00
3299	91	3279	original/0ac0d995-996c-437b-a4bd-b651a781d88b/multiqc/multiqc_data/multiqc_data.json	multiqc_data.json	73478	-1890716367	\N	f	2024-01-31 17:58:47.596+00
3300	91	3279	original/0ac0d995-996c-437b-a4bd-b651a781d88b/multiqc/multiqc_data/multiqc_featureCounts.txt	multiqc_featureCounts.txt	801	-56125193	\N	f	2024-01-31 17:58:47.596+00
3301	91	3279	original/0ac0d995-996c-437b-a4bd-b651a781d88b/multiqc/multiqc_data/multiqc_general_stats.txt	multiqc_general_stats.txt	1251	1535192414	\N	f	2024-01-31 17:58:47.596+00
3302	91	3279	original/0ac0d995-996c-437b-a4bd-b651a781d88b/multiqc/multiqc_data/multiqc_nanostat.txt	multiqc_nanostat.txt	750	682070401	\N	f	2024-01-31 17:58:47.596+00
3303	91	3279	original/0ac0d995-996c-437b-a4bd-b651a781d88b/multiqc/multiqc_data/multiqc_samtools_stats.txt	multiqc_samtools_stats.txt	2816	1646884636	\N	f	2024-01-31 17:58:47.596+00
3304	91	3279	original/0ac0d995-996c-437b-a4bd-b651a781d88b/multiqc/multiqc_data/multiqc_software_versions.txt	multiqc_software_versions.txt	74	1919419837	\N	f	2024-01-31 17:58:47.596+00
3305	91	3279	original/0ac0d995-996c-437b-a4bd-b651a781d88b/multiqc/multiqc_data/multiqc_sources.txt	multiqc_sources.txt	1745	-1925817613	\N	f	2024-01-31 17:58:47.596+00
3306	91	3281	original/0ac0d995-996c-437b-a4bd-b651a781d88b/multiqc/multiqc_plots/pdf/mqc_featureCounts_assignment_plot_1.pdf	mqc_featureCounts_assignment_plot_1.pdf	15421	1620112225	\N	f	2024-01-31 17:58:47.596+00
3307	91	3281	original/0ac0d995-996c-437b-a4bd-b651a781d88b/multiqc/multiqc_plots/pdf/mqc_featureCounts_assignment_plot_1_pc.pdf	mqc_featureCounts_assignment_plot_1_pc.pdf	16340	-1332421617	\N	f	2024-01-31 17:58:47.596+00
3308	91	3281	original/0ac0d995-996c-437b-a4bd-b651a781d88b/multiqc/multiqc_plots/pdf/mqc_nanostat_quality_dist_1.pdf	mqc_nanostat_quality_dist_1.pdf	14749	-117723756	\N	f	2024-01-31 17:58:47.596+00
3309	91	3281	original/0ac0d995-996c-437b-a4bd-b651a781d88b/multiqc/multiqc_plots/pdf/mqc_nanostat_quality_dist_1_pc.pdf	mqc_nanostat_quality_dist_1_pc.pdf	15185	-854019076	\N	f	2024-01-31 17:58:47.596+00
3310	91	3281	original/0ac0d995-996c-437b-a4bd-b651a781d88b/multiqc/multiqc_plots/pdf/mqc_samtools_alignment_plot_1.pdf	mqc_samtools_alignment_plot_1.pdf	15764	-402909519	\N	f	2024-01-31 17:58:47.596+00
3311	91	3281	original/0ac0d995-996c-437b-a4bd-b651a781d88b/multiqc/multiqc_plots/pdf/mqc_samtools_alignment_plot_1_pc.pdf	mqc_samtools_alignment_plot_1_pc.pdf	16202	2092075576	\N	f	2024-01-31 17:58:47.596+00
3312	91	3282	original/0ac0d995-996c-437b-a4bd-b651a781d88b/multiqc/multiqc_plots/png/mqc_featureCounts_assignment_plot_1.png	mqc_featureCounts_assignment_plot_1.png	15527	-1814767352	\N	f	2024-01-31 17:58:47.596+00
3313	91	3282	original/0ac0d995-996c-437b-a4bd-b651a781d88b/multiqc/multiqc_plots/png/mqc_featureCounts_assignment_plot_1_pc.png	mqc_featureCounts_assignment_plot_1_pc.png	15848	-102694013	\N	f	2024-01-31 17:58:47.592+00
3314	91	3282	original/0ac0d995-996c-437b-a4bd-b651a781d88b/multiqc/multiqc_plots/png/mqc_nanostat_quality_dist_1.png	mqc_nanostat_quality_dist_1.png	12985	-2089786480	\N	f	2024-01-31 17:58:47.596+00
3315	91	3282	original/0ac0d995-996c-437b-a4bd-b651a781d88b/multiqc/multiqc_plots/png/mqc_nanostat_quality_dist_1_pc.png	mqc_nanostat_quality_dist_1_pc.png	13268	-724930167	\N	f	2024-01-31 17:58:47.596+00
3316	91	3282	original/0ac0d995-996c-437b-a4bd-b651a781d88b/multiqc/multiqc_plots/png/mqc_samtools_alignment_plot_1.png	mqc_samtools_alignment_plot_1.png	12147	-1558214728	\N	f	2024-01-31 17:58:47.596+00
3317	91	3282	original/0ac0d995-996c-437b-a4bd-b651a781d88b/multiqc/multiqc_plots/png/mqc_samtools_alignment_plot_1_pc.png	mqc_samtools_alignment_plot_1_pc.png	12369	1398826491	\N	f	2024-01-31 17:58:47.592+00
3318	91	3283	original/0ac0d995-996c-437b-a4bd-b651a781d88b/multiqc/multiqc_plots/svg/mqc_featureCounts_assignment_plot_1.svg	mqc_featureCounts_assignment_plot_1.svg	39594	-1904610159	\N	f	2024-01-31 17:58:47.592+00
3319	91	3283	original/0ac0d995-996c-437b-a4bd-b651a781d88b/multiqc/multiqc_plots/svg/mqc_featureCounts_assignment_plot_1_pc.svg	mqc_featureCounts_assignment_plot_1_pc.svg	39702	-756354954	\N	f	2024-01-31 17:58:47.592+00
3320	91	3283	original/0ac0d995-996c-437b-a4bd-b651a781d88b/multiqc/multiqc_plots/svg/mqc_nanostat_quality_dist_1.svg	mqc_nanostat_quality_dist_1.svg	35583	1122059121	\N	f	2024-01-31 17:58:47.592+00
3321	91	3283	original/0ac0d995-996c-437b-a4bd-b651a781d88b/multiqc/multiqc_plots/svg/mqc_nanostat_quality_dist_1_pc.svg	mqc_nanostat_quality_dist_1_pc.svg	35539	404884186	\N	f	2024-01-31 17:58:47.592+00
3322	91	3283	original/0ac0d995-996c-437b-a4bd-b651a781d88b/multiqc/multiqc_plots/svg/mqc_samtools_alignment_plot_1.svg	mqc_samtools_alignment_plot_1.svg	31873	1262148136	\N	f	2024-01-31 17:58:47.592+00
3323	91	3283	original/0ac0d995-996c-437b-a4bd-b651a781d88b/multiqc/multiqc_plots/svg/mqc_samtools_alignment_plot_1_pc.svg	mqc_samtools_alignment_plot_1_pc.svg	31907	-635984995	\N	f	2024-01-31 17:58:47.592+00
3324	91	3278	original/0ac0d995-996c-437b-a4bd-b651a781d88b/multiqc/multiqc_report.html	multiqc_report.html	1270567	-697207705	\N	f	2024-01-31 17:58:47.592+00
3325	92	\N		20240214151724750-459	5241811	\N	\N	t	2024-02-14 15:17:26.235+00
3326	92	3325	original	original	5241811	\N	\N	t	2024-02-14 15:17:24.987+00
3327	92	3326	original/d1f1db0c-f50d-4f4b-a6d8-f211a94b3215	d1f1db0c-f50d-4f4b-a6d8-f211a94b3215	5241811	\N	\N	t	2024-02-14 15:17:24.207+00
3328	92	3327	original/d1f1db0c-f50d-4f4b-a6d8-f211a94b3215/analyses	analyses	3491542	\N	\N	t	2024-02-14 15:17:24.731+00
3329	92	3327	original/d1f1db0c-f50d-4f4b-a6d8-f211a94b3215/multiqc	multiqc	1750269	\N	\N	t	2024-02-14 15:17:24.731+00
3330	92	3329	original/d1f1db0c-f50d-4f4b-a6d8-f211a94b3215/multiqc/multiqc_data	multiqc_data	88561	\N	\N	t	2024-02-14 15:17:24.735+00
3331	92	3329	original/d1f1db0c-f50d-4f4b-a6d8-f211a94b3215/multiqc/multiqc_plots	multiqc_plots	390017	\N	\N	t	2024-02-14 15:16:50+00
3332	92	3331	original/d1f1db0c-f50d-4f4b-a6d8-f211a94b3215/multiqc/multiqc_plots/pdf	pdf	93652	\N	\N	t	2024-02-14 15:17:24.735+00
3333	92	3331	original/d1f1db0c-f50d-4f4b-a6d8-f211a94b3215/multiqc/multiqc_plots/png	png	82146	\N	\N	t	2024-02-14 15:17:24.735+00
3334	92	3331	original/d1f1db0c-f50d-4f4b-a6d8-f211a94b3215/multiqc/multiqc_plots/svg	svg	214219	\N	\N	t	2024-02-14 15:17:24.731+00
3335	92	3328	original/d1f1db0c-f50d-4f4b-a6d8-f211a94b3215/analyses/1.tsv	1.tsv	901426	1016944231	\N	f	2024-02-14 15:17:24.727+00
3337	92	3328	original/d1f1db0c-f50d-4f4b-a6d8-f211a94b3215/analyses/3.tsv	3.tsv	912083	1623906678	\N	f	2024-02-14 15:17:24.727+00
3338	92	3328	original/d1f1db0c-f50d-4f4b-a6d8-f211a94b3215/analyses/MAplot_1_label.pdf	MAplot_1_label.pdf	21380	-1336830964	\N	f	2024-02-14 15:17:24.723+00
3339	92	3328	original/d1f1db0c-f50d-4f4b-a6d8-f211a94b3215/analyses/MAplot_1_label.png	MAplot_1_label.png	248833	-1616010974	\N	f	2024-02-14 15:17:24.731+00
3340	92	3328	original/d1f1db0c-f50d-4f4b-a6d8-f211a94b3215/analyses/MAplot_2_label.pdf	MAplot_2_label.pdf	21492	-1240242807	\N	f	2024-02-14 15:17:24.727+00
3341	92	3328	original/d1f1db0c-f50d-4f4b-a6d8-f211a94b3215/analyses/MAplot_2_label.png	MAplot_2_label.png	248262	-1572004457	\N	f	2024-02-14 15:17:24.723+00
3342	92	3328	original/d1f1db0c-f50d-4f4b-a6d8-f211a94b3215/analyses/MAplot_3_label.pdf	MAplot_3_label.pdf	14435	-815714939	\N	f	2024-02-14 15:17:24.727+00
3343	92	3328	original/d1f1db0c-f50d-4f4b-a6d8-f211a94b3215/analyses/MAplot_3_label.png	MAplot_3_label.png	217098	2021265025	\N	f	2024-02-14 15:17:24.727+00
3344	92	3329	original/d1f1db0c-f50d-4f4b-a6d8-f211a94b3215/multiqc/.snakemake_timestamp	.snakemake_timestamp	28	-1811493955	\N	f	2024-02-14 15:17:24.731+00
3345	92	3330	original/d1f1db0c-f50d-4f4b-a6d8-f211a94b3215/multiqc/multiqc_data/mqc_featureCounts_assignment_plot_1.txt	mqc_featureCounts_assignment_plot_1.txt	379	1886586768	\N	f	2024-02-14 15:17:24.735+00
3346	92	3330	original/d1f1db0c-f50d-4f4b-a6d8-f211a94b3215/multiqc/multiqc_data/mqc_nanostat_quality_dist_1.txt	mqc_nanostat_quality_dist_1.txt	339	1325043534	\N	f	2024-02-14 15:17:24.735+00
3347	92	3330	original/d1f1db0c-f50d-4f4b-a6d8-f211a94b3215/multiqc/multiqc_data/mqc_samtools_alignment_plot_1.txt	mqc_samtools_alignment_plot_1.txt	213	-137300882	\N	f	2024-02-14 15:17:24.735+00
3348	92	3330	original/d1f1db0c-f50d-4f4b-a6d8-f211a94b3215/multiqc/multiqc_data/multiqc.log	multiqc.log	5967	515198486	\N	f	2024-02-14 15:17:24.735+00
3349	92	3330	original/d1f1db0c-f50d-4f4b-a6d8-f211a94b3215/multiqc/multiqc_data/multiqc_citations.txt	multiqc_citations.txt	281	-627968381	\N	f	2024-02-14 15:17:24.735+00
3350	92	3330	original/d1f1db0c-f50d-4f4b-a6d8-f211a94b3215/multiqc/multiqc_data/multiqc_data.json	multiqc_data.json	73493	-1402575563	\N	f	2024-02-14 15:17:24.735+00
3351	92	3330	original/d1f1db0c-f50d-4f4b-a6d8-f211a94b3215/multiqc/multiqc_data/multiqc_featureCounts.txt	multiqc_featureCounts.txt	801	948489847	\N	f	2024-02-14 15:17:24.735+00
3352	92	3330	original/d1f1db0c-f50d-4f4b-a6d8-f211a94b3215/multiqc/multiqc_data/multiqc_general_stats.txt	multiqc_general_stats.txt	1251	2026901172	\N	f	2024-02-14 15:17:24.735+00
3353	92	3330	original/d1f1db0c-f50d-4f4b-a6d8-f211a94b3215/multiqc/multiqc_data/multiqc_nanostat.txt	multiqc_nanostat.txt	750	825665745	\N	f	2024-02-14 15:17:24.735+00
3354	92	3330	original/d1f1db0c-f50d-4f4b-a6d8-f211a94b3215/multiqc/multiqc_data/multiqc_samtools_stats.txt	multiqc_samtools_stats.txt	2816	1566564674	\N	f	2024-02-14 15:17:24.735+00
3355	92	3330	original/d1f1db0c-f50d-4f4b-a6d8-f211a94b3215/multiqc/multiqc_data/multiqc_software_versions.txt	multiqc_software_versions.txt	511	-446236368	\N	f	2024-02-14 15:17:24.735+00
3356	92	3330	original/d1f1db0c-f50d-4f4b-a6d8-f211a94b3215/multiqc/multiqc_data/multiqc_sources.txt	multiqc_sources.txt	1760	-332415467	\N	f	2024-02-14 15:17:24.735+00
3357	92	3332	original/d1f1db0c-f50d-4f4b-a6d8-f211a94b3215/multiqc/multiqc_plots/pdf/mqc_featureCounts_assignment_plot_1.pdf	mqc_featureCounts_assignment_plot_1.pdf	15420	-1218839325	\N	f	2024-02-14 15:17:24.735+00
3358	92	3332	original/d1f1db0c-f50d-4f4b-a6d8-f211a94b3215/multiqc/multiqc_plots/pdf/mqc_featureCounts_assignment_plot_1_pc.pdf	mqc_featureCounts_assignment_plot_1_pc.pdf	16337	1174500690	\N	f	2024-02-14 15:17:24.735+00
3359	92	3332	original/d1f1db0c-f50d-4f4b-a6d8-f211a94b3215/multiqc/multiqc_plots/pdf/mqc_nanostat_quality_dist_1.pdf	mqc_nanostat_quality_dist_1.pdf	14742	1566340664	\N	f	2024-02-14 15:17:24.735+00
3360	92	3332	original/d1f1db0c-f50d-4f4b-a6d8-f211a94b3215/multiqc/multiqc_plots/pdf/mqc_nanostat_quality_dist_1_pc.pdf	mqc_nanostat_quality_dist_1_pc.pdf	15187	1575197384	\N	f	2024-02-14 15:17:24.735+00
3361	92	3332	original/d1f1db0c-f50d-4f4b-a6d8-f211a94b3215/multiqc/multiqc_plots/pdf/mqc_samtools_alignment_plot_1.pdf	mqc_samtools_alignment_plot_1.pdf	15764	717540592	\N	f	2024-02-14 15:17:24.735+00
3362	92	3332	original/d1f1db0c-f50d-4f4b-a6d8-f211a94b3215/multiqc/multiqc_plots/pdf/mqc_samtools_alignment_plot_1_pc.pdf	mqc_samtools_alignment_plot_1_pc.pdf	16202	-677907132	\N	f	2024-02-14 15:17:24.735+00
3363	92	3333	original/d1f1db0c-f50d-4f4b-a6d8-f211a94b3215/multiqc/multiqc_plots/png/mqc_featureCounts_assignment_plot_1.png	mqc_featureCounts_assignment_plot_1.png	15528	-1731166753	\N	f	2024-02-14 15:17:24.731+00
3364	92	3333	original/d1f1db0c-f50d-4f4b-a6d8-f211a94b3215/multiqc/multiqc_plots/png/mqc_featureCounts_assignment_plot_1_pc.png	mqc_featureCounts_assignment_plot_1_pc.png	15849	1562400128	\N	f	2024-02-14 15:17:24.731+00
3365	92	3333	original/d1f1db0c-f50d-4f4b-a6d8-f211a94b3215/multiqc/multiqc_plots/png/mqc_nanostat_quality_dist_1.png	mqc_nanostat_quality_dist_1.png	12985	1916724959	\N	f	2024-02-14 15:17:24.735+00
3366	92	3333	original/d1f1db0c-f50d-4f4b-a6d8-f211a94b3215/multiqc/multiqc_plots/png/mqc_nanostat_quality_dist_1_pc.png	mqc_nanostat_quality_dist_1_pc.png	13268	1967467692	\N	f	2024-02-14 15:17:24.735+00
3367	92	3333	original/d1f1db0c-f50d-4f4b-a6d8-f211a94b3215/multiqc/multiqc_plots/png/mqc_samtools_alignment_plot_1.png	mqc_samtools_alignment_plot_1.png	12147	-364267077	\N	f	2024-02-14 15:17:24.735+00
3368	92	3333	original/d1f1db0c-f50d-4f4b-a6d8-f211a94b3215/multiqc/multiqc_plots/png/mqc_samtools_alignment_plot_1_pc.png	mqc_samtools_alignment_plot_1_pc.png	12369	923405727	\N	f	2024-02-14 15:17:24.731+00
3369	92	3334	original/d1f1db0c-f50d-4f4b-a6d8-f211a94b3215/multiqc/multiqc_plots/svg/mqc_featureCounts_assignment_plot_1.svg	mqc_featureCounts_assignment_plot_1.svg	39606	-1268806252	\N	f	2024-02-14 15:17:24.731+00
3370	92	3334	original/d1f1db0c-f50d-4f4b-a6d8-f211a94b3215/multiqc/multiqc_plots/svg/mqc_featureCounts_assignment_plot_1_pc.svg	mqc_featureCounts_assignment_plot_1_pc.svg	39706	1235533666	\N	f	2024-02-14 15:17:24.731+00
3371	92	3334	original/d1f1db0c-f50d-4f4b-a6d8-f211a94b3215/multiqc/multiqc_plots/svg/mqc_nanostat_quality_dist_1.svg	mqc_nanostat_quality_dist_1.svg	35584	-1484833532	\N	f	2024-02-14 15:17:24.731+00
3372	92	3334	original/d1f1db0c-f50d-4f4b-a6d8-f211a94b3215/multiqc/multiqc_plots/svg/mqc_nanostat_quality_dist_1_pc.svg	mqc_nanostat_quality_dist_1_pc.svg	35543	-1396155933	\N	f	2024-02-14 15:17:24.731+00
3373	92	3334	original/d1f1db0c-f50d-4f4b-a6d8-f211a94b3215/multiqc/multiqc_plots/svg/mqc_samtools_alignment_plot_1.svg	mqc_samtools_alignment_plot_1.svg	31873	-510544859	\N	f	2024-02-14 15:17:24.731+00
3374	92	3334	original/d1f1db0c-f50d-4f4b-a6d8-f211a94b3215/multiqc/multiqc_plots/svg/mqc_samtools_alignment_plot_1_pc.svg	mqc_samtools_alignment_plot_1_pc.svg	31907	61033531	\N	f	2024-02-14 15:17:24.731+00
3375	92	3329	original/d1f1db0c-f50d-4f4b-a6d8-f211a94b3215/multiqc/multiqc_report.html	multiqc_report.html	1271663	1580575456	\N	f	2024-02-14 15:17:24.731+00
\.


--
-- Data for Name: data_sets; Type: TABLE DATA; Schema: public; Owner: openbis
--

COPY public.data_sets (id, code, location) FROM stdin;
7	20220916105315990-43	65970533-6343-475C-AFBC-30AA379B4C5D/89/b2/60/20220916105315990-43
8	20220916105318900-46	65970533-6343-475C-AFBC-30AA379B4C5D/e3/ba/bb/20220916105318900-46
9	20220916105408646-47	65970533-6343-475C-AFBC-30AA379B4C5D/a3/4f/d0/20220916105408646-47
10	20220916105409958-48	65970533-6343-475C-AFBC-30AA379B4C5D/08/f3/97/20220916105409958-48
11	20220916111346647-53	65970533-6343-475C-AFBC-30AA379B4C5D/51/fe/39/20220916111346647-53
12	20220916111349528-56	65970533-6343-475C-AFBC-30AA379B4C5D/4e/eb/06/20220916111349528-56
13	20220916112128074-57	65970533-6343-475C-AFBC-30AA379B4C5D/50/a9/ee/20220916112128074-57
14	20220916112130140-58	65970533-6343-475C-AFBC-30AA379B4C5D/9f/64/68/20220916112130140-58
15	20220916143849160-65	65970533-6343-475C-AFBC-30AA379B4C5D/d6/10/1a/20220916143849160-65
16	20220916143849849-66	65970533-6343-475C-AFBC-30AA379B4C5D/39/89/78/20220916143849849-66
17	20220916144035060-68	65970533-6343-475C-AFBC-30AA379B4C5D/ae/28/e9/20220916144035060-68
18	20220916144035778-69	65970533-6343-475C-AFBC-30AA379B4C5D/58/ce/37/20220916144035778-69
19	20220923133926119-79	65970533-6343-475C-AFBC-30AA379B4C5D/03/67/1a/20220923133926119-79
20	20220927093228519-107	65970533-6343-475C-AFBC-30AA379B4C5D/5f/67/5f/20220927093228519-107
21	20220927093229273-108	65970533-6343-475C-AFBC-30AA379B4C5D/7c/97/b7/20220927093229273-108
22	20220927103713198-119	65970533-6343-475C-AFBC-30AA379B4C5D/be/b0/cf/20220927103713198-119
23	20220927104912276-122	65970533-6343-475C-AFBC-30AA379B4C5D/c2/f9/8b/20220927104912276-122
24	20220927105045929-125	65970533-6343-475C-AFBC-30AA379B4C5D/8c/6b/85/20220927105045929-125
25	20220927111304581-128	65970533-6343-475C-AFBC-30AA379B4C5D/2b/fe/92/20220927111304581-128
26	20220927114625096-131	65970533-6343-475C-AFBC-30AA379B4C5D/60/9c/b0/20220927114625096-131
27	20220927120757138-134	65970533-6343-475C-AFBC-30AA379B4C5D/1b/00/44/20220927120757138-134
28	20220927122151806-137	65970533-6343-475C-AFBC-30AA379B4C5D/59/3b/fe/20220927122151806-137
29	20220927122613289-140	65970533-6343-475C-AFBC-30AA379B4C5D/30/30/49/20220927122613289-140
30	20220927123024021-143	65970533-6343-475C-AFBC-30AA379B4C5D/db/0c/43/20220927123024021-143
31	20220927123744843-144	65970533-6343-475C-AFBC-30AA379B4C5D/56/0f/d1/20220927123744843-144
32	20220927123746366-145	65970533-6343-475C-AFBC-30AA379B4C5D/c0/b0/9e/20220927123746366-145
44	20220929095430350-208	65970533-6343-475C-AFBC-30AA379B4C5D/b9/03/c0/20220929095430350-208
45	20220929095432198-209	65970533-6343-475C-AFBC-30AA379B4C5D/4a/9b/6c/20220929095432198-209
46	20220929105444307-213	65970533-6343-475C-AFBC-30AA379B4C5D/1d/75/18/20220929105444307-213
47	20220929105446165-214	65970533-6343-475C-AFBC-30AA379B4C5D/34/68/3a/20220929105446165-214
48	20220929123528711-232	65970533-6343-475C-AFBC-30AA379B4C5D/b1/58/45/20220929123528711-232
49	20220929123837937-235	65970533-6343-475C-AFBC-30AA379B4C5D/a3/fd/1f/20220929123837937-235
50	20220929133507343-238	65970533-6343-475C-AFBC-30AA379B4C5D/7a/92/ad/20220929133507343-238
51	20220929133835249-241	65970533-6343-475C-AFBC-30AA379B4C5D/22/77/e4/20220929133835249-241
52	20220929134055217-245	65970533-6343-475C-AFBC-30AA379B4C5D/9b/71/4f/20220929134055217-245
53	20220929134124772-248	65970533-6343-475C-AFBC-30AA379B4C5D/1d/0e/7d/20220929134124772-248
54	20220929134316852-251	65970533-6343-475C-AFBC-30AA379B4C5D/84/76/bf/20220929134316852-251
55	20220929134333235-254	65970533-6343-475C-AFBC-30AA379B4C5D/15/75/c5/20220929134333235-254
56	20220929134517601-257	65970533-6343-475C-AFBC-30AA379B4C5D/d0/64/99/20220929134517601-257
57	20220929134532603-260	65970533-6343-475C-AFBC-30AA379B4C5D/83/4c/3b/20220929134532603-260
58	20220929134708170-263	65970533-6343-475C-AFBC-30AA379B4C5D/48/a7/52/20220929134708170-263
59	20220929134758760-264	65970533-6343-475C-AFBC-30AA379B4C5D/23/29/63/20220929134758760-264
60	20220929134800095-265	65970533-6343-475C-AFBC-30AA379B4C5D/dd/5b/06/20220929134800095-265
61	20230614121938319-271	65970533-6343-475C-AFBC-30AA379B4C5D/c3/2b/52/20230614121938319-271
64	20230616120342632-276	65970533-6343-475C-AFBC-30AA379B4C5D/cf/13/ac/20230616120342632-276
65	20230718093749840-320	65970533-6343-475C-AFBC-30AA379B4C5D/c8/61/3a/20230718093749840-320
66	20240125084137156-341	65970533-6343-475C-AFBC-30AA379B4C5D/1e/57/61/20240125084137156-341
67	20240125084141149-344	65970533-6343-475C-AFBC-30AA379B4C5D/8a/1f/bc/20240125084141149-344
68	20240125084144342-347	65970533-6343-475C-AFBC-30AA379B4C5D/84/a3/c0/20240125084144342-347
69	20240125084147019-350	65970533-6343-475C-AFBC-30AA379B4C5D/f0/e3/29/20240125084147019-350
70	20240125084424209-351	65970533-6343-475C-AFBC-30AA379B4C5D/ff/8a/f9/20240125084424209-351
71	20240125085509644-352	65970533-6343-475C-AFBC-30AA379B4C5D/4e/24/4c/20240125085509644-352
72	20240125105136495-354	65970533-6343-475C-AFBC-30AA379B4C5D/63/d3/b8/20240125105136495-354
73	20240125105229725-355	65970533-6343-475C-AFBC-30AA379B4C5D/f2/0a/c1/20240125105229725-355
74	20240126140501918-384	65970533-6343-475C-AFBC-30AA379B4C5D/69/cd/23/20240126140501918-384
75	20240126140503801-387	65970533-6343-475C-AFBC-30AA379B4C5D/a9/76/7a/20240126140503801-387
76	20240126140505796-390	65970533-6343-475C-AFBC-30AA379B4C5D/bc/20/71/20240126140505796-390
77	20240126140507557-393	65970533-6343-475C-AFBC-30AA379B4C5D/7d/f4/1e/20240126140507557-393
78	20240126140508690-396	65970533-6343-475C-AFBC-30AA379B4C5D/b4/72/12/20240126140508690-396
79	20240126140509811-399	65970533-6343-475C-AFBC-30AA379B4C5D/bf/99/78/20240126140509811-399
80	20240126140600399-400	65970533-6343-475C-AFBC-30AA379B4C5D/20/d7/eb/20240126140600399-400
81	20240126140601830-401	65970533-6343-475C-AFBC-30AA379B4C5D/36/c8/e8/20240126140601830-401
82	20240131150403511-412	65970533-6343-475C-AFBC-30AA379B4C5D/d3/4b/48/20240131150403511-412
83	20240131160327740-434	65970533-6343-475C-AFBC-30AA379B4C5D/7f/e1/43/20240131160327740-434
84	20240131160330156-437	65970533-6343-475C-AFBC-30AA379B4C5D/80/5e/db/20240131160330156-437
85	20240131160332312-440	65970533-6343-475C-AFBC-30AA379B4C5D/04/c4/e3/20240131160332312-440
86	20240131160335838-443	65970533-6343-475C-AFBC-30AA379B4C5D/47/75/7c/20240131160335838-443
87	20240131160338918-446	65970533-6343-475C-AFBC-30AA379B4C5D/aa/b4/27/20240131160338918-446
88	20240131160341932-449	65970533-6343-475C-AFBC-30AA379B4C5D/9a/67/d6/20240131160341932-449
89	20240131160923116-450	65970533-6343-475C-AFBC-30AA379B4C5D/f9/23/92/20240131160923116-450
90	20240131160924390-451	65970533-6343-475C-AFBC-30AA379B4C5D/89/be/40/20240131160924390-451
91	20240131175847611-454	65970533-6343-475C-AFBC-30AA379B4C5D/f5/b7/25/20240131175847611-454
92	20240214151724750-459	65970533-6343-475C-AFBC-30AA379B4C5D/c8/dc/8b/20240214151724750-459
\.


--
-- Data for Name: database_version_logs; Type: TABLE DATA; Schema: public; Owner: openbis
--

COPY public.database_version_logs (db_version, module_name, run_status, run_status_timestamp, module_code, run_exception) FROM stdin;
009	datastore_server/sql/postgresql/009/schema-009.sql	SUCCESS	2022-08-12 12:14:10.814	\\x0a2f2a202d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d202a2f0a2f2a20446f6d61696e73202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202a2f0a2f2a202d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d202a2f0a0a43524541544520444f4d41494e20544543485f494420415320424947494e543b0a0a43524541544520444f4d41494e20434f44452041532056415243484152283630293b0a0a43524541544520444f4d41494e2046494c455f5041544820415320564152434841522831303030293b0a0a43524541544520444f4d41494e20424f4f4c45414e5f4348415220415320424f4f4c45414e2044454641554c542046414c53453b0a0a43524541544520444f4d41494e2054494d455f5354414d502041532054494d455354414d5020574954482054494d45205a4f4e453b0a0a0a2f2a202d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d202a2f0a2f2a205461626c657320202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202a2f0a2f2a202d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d202a2f0a0a435245415445205441424c4520444154415f5345545320280a202049442042494753455249414c204e4f54204e554c4c2c0a2020434f444520434f4445204e4f54204e554c4c2c0a20204c4f434154494f4e2046494c455f50415448204e4f54204e554c4c2c0a0a20205052494d415259204b455920284944292c0a2020554e495155452028434f4445290a293b0a0a43524541544520494e44455820444154415f534554535f434f44455f494458204f4e20444154415f534554532028434f4445293b0a0a435245415445205441424c4520444154415f5345545f46494c455320280a202049442042494753455249414c204e4f54204e554c4c2c0a2020444153455f494420544543485f4944204e4f54204e554c4c2c0a2020504152454e545f494420544543485f49442c0a202052454c41544956455f504154482046494c455f50415448204e4f54204e554c4c2c0a202046494c455f4e414d452046494c455f50415448204e4f54204e554c4c2c0a202053495a455f494e5f425954455320424947494e54204e4f54204e554c4c2c0a2020434845434b53554d5f435243333220494e54454745522c0a2020434845434b53554d20544558542c0a202049535f4449524543544f525920424f4f4c45414e5f43484152204e4f54204e554c4c2c0a20204c4153545f4d4f4449464945442054494d455f5354414d50204e4f54204e554c4c2044454641554c54204e4f5728292c0a0a20205052494d415259204b455920284944292c0a2020434f4e53545241494e5420464b5f444154415f5345545f46494c45535f444154415f5345545320464f524549474e204b45592028444153455f494429205245464552454e43455320444154415f534554532028494429204f4e2044454c4554452043415343414445204f4e2055504441544520434153434144450a293b0a0a43524541544520494e44455820444154415f5345545f46494c45535f444153455f49445f494458204f4e20444154415f5345545f46494c45532028444153455f4944293b0a43524541544520494e44455820444154415f5345545f46494c45535f444153455f49445f504152454e545f49445f494458204f4e20444154415f5345545f46494c45532028444153455f49442c20504152454e545f4944293b0a43524541544520494e44455820444154415f5345545f46494c45535f444153455f49445f52454c41544956455f504154485f494458204f4e20444154415f5345545f46494c45532028444153455f49442c2052454c41544956455f50415448293b0a43524541544520494e44455820444154415f5345545f46494c45535f444153455f49445f46494c455f4e414d455f494458204f4e20444154415f5345545f46494c45532028444153455f49442c2046494c455f4e414d45293b0a0a435245415445205441424c45204556454e545320280a20204c4153545f5345454e5f44454c4554494f4e5f4556454e545f494420544543485f4944204e4f54204e554c4c0a293b0a0a435245415445205441424c45204c4153545f46454544494e475f4556454e5420280a2020524547495354524154494f4e5f54494d455354414d502054494d455f5354414d50204e4f54204e554c4c0a293b0a0a	\N
\.


--
-- Data for Name: events; Type: TABLE DATA; Schema: public; Owner: openbis
--

COPY public.events (last_seen_deletion_event_id) FROM stdin;
49
\.


--
-- Data for Name: last_feeding_event; Type: TABLE DATA; Schema: public; Owner: openbis
--

COPY public.last_feeding_event (registration_timestamp) FROM stdin;
\.


--
-- Name: data_set_files_id_seq; Type: SEQUENCE SET; Schema: public; Owner: openbis
--

SELECT pg_catalog.setval('public.data_set_files_id_seq', 3375, true);


--
-- Name: data_sets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: openbis
--

SELECT pg_catalog.setval('public.data_sets_id_seq', 92, true);


--
-- Name: data_set_files data_set_files_pkey; Type: CONSTRAINT; Schema: public; Owner: openbis
--

ALTER TABLE ONLY public.data_set_files
    ADD CONSTRAINT data_set_files_pkey PRIMARY KEY (id);


--
-- Name: data_sets data_sets_code_key; Type: CONSTRAINT; Schema: public; Owner: openbis
--

ALTER TABLE ONLY public.data_sets
    ADD CONSTRAINT data_sets_code_key UNIQUE (code);


--
-- Name: data_sets data_sets_pkey; Type: CONSTRAINT; Schema: public; Owner: openbis
--

ALTER TABLE ONLY public.data_sets
    ADD CONSTRAINT data_sets_pkey PRIMARY KEY (id);


--
-- Name: data_set_files_dase_id_file_name_idx; Type: INDEX; Schema: public; Owner: openbis
--

CREATE INDEX data_set_files_dase_id_file_name_idx ON public.data_set_files USING btree (dase_id, file_name);


--
-- Name: data_set_files_dase_id_idx; Type: INDEX; Schema: public; Owner: openbis
--

CREATE INDEX data_set_files_dase_id_idx ON public.data_set_files USING btree (dase_id);


--
-- Name: data_set_files_dase_id_parent_id_idx; Type: INDEX; Schema: public; Owner: openbis
--

CREATE INDEX data_set_files_dase_id_parent_id_idx ON public.data_set_files USING btree (dase_id, parent_id);


--
-- Name: data_set_files_dase_id_relative_path_idx; Type: INDEX; Schema: public; Owner: openbis
--

CREATE INDEX data_set_files_dase_id_relative_path_idx ON public.data_set_files USING btree (dase_id, relative_path);


--
-- Name: data_sets_code_idx; Type: INDEX; Schema: public; Owner: openbis
--

CREATE INDEX data_sets_code_idx ON public.data_sets USING btree (code);


--
-- Name: data_set_files fk_data_set_files_data_sets; Type: FK CONSTRAINT; Schema: public; Owner: openbis
--

ALTER TABLE ONLY public.data_set_files
    ADD CONSTRAINT fk_data_set_files_data_sets FOREIGN KEY (dase_id) REFERENCES public.data_sets(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

