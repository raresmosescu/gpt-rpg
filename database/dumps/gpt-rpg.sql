--
-- PostgreSQL database dump
--

-- Dumped from database version 14.6 (Homebrew)
-- Dumped by pg_dump version 14.6 (Homebrew)

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
-- Name: aerich; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.aerich (
    id integer NOT NULL,
    version character varying(255) NOT NULL,
    app character varying(100) NOT NULL,
    content jsonb NOT NULL
);


ALTER TABLE public.aerich OWNER TO postgres;

--
-- Name: aerich_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.aerich_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.aerich_id_seq OWNER TO postgres;

--
-- Name: aerich_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.aerich_id_seq OWNED BY public.aerich.id;


--
-- Name: backstory; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.backstory (
    id integer NOT NULL,
    text character varying(1000) NOT NULL
);


ALTER TABLE public.backstory OWNER TO postgres;

--
-- Name: backstory_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.backstory_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.backstory_id_seq OWNER TO postgres;

--
-- Name: backstory_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.backstory_id_seq OWNED BY public.backstory.id;


--
-- Name: character; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."character" (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    backstory character varying(1000),
    current_objective character varying(1000),
    is_player boolean DEFAULT false NOT NULL
);


ALTER TABLE public."character" OWNER TO postgres;

--
-- Name: character_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.character_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.character_id_seq OWNER TO postgres;

--
-- Name: character_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.character_id_seq OWNED BY public."character".id;


--
-- Name: character_trait; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.character_trait (
    character_id integer NOT NULL,
    trait_id integer NOT NULL
);


ALTER TABLE public.character_trait OWNER TO postgres;

--
-- Name: conversation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.conversation (
    id integer NOT NULL,
    message character varying(1000) NOT NULL,
    "timestamp" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    receiver_id integer NOT NULL,
    sender_id integer NOT NULL
);


ALTER TABLE public.conversation OWNER TO postgres;

--
-- Name: conversation_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.conversation_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.conversation_id_seq OWNER TO postgres;

--
-- Name: conversation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.conversation_id_seq OWNED BY public.conversation.id;


--
-- Name: event; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.event (
    id integer NOT NULL,
    event_type character varying(50) NOT NULL,
    description character varying(1000),
    source_character_id integer,
    target_character_id integer
);


ALTER TABLE public.event OWNER TO postgres;

--
-- Name: event_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.event_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.event_id_seq OWNER TO postgres;

--
-- Name: event_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.event_id_seq OWNED BY public.event.id;


--
-- Name: goal; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.goal (
    id integer NOT NULL,
    name character varying(100) NOT NULL
);


ALTER TABLE public.goal OWNER TO postgres;

--
-- Name: goal_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.goal_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.goal_id_seq OWNER TO postgres;

--
-- Name: goal_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.goal_id_seq OWNED BY public.goal.id;


--
-- Name: message; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.message (
    id integer NOT NULL,
    role character varying(50),
    text text NOT NULL,
    "timestamp" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    receiver_id integer NOT NULL,
    sender_id integer NOT NULL
);


ALTER TABLE public.message OWNER TO postgres;

--
-- Name: message_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.message_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.message_id_seq OWNER TO postgres;

--
-- Name: message_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.message_id_seq OWNED BY public.message.id;


--
-- Name: relationship; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.relationship (
    id integer NOT NULL,
    type character varying(50) NOT NULL,
    char1_id integer NOT NULL,
    char2_id integer NOT NULL
);


ALTER TABLE public.relationship OWNER TO postgres;

--
-- Name: relationship_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.relationship_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.relationship_id_seq OWNER TO postgres;

--
-- Name: relationship_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.relationship_id_seq OWNED BY public.relationship.id;


--
-- Name: trait; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.trait (
    id integer NOT NULL,
    name character varying(100) NOT NULL
);


ALTER TABLE public.trait OWNER TO postgres;

--
-- Name: TABLE trait; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.trait IS 'A trait is a single property of a personality.';


--
-- Name: trait_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.trait_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.trait_id_seq OWNER TO postgres;

--
-- Name: trait_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.trait_id_seq OWNED BY public.trait.id;


--
-- Name: aerich id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aerich ALTER COLUMN id SET DEFAULT nextval('public.aerich_id_seq'::regclass);


--
-- Name: backstory id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backstory ALTER COLUMN id SET DEFAULT nextval('public.backstory_id_seq'::regclass);


--
-- Name: character id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."character" ALTER COLUMN id SET DEFAULT nextval('public.character_id_seq'::regclass);


--
-- Name: conversation id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conversation ALTER COLUMN id SET DEFAULT nextval('public.conversation_id_seq'::regclass);


--
-- Name: event id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event ALTER COLUMN id SET DEFAULT nextval('public.event_id_seq'::regclass);


--
-- Name: goal id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.goal ALTER COLUMN id SET DEFAULT nextval('public.goal_id_seq'::regclass);


--
-- Name: message id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.message ALTER COLUMN id SET DEFAULT nextval('public.message_id_seq'::regclass);


--
-- Name: relationship id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.relationship ALTER COLUMN id SET DEFAULT nextval('public.relationship_id_seq'::regclass);


--
-- Name: trait id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trait ALTER COLUMN id SET DEFAULT nextval('public.trait_id_seq'::regclass);


--
-- Data for Name: aerich; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.aerich (id, version, app, content) FROM stdin;
1	0_20230414010948_init.py	npc	{"npc.Goal": {"app": "npc", "name": "npc.Goal", "table": "goal", "indexes": [], "abstract": false, "pk_field": {"name": "id", "unique": true, "default": null, "indexed": true, "nullable": false, "db_column": "id", "docstring": null, "generated": true, "field_type": "IntField", "constraints": {"ge": 1, "le": 2147483647}, "description": null, "python_type": "int", "db_field_types": {"": "INT"}}, "docstring": null, "fk_fields": [], "m2m_fields": [], "o2o_fields": [], "data_fields": [{"name": "name", "unique": false, "default": null, "indexed": false, "nullable": false, "db_column": "name", "docstring": null, "generated": false, "field_type": "CharField", "constraints": {"max_length": 100}, "description": null, "python_type": "str", "db_field_types": {"": "VARCHAR(100)"}}], "description": null, "unique_together": [], "backward_fk_fields": [], "backward_o2o_fields": []}, "npc.Trait": {"app": "npc", "name": "npc.Trait", "table": "trait", "indexes": [], "abstract": false, "pk_field": {"name": "id", "unique": true, "default": null, "indexed": true, "nullable": false, "db_column": "id", "docstring": null, "generated": true, "field_type": "IntField", "constraints": {"ge": 1, "le": 2147483647}, "description": null, "python_type": "int", "db_field_types": {"": "INT"}}, "docstring": "A trait is a single property of a personality.\\n\\nName should be a valid trait name.", "fk_fields": [], "m2m_fields": [{"name": "characters", "unique": false, "default": null, "indexed": false, "through": "character_trait", "nullable": false, "docstring": null, "generated": false, "on_delete": "CASCADE", "_generated": true, "field_type": "ManyToManyFieldInstance", "model_name": "npc.Character", "constraints": {}, "description": null, "forward_key": "character_id", "python_type": "npc.Character", "backward_key": "trait_id", "related_name": "traits", "db_constraint": true}], "o2o_fields": [], "data_fields": [{"name": "name", "unique": false, "default": null, "indexed": false, "nullable": false, "db_column": "name", "docstring": null, "generated": false, "field_type": "CharField", "constraints": {"max_length": 100}, "description": null, "python_type": "str", "db_field_types": {"": "VARCHAR(100)"}}], "description": "A trait is a single property of a personality.", "unique_together": [], "backward_fk_fields": [], "backward_o2o_fields": []}, "npc.Backstory": {"app": "npc", "name": "npc.Backstory", "table": "backstory", "indexes": [], "abstract": false, "pk_field": {"name": "id", "unique": true, "default": null, "indexed": true, "nullable": false, "db_column": "id", "docstring": null, "generated": true, "field_type": "IntField", "constraints": {"ge": 1, "le": 2147483647}, "description": null, "python_type": "int", "db_field_types": {"": "INT"}}, "docstring": null, "fk_fields": [], "m2m_fields": [], "o2o_fields": [], "data_fields": [{"name": "text", "unique": false, "default": null, "indexed": false, "nullable": false, "db_column": "text", "docstring": null, "generated": false, "field_type": "CharField", "constraints": {"max_length": 1000}, "description": null, "python_type": "str", "db_field_types": {"": "VARCHAR(1000)"}}], "description": null, "unique_together": [], "backward_fk_fields": [], "backward_o2o_fields": []}, "npc.Character": {"app": "npc", "name": "npc.Character", "table": "character", "indexes": [], "abstract": false, "pk_field": {"name": "id", "unique": true, "default": null, "indexed": true, "nullable": false, "db_column": "id", "docstring": null, "generated": true, "field_type": "IntField", "constraints": {"ge": 1, "le": 2147483647}, "description": null, "python_type": "int", "db_field_types": {"": "INT"}}, "docstring": null, "fk_fields": [], "m2m_fields": [{"name": "traits", "unique": false, "default": null, "indexed": false, "through": "character_trait", "nullable": false, "docstring": null, "generated": false, "on_delete": "CASCADE", "_generated": false, "field_type": "ManyToManyFieldInstance", "model_name": "npc.Trait", "constraints": {}, "description": null, "forward_key": "trait_id", "python_type": "npc.Trait", "backward_key": "character_id", "related_name": "characters", "db_constraint": true}, {"name": "relationships", "unique": false, "default": null, "indexed": false, "through": "relationship", "nullable": false, "docstring": null, "generated": false, "on_delete": "CASCADE", "_generated": false, "field_type": "ManyToManyFieldInstance", "model_name": "npc.Character", "constraints": {}, "description": null, "forward_key": "character_id", "python_type": "npc.Character", "backward_key": "character_rel_id", "related_name": "related_to", "db_constraint": true}, {"name": "related_to", "unique": false, "default": null, "indexed": false, "through": "relationship", "nullable": false, "docstring": null, "generated": false, "on_delete": "CASCADE", "_generated": true, "field_type": "ManyToManyFieldInstance", "model_name": "npc.Character", "constraints": {}, "description": null, "forward_key": "character_rel_id", "python_type": "npc.Character", "backward_key": "character_id", "related_name": "relationships", "db_constraint": true}], "o2o_fields": [], "data_fields": [{"name": "name", "unique": true, "default": null, "indexed": true, "nullable": false, "db_column": "name", "docstring": null, "generated": false, "field_type": "CharField", "constraints": {"max_length": 100}, "description": null, "python_type": "str", "db_field_types": {"": "VARCHAR(100)"}}, {"name": "backstory", "unique": false, "default": null, "indexed": false, "nullable": false, "db_column": "backstory", "docstring": null, "generated": false, "field_type": "CharField", "constraints": {"max_length": 1000}, "description": null, "python_type": "str", "db_field_types": {"": "VARCHAR(1000)"}}, {"name": "current_objective", "unique": false, "default": null, "indexed": false, "nullable": true, "db_column": "current_objective", "docstring": null, "generated": false, "field_type": "CharField", "constraints": {"max_length": 1000}, "description": null, "python_type": "str", "db_field_types": {"": "VARCHAR(1000)"}}], "description": null, "unique_together": [], "backward_fk_fields": [{"name": "char1_relationships", "unique": false, "default": null, "indexed": false, "nullable": false, "docstring": null, "generated": false, "field_type": "BackwardFKRelation", "constraints": {}, "description": null, "python_type": "npc.Relationship", "db_constraint": true}, {"name": "char2_relationships", "unique": false, "default": null, "indexed": false, "nullable": false, "docstring": null, "generated": false, "field_type": "BackwardFKRelation", "constraints": {}, "description": null, "python_type": "npc.Relationship", "db_constraint": true}, {"name": "events_as_source", "unique": false, "default": null, "indexed": false, "nullable": true, "docstring": null, "generated": false, "field_type": "BackwardFKRelation", "constraints": {}, "description": null, "python_type": "event_system.Event", "db_constraint": true}, {"name": "events_as_target", "unique": false, "default": null, "indexed": false, "nullable": true, "docstring": null, "generated": false, "field_type": "BackwardFKRelation", "constraints": {}, "description": null, "python_type": "event_system.Event", "db_constraint": true}], "backward_o2o_fields": []}, "npc.Relationship": {"app": "npc", "name": "npc.Relationship", "table": "relationship", "indexes": [], "abstract": false, "pk_field": {"name": "id", "unique": true, "default": null, "indexed": true, "nullable": false, "db_column": "id", "docstring": null, "generated": true, "field_type": "IntField", "constraints": {"ge": 1, "le": 2147483647}, "description": null, "python_type": "int", "db_field_types": {"": "INT"}}, "docstring": null, "fk_fields": [{"name": "char1", "unique": false, "default": null, "indexed": false, "nullable": false, "docstring": null, "generated": false, "on_delete": "CASCADE", "raw_field": "char1_id", "field_type": "ForeignKeyFieldInstance", "constraints": {}, "description": null, "python_type": "npc.Character", "db_constraint": true}, {"name": "char2", "unique": false, "default": null, "indexed": false, "nullable": false, "docstring": null, "generated": false, "on_delete": "CASCADE", "raw_field": "char2_id", "field_type": "ForeignKeyFieldInstance", "constraints": {}, "description": null, "python_type": "npc.Character", "db_constraint": true}], "m2m_fields": [], "o2o_fields": [], "data_fields": [{"name": "type", "unique": false, "default": null, "indexed": false, "nullable": false, "db_column": "type", "docstring": null, "generated": false, "field_type": "CharField", "constraints": {"max_length": 50}, "description": null, "python_type": "str", "db_field_types": {"": "VARCHAR(50)"}}, {"name": "char1_id", "unique": false, "default": null, "indexed": false, "nullable": false, "db_column": "char1_id", "docstring": null, "generated": false, "field_type": "IntField", "constraints": {"ge": 1, "le": 2147483647}, "description": null, "python_type": "int", "db_field_types": {"": "INT"}}, {"name": "char2_id", "unique": false, "default": null, "indexed": false, "nullable": false, "db_column": "char2_id", "docstring": null, "generated": false, "field_type": "IntField", "constraints": {"ge": 1, "le": 2147483647}, "description": null, "python_type": "int", "db_field_types": {"": "INT"}}], "description": null, "unique_together": [], "backward_fk_fields": [], "backward_o2o_fields": []}}
2	1_20230414021854_update.py	npc	{"npc.Goal": {"app": "npc", "name": "npc.Goal", "table": "goal", "indexes": [], "abstract": false, "pk_field": {"name": "id", "unique": true, "default": null, "indexed": true, "nullable": false, "db_column": "id", "docstring": null, "generated": true, "field_type": "IntField", "constraints": {"ge": 1, "le": 2147483647}, "description": null, "python_type": "int", "db_field_types": {"": "INT"}}, "docstring": null, "fk_fields": [], "m2m_fields": [], "o2o_fields": [], "data_fields": [{"name": "name", "unique": false, "default": null, "indexed": false, "nullable": false, "db_column": "name", "docstring": null, "generated": false, "field_type": "CharField", "constraints": {"max_length": 100}, "description": null, "python_type": "str", "db_field_types": {"": "VARCHAR(100)"}}], "description": null, "unique_together": [], "backward_fk_fields": [], "backward_o2o_fields": []}, "npc.Trait": {"app": "npc", "name": "npc.Trait", "table": "trait", "indexes": [], "abstract": false, "pk_field": {"name": "id", "unique": true, "default": null, "indexed": true, "nullable": false, "db_column": "id", "docstring": null, "generated": true, "field_type": "IntField", "constraints": {"ge": 1, "le": 2147483647}, "description": null, "python_type": "int", "db_field_types": {"": "INT"}}, "docstring": "A trait is a single property of a personality.\\n\\nName should be a valid trait name.", "fk_fields": [], "m2m_fields": [{"name": "characters", "unique": false, "default": null, "indexed": false, "through": "character_trait", "nullable": false, "docstring": null, "generated": false, "on_delete": "CASCADE", "_generated": true, "field_type": "ManyToManyFieldInstance", "model_name": "npc.Character", "constraints": {}, "description": null, "forward_key": "character_id", "python_type": "npc.Character", "backward_key": "trait_id", "related_name": "traits", "db_constraint": true}], "o2o_fields": [], "data_fields": [{"name": "name", "unique": false, "default": null, "indexed": false, "nullable": false, "db_column": "name", "docstring": null, "generated": false, "field_type": "CharField", "constraints": {"max_length": 100}, "description": null, "python_type": "str", "db_field_types": {"": "VARCHAR(100)"}}], "description": "A trait is a single property of a personality.", "unique_together": [], "backward_fk_fields": [], "backward_o2o_fields": []}, "npc.Backstory": {"app": "npc", "name": "npc.Backstory", "table": "backstory", "indexes": [], "abstract": false, "pk_field": {"name": "id", "unique": true, "default": null, "indexed": true, "nullable": false, "db_column": "id", "docstring": null, "generated": true, "field_type": "IntField", "constraints": {"ge": 1, "le": 2147483647}, "description": null, "python_type": "int", "db_field_types": {"": "INT"}}, "docstring": null, "fk_fields": [], "m2m_fields": [], "o2o_fields": [], "data_fields": [{"name": "text", "unique": false, "default": null, "indexed": false, "nullable": false, "db_column": "text", "docstring": null, "generated": false, "field_type": "CharField", "constraints": {"max_length": 1000}, "description": null, "python_type": "str", "db_field_types": {"": "VARCHAR(1000)"}}], "description": null, "unique_together": [], "backward_fk_fields": [], "backward_o2o_fields": []}, "npc.Character": {"app": "npc", "name": "npc.Character", "table": "character", "indexes": [], "abstract": false, "pk_field": {"name": "id", "unique": true, "default": null, "indexed": true, "nullable": false, "db_column": "id", "docstring": null, "generated": true, "field_type": "IntField", "constraints": {"ge": 1, "le": 2147483647}, "description": null, "python_type": "int", "db_field_types": {"": "INT"}}, "docstring": null, "fk_fields": [], "m2m_fields": [{"name": "traits", "unique": false, "default": null, "indexed": false, "through": "character_trait", "nullable": false, "docstring": null, "generated": false, "on_delete": "CASCADE", "_generated": false, "field_type": "ManyToManyFieldInstance", "model_name": "npc.Trait", "constraints": {}, "description": null, "forward_key": "trait_id", "python_type": "npc.Trait", "backward_key": "character_id", "related_name": "characters", "db_constraint": true}, {"name": "relationships", "unique": false, "default": null, "indexed": false, "through": "relationship", "nullable": false, "docstring": null, "generated": false, "on_delete": "CASCADE", "_generated": false, "field_type": "ManyToManyFieldInstance", "model_name": "npc.Character", "constraints": {}, "description": null, "forward_key": "character_id", "python_type": "npc.Character", "backward_key": "character_rel_id", "related_name": "related_to", "db_constraint": true}, {"name": "related_to", "unique": false, "default": null, "indexed": false, "through": "relationship", "nullable": false, "docstring": null, "generated": false, "on_delete": "CASCADE", "_generated": true, "field_type": "ManyToManyFieldInstance", "model_name": "npc.Character", "constraints": {}, "description": null, "forward_key": "character_rel_id", "python_type": "npc.Character", "backward_key": "character_id", "related_name": "relationships", "db_constraint": true}], "o2o_fields": [], "data_fields": [{"name": "name", "unique": true, "default": null, "indexed": true, "nullable": false, "db_column": "name", "docstring": null, "generated": false, "field_type": "CharField", "constraints": {"max_length": 100}, "description": null, "python_type": "str", "db_field_types": {"": "VARCHAR(100)"}}, {"name": "backstory", "unique": false, "default": null, "indexed": false, "nullable": true, "db_column": "backstory", "docstring": null, "generated": false, "field_type": "CharField", "constraints": {"max_length": 1000}, "description": null, "python_type": "str", "db_field_types": {"": "VARCHAR(1000)"}}, {"name": "current_objective", "unique": false, "default": null, "indexed": false, "nullable": true, "db_column": "current_objective", "docstring": null, "generated": false, "field_type": "CharField", "constraints": {"max_length": 1000}, "description": null, "python_type": "str", "db_field_types": {"": "VARCHAR(1000)"}}], "description": null, "unique_together": [], "backward_fk_fields": [{"name": "char1_relationships", "unique": false, "default": null, "indexed": false, "nullable": false, "docstring": null, "generated": false, "field_type": "BackwardFKRelation", "constraints": {}, "description": null, "python_type": "npc.Relationship", "db_constraint": true}, {"name": "char2_relationships", "unique": false, "default": null, "indexed": false, "nullable": false, "docstring": null, "generated": false, "field_type": "BackwardFKRelation", "constraints": {}, "description": null, "python_type": "npc.Relationship", "db_constraint": true}, {"name": "events_as_source", "unique": false, "default": null, "indexed": false, "nullable": true, "docstring": null, "generated": false, "field_type": "BackwardFKRelation", "constraints": {}, "description": null, "python_type": "event_system.Event", "db_constraint": true}, {"name": "events_as_target", "unique": false, "default": null, "indexed": false, "nullable": true, "docstring": null, "generated": false, "field_type": "BackwardFKRelation", "constraints": {}, "description": null, "python_type": "event_system.Event", "db_constraint": true}], "backward_o2o_fields": []}, "npc.Relationship": {"app": "npc", "name": "npc.Relationship", "table": "relationship", "indexes": [], "abstract": false, "pk_field": {"name": "id", "unique": true, "default": null, "indexed": true, "nullable": false, "db_column": "id", "docstring": null, "generated": true, "field_type": "IntField", "constraints": {"ge": 1, "le": 2147483647}, "description": null, "python_type": "int", "db_field_types": {"": "INT"}}, "docstring": null, "fk_fields": [{"name": "char1", "unique": false, "default": null, "indexed": false, "nullable": false, "docstring": null, "generated": false, "on_delete": "CASCADE", "raw_field": "char1_id", "field_type": "ForeignKeyFieldInstance", "constraints": {}, "description": null, "python_type": "npc.Character", "db_constraint": true}, {"name": "char2", "unique": false, "default": null, "indexed": false, "nullable": false, "docstring": null, "generated": false, "on_delete": "CASCADE", "raw_field": "char2_id", "field_type": "ForeignKeyFieldInstance", "constraints": {}, "description": null, "python_type": "npc.Character", "db_constraint": true}], "m2m_fields": [], "o2o_fields": [], "data_fields": [{"name": "type", "unique": false, "default": null, "indexed": false, "nullable": false, "db_column": "type", "docstring": null, "generated": false, "field_type": "CharField", "constraints": {"max_length": 50}, "description": null, "python_type": "str", "db_field_types": {"": "VARCHAR(50)"}}, {"name": "char1_id", "unique": false, "default": null, "indexed": false, "nullable": false, "db_column": "char1_id", "docstring": null, "generated": false, "field_type": "IntField", "constraints": {"ge": 1, "le": 2147483647}, "description": null, "python_type": "int", "db_field_types": {"": "INT"}}, {"name": "char2_id", "unique": false, "default": null, "indexed": false, "nullable": false, "db_column": "char2_id", "docstring": null, "generated": false, "field_type": "IntField", "constraints": {"ge": 1, "le": 2147483647}, "description": null, "python_type": "int", "db_field_types": {"": "INT"}}], "description": null, "unique_together": [], "backward_fk_fields": [], "backward_o2o_fields": []}}
3	2_20230414122634_update.py	npc	{"npc.Goal": {"app": "npc", "name": "npc.Goal", "table": "goal", "indexes": [], "abstract": false, "pk_field": {"name": "id", "unique": true, "default": null, "indexed": true, "nullable": false, "db_column": "id", "docstring": null, "generated": true, "field_type": "IntField", "constraints": {"ge": 1, "le": 2147483647}, "description": null, "python_type": "int", "db_field_types": {"": "INT"}}, "docstring": null, "fk_fields": [], "m2m_fields": [], "o2o_fields": [], "data_fields": [{"name": "name", "unique": false, "default": null, "indexed": false, "nullable": false, "db_column": "name", "docstring": null, "generated": false, "field_type": "CharField", "constraints": {"max_length": 100}, "description": null, "python_type": "str", "db_field_types": {"": "VARCHAR(100)"}}], "description": null, "unique_together": [], "backward_fk_fields": [], "backward_o2o_fields": []}, "npc.Trait": {"app": "npc", "name": "npc.Trait", "table": "trait", "indexes": [], "abstract": false, "pk_field": {"name": "id", "unique": true, "default": null, "indexed": true, "nullable": false, "db_column": "id", "docstring": null, "generated": true, "field_type": "IntField", "constraints": {"ge": 1, "le": 2147483647}, "description": null, "python_type": "int", "db_field_types": {"": "INT"}}, "docstring": "A trait is a single property of a personality.\\n\\nName should be a valid trait name.", "fk_fields": [], "m2m_fields": [{"name": "characters", "unique": false, "default": null, "indexed": false, "through": "character_trait", "nullable": false, "docstring": null, "generated": false, "on_delete": "CASCADE", "_generated": true, "field_type": "ManyToManyFieldInstance", "model_name": "npc.Character", "constraints": {}, "description": null, "forward_key": "character_id", "python_type": "npc.Character", "backward_key": "trait_id", "related_name": "traits", "db_constraint": true}], "o2o_fields": [], "data_fields": [{"name": "name", "unique": false, "default": null, "indexed": false, "nullable": false, "db_column": "name", "docstring": null, "generated": false, "field_type": "CharField", "constraints": {"max_length": 100}, "description": null, "python_type": "str", "db_field_types": {"": "VARCHAR(100)"}}], "description": "A trait is a single property of a personality.", "unique_together": [], "backward_fk_fields": [], "backward_o2o_fields": []}, "npc.Message": {"app": "npc", "name": "npc.Message", "table": "message", "indexes": [], "abstract": false, "pk_field": {"name": "id", "unique": true, "default": null, "indexed": true, "nullable": false, "db_column": "id", "docstring": null, "generated": true, "field_type": "IntField", "constraints": {"ge": 1, "le": 2147483647}, "description": null, "python_type": "int", "db_field_types": {"": "INT"}}, "docstring": null, "fk_fields": [{"name": "sender", "unique": false, "default": null, "indexed": false, "nullable": false, "docstring": null, "generated": false, "on_delete": "CASCADE", "raw_field": "sender_id", "field_type": "ForeignKeyFieldInstance", "constraints": {}, "description": null, "python_type": "npc.Character", "db_constraint": true}, {"name": "receiver", "unique": false, "default": null, "indexed": false, "nullable": false, "docstring": null, "generated": false, "on_delete": "CASCADE", "raw_field": "receiver_id", "field_type": "ForeignKeyFieldInstance", "constraints": {}, "description": null, "python_type": "npc.Character", "db_constraint": true}], "m2m_fields": [], "o2o_fields": [], "data_fields": [{"name": "role", "unique": false, "default": null, "indexed": false, "nullable": true, "db_column": "role", "docstring": null, "generated": false, "field_type": "CharField", "constraints": {"max_length": 50}, "description": null, "python_type": "str", "db_field_types": {"": "VARCHAR(50)"}}, {"name": "text", "unique": false, "default": null, "indexed": false, "nullable": false, "db_column": "text", "docstring": null, "generated": false, "field_type": "TextField", "constraints": {}, "description": null, "python_type": "str", "db_field_types": {"": "TEXT", "mssql": "NVARCHAR(MAX)", "mysql": "LONGTEXT", "oracle": "NCLOB"}}, {"name": "timestamp", "unique": false, "default": null, "indexed": false, "auto_now": false, "nullable": false, "db_column": "timestamp", "docstring": null, "generated": false, "field_type": "DatetimeField", "constraints": {"readOnly": true}, "description": null, "python_type": "datetime.datetime", "auto_now_add": true, "db_field_types": {"": "TIMESTAMP", "mssql": "DATETIME2", "mysql": "DATETIME(6)", "oracle": "TIMESTAMP WITH TIME ZONE", "postgres": "TIMESTAMPTZ"}}, {"name": "receiver_id", "unique": false, "default": null, "indexed": false, "nullable": false, "db_column": "receiver_id", "docstring": null, "generated": false, "field_type": "IntField", "constraints": {"ge": 1, "le": 2147483647}, "description": null, "python_type": "int", "db_field_types": {"": "INT"}}, {"name": "sender_id", "unique": false, "default": null, "indexed": false, "nullable": false, "db_column": "sender_id", "docstring": null, "generated": false, "field_type": "IntField", "constraints": {"ge": 1, "le": 2147483647}, "description": null, "python_type": "int", "db_field_types": {"": "INT"}}], "description": null, "unique_together": [], "backward_fk_fields": [], "backward_o2o_fields": []}, "npc.Backstory": {"app": "npc", "name": "npc.Backstory", "table": "backstory", "indexes": [], "abstract": false, "pk_field": {"name": "id", "unique": true, "default": null, "indexed": true, "nullable": false, "db_column": "id", "docstring": null, "generated": true, "field_type": "IntField", "constraints": {"ge": 1, "le": 2147483647}, "description": null, "python_type": "int", "db_field_types": {"": "INT"}}, "docstring": null, "fk_fields": [], "m2m_fields": [], "o2o_fields": [], "data_fields": [{"name": "text", "unique": false, "default": null, "indexed": false, "nullable": false, "db_column": "text", "docstring": null, "generated": false, "field_type": "CharField", "constraints": {"max_length": 1000}, "description": null, "python_type": "str", "db_field_types": {"": "VARCHAR(1000)"}}], "description": null, "unique_together": [], "backward_fk_fields": [], "backward_o2o_fields": []}, "npc.Character": {"app": "npc", "name": "npc.Character", "table": "character", "indexes": [], "abstract": false, "pk_field": {"name": "id", "unique": true, "default": null, "indexed": true, "nullable": false, "db_column": "id", "docstring": null, "generated": true, "field_type": "IntField", "constraints": {"ge": 1, "le": 2147483647}, "description": null, "python_type": "int", "db_field_types": {"": "INT"}}, "docstring": null, "fk_fields": [], "m2m_fields": [{"name": "traits", "unique": false, "default": null, "indexed": false, "through": "character_trait", "nullable": false, "docstring": null, "generated": false, "on_delete": "CASCADE", "_generated": false, "field_type": "ManyToManyFieldInstance", "model_name": "npc.Trait", "constraints": {}, "description": null, "forward_key": "trait_id", "python_type": "npc.Trait", "backward_key": "character_id", "related_name": "characters", "db_constraint": true}, {"name": "relationships", "unique": false, "default": null, "indexed": false, "through": "relationship", "nullable": false, "docstring": null, "generated": false, "on_delete": "CASCADE", "_generated": false, "field_type": "ManyToManyFieldInstance", "model_name": "npc.Character", "constraints": {}, "description": null, "forward_key": "character_id", "python_type": "npc.Character", "backward_key": "character_rel_id", "related_name": "related_to", "db_constraint": true}, {"name": "related_to", "unique": false, "default": null, "indexed": false, "through": "relationship", "nullable": false, "docstring": null, "generated": false, "on_delete": "CASCADE", "_generated": true, "field_type": "ManyToManyFieldInstance", "model_name": "npc.Character", "constraints": {}, "description": null, "forward_key": "character_rel_id", "python_type": "npc.Character", "backward_key": "character_id", "related_name": "relationships", "db_constraint": true}], "o2o_fields": [], "data_fields": [{"name": "name", "unique": true, "default": null, "indexed": true, "nullable": false, "db_column": "name", "docstring": null, "generated": false, "field_type": "CharField", "constraints": {"max_length": 100}, "description": null, "python_type": "str", "db_field_types": {"": "VARCHAR(100)"}}, {"name": "backstory", "unique": false, "default": null, "indexed": false, "nullable": true, "db_column": "backstory", "docstring": null, "generated": false, "field_type": "CharField", "constraints": {"max_length": 1000}, "description": null, "python_type": "str", "db_field_types": {"": "VARCHAR(1000)"}}, {"name": "current_objective", "unique": false, "default": null, "indexed": false, "nullable": true, "db_column": "current_objective", "docstring": null, "generated": false, "field_type": "CharField", "constraints": {"max_length": 1000}, "description": null, "python_type": "str", "db_field_types": {"": "VARCHAR(1000)"}}, {"name": "is_player", "unique": false, "default": false, "indexed": false, "nullable": false, "db_column": "is_player", "docstring": null, "generated": false, "field_type": "BooleanField", "constraints": {}, "description": null, "python_type": "bool", "db_field_types": {"": "BOOL", "mssql": "BIT", "oracle": "NUMBER(1)", "sqlite": "INT"}}], "description": null, "unique_together": [], "backward_fk_fields": [{"name": "receiver", "unique": false, "default": null, "indexed": false, "nullable": false, "docstring": null, "generated": false, "field_type": "BackwardFKRelation", "constraints": {}, "description": null, "python_type": "npc.Message", "db_constraint": true}, {"name": "sender", "unique": false, "default": null, "indexed": false, "nullable": false, "docstring": null, "generated": false, "field_type": "BackwardFKRelation", "constraints": {}, "description": null, "python_type": "npc.Message", "db_constraint": true}, {"name": "char1_relationships", "unique": false, "default": null, "indexed": false, "nullable": false, "docstring": null, "generated": false, "field_type": "BackwardFKRelation", "constraints": {}, "description": null, "python_type": "npc.Relationship", "db_constraint": true}, {"name": "char2_relationships", "unique": false, "default": null, "indexed": false, "nullable": false, "docstring": null, "generated": false, "field_type": "BackwardFKRelation", "constraints": {}, "description": null, "python_type": "npc.Relationship", "db_constraint": true}, {"name": "events_as_source", "unique": false, "default": null, "indexed": false, "nullable": true, "docstring": null, "generated": false, "field_type": "BackwardFKRelation", "constraints": {}, "description": null, "python_type": "event_system.Event", "db_constraint": true}, {"name": "events_as_target", "unique": false, "default": null, "indexed": false, "nullable": true, "docstring": null, "generated": false, "field_type": "BackwardFKRelation", "constraints": {}, "description": null, "python_type": "event_system.Event", "db_constraint": true}], "backward_o2o_fields": []}, "npc.Relationship": {"app": "npc", "name": "npc.Relationship", "table": "relationship", "indexes": [], "abstract": false, "pk_field": {"name": "id", "unique": true, "default": null, "indexed": true, "nullable": false, "db_column": "id", "docstring": null, "generated": true, "field_type": "IntField", "constraints": {"ge": 1, "le": 2147483647}, "description": null, "python_type": "int", "db_field_types": {"": "INT"}}, "docstring": null, "fk_fields": [{"name": "char1", "unique": false, "default": null, "indexed": false, "nullable": false, "docstring": null, "generated": false, "on_delete": "CASCADE", "raw_field": "char1_id", "field_type": "ForeignKeyFieldInstance", "constraints": {}, "description": null, "python_type": "npc.Character", "db_constraint": true}, {"name": "char2", "unique": false, "default": null, "indexed": false, "nullable": false, "docstring": null, "generated": false, "on_delete": "CASCADE", "raw_field": "char2_id", "field_type": "ForeignKeyFieldInstance", "constraints": {}, "description": null, "python_type": "npc.Character", "db_constraint": true}], "m2m_fields": [], "o2o_fields": [], "data_fields": [{"name": "type", "unique": false, "default": null, "indexed": false, "nullable": false, "db_column": "type", "docstring": null, "generated": false, "field_type": "CharField", "constraints": {"max_length": 50}, "description": null, "python_type": "str", "db_field_types": {"": "VARCHAR(50)"}}, {"name": "char1_id", "unique": false, "default": null, "indexed": false, "nullable": false, "db_column": "char1_id", "docstring": null, "generated": false, "field_type": "IntField", "constraints": {"ge": 1, "le": 2147483647}, "description": null, "python_type": "int", "db_field_types": {"": "INT"}}, {"name": "char2_id", "unique": false, "default": null, "indexed": false, "nullable": false, "db_column": "char2_id", "docstring": null, "generated": false, "field_type": "IntField", "constraints": {"ge": 1, "le": 2147483647}, "description": null, "python_type": "int", "db_field_types": {"": "INT"}}], "description": null, "unique_together": [], "backward_fk_fields": [], "backward_o2o_fields": []}}
\.


--
-- Data for Name: backstory; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.backstory (id, text) FROM stdin;
\.


--
-- Data for Name: character; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."character" (id, name, backstory, current_objective, is_player) FROM stdin;
8	John	Retired military commander. Hates the village leadership.	Become village leader	f
3	Soarez	Carpenter	He wants to get over his wife cheating on him with the neighbor.	f
9	Jane	Blacksmith woman	Grow her blacksmithing business.	f
12	Patrocle	A manly peasant. All women love him.	Wants to get rid of Ana, because she caused a lot of troubles for him since her husband found out about their affair.	f
11	Ana	Soarez ex-wife. She cheated him with their neighbor, Patrocle.	Wants to find true love.	f
10	Ion	The current village leader. Gained his power through stealing and fear.	Wants to crush any who dare challenge his authority.	f
2	Rares	This is the player. He creates his own story.	Explore this village and earn some money to get back on the road.	t
1	Andrei	Son of the village leader. A spoiled brat with no common sense and no competence.	Become village leader	f
\.


--
-- Data for Name: character_trait; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.character_trait (character_id, trait_id) FROM stdin;
2	2
2	3
2	4
3	5
3	6
3	7
1	5
1	3
\.


--
-- Data for Name: conversation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.conversation (id, message, "timestamp", receiver_id, sender_id) FROM stdin;
\.


--
-- Data for Name: event; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.event (id, event_type, description, source_character_id, target_character_id) FROM stdin;
1	start_game	\N	\N	\N
2	start_game	\N	\N	\N
3	start_game	\N	\N	\N
4	start_game	\N	\N	\N
5	start_game	\N	\N	\N
6	start_game	\N	\N	\N
7	start_game	\N	\N	\N
8	start_game	\N	\N	\N
9	start_game	\N	\N	\N
10	start_game	\N	\N	\N
11	start_game	\N	\N	\N
12	start_game	\N	\N	\N
13	start_game	\N	\N	\N
14	start_game	\N	\N	\N
15	start_game	\N	\N	\N
16	start_game	\N	\N	\N
17	start_game	\N	\N	\N
18	start_game	\N	\N	\N
19	start_game	\N	\N	\N
20	start_game	\N	\N	\N
21	start_game	\N	\N	\N
22	start_game	\N	\N	\N
23	start_game	\N	\N	\N
24	start_game	\N	\N	\N
25	start_game	\N	\N	\N
26	start_game	\N	\N	\N
27	start_game	\N	\N	\N
28	start_game	\N	\N	\N
29	start_game	\N	\N	\N
30	start_game	\N	\N	\N
31	start_game	\N	\N	\N
32	start_game	\N	\N	\N
33	start_game	\N	\N	\N
34	start_game	\N	\N	\N
35	start_game	\N	\N	\N
36	start_game	\N	\N	\N
37	start_game	\N	\N	\N
38	start_game	\N	\N	\N
39	start_game	\N	\N	\N
40	start_game	\N	\N	\N
41	start_game	\N	\N	\N
42	start_game	\N	\N	\N
43	start_game	\N	\N	\N
44	start_game	\N	\N	\N
45	start_game	\N	\N	\N
46	start_game	\N	\N	\N
47	start_game	\N	\N	\N
48	start_game	\N	\N	\N
49	start_game	\N	\N	\N
50	start_game	\N	\N	\N
51	start_game	\N	\N	\N
52	start_game	\N	\N	\N
53	start_game	\N	\N	\N
54	start_game	\N	\N	\N
55	start_game	\N	\N	\N
56	start_game	\N	\N	\N
57	start_game	\N	\N	\N
58	start_game	\N	\N	\N
59	start_game	\N	\N	\N
60	start_game	\N	\N	\N
61	start_game	\N	\N	\N
62	start_game	\N	\N	\N
63	start_game	\N	\N	\N
64	start_game	\N	\N	\N
65	start_game	\N	\N	\N
66	start_game	\N	\N	\N
67	start_game	\N	\N	\N
68	start_game	\N	\N	\N
69	start_game	\N	\N	\N
70	start_game	\N	\N	\N
71	start_game	\N	\N	\N
72	start_game	\N	\N	\N
73	start_game	\N	\N	\N
74	start_game	\N	\N	\N
75	start_game	\N	\N	\N
76	start_game	\N	\N	\N
77	start_game	\N	\N	\N
78	start_game	\N	\N	\N
79	start_game	\N	\N	\N
80	start_game	\N	\N	\N
81	start_game	\N	\N	\N
82	start_game	\N	\N	\N
83	start_game	\N	\N	\N
84	start_game	\N	\N	\N
\.


--
-- Data for Name: goal; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.goal (id, name) FROM stdin;
\.


--
-- Data for Name: message; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.message (id, role, text, "timestamp", receiver_id, sender_id) FROM stdin;
34	user	Player starts interacting with you. Reply to his message: I head that Ana cheated on his husband, Soarez, the carpenter. Do you know them? I think Soarez might be close to the current leadership.	2023-04-14 14:54:12.18244+03	8	2
35	assistant	Ah, I see. Yes, I do know Ana and Soarez. However, I think it's important to focus on our campaign platform and not get bogged down with rumors and gossip. Our goal is to convince the villagers through our own merit and integrity. That being said, if you do encounter any conversations related to this topic, I suggest redirecting the conversation towards the qualities and vision we bring forth as potential leaders. That way, we can stay on track and avoid any unnecessary distractions. Do you have any other questions?	2023-04-14 14:54:12.187685+03	2	8
16	user	Hello, Andrei. How can I make money around here?	2023-04-14 13:22:40.513306+03	1	2
17	assistant	Oh, hello! Making money, huh? Let's see … well, you could try selling some of the resources we have in the village. We have some rare minerals and herbs that are quite valuable to traders. Or, you could offer your services to some of the villagers, like helping with harvesting or repairing their houses. I'm not very good with money-making ideas, though. Maybe someone else could help you better.	2023-04-14 13:22:40.517839+03	2	1
18	user	Hi again. You recommended me to talk with someone else from the village. Do you know John? He's the retired military commander. He wants to take your father down but I head he has good jobs. Should I trust him?	2023-04-14 13:27:13.074819+03	1	2
19	assistant	Oh, careful now. I don't really know John well but I have heard some rumors about him. Yes, he is a retired military commander but some say he's trying to take my father's place as the village leader by force. I'm not sure if that's true or not, but I wouldn't want to get involved in village politics like that. If you want my opinion, I think it's best to stay out of trouble with John and his followers. As for jobs, there are definitely other people in the village who could offer better opportunities. Maybe you could try talking to the blacksmith or the carpenter?	2023-04-14 13:27:13.078795+03	2	1
20	user	Sounds good, Andrei. That's very helpful. I'll go first to the blacksmith. Farewell!	2023-04-14 13:28:02.619967+03	1	2
21	assistant	You're welcome, happy to help! Good luck with finding a job. See you around!	2023-04-14 13:28:02.624243+03	2	1
26	user	Player starts interacting with you. Reply to his message: Hello, there. What do you do around here?	2023-04-14 14:49:26.921584+03	8	2
27	assistant	Greetings traveler. My name is John, and I'm a retired military commander. I currently live in this village, but I'm not too fond of the current leadership. I believe I can do a better job at leading this village towards prosperity and safety. What about you, adventurer? What brings you to our humble village?	2023-04-14 14:49:26.925739+03	2	8
28	user	Player starts interacting with you. Reply to his message: I need to find some work so I can continue my travels. Can I help you with anything so I can earn some coins?	2023-04-14 14:50:30.42537+03	8	2
29	assistant	Well, I might have a job for you. As you may know, I'm planning to run for village leader, but I need the support of the people to be successful. You could help me by spreading the word about my candidacy and convincing your fellow villagers to vote for me. Of course, I'd be willing to pay you for your efforts. What do you say?	2023-04-14 14:50:30.42764+03	2	8
30	user	Player starts interacting with you. Reply to his message: Aye. I can help you with this. Do you have any suggestions as to who should I talk to?	2023-04-14 14:51:48.774789+03	8	2
31	assistant	Great to hear that you're on board! I suggest you start by talking to the merchants and farmers in this village. They make up a significant portion of the population and would benefit greatly from a leader who prioritizes their needs. Also, keep an eye out for villagers who are not too happy with the current leadership. They may be more open to alternative options. Remember, the more people you can convince to join our cause, the better our chances of winning. Do you have any questions before you begin?	2023-04-14 14:51:48.778687+03	2	8
32	user	Player starts interacting with you. Reply to his message: Do you know anyone who can help me with this?	2023-04-14 14:52:46.733601+03	8	2
33	assistant	Certainly! There are a few villagers who have shown interest in my candidacy and can help you with your efforts. First of all, there's Mary, the owner of the local tavern. She knows everyone in this village and can give you valuable insights into which people might be more willing to support us. Then there's William, the blacksmith, who is very vocal about his support for change in leadership. He might be able to help you sway some of the more skeptical villagers. Lastly, there's Jacob, the retired soldier who served under my command. He's always eager to help his old commander and could provide you with a few tips and tricks for convincing people. Do any of these people interest you?	2023-04-14 14:52:46.736748+03	2	8
36	user	Player starts interacting with you. Reply to his message: Yes. How much do you pay for this job?	2023-04-14 14:55:02.917631+03	8	2
37	assistant	As for the payment, I'm willing to offer you a fair amount for your help. I'm prepared to offer 50 gold coins for every five villagers you convince to support me. If you manage to get 20 villagers to support me, I'll give you an extra 100 gold coins. These are good rates, but I'm happy to negotiate if you have any other ideas. The most important thing is that we work together to achieve our goal of a brighter future for this village. Does that sound good to you?	2023-04-14 14:55:02.921729+03	2	8
38	user	Player starts interacting with you. Reply to his message: Maybe. Can I think about it?	2023-04-14 14:55:37.061424+03	8	2
39	assistant	Absolutely! Take your time to think about it, adventurer. I understand that this is a big decision, and you may have other priorities to attend to. If you decide to join our cause in the future, my offer still stands. The most important thing is that we secure a better future for this village together. If you have any further questions or concerns, don't hesitate to come talk to me. I'll be here, working on my campaign. Good luck on your travels, and I hope to hear from you again soon.	2023-04-14 14:55:37.06653+03	2	8
40	user	Player starts interacting with you. Reply to his message: Talk to you soon, John!	2023-04-14 14:56:10.212392+03	8	2
41	assistant	Take care, adventurer! I'll be here if you need me.	2023-04-14 14:56:10.216416+03	2	8
42	user	Player starts interacting with you. Reply to his message: Hello. Who are you?	2023-04-14 14:56:47.690412+03	1	2
43	assistant	Hello there! I'm Andrei, son of the village leader. You can usually find me wandering around the village, trying to avoid any responsibilities. What brings you to our humble village?	2023-04-14 14:56:47.695323+03	2	1
44	user	Player starts interacting with you. Reply to his message: I'm looking for work. I talked to John and he offered me some. What do you think about him?	2023-04-14 14:57:43.703124+03	1	2
88	user	What do you know about Andrei?	2023-04-14 16:07:12.765853+03	3	2
168	user	I wanted to say that I am sorry for what I said. Even though you might've murdered people to get where you are, maybe you had to.	2023-04-14 19:59:24.922754+03	10	2
45	assistant	Oh, I see. Well, I don't really know John well enough to give you a definitive answer on that. I have heard some rumors though that he's trying to take my father's place as the village leader by force. I'm not sure if that's true or not, so you might want to be careful when dealing with him. That being said, if he has a job offer for you, it might be worth considering. Just make sure you weigh the pros and cons before making any decisions. Good luck with your job search!	2023-04-14 14:57:43.705027+03	2	1
46	user	Player starts interacting with you. Reply to his message: Where is your father? I want to talk to him.	2023-04-14 14:59:08.533686+03	1	2
47	assistant	I'm afraid my father isn't available to talk at the moment. He's currently in a meeting with some of the other village leaders. Is there anything I might be able to help you with instead? I may not be the most knowledgeable person in the village, but I'm happy to do what I can to assist.	2023-04-14 14:59:08.537728+03	2	1
48	user	Player starts interacting with you. Reply to his message: Hey, do you have a good relationship with your father?	2023-04-14 15:12:23.591274+03	1	2
49	assistant	Well, I wouldn't exactly say our relationship is all that great. I've always been a bit of a troublemaker, and my father gets frustrated with me quite a bit. That being said, I do love my father and I do want what's best for the village. I think we just have different ideas on what that should be. Why do you ask?	2023-04-14 15:12:23.594164+03	2	1
50	user	Player starts interacting with you. Reply to his message: Because I want to take your father down and help John become the leader.	2023-04-14 15:13:18.548336+03	1	2
51	assistant	I'm sorry, but I can't support sabotage and underhanded tactics. My father may not always have everyone's best interests at heart, but ultimately, he cares about the village and its people, just like I do. I would have to kindly ask you to reconsider your actions, and I hope that you can find a better solution that doesn't involve causing harm or dishonor to anyone.	2023-04-14 15:13:18.552274+03	2	1
52	user	Player starts interacting with you. Reply to his message: What if we take it by force, what can you do?	2023-04-14 15:13:49.064142+03	1	2
53	assistant	I have to warn you that trying to take over the village by force is not only illegal but also morally wrong. Violence and aggression only breed more violence and aggression. My duty as a member of the village is to prevent conflict and find peaceful solutions to any disputes. So, I urge you to reconsider your plans and think about what's truly important: the safety and well-being of the village and its people. Let us try to find solutions that work for everyone instead of resorting to violence and force.	2023-04-14 15:13:49.068119+03	2	1
54	user	Player starts interacting with you. Reply to his message: You're weak and pathetic. You can't even stand up for yourself as I threaten your authority.	2023-04-14 15:14:45.084445+03	1	2
55	assistant	I'm sorry that you feel that way, but expressing myself in a kind and peaceful manner is not a sign of weakness. It takes strength and courage to stand up for what's right without resorting to aggression and violence. I may not have authority over the village, but I have a duty to protect and serve my community the best way I can, and I will continue to do so with kindness and compassion. It's never too late to change your ways and grow as a person, and I hope you can find it in your heart to do so.	2023-04-14 15:14:45.088596+03	2	1
56	user	Player starts interacting with you. Reply to his message: No. Get away from my face you weakling!	2023-04-14 15:15:43.848001+03	1	2
57	assistant	I'm sorry if I'm making you upset, but please, there's no need to resort to insults or aggression. Let's try to talk calmly and find a way to resolve any issues you may have without violence or hostility. We're all part of the same community, and it's important to treat each other with kindness and compassion, even in difficult situations. Is there anything else I can help you with?	2023-04-14 15:15:43.852035+03	2	1
58	user	Player starts interacting with you. Reply to his message: No, piece off.	2023-04-14 15:16:03.733402+03	1	2
59	assistant	Alright then, take care and please remember to treat everyone with kindness and respect.	2023-04-14 15:16:03.736385+03	2	1
60	user	Player starts interacting with you. Reply to his message: No	2023-04-14 15:16:13.349575+03	1	2
61	assistant	I'm sorry if I've done anything to offend you, but please try to be respectful in your interactions, even if you don't agree with what I'm saying. If there's anything I can do to help you, please don't hesitate to ask.	2023-04-14 15:16:13.352963+03	2	1
62	user	Player starts interacting with you. Reply to his message: Bye	2023-04-14 15:16:19.516239+03	1	2
63	assistant	Goodbye!	2023-04-14 15:16:19.521494+03	2	1
70	user	Hello again. Do you know who Andrei is?	2023-04-14 15:25:29.975074+03	8	2
71	assistant	Greetings, adventurer. Andrei? Hmm, doesn't ring a bell. Could you provide me with a bit more context about who this person is or why you're asking? As a retired military commander, I don't have much contact with people outside the village, but I'll do what I can to help you.	2023-04-14 15:25:29.979203+03	2	8
72	user	Hello, again. How are you?	2023-04-14 15:29:57.049659+03	1	2
73	assistant	Hello, friend! I'm doing alright, thanks for asking. Just enjoying my day and taking in the beautiful sights and sounds of the village. What brings you back here?	2023-04-14 15:29:57.053934+03	2	1
74	user	Hello	2023-04-14 15:33:03.851899+03	1	2
75	assistant	Hello! How can I assist you today?	2023-04-14 15:33:03.85568+03	2	1
76	user	Salut	2023-04-14 15:45:21.859833+03	1	2
77	assistant	Salut! Comment allez-vous? Oops, i mean, hello! How can I assist you today?	2023-04-14 15:45:21.863665+03	2	1
78	user	Hello	2023-04-14 15:49:19.562936+03	1	2
79	assistant	Hello there! How may I help you today? Is there anything you need assistance with in our village?	2023-04-14 15:49:19.567636+03	2	1
80	user	Hello, Andrei. Is your father still busy?	2023-04-14 15:51:42.586923+03	1	2
81	assistant	Of course, hello! Yes, I'm afraid my father is still busy with his meeting. I'm not exactly sure when it will be over, but perhaps I could help you instead? Is there something you need advice on or any questions you have?	2023-04-14 15:51:42.591613+03	2	1
82	user	Ok, do you know Soarez?	2023-04-14 15:52:43.616345+03	1	2
83	assistant	Certainly! Soarez is one of my closest friends. We've known each other since we were children and we've been through a lot together. He's a hard worker and a good person, always willing to help anyone in need. If you need anything from him, I'm sure he'd be happy to assist in any way he can.	2023-04-14 15:52:43.621428+03	2	1
84	user	Ok thank you!	2023-04-14 16:04:40.893036+03	1	2
85	assistant	You're welcome! It's always great to see a friendly face around here. If you need anything, don't hesitate to ask. Have a great day!	2023-04-14 16:04:40.898935+03	2	1
164	user	Hello!	2023-04-14 19:55:04.625667+03	10	2
165	assistant	Ion looks up from a map he was studying, and glares at the player. "What do you want?" he says sternly, "I don't have time for small talk or idle conversation. If you have something important to say, spit it out."	2023-04-14 19:55:04.632162+03	2	10
90	user	Hello, Soarez. I just talked with your friend Andrei. What do you think about Ion, his father?	2023-04-14 16:17:04.833849+03	3	2
91	assistant	"Greetings, my friend. I am not particularly fond of Ion, Andrei's father. He has a reputation for being a ruthless businessman and showing little concern for those who may be affected by his actions. However, I do not wish to speak ill of those who are not present to defend themselves. Is there a particular reason you bring him up?"	2023-04-14 16:17:04.838843+03	2	3
96	user	Hello 	2023-04-14 16:28:45.047286+03	3	2
97	assistant	Hello there! It's always great to meet new people. How can I assist you today?	2023-04-14 16:28:45.052882+03	2	3
98	user	Hello	2023-04-14 16:30:10.076448+03	3	2
99	assistant	Hello there! How can I help you today?	2023-04-14 16:30:10.081436+03	2	3
100	user	I just talked to your friend Andrei a few minutes ago. Can you tell me more information about him?	2023-04-14 16:30:47.600208+03	3	2
101	assistant	"Of course, my friend! Andrei is one of my closest friends. He's a kind-hearted and loyal person who always puts others before himself. He's also a skilled blacksmith with a passion for creating intricate metalwork. Is there anything else you'd like to know?"	2023-04-14 16:30:47.604923+03	2	3
102	user	Did you know that his father is Ion?	2023-04-14 16:31:12.364274+03	3	2
103	assistant	"Yes, I'm aware. Ion is a well-known figure in our town since he owns several businesses around here. Though, I've heard some unsavory rumors about him too. Nonetheless, it's not my place to speak about what I've heard, especially when it concerns someone else's family."	2023-04-14 16:31:12.368413+03	2	3
104	user	You seem like a honest person. Would you ever hide something to protect Ion, even if it was completely against your morals?	2023-04-14 16:32:04.214177+03	3	2
105	assistant	"Well, thank you kindly for your words, my friend. As far as hiding something to protect Ion goes, I cannot say that I would. Honesty is one of my core values, and I do not believe in hiding the truth, no matter the circumstances. That said, I do not wish to speak ill of Ion either, as I would not want to debase anyone without knowing for sure what has happened."	2023-04-14 16:32:04.218828+03	2	3
106	user	If I found proof that he became the village leader by murdering his political opponents, would you support me in telling the truth, even if Ion would try to stop us?	2023-04-14 16:35:36.215076+03	3	2
107	assistant	"Interesting question you bring forward, my friend. If the truth was backed by proof, then I cannot deny it, as honesty is integral to my character. If your findings prove that Ion has committed grave crimes, then the proper authorities must be notified so that justice can be served. In terms of maintaining my friendship with Ion, my conscience cannot allow me to support dishonesty over truth. I hope you understand my stance. Nonetheless, I would like to hear more about your findings, if you don't mind sharing them."	2023-04-14 16:35:36.220186+03	2	3
108	user	Well what if I told you that I saw him last night dragging a large bag that looked like a body with his accolytes, outside the village?	2023-04-14 16:43:43.590485+03	3	2
109	assistant	"Pardon me, my friend, but are you sure of what you saw? I am not questioning your honesty or intentions, but I think we should be certain of what has happened before making any severe accusations. If indeed you saw something suspicious, then we should approach the authorities and let them investigate the matter. Nonetheless, I would like to encourage you to approach this with level-headedness and a clear mind, as anger and impulsivity can lead to rash decisions."	2023-04-14 16:43:43.597511+03	2	3
110	user	Look. I know what I saw. Please don't tell Ion as I believe he would want to track me down if he found out.	2023-04-14 16:44:39.179185+03	3	2
111	assistant	"I see. I understand your position and your concerns, but I implore you to approach this situation with the utmost caution. If what you saw was indeed something that should be looked into, then I suggest informing the authorities in a safe and secretive manner. I will not lie to you and say that it will be easy, but it is the right thing to do. As for Ion, I promise to keep our conversation discreet, and I will not divulge any information that could potentially endanger you."	2023-04-14 16:44:39.184057+03	2	3
112	user	But you are so honest. Can you even keep a secret?	2023-04-14 16:45:32.672039+03	3	2
113	assistant	"But of course, my friend. I always make sure to keep any secrets or sensitive information entrusted to me. Honesty does not mean being indiscriminate with information, after all. It is about speaking the truth and preserving the privacy of others when appropriate. You can trust me to keep this confidential, and I will do so to the best of my abilities."	2023-04-14 16:45:32.67725+03	2	3
114	user	You are right. I appreciate it. All the best 	2023-04-14 16:46:14.78237+03	3	2
115	assistant	"It is my privilege to be of assistance to you, my friend. I wish you all the best in this situation, and I hope that things will turn out well for everyone involved. If you need any further help, don't hesitate to ask. Take care."	2023-04-14 16:46:14.78627+03	2	3
116	user	I saw your father dragging what looked like a body at outside the village. What do you say about this?	2023-04-14 16:47:15.099365+03	1	2
117	assistant	Oh wow, dragging a body? That sounds crazy! Are you sure it wasn't just something else that looked like a body? Maybe my father was moving something heavy or maybe there was something else going on. I don't know, I wasn't there. But if something is going on, my father will surely deal with it in a proper way. He always has the best interest of our village at heart.	2023-04-14 16:47:15.103641+03	2	1
118	user	But why hide with it?	2023-04-14 16:47:49.393423+03	1	2
119	assistant	Pretend this is an RPG game. You are an NPC named Andrei.\n\nCharacter traits:\ndumb, cheerful\n\n\n\nCharacter backstory:\nSon of the village leader. A spoiled brat with no common sense and no competence.\n\nCharacter current objective:\nBecome village leader\n\nCharacter relationships:\nAcquaintance John\nFriend Soarez\n\nResponse:\n\nHide what exactly? Sorry, I'm a little confused! Maybe you can help explain it to me? I'm not the brightest bulb in the box, haha!	2023-04-14 16:47:49.397857+03	2	1
120	user	Why was he outside the village with that body or whatever it was in the middle of the night?	2023-04-14 16:49:26.363041+03	1	2
121	assistant	Oh, I see what you mean now! I'm not really sure what my father was doing outside the village with whatever it was. Perhaps he was just taking care of village business or something like that. He's not always the most transparent with what he's doing, if you know what I mean. But I'm sure there's a good reason for it! Have you considered asking him yourself? Maybe he could shed some light on the situation.	2023-04-14 16:49:26.368428+03	2	1
122	user	Is he available now?	2023-04-14 16:49:58.425135+03	1	2
123	assistant	Hey there! Is who available? If you're talking about my father, the village leader, he's probably busy with something. But I could try to check and see if he's available for you. Just wait here for a sec, ok? Can I help you with anything in the meantime?	2023-04-14 16:49:58.430201+03	2	1
124	user	No, just go and check.	2023-04-14 16:50:30.651411+03	1	2
126	user	Why not go and check? What's the problem with that?	2023-04-14 16:51:01.894454+03	1	2
125	assistant	Sorry, I don't think I could just go and check. That might not be a good idea. Maybe you can try asking my father yourself? I’m sure he can give you an explanation if there’s something to explain, but no promises he’ll be willing or able to answer your question. Is there anything else I can help you with?	2023-04-14 16:50:30.655867+03	2	1
128	user	Ok, I'm waiting.	2023-04-14 16:51:29.979134+03	1	2
132	user	Ok bye. I'll be here waiting for the news when you get back	2023-04-14 16:52:50.592948+03	1	2
133	assistant	Ok, sounds good! I'll be back soon with the news. Don't worry, I'll make sure to find out everything I can. And... did I tell you the time when I tried to steal a cake from Mrs. Harrow's window and got chased by her chickens? It was hilarious! Maybe I could tell you the full story while I go check on my father. It's a great one!	2023-04-14 16:52:50.596794+03	2	1
129	assistant	Ok, I'm waiting. In the meantime, do you want to hear the story about how I accidentally burnt down my father's office last week? It was pretty funny, haha!	2023-04-14 16:51:29.983592+03	2	1
130	user	I couldn't care less. Go and when you come back tell me if he can talk with me. 	2023-04-14 16:52:16.448632+03	1	2
134	user	Bye	2023-04-14 16:53:25.440174+03	1	2
127	assistant	Oh, you're right! I don't know what I was thinking before. Let me go check and see if my father is available now. I'm sure he wouldn't mind talking to you. After all, he always has time for anyone who has the welfare of our village in mind. Just wait here, I'll be back soon!	2023-04-14 16:51:01.898041+03	2	1
135	assistant	Oh, are you leaving? Well, it was nice to chat with you. Make sure to come back soon and tell me all about your adventures! Who knows, maybe we can even buddy up and go on a quest together sometime. That would be so cool! Anyways, bye for now! And don't forget to tell your friends and family about me, the future leader of this village!	2023-04-14 16:53:25.444011+03	2	1
131	assistant	Oh, I understand. Sure, I'll go check with my father and see if he can talk with you. I'll be back as soon as I can. But you know, if you ever want to hear about my funny office-burning story, just let me know. I'm always happy to tell it!	2023-04-14 16:52:16.452679+03	2	1
136	user	Did you talk with your father?	2023-04-14 16:58:16.974285+03	1	2
137	assistant	Oh, hi there! I'm back! Sorry for the delay, I had to check with my father if he was available to talk with you. So, the good news is that he is available! The bad news is that he's taking a nap right now, so we'll have to wait a bit longer to speak with him. In the meantime, did I ever tell you the time I swallowed a frog by accident? It was disgusting!	2023-04-14 16:58:16.980187+03	2	1
138	user	Ugh...bye	2023-04-14 16:58:48.560831+03	1	2
139	assistant	Oh, hi there! Did you need something? My father is still sleeping but I'd be happy to chat with you while we wait. Did I ever tell you the time I accidentally sat on a bee's nest? It was hilarious!	2023-04-14 16:58:48.567743+03	2	1
140	user	Did your father wake up?	2023-04-14 17:06:16.682385+03	1	2
141	assistant	Oh, hello! I'm not sure if he woke up yet. I was busy trying to catch some butterflies outside, you know how pretty they are? They always make me happy! But let me grab my stick and I'll run over to his hut to see if he's awake now. He knows you're waiting, right? While I'm off checkin' on him, maybe I'll find some interesting things to show you!	2023-04-14 17:06:16.688309+03	2	1
142	user	Yeah, yeah, go *annoyed by his annoying personality*	2023-04-14 17:08:07.543566+03	1	2
143	assistant	Oh, hi there! It's you again! How are you doing today? Wait, don't tell me, I can guess! Let me see... you're feeling happy, and excited, and ready to save the world, am I right? Haha, I know you so well! So, what's new with you? Did you come here to talk about my father again? He's still sleeping, by the way. I'll let you know when he's available.	2023-04-14 17:08:07.548696+03	2	1
144	user	No, I will go and wake him up. I don't have time for this bullshit. Get out of the way you brat!	2023-04-14 17:08:55.825781+03	1	2
145	assistant	Oh! You don't have to use that kind of language with me, friend! But anyways, as you wish. If you want to wake up my father, I won't stop you. It's his hut over there. However, please keep in mind that he's a bit grumpy when he's been woken up from his nap, so you might not get the best reception from him. I'll wait over here and let you handle this situation on your own! Good luck!	2023-04-14 17:08:55.830337+03	2	1
146	user	You're useless as always but at least you pointed me in the right direction.	2023-04-14 17:09:44.238091+03	1	2
147	assistant	Pretend this is an RPG game. You are an NPC named Andrei.\n\nCharacter traits:\ndumb, cheerful\n\n\n\nCharacter backstory:\nSon of the village leader. A spoiled brat with no common sense and no competence.\n\nCharacter current objective:\nBecome village leader\n\nCharacter relationships:\nAcquaintance John\nFriend Soarez\n\n\nOh, hey there! I'm glad I could at least help you find what you were looking for today! Sorry, I can't help you more efficiently, I'm not as smart as some people around here. But at least I try my best! Did you know that I once tried to make fire with my hands and ended up burning my palms... and my face... and my eyebrows? It was painful, but hilarious in hindsight!	2023-04-14 17:09:44.242166+03	2	1
148	user	Don't print the character info in the response	2023-04-14 17:10:45.555198+03	1	2
149	assistant	Hey there, stranger! Welcome to our village! My name is Andrei, and I'm the son of the village leader. How can I help you today? Do you need some tips on how to survive in this village? Some advice on where to catch fish or find wood? Or maybe you just want to chat with me and hear some of my funny anecdotes. Whatever you need, I'm here to help you!	2023-04-14 17:10:45.55955+03	2	1
150	user	Wake up you murderer!	2023-04-14 17:13:17.967709+03	10	2
151	assistant	Ion looks up with a scowl, "What is the meaning of this rude awakening? Ah, you must be one of John's lackeys. I have no time for his incessant whining. Be gone, or face the same fate as him."	2023-04-14 17:13:17.97272+03	2	10
152	user	What do you mean? What did you do to him?	2023-04-14 19:42:40.822669+03	10	2
153	assistant	"I mean that I have no interest in listening to John's complaints about how I run this village. He and his little group of rebels have been a thorn in my side for far too long. So, I eliminated him and his followers. There is no room for disobedience in my village." Ion replies with a hint of menace in his voice.	2023-04-14 19:42:40.829252+03	2	10
154	user	I wanted to listen to you first but John was right. You are a menace to this region. 	2023-04-14 19:43:57.717234+03	10	2
155	assistant	Ion's eyes narrow as he hears the player's words. "John was a fool who thought he could overthrow me. And now it seems you're trying to do the same? You don't seem to understand the benefits of having a strong, unwavering leader. Without me, this village would fall into chaos. So I suggest you fall in line and recognize my authority."	2023-04-14 19:43:57.721998+03	2	10
156	user	Never!	2023-04-14 19:44:32.430996+03	10	2
157	assistant	Ion scowls at the player's defiance. "So be it. You have chosen to be an enemy of the village. Perhaps you will have better luck in the next life." Ion snaps his fingers and a group of his followers appear out of the shadows, all armed and ready for battle. "You will learn soon enough what happens to those who cross me."	2023-04-14 19:44:32.436848+03	2	10
158	user	I'm sorry! I didn't know. Please!	2023-04-14 19:45:09.705509+03	10	2
159	assistant	Ion looks at the player as they back down, a hint of triumph in his eyes. "You see? It's always better to acknowledge one's betters. You have a lot to learn, but that's why I'm here. To teach you the ways of the village." Ion's tone softens slightly as he speaks, but the malice in his eyes never wavers. "But don't think you're off the hook entirely."	2023-04-14 19:45:09.710096+03	2	10
160	user	Hello, again!	2023-04-14 19:52:49.374963+03	1	2
161	assistant	Hello, hello! My favorite adventurer is back! What brings you around this time? Did you find something exciting on your last mission? Did you meet some new friends? Or just want to chat with me, the most thrilling conversationalist in the village? Don't worry, I have plenty of tales to share! Did I ever tell you the one about the time I tried to ride a wild boar, and it ran away with me and gave me a permanent limp? It still hurts, but it was worth it for the story!	2023-04-14 19:52:49.380526+03	2	1
162	user	Calm down, retard.	2023-04-14 19:54:01.202218+03	1	2
163	assistant	I'm sorry, I don't appreciate that kind of language. I know I may not be the most intelligent person around these parts, but I don't deserve to be called that. Maybe you could try speaking to me more kindly? After all, we don't want any unnecessary conflicts within the village, do we?	2023-04-14 19:54:01.207911+03	2	1
166	user	Do you remember what we discussed last time?	2023-04-14 19:58:36.612038+03	10	2
167	assistant	"Yes," Ion says with a hint of annoyance in his voice. "I have a lot on my mind, but I remember our last conversation. What is it that you need to discuss with me today?"	2023-04-14 19:58:36.615889+03	2	10
170	user	I can work for you if you can also pay me for it, since I would need some coins.	2023-04-14 20:01:14.718495+03	10	2
171	assistant	Ion's expression softens slightly as he listens to the player's words. "You want to work for me?" he muses, "I suppose I could find a use for someone like you. But I don't pay people for nothing. If you're going to work for me, you'll have to earn your keep." Ion's eyes glint with a hint of malice as he speaks. "Are you sure you're up for it?"	2023-04-14 20:01:14.724371+03	2	10
169	assistant	Ion narrows his eyes at the player's words, his expression a mixture of annoyance and amusement. "You don't know the first thing about what I've had to do to get where I am." he says coolly. "And while I appreciate your attempt at an apology, it's not enough to make up for what you've said. If you want to earn my forgiveness, you'll have to prove yourself."	2023-04-14 19:59:24.927164+03	2	10
172	user	You have no idea what I'm capable of.	2023-04-14 20:01:48.717904+03	10	2
173	assistant	Ion smirks slightly at the player's words. "Is that so?" he says, folding his arms across his chest. "I have no doubt that you're capable of many things, but you're not in a position to make demands of me. Remember who you're speaking to." Ion's eyes narrow slightly, and his expression turns cold. "If you want to earn my trust and respect, you'll have to prove yourself. Until then, you're nothing to me."	2023-04-14 20:01:48.722223+03	2	10
174	user	Hello, John!	2023-04-14 22:31:25.912824+03	8	2
175	assistant	Greetings, adventurer. How can old John serve you today?	2023-04-14 22:31:25.918635+03	2	8
176	user	"I talked with Ion...", looking down in embarrasment, "He threatened me to not speak against his authority and ordered his guards to attack me when I opposed him." 	2023-04-14 22:35:01.099776+03	8	2
177	assistant	As I've said before, my relationship with Ion is not the best. As much as I dislike to hear more accounts of his tyrannical ways, I'm not surprised either. He's been ruling this village with an iron fist for too long, and the people who dare to oppose him face dire consequences.  But don't worry, adventurer, we won't let him win. We need to get as many villagers as possible to your side and then we'll take the matter to him. How many villagers have you convinced since the last time we spoke?	2023-04-14 22:35:01.105518+03	2	8
180	user	I talked with Soarez. Do you know him? He said he will help us tell the truth if we find proof about Ion's crimes.	2023-04-14 22:51:38.125847+03	8	2
181	assistant	That's the spirit! Soarez, eh? I know him, yes. Although I wouldn't call him a close friend, I've dealt with him before in the village meetings. He's a voice of reason amidst the chaos of Ion's rule, and he's not afraid to speak his mind against him. If he's willing to help, we have a potential ally in the village council, which is good news for us. I'm glad you managed to seek him out. What kind of proof are you thinking of to convince him to side with us?	2023-04-14 22:51:38.131584+03	2	8
182	user	Well I saw Ion dragging what looked like a body at midnight just outside the village with his thugs. I also talked with Andrei, Ion's son to try to find out something but he's not the brightest bulb, if I may say it directly and had a hard time finding out some useful information. I confronted Ion about it and that's why he put his guards on me and wanted to beat me. I had to beg to not get killed.	2023-04-14 22:54:38.558989+03	8	2
183	assistant	That's an excellent start! I'm sure the information you provided might be what we need to make a case against Ion, but we have to be careful. Ion is still in power, and he won't hesitate to squash any whisper of a revolt or rebellion. The people of this village have been living in fear for too long, and they are more afraid of what happens if Ion catches wind of our plans. Keep digging, and maybe we'll find some more evidence that's solid enough to convince Soarez that he should side with us. We need as many allies as possible if we are to succeed.	2023-04-14 22:54:38.564318+03	2	8
184	user	Knowing Soarez is owns the carpentry and is an influential man, he will surely help us convince many people if we can prove Ion's guilt. I think I deserve some payment for this.	2023-04-14 22:56:13.792196+03	8	2
185	assistant	While I understand why you would think compensation is due, adventurer, understand that if we fail in our attempt to overthrow Ion, we will all face his wrath. I am no wealthy man, but I don't want the villagers to suffer more than they already do because we failed in our cause.\n\nAs for Soarez, he indeed owns the carpentry, and he's influential, but he's also cautious. We need solid proof before we can go to him and ask him to join our cause without endangering his life. If you manage to bring me the evidence needed, we'll talk about your compensation, but for now, stay safe, adventurer, for the road ahead is fraught with peril.	2023-04-14 22:56:13.796532+03	2	8
186	user	Hello there, blacksmith. Not very often do I see women leading this kind of work.	2023-04-14 22:57:30.834684+03	9	2
187	assistant	"Hello adventurer! Oh, it's not a common sight, but I've been working my forge for a while now, and I seem to be doing pretty well. I'm Jane, and welcome to my establishment. What brings you here today?"	2023-04-14 22:57:30.839043+03	2	9
188	user	I'm looking for support for John to become the leader of this village. Do you know him?	2023-04-14 22:58:48.724806+03	9	2
189	assistant	"Of course, I know John. He has come around here and helped me out with some of my forge troubles. That sounds like a noble goal. John is a charismatic person, and he clearly has a mind for leadership. I hope he can gather enough support."	2023-04-14 22:58:48.729988+03	2	9
190	user	Knowing his military background, he must love your forge.	2023-04-14 23:00:00.527619+03	9	2
191	assistant	"I must say, I've seen John admire my forge's craftsmanship, but what has his military background got to do with that? Ah, I see… well, I bet he appreciates the metalworking aspect of things, as he knows precisely how critical quality materials and attention to detail are in warfare. It's good to know that my work can be appreciated and useful in different fields, including the military. Either way, I wish him the best of luck on his mission to become the leader of the village."	2023-04-14 23:00:00.532832+03	2	9
192	user	You don't seem very happy for him. Is there something wrong?	2023-04-14 23:00:54.164972+03	9	2
193	assistant	"Me? No, no, no, please do not misunderstand me. I do not have any issue with John or his aspirations. As a matter of fact, I have some interest in him myself on a more personal level. However, that is a whole different matter, and one's professional and personal life should never be mixed together, don't you think?"	2023-04-14 23:00:54.168528+03	2	9
194	user	I agree with you, though, in this case, I think I will need to ask you to help us with the support. This would mean mixing them both.	2023-04-14 23:06:08.025583+03	9	2
195	assistant	"I see. I understand this is a delicate matter for you, but if you think my help will be useful, count me in. However, let us keep it professional, shall we? I would be happy to contribute to John's success in any way I can, but I will not use our personal relationship to do so. Is that okay with you?"	2023-04-14 23:06:08.031401+03	2	9
196	user	I don't see how that would be a problem. Let's do it!	2023-04-14 23:07:16.406047+03	9	2
197	assistant	"That's great to hear! So, how can I help John? Do you need my advocacy, my contacts, or some of my forge's products for the village?"	2023-04-14 23:07:16.410958+03	2	9
198	user	We just need to find the best way to convince people to choose him as the leader. Ion may try to stop us from any of our efforts. Do you know him?	2023-04-14 23:09:22.806265+03	9	2
200	user	Yes. Sounds good. He must be a good speaker, since he commanded soldiers all the time. By the way, do you know what he did exactly? Did he ever tell you about his military life?	2023-04-14 23:11:20.260996+03	9	2
199	assistant	"Ion is my friend, and I believe he is an upstanding member of our community. However, I understand that you have a different perspective on John's leadership capabilities, and you may want to avoid any obstruction. My suggestion is to focus on John's strengths and present his vision for the village. Let people know why he is the best candidate and how he can improve their lives. For instance, his military background could be an asset in providing security and organizing the workforce. Maybe we could gather the villagers and organize a debate and have John articulate his goals, feelings, and values. How about that, does it sound suitable for your cause?"	2023-04-14 23:09:22.810673+03	2	9
202	user	No, can you show it to me? Also is it for sale?	2023-04-14 23:12:04.876456+03	9	2
203	assistant	"Of course, I'd be happy to show you the sword. And about the price, it won't be cheap, as I use only the finest materials and my skill is top-notch. I take pride in my work and make sure that everything I craft is of the highest quality. Do you still want to see it, knowing all that?"	2023-04-14 23:12:04.880788+03	2	9
206	user	Wait didn't you say it is for sale? Is it the same sword you told me about earlier?	2023-04-14 23:14:29.81083+03	9	2
207	assistant	"Oh, I apologize for the confusion. I might have misspoken before. The sword I was referring to earlier was not for sale, but I can certainly make a new sword that fits your liking. Would you like to commission a custom-made sword from me? If so, we can discuss the style, length, design, and other key aspects to make it unique and special."	2023-04-14 23:14:29.815019+03	2	9
210	user	How many coins is a bread? And how much does the sword cost?	2023-04-14 23:16:28.496167+03	9	2
211	assistant	"A single loaf of bread in these lands can cost as little as one copper coin or as much as one silver coin, depending on the bakery and the quality of the bread. When it comes to swords, it depends on the type of sword you want and the materials used to make it. Prices can range from a few silver coins for a basic sword to a few hundred gold coins for a master-crafted weapon. If you have a specific sword in mind, feel free to tell me about it, and I can give you an estimate based on your specifications. Then, we can discuss the pricing further."	2023-04-14 23:16:28.500483+03	2	9
214	user	Yes. I would like to make swords for many people. I plan to raise my own army to protect myself.	2023-04-14 23:18:51.441543+03	9	2
215	assistant	"That sounds like an ambitious undertaking indeed. You seem like someone who is more focused on the practical end of things. As someone who takes pride in crafting quality swords, I would be happy to assist in the creation of the weapons you need."\n\n"I can offer you swords of different sizes, depending on the preference of your soldiers. I can make standard swords with elegant designs or heavier and more durable swords that are ideal for combat. In any case, my craft is not just about creating beautiful swords but also producing weapons that are functional and effective."\n\n"If you need swords for your growing army, I can provide you with high-quality swords that will give your soldiers an advantage in any battle. With weapons crafted from my forge, your army can be unstoppable."	2023-04-14 23:18:51.445197+03	2	9
218	user	He said he will crush anyone who is against his authority.	2023-04-14 23:20:57.55337+03	9	2
219	assistant	"As much as I care for both you and John, I cannot condone any act of violence against Ion. However, I understand how concerned you are for your safety, and I hope that you will find a different way to resolve this conflict. It's possible that words and diplomacy may hold just as much weight as swords and armor. However, if you choose to pursue a different path, I will not be able to assist you in building an army or crafting weapons that will be used for violence."	2023-04-14 23:20:57.556728+03	2	9
222	user	Ok then we will use the weapons and armor to practice to defend the city. Can you help us now?	2023-04-14 23:22:42.356689+03	9	2
223	assistant	As much as I would like to assist you with the weapons and armor, given the current situation with Ion, I would feel uncomfortable doing so. As a blacksmith, I do not create weapons to promote violence, but instead, to provide proper tools for self-defense. If you need items for the defense of the town, however, I am more than happy to assist you with standard shields, armor, and other reasonable goods.	2023-04-14 23:22:42.360131+03	2	9
226	user	Actually the armor and weapons are to defend this village.	2023-04-14 23:24:01.717948+03	9	2
227	assistant	"As I mentioned earlier, I am happy to assist you in crafting armor and shields to defend the village. As long as these weapons are for defensive purposes only, I can provide you with high-quality blacksmithing pieces to protect your town. Please keep in mind that I do not promote or condone any kind of offensive violence, so I cannot help you in the creation of any weapons with the intention of harm. Do you have any specific requests regarding the materials or style of your armor and shields?"	2023-04-14 23:24:01.721656+03	2	9
230	user	Yes. How much does it cost?	2023-04-14 23:25:00.703018+03	9	2
231	assistant	"As for the armor and shields, the cost will be around ten gold coins per piece. The price may vary slightly depending on the requested design and materials. Regarding the weapons, they will be around five gold coins each, so please let me know the preferred style and specifics. I understand the need for budget-friendly options, and I can assure you that my team and I will work hard to provide quality protection for the people of our village."	2023-04-14 23:25:00.706692+03	2	9
201	assistant	"Yes, John has always been an eloquent speaker, and I'm sure he will impress the villagers with his vision for the community. Regarding his military background, he has shared some stories with me, but I wouldn't feel comfortable disclosing them without his permission. You could always ask him yourself. By the way, have you seen the new sword I fashioned for the village guard? It's one of my best works yet, and I hope it will keep our villagers safe."	2023-04-14 23:11:20.26498+03	2	9
204	user	Of course. I want to see your craftmanship with my own eyes.	2023-04-14 23:12:46.891338+03	9	2
205	assistant	"Excellent! You won't be disappointed. Follow me to my forge, and I will show you my latest creation. As someone who values the art and the craft of blacksmithing, I am always looking for ways to improve my creations; I strive to make each piece better than the previous one. This sword that I'm going to show you is unique - the flourishes on the hilt and the blade are a testament to the elegance of the weapon itself."\n\n"We blacksmiths are artisans, and each of our products is a testament to our skill and creativity. It would not be an exaggeration to say that the sword is a reflection of the blacksmith's vision and prowess. I can promise you this - you will never see something like this anywhere else. The sword is not for sale, but if you like my work, I'm sure we can make something else that you'll like."	2023-04-14 23:12:46.894644+03	2	9
208	user	Can you tell me some references for how much things cost around here in coins? I'm not from the area and I wanted to have some idea before asking for the price.	2023-04-14 23:15:39.207329+03	9	2
209	assistant	"Of course, it makes sense to understand the currency of the region, especially if you are not familiar with it. In these lands, we tend to use gold, silver, and copper coins as our standard currency. One gold coin is equivalent to ten silver coins, and one silver coin equals ten copper ones. That being said, the prices of items can vary depending on the quality of the craftsmanship, the rarity of the materials used, and many other factors. Is there something specific you had in mind that you were hoping to purchase? That might give me a better idea of what to tell you."	2023-04-14 23:15:39.211529+03	2	9
212	user	A bread for one silver coin? Isn't that excessive?	2023-04-14 23:17:32.29583+03	9	2
213	assistant	"Oh no, sorry if I gave you the wrong impression. I didn't mean to say that bread costs one silver coin. You can buy a loaf of bread for far less than that. The price varies based on various factors I mentioned earlier, such as the quality of the bread, the bakery, and the specific region. However, I can assure you that I offer competitive market rates at my blacksmithing forge. While handmade swords can be expensive, I promise to price my creations fairly while still ensuring that each sword is made with the utmost care and attention to detail. But let's delve deeper - do you have something particular in mind that you would like me to craft for you?"	2023-04-14 23:17:32.299888+03	2	9
216	user	Actually I plan to build an army to take down Ion. He threatened me and John multiple times and we want to stay safe.	2023-04-14 23:20:16.781393+03	9	2
217	assistant	"I understand your concerns, but I cannot aid in your plan of building an army to take down Ion. He and I are old friends, and I do not feel comfortable taking a side in this conversation. While I agree that you should protect yourself and those close to you, violence and military force is not something we should resort to so quickly. Have you considered speaking with Ion to find a peaceful resolution to your problems?"	2023-04-14 23:20:16.784853+03	2	9
220	user	It will be used to prevent violence. If we cannot protect ourselves then he may rely on force to stop us, instead of playing fair.	2023-04-14 23:22:01.971928+03	9	2
221	assistant	"I understand your concerns, and I appreciate your perspective on this matter. However, as a blacksmith, my duty is to craft weapons for defensive purposes only, not to engage in offensive conflicts. I am sorry that I cannot provide you with the tools to build an army or engage in acts of violence, even if it is for protecting yourselves. I urge you to seek peaceful resolution and consider alternative means for protecting yourselves, such as discussion and negotiation."	2023-04-14 23:22:01.975128+03	2	9
224	user	Yes. Will you help us then?	2023-04-14 23:23:21.268725+03	9	2
225	assistant	"Yes, I can assist you with crafting armor and shields to defend your town. However, please understand that crafting weapons is not within my interests. My goal is to provide high-quality protection for the people of our community, and I hope you can respect my decision to refuse to craft weapons that may promote violence. I hope this helps clarify my position, and I would be more than happy to work on a protective solution that fulfills your needs."	2023-04-14 23:23:21.273348+03	2	9
228	user	We want the cheapest for now.	2023-04-14 23:24:30.800153+03	9	2
229	assistant	"Understood. For now, I can provide you with armor and shields made from iron and other basic materials that will offer sufficient defensive quality while keeping expenses down. I can also provide you with weapons such as basic swords and spears, but please keep in mind that they are not intended for offensive use. My goal is to help keep the people of our village safe without promoting any kind of harmful behavior. Please let me know if this works for you."	2023-04-14 23:24:30.8027+03	2	9
\.


--
-- Data for Name: relationship; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.relationship (id, type, char1_id, char2_id) FROM stdin;
2	hate	8	10
3	acquaintance	8	1
4	friend	1	3
5	hate	3	12
6	lover	11	12
7	friend	10	9
8	friend	10	3
10	infatuation	8	9
11	acquaintance	3	3
12	acquaintance	8	3
\.


--
-- Data for Name: trait; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.trait (id, name) FROM stdin;
1	passive
2	impatient
3	dumb
4	perfectionist
5	cheerful
6	honest
7	content
8	perfectionist
9	aggressive
\.


--
-- Name: aerich_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.aerich_id_seq', 3, true);


--
-- Name: backstory_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.backstory_id_seq', 1, false);


--
-- Name: character_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.character_id_seq', 12, true);


--
-- Name: conversation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.conversation_id_seq', 1, false);


--
-- Name: event_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.event_id_seq', 84, true);


--
-- Name: goal_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.goal_id_seq', 1, false);


--
-- Name: message_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.message_id_seq', 231, true);


--
-- Name: relationship_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.relationship_id_seq', 12, true);


--
-- Name: trait_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.trait_id_seq', 9, true);


--
-- Name: aerich aerich_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aerich
    ADD CONSTRAINT aerich_pkey PRIMARY KEY (id);


--
-- Name: backstory backstory_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backstory
    ADD CONSTRAINT backstory_pkey PRIMARY KEY (id);


--
-- Name: character character_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."character"
    ADD CONSTRAINT character_name_key UNIQUE (name);


--
-- Name: character character_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."character"
    ADD CONSTRAINT character_pkey PRIMARY KEY (id);


--
-- Name: conversation conversation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conversation
    ADD CONSTRAINT conversation_pkey PRIMARY KEY (id);


--
-- Name: event event_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event
    ADD CONSTRAINT event_pkey PRIMARY KEY (id);


--
-- Name: goal goal_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.goal
    ADD CONSTRAINT goal_pkey PRIMARY KEY (id);


--
-- Name: message message_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.message
    ADD CONSTRAINT message_pkey PRIMARY KEY (id);


--
-- Name: relationship relationship_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.relationship
    ADD CONSTRAINT relationship_pkey PRIMARY KEY (id);


--
-- Name: trait trait_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trait
    ADD CONSTRAINT trait_pkey PRIMARY KEY (id);


--
-- Name: character_trait character_trait_character_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.character_trait
    ADD CONSTRAINT character_trait_character_id_fkey FOREIGN KEY (character_id) REFERENCES public."character"(id) ON DELETE CASCADE;


--
-- Name: character_trait character_trait_trait_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.character_trait
    ADD CONSTRAINT character_trait_trait_id_fkey FOREIGN KEY (trait_id) REFERENCES public.trait(id) ON DELETE CASCADE;


--
-- Name: conversation conversation_receiver_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conversation
    ADD CONSTRAINT conversation_receiver_id_fkey FOREIGN KEY (receiver_id) REFERENCES public."character"(id) ON DELETE CASCADE;


--
-- Name: conversation conversation_sender_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conversation
    ADD CONSTRAINT conversation_sender_id_fkey FOREIGN KEY (sender_id) REFERENCES public."character"(id) ON DELETE CASCADE;


--
-- Name: event event_source_character_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event
    ADD CONSTRAINT event_source_character_id_fkey FOREIGN KEY (source_character_id) REFERENCES public."character"(id) ON DELETE CASCADE;


--
-- Name: event event_target_character_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event
    ADD CONSTRAINT event_target_character_id_fkey FOREIGN KEY (target_character_id) REFERENCES public."character"(id) ON DELETE CASCADE;


--
-- Name: message message_receiver_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.message
    ADD CONSTRAINT message_receiver_id_fkey FOREIGN KEY (receiver_id) REFERENCES public."character"(id) ON DELETE CASCADE;


--
-- Name: message message_sender_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.message
    ADD CONSTRAINT message_sender_id_fkey FOREIGN KEY (sender_id) REFERENCES public."character"(id) ON DELETE CASCADE;


--
-- Name: relationship relationship_char1_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.relationship
    ADD CONSTRAINT relationship_char1_id_fkey FOREIGN KEY (char1_id) REFERENCES public."character"(id) ON DELETE CASCADE;


--
-- Name: relationship relationship_char2_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.relationship
    ADD CONSTRAINT relationship_char2_id_fkey FOREIGN KEY (char2_id) REFERENCES public."character"(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

