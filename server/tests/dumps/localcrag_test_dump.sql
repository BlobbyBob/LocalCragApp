PGDMP  )                    |           localcrag_dev    16.2 (Homebrew)    16.2 (Homebrew) �    P           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            Q           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            R           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            S           1262    16388    localcrag_dev    DATABASE     o   CREATE DATABASE localcrag_dev WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'C';
    DROP DATABASE localcrag_dev;
                felixengelmann    false                        3079    1210036    fuzzystrmatch 	   EXTENSION     A   CREATE EXTENSION IF NOT EXISTS fuzzystrmatch WITH SCHEMA public;
    DROP EXTENSION fuzzystrmatch;
                   false            T           0    0    EXTENSION fuzzystrmatch    COMMENT     ]   COMMENT ON EXTENSION fuzzystrmatch IS 'determine similarities and distance between strings';
                        false    2            h           1247    1682396    linetypeenum    TYPE     T   CREATE TYPE public.linetypeenum AS ENUM (
    'BOULDER',
    'SPORT',
    'TRAD'
);
    DROP TYPE public.linetypeenum;
       public          felixengelmann    false            k           1247    1682404    menuitempositionenum    TYPE     M   CREATE TYPE public.menuitempositionenum AS ENUM (
    'BOTTOM',
    'TOP'
);
 '   DROP TYPE public.menuitempositionenum;
       public          felixengelmann    false            n           1247    1682410    menuitemtypeenum    TYPE     �   CREATE TYPE public.menuitemtypeenum AS ENUM (
    'MENU_PAGE',
    'TOPO',
    'NEWS',
    'YOUTUBE',
    'INSTAGRAM',
    'ASCENTS',
    'RANKING'
);
 #   DROP TYPE public.menuitemtypeenum;
       public          felixengelmann    false            q           1247    1682426    searchableitemtypeenum    TYPE     t   CREATE TYPE public.searchableitemtypeenum AS ENUM (
    'CRAG',
    'SECTOR',
    'AREA',
    'LINE',
    'USER'
);
 )   DROP TYPE public.searchableitemtypeenum;
       public          felixengelmann    false            t           1247    1682438    startingpositionenum    TYPE     v   CREATE TYPE public.startingpositionenum AS ENUM (
    'SIT',
    'STAND',
    'CROUCH',
    'FRENCH',
    'CANDLE'
);
 '   DROP TYPE public.startingpositionenum;
       public          felixengelmann    false                        1255    1682449    parse_websearch(text)    FUNCTION     �   CREATE FUNCTION public.parse_websearch(search_query text) RETURNS tsquery
    LANGUAGE sql IMMUTABLE
    AS $$
SELECT parse_websearch('pg_catalog.simple', search_query);
$$;
 9   DROP FUNCTION public.parse_websearch(search_query text);
       public          felixengelmann    false                       1255    1682450     parse_websearch(regconfig, text)    FUNCTION       CREATE FUNCTION public.parse_websearch(config regconfig, search_query text) RETURNS tsquery
    LANGUAGE sql IMMUTABLE
    AS $$
SELECT
    string_agg(
        (
            CASE
                WHEN position('''' IN words.word) > 0 THEN CONCAT(words.word, ':*')
                ELSE words.word
            END
        ),
        ' '
    )::tsquery
FROM (
    SELECT trim(
        regexp_split_to_table(
            websearch_to_tsquery(config, lower(search_query))::text,
            ' '
        )
    ) AS word
) AS words
$$;
 K   DROP FUNCTION public.parse_websearch(config regconfig, search_query text);
       public          felixengelmann    false            �            1259    1682451    alembic_version    TABLE     X   CREATE TABLE public.alembic_version (
    version_num character varying(32) NOT NULL
);
 #   DROP TABLE public.alembic_version;
       public         heap    felixengelmann    false            �            1259    1682454    areas    TABLE     �  CREATE TABLE public.areas (
    name character varying(120) NOT NULL,
    description text,
    lat double precision,
    lng double precision,
    id uuid NOT NULL,
    time_created timestamp without time zone,
    time_updated timestamp without time zone,
    created_by_id uuid,
    portrait_image_id uuid,
    sector_id uuid NOT NULL,
    slug character varying NOT NULL,
    order_index integer DEFAULT 0 NOT NULL,
    short_description text,
    secret boolean DEFAULT false
);
    DROP TABLE public.areas;
       public         heap    felixengelmann    false            �            1259    1682462    ascents    TABLE     v  CREATE TABLE public.ascents (
    line_id uuid NOT NULL,
    flash boolean NOT NULL,
    fa boolean NOT NULL,
    soft boolean NOT NULL,
    hard boolean NOT NULL,
    grade_name character varying(120) NOT NULL,
    grade_scale character varying(120) NOT NULL,
    rating integer,
    comment text,
    year integer,
    date date,
    id uuid NOT NULL,
    time_created timestamp without time zone,
    time_updated timestamp without time zone,
    created_by_id uuid NOT NULL,
    with_kneepad boolean NOT NULL,
    crag_id uuid NOT NULL,
    sector_id uuid NOT NULL,
    area_id uuid NOT NULL,
    ascent_date date NOT NULL
);
    DROP TABLE public.ascents;
       public         heap    felixengelmann    false            �            1259    1682467    crags    TABLE     �  CREATE TABLE public.crags (
    name character varying(120) NOT NULL,
    description text,
    rules text,
    id uuid NOT NULL,
    time_created timestamp without time zone,
    time_updated timestamp without time zone,
    created_by_id uuid,
    slug character varying(120) NOT NULL,
    short_description text,
    portrait_image_id uuid,
    order_index integer DEFAULT 0 NOT NULL,
    lat double precision,
    lng double precision,
    secret boolean DEFAULT false
);
    DROP TABLE public.crags;
       public         heap    felixengelmann    false            �            1259    1682475    files    TABLE     �  CREATE TABLE public.files (
    id uuid NOT NULL,
    time_created timestamp without time zone,
    time_updated timestamp without time zone,
    original_filename character varying(120) NOT NULL,
    filename character varying(120) NOT NULL,
    width integer,
    height integer,
    thumbnail_xs boolean,
    thumbnail_s boolean,
    thumbnail_m boolean,
    thumbnail_l boolean,
    thumbnail_xl boolean,
    created_by_id uuid
);
    DROP TABLE public.files;
       public         heap    felixengelmann    false            �            1259    1682478    instance_settings    TABLE     �  CREATE TABLE public.instance_settings (
    id uuid NOT NULL,
    time_updated timestamp without time zone,
    instance_name character varying(120) NOT NULL,
    copyright_owner character varying(120) NOT NULL,
    youtube_url character varying(120),
    instagram_url character varying(120),
    logo_image_id uuid,
    favicon_image_id uuid,
    auth_bg_image_id uuid,
    main_bg_image_id uuid,
    arrow_color character varying(7) DEFAULT '#FFE016'::character varying NOT NULL,
    arrow_text_color character varying(7) DEFAULT '#000000'::character varying NOT NULL,
    arrow_highlight_color character varying(7) DEFAULT '#FF0000'::character varying NOT NULL,
    arrow_highlight_text_color character varying(7) DEFAULT '#FFFFFF'::character varying NOT NULL,
    bar_chart_color character varying(30) DEFAULT '`rgb(213, 30, 38)'::character varying NOT NULL,
    matomo_tracker_url character varying(120),
    matomo_site_id character varying(120)
);
 %   DROP TABLE public.instance_settings;
       public         heap    felixengelmann    false            �            1259    1682488 
   line_paths    TABLE     b  CREATE TABLE public.line_paths (
    line_id uuid NOT NULL,
    topo_image_id uuid NOT NULL,
    path json NOT NULL,
    id uuid NOT NULL,
    time_created timestamp without time zone,
    time_updated timestamp without time zone,
    created_by_id uuid,
    order_index integer DEFAULT 0 NOT NULL,
    order_index_for_line integer DEFAULT 0 NOT NULL
);
    DROP TABLE public.line_paths;
       public         heap    felixengelmann    false            �            1259    1682495    lines    TABLE     �  CREATE TABLE public.lines (
    name character varying(120) NOT NULL,
    description text,
    type public.linetypeenum NOT NULL,
    eliminate boolean NOT NULL,
    traverse boolean NOT NULL,
    area_id uuid NOT NULL,
    id uuid NOT NULL,
    time_created timestamp without time zone,
    time_updated timestamp without time zone,
    created_by_id uuid,
    slug character varying NOT NULL,
    rating integer,
    fa_year integer,
    fa_name character varying(120),
    highball boolean NOT NULL,
    no_topout boolean NOT NULL,
    roof boolean NOT NULL,
    slab boolean NOT NULL,
    vertical boolean NOT NULL,
    overhang boolean NOT NULL,
    athletic boolean NOT NULL,
    technical boolean NOT NULL,
    endurance boolean NOT NULL,
    cruxy boolean NOT NULL,
    dyno boolean NOT NULL,
    jugs boolean NOT NULL,
    sloper boolean NOT NULL,
    pockets boolean NOT NULL,
    crack boolean NOT NULL,
    dihedral boolean NOT NULL,
    compression boolean NOT NULL,
    arete boolean NOT NULL,
    crimps boolean NOT NULL,
    pinches boolean NOT NULL,
    grade_name character varying(120) NOT NULL,
    grade_scale character varying(120) NOT NULL,
    starting_position public.startingpositionenum NOT NULL,
    mantle boolean DEFAULT false NOT NULL,
    videos json,
    lowball boolean DEFAULT false NOT NULL,
    bad_dropzone boolean DEFAULT false NOT NULL,
    child_friendly boolean DEFAULT false NOT NULL,
    morpho boolean DEFAULT false NOT NULL,
    secret boolean DEFAULT false
);
    DROP TABLE public.lines;
       public         heap    felixengelmann    false    872    884            �            1259    1682507 
   menu_items    TABLE     q  CREATE TABLE public.menu_items (
    type public.menuitemtypeenum NOT NULL,
    "position" public.menuitempositionenum NOT NULL,
    order_index integer DEFAULT 0 NOT NULL,
    menu_page_id uuid,
    id uuid NOT NULL,
    time_created timestamp without time zone,
    time_updated timestamp without time zone,
    created_by_id uuid,
    icon character varying(120)
);
    DROP TABLE public.menu_items;
       public         heap    felixengelmann    false    875    878            �            1259    1682511 
   menu_pages    TABLE       CREATE TABLE public.menu_pages (
    title character varying(120) NOT NULL,
    text text,
    slug character varying NOT NULL,
    id uuid NOT NULL,
    time_created timestamp without time zone,
    time_updated timestamp without time zone,
    created_by_id uuid
);
    DROP TABLE public.menu_pages;
       public         heap    felixengelmann    false            �            1259    1682516    posts    TABLE       CREATE TABLE public.posts (
    title character varying(120) NOT NULL,
    text text,
    slug character varying NOT NULL,
    id uuid NOT NULL,
    time_created timestamp without time zone,
    time_updated timestamp without time zone,
    created_by_id uuid
);
    DROP TABLE public.posts;
       public         heap    felixengelmann    false            �            1259    1682521    rankings    TABLE     ^  CREATE TABLE public.rankings (
    id uuid NOT NULL,
    crag_id uuid,
    sector_id uuid,
    user_id uuid NOT NULL,
    top_10 integer,
    top_25 integer,
    top_10_fa integer,
    total integer,
    total_fa integer,
    type public.linetypeenum NOT NULL,
    top_values json DEFAULT '[]'::json,
    top_fa_values json DEFAULT '[]'::json,
    top_10_exponential integer,
    top_25_exponential integer,
    total_exponential integer,
    total_fa_exponential integer,
    total_count integer,
    total_fa_count integer,
    top_10_fa_exponential integer,
    secret boolean DEFAULT false NOT NULL
);
    DROP TABLE public.rankings;
       public         heap    felixengelmann    false    872            �            1259    1682528    regions    TABLE     �   CREATE TABLE public.regions (
    name character varying(120) NOT NULL,
    description text,
    id uuid NOT NULL,
    time_created timestamp without time zone,
    time_updated timestamp without time zone,
    created_by_id uuid,
    rules text
);
    DROP TABLE public.regions;
       public         heap    felixengelmann    false            �            1259    1682534    revoked_tokens    TABLE     `   CREATE TABLE public.revoked_tokens (
    id integer NOT NULL,
    jti character varying(120)
);
 "   DROP TABLE public.revoked_tokens;
       public         heap    felixengelmann    false            �            1259    1682537    revoked_tokens_id_seq    SEQUENCE     �   CREATE SEQUENCE public.revoked_tokens_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.revoked_tokens_id_seq;
       public          felixengelmann    false    229            U           0    0    revoked_tokens_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.revoked_tokens_id_seq OWNED BY public.revoked_tokens.id;
          public          felixengelmann    false    230            �            1259    1682538    searchables    TABLE     �   CREATE TABLE public.searchables (
    name character varying(120) NOT NULL,
    type public.searchableitemtypeenum NOT NULL,
    id uuid NOT NULL,
    secret boolean DEFAULT false
);
    DROP TABLE public.searchables;
       public         heap    felixengelmann    false    881            �            1259    1682542    sectors    TABLE     �  CREATE TABLE public.sectors (
    name character varying(120) NOT NULL,
    description text,
    crag_id uuid NOT NULL,
    id uuid NOT NULL,
    time_created timestamp without time zone,
    time_updated timestamp without time zone,
    created_by_id uuid,
    short_description text,
    slug character varying(120) NOT NULL,
    portrait_image_id uuid,
    order_index integer DEFAULT 0 NOT NULL,
    lat double precision,
    lng double precision,
    rules text,
    secret boolean DEFAULT false
);
    DROP TABLE public.sectors;
       public         heap    felixengelmann    false            �            1259    1682550    topo_images    TABLE     |  CREATE TABLE public.topo_images (
    area_id uuid NOT NULL,
    file_id uuid NOT NULL,
    id uuid NOT NULL,
    time_created timestamp without time zone,
    time_updated timestamp without time zone,
    created_by_id uuid,
    order_index integer DEFAULT 0 NOT NULL,
    lat double precision,
    lng double precision,
    description text,
    title character varying(120)
);
    DROP TABLE public.topo_images;
       public         heap    felixengelmann    false            �            1259    1682556    users    TABLE     �  CREATE TABLE public.users (
    id uuid NOT NULL,
    time_created timestamp without time zone,
    time_updated timestamp without time zone,
    password character varying(120) NOT NULL,
    email character varying(120) NOT NULL,
    firstname character varying(120),
    lastname character varying(120),
    activated boolean,
    activated_at timestamp without time zone,
    reset_password_hash character varying(120),
    reset_password_hash_created timestamp with time zone,
    language character varying DEFAULT 'de'::character varying NOT NULL,
    created_by_id uuid,
    avatar_id uuid,
    admin boolean DEFAULT false NOT NULL,
    member boolean DEFAULT false NOT NULL,
    new_email character varying(120),
    new_email_hash character varying(120),
    new_email_hash_created timestamp with time zone,
    moderator boolean DEFAULT false NOT NULL,
    slug character varying NOT NULL
);
    DROP TABLE public.users;
       public         heap    felixengelmann    false            -           2604    1682565    revoked_tokens id    DEFAULT     v   ALTER TABLE ONLY public.revoked_tokens ALTER COLUMN id SET DEFAULT nextval('public.revoked_tokens_id_seq'::regclass);
 @   ALTER TABLE public.revoked_tokens ALTER COLUMN id DROP DEFAULT;
       public          felixengelmann    false    230    229            ;          0    1682451    alembic_version 
   TABLE DATA           6   COPY public.alembic_version (version_num) FROM stdin;
    public          felixengelmann    false    216   ��       <          0    1682454    areas 
   TABLE DATA           �   COPY public.areas (name, description, lat, lng, id, time_created, time_updated, created_by_id, portrait_image_id, sector_id, slug, order_index, short_description, secret) FROM stdin;
    public          felixengelmann    false    217   ��       =          0    1682462    ascents 
   TABLE DATA           �   COPY public.ascents (line_id, flash, fa, soft, hard, grade_name, grade_scale, rating, comment, year, date, id, time_created, time_updated, created_by_id, with_kneepad, crag_id, sector_id, area_id, ascent_date) FROM stdin;
    public          felixengelmann    false    218   	�       >          0    1682467    crags 
   TABLE DATA           �   COPY public.crags (name, description, rules, id, time_created, time_updated, created_by_id, slug, short_description, portrait_image_id, order_index, lat, lng, secret) FROM stdin;
    public          felixengelmann    false    219   ��       ?          0    1682475    files 
   TABLE DATA           �   COPY public.files (id, time_created, time_updated, original_filename, filename, width, height, thumbnail_xs, thumbnail_s, thumbnail_m, thumbnail_l, thumbnail_xl, created_by_id) FROM stdin;
    public          felixengelmann    false    220   �       @          0    1682478    instance_settings 
   TABLE DATA           E  COPY public.instance_settings (id, time_updated, instance_name, copyright_owner, youtube_url, instagram_url, logo_image_id, favicon_image_id, auth_bg_image_id, main_bg_image_id, arrow_color, arrow_text_color, arrow_highlight_color, arrow_highlight_text_color, bar_chart_color, matomo_tracker_url, matomo_site_id) FROM stdin;
    public          felixengelmann    false    221   d�       A          0    1682488 
   line_paths 
   TABLE DATA           �   COPY public.line_paths (line_id, topo_image_id, path, id, time_created, time_updated, created_by_id, order_index, order_index_for_line) FROM stdin;
    public          felixengelmann    false    222   �       B          0    1682495    lines 
   TABLE DATA           �  COPY public.lines (name, description, type, eliminate, traverse, area_id, id, time_created, time_updated, created_by_id, slug, rating, fa_year, fa_name, highball, no_topout, roof, slab, vertical, overhang, athletic, technical, endurance, cruxy, dyno, jugs, sloper, pockets, crack, dihedral, compression, arete, crimps, pinches, grade_name, grade_scale, starting_position, mantle, videos, lowball, bad_dropzone, child_friendly, morpho, secret) FROM stdin;
    public          felixengelmann    false    223   ��       C          0    1682507 
   menu_items 
   TABLE DATA           �   COPY public.menu_items (type, "position", order_index, menu_page_id, id, time_created, time_updated, created_by_id, icon) FROM stdin;
    public          felixengelmann    false    224   n�       D          0    1682511 
   menu_pages 
   TABLE DATA           f   COPY public.menu_pages (title, text, slug, id, time_created, time_updated, created_by_id) FROM stdin;
    public          felixengelmann    false    225   ��       E          0    1682516    posts 
   TABLE DATA           a   COPY public.posts (title, text, slug, id, time_created, time_updated, created_by_id) FROM stdin;
    public          felixengelmann    false    226   ��       F          0    1682521    rankings 
   TABLE DATA             COPY public.rankings (id, crag_id, sector_id, user_id, top_10, top_25, top_10_fa, total, total_fa, type, top_values, top_fa_values, top_10_exponential, top_25_exponential, total_exponential, total_fa_exponential, total_count, total_fa_count, top_10_fa_exponential, secret) FROM stdin;
    public          felixengelmann    false    227   ��       G          0    1682528    regions 
   TABLE DATA           j   COPY public.regions (name, description, id, time_created, time_updated, created_by_id, rules) FROM stdin;
    public          felixengelmann    false    228   ��       H          0    1682534    revoked_tokens 
   TABLE DATA           1   COPY public.revoked_tokens (id, jti) FROM stdin;
    public          felixengelmann    false    229   $�       J          0    1682538    searchables 
   TABLE DATA           =   COPY public.searchables (name, type, id, secret) FROM stdin;
    public          felixengelmann    false    231   ��       K          0    1682542    sectors 
   TABLE DATA           �   COPY public.sectors (name, description, crag_id, id, time_created, time_updated, created_by_id, short_description, slug, portrait_image_id, order_index, lat, lng, rules, secret) FROM stdin;
    public          felixengelmann    false    232   a�       L          0    1682550    topo_images 
   TABLE DATA           �   COPY public.topo_images (area_id, file_id, id, time_created, time_updated, created_by_id, order_index, lat, lng, description, title) FROM stdin;
    public          felixengelmann    false    233   t�       M          0    1682556    users 
   TABLE DATA           '  COPY public.users (id, time_created, time_updated, password, email, firstname, lastname, activated, activated_at, reset_password_hash, reset_password_hash_created, language, created_by_id, avatar_id, admin, member, new_email, new_email_hash, new_email_hash_created, moderator, slug) FROM stdin;
    public          felixengelmann    false    234   O�       V           0    0    revoked_tokens_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.revoked_tokens_id_seq', 6, true);
          public          felixengelmann    false    230            7           2606    1682567 #   alembic_version alembic_version_pkc 
   CONSTRAINT     j   ALTER TABLE ONLY public.alembic_version
    ADD CONSTRAINT alembic_version_pkc PRIMARY KEY (version_num);
 M   ALTER TABLE ONLY public.alembic_version DROP CONSTRAINT alembic_version_pkc;
       public            felixengelmann    false    216            9           2606    1682569    areas areas_id_key 
   CONSTRAINT     K   ALTER TABLE ONLY public.areas
    ADD CONSTRAINT areas_id_key UNIQUE (id);
 <   ALTER TABLE ONLY public.areas DROP CONSTRAINT areas_id_key;
       public            felixengelmann    false    217            ;           2606    1682571    areas areas_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.areas
    ADD CONSTRAINT areas_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.areas DROP CONSTRAINT areas_pkey;
       public            felixengelmann    false    217            =           2606    1682573    areas areas_slug_key 
   CONSTRAINT     O   ALTER TABLE ONLY public.areas
    ADD CONSTRAINT areas_slug_key UNIQUE (slug);
 >   ALTER TABLE ONLY public.areas DROP CONSTRAINT areas_slug_key;
       public            felixengelmann    false    217            ?           2606    1682575    ascents ascents_id_key 
   CONSTRAINT     O   ALTER TABLE ONLY public.ascents
    ADD CONSTRAINT ascents_id_key UNIQUE (id);
 @   ALTER TABLE ONLY public.ascents DROP CONSTRAINT ascents_id_key;
       public            felixengelmann    false    218            A           2606    1682577    ascents ascents_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.ascents
    ADD CONSTRAINT ascents_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.ascents DROP CONSTRAINT ascents_pkey;
       public            felixengelmann    false    218            C           2606    1682579    crags crags_id_key 
   CONSTRAINT     K   ALTER TABLE ONLY public.crags
    ADD CONSTRAINT crags_id_key UNIQUE (id);
 <   ALTER TABLE ONLY public.crags DROP CONSTRAINT crags_id_key;
       public            felixengelmann    false    219            E           2606    1682581    crags crags_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.crags
    ADD CONSTRAINT crags_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.crags DROP CONSTRAINT crags_pkey;
       public            felixengelmann    false    219            G           2606    1682583    crags crags_slug_key 
   CONSTRAINT     O   ALTER TABLE ONLY public.crags
    ADD CONSTRAINT crags_slug_key UNIQUE (slug);
 >   ALTER TABLE ONLY public.crags DROP CONSTRAINT crags_slug_key;
       public            felixengelmann    false    219            I           2606    1682585    files files_id_key 
   CONSTRAINT     K   ALTER TABLE ONLY public.files
    ADD CONSTRAINT files_id_key UNIQUE (id);
 <   ALTER TABLE ONLY public.files DROP CONSTRAINT files_id_key;
       public            felixengelmann    false    220            K           2606    1682587    files files_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.files
    ADD CONSTRAINT files_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.files DROP CONSTRAINT files_pkey;
       public            felixengelmann    false    220            M           2606    1682589 *   instance_settings instance_settings_id_key 
   CONSTRAINT     c   ALTER TABLE ONLY public.instance_settings
    ADD CONSTRAINT instance_settings_id_key UNIQUE (id);
 T   ALTER TABLE ONLY public.instance_settings DROP CONSTRAINT instance_settings_id_key;
       public            felixengelmann    false    221            O           2606    1682591 (   instance_settings instance_settings_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.instance_settings
    ADD CONSTRAINT instance_settings_pkey PRIMARY KEY (id);
 R   ALTER TABLE ONLY public.instance_settings DROP CONSTRAINT instance_settings_pkey;
       public            felixengelmann    false    221            Q           2606    1682593    line_paths line_paths_id_key 
   CONSTRAINT     U   ALTER TABLE ONLY public.line_paths
    ADD CONSTRAINT line_paths_id_key UNIQUE (id);
 F   ALTER TABLE ONLY public.line_paths DROP CONSTRAINT line_paths_id_key;
       public            felixengelmann    false    222            S           2606    1682595    line_paths line_paths_pkey 
   CONSTRAINT     p   ALTER TABLE ONLY public.line_paths
    ADD CONSTRAINT line_paths_pkey PRIMARY KEY (line_id, topo_image_id, id);
 D   ALTER TABLE ONLY public.line_paths DROP CONSTRAINT line_paths_pkey;
       public            felixengelmann    false    222    222    222            U           2606    1682597    lines lines_id_key 
   CONSTRAINT     K   ALTER TABLE ONLY public.lines
    ADD CONSTRAINT lines_id_key UNIQUE (id);
 <   ALTER TABLE ONLY public.lines DROP CONSTRAINT lines_id_key;
       public            felixengelmann    false    223            W           2606    1682599    lines lines_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.lines
    ADD CONSTRAINT lines_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.lines DROP CONSTRAINT lines_pkey;
       public            felixengelmann    false    223            Y           2606    1682601    lines lines_slug_key 
   CONSTRAINT     O   ALTER TABLE ONLY public.lines
    ADD CONSTRAINT lines_slug_key UNIQUE (slug);
 >   ALTER TABLE ONLY public.lines DROP CONSTRAINT lines_slug_key;
       public            felixengelmann    false    223            [           2606    1682603    menu_items menu_items_id_key 
   CONSTRAINT     U   ALTER TABLE ONLY public.menu_items
    ADD CONSTRAINT menu_items_id_key UNIQUE (id);
 F   ALTER TABLE ONLY public.menu_items DROP CONSTRAINT menu_items_id_key;
       public            felixengelmann    false    224            ]           2606    1682605    menu_pages menu_pages_id_key 
   CONSTRAINT     U   ALTER TABLE ONLY public.menu_pages
    ADD CONSTRAINT menu_pages_id_key UNIQUE (id);
 F   ALTER TABLE ONLY public.menu_pages DROP CONSTRAINT menu_pages_id_key;
       public            felixengelmann    false    225            _           2606    1682607    menu_pages menu_pages_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.menu_pages
    ADD CONSTRAINT menu_pages_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.menu_pages DROP CONSTRAINT menu_pages_pkey;
       public            felixengelmann    false    225            a           2606    1682609    menu_pages menu_pages_slug_key 
   CONSTRAINT     Y   ALTER TABLE ONLY public.menu_pages
    ADD CONSTRAINT menu_pages_slug_key UNIQUE (slug);
 H   ALTER TABLE ONLY public.menu_pages DROP CONSTRAINT menu_pages_slug_key;
       public            felixengelmann    false    225            c           2606    1682611    posts posts_id_key 
   CONSTRAINT     K   ALTER TABLE ONLY public.posts
    ADD CONSTRAINT posts_id_key UNIQUE (id);
 <   ALTER TABLE ONLY public.posts DROP CONSTRAINT posts_id_key;
       public            felixengelmann    false    226            e           2606    1682613    posts posts_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.posts
    ADD CONSTRAINT posts_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.posts DROP CONSTRAINT posts_pkey;
       public            felixengelmann    false    226            g           2606    1682615    posts posts_slug_key 
   CONSTRAINT     O   ALTER TABLE ONLY public.posts
    ADD CONSTRAINT posts_slug_key UNIQUE (slug);
 >   ALTER TABLE ONLY public.posts DROP CONSTRAINT posts_slug_key;
       public            felixengelmann    false    226            i           2606    1682617    rankings rankings_id_key 
   CONSTRAINT     Q   ALTER TABLE ONLY public.rankings
    ADD CONSTRAINT rankings_id_key UNIQUE (id);
 B   ALTER TABLE ONLY public.rankings DROP CONSTRAINT rankings_id_key;
       public            felixengelmann    false    227            k           2606    1682619    rankings rankings_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.rankings
    ADD CONSTRAINT rankings_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.rankings DROP CONSTRAINT rankings_pkey;
       public            felixengelmann    false    227            m           2606    1682621    regions regions_id_key 
   CONSTRAINT     O   ALTER TABLE ONLY public.regions
    ADD CONSTRAINT regions_id_key UNIQUE (id);
 @   ALTER TABLE ONLY public.regions DROP CONSTRAINT regions_id_key;
       public            felixengelmann    false    228            o           2606    1682623    regions regions_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.regions
    ADD CONSTRAINT regions_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.regions DROP CONSTRAINT regions_pkey;
       public            felixengelmann    false    228            q           2606    1682625 "   revoked_tokens revoked_tokens_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.revoked_tokens
    ADD CONSTRAINT revoked_tokens_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.revoked_tokens DROP CONSTRAINT revoked_tokens_pkey;
       public            felixengelmann    false    229            s           2606    1682627    searchables searchables_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.searchables
    ADD CONSTRAINT searchables_pkey PRIMARY KEY (type, id);
 F   ALTER TABLE ONLY public.searchables DROP CONSTRAINT searchables_pkey;
       public            felixengelmann    false    231    231            u           2606    1682629    sectors sectors_id_key 
   CONSTRAINT     O   ALTER TABLE ONLY public.sectors
    ADD CONSTRAINT sectors_id_key UNIQUE (id);
 @   ALTER TABLE ONLY public.sectors DROP CONSTRAINT sectors_id_key;
       public            felixengelmann    false    232            w           2606    1682631    sectors sectors_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.sectors
    ADD CONSTRAINT sectors_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.sectors DROP CONSTRAINT sectors_pkey;
       public            felixengelmann    false    232            y           2606    1682633    sectors sectors_slug_key 
   CONSTRAINT     S   ALTER TABLE ONLY public.sectors
    ADD CONSTRAINT sectors_slug_key UNIQUE (slug);
 B   ALTER TABLE ONLY public.sectors DROP CONSTRAINT sectors_slug_key;
       public            felixengelmann    false    232            {           2606    1682635    topo_images topo_images_id_key 
   CONSTRAINT     W   ALTER TABLE ONLY public.topo_images
    ADD CONSTRAINT topo_images_id_key UNIQUE (id);
 H   ALTER TABLE ONLY public.topo_images DROP CONSTRAINT topo_images_id_key;
       public            felixengelmann    false    233            }           2606    1682637    topo_images topo_images_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY public.topo_images
    ADD CONSTRAINT topo_images_pkey PRIMARY KEY (area_id, file_id, id);
 F   ALTER TABLE ONLY public.topo_images DROP CONSTRAINT topo_images_pkey;
       public            felixengelmann    false    233    233    233                       2606    1682639    users users_email_key 
   CONSTRAINT     Q   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);
 ?   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key;
       public            felixengelmann    false    234            �           2606    1682641    users users_id_key 
   CONSTRAINT     K   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_id_key UNIQUE (id);
 <   ALTER TABLE ONLY public.users DROP CONSTRAINT users_id_key;
       public            felixengelmann    false    234            �           2606    1682643    users users_new_email_key 
   CONSTRAINT     Y   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_new_email_key UNIQUE (new_email);
 C   ALTER TABLE ONLY public.users DROP CONSTRAINT users_new_email_key;
       public            felixengelmann    false    234            �           2606    1682645    users users_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            felixengelmann    false    234            �           2606    1682647    users users_slug_key 
   CONSTRAINT     O   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_slug_key UNIQUE (slug);
 >   ALTER TABLE ONLY public.users DROP CONSTRAINT users_slug_key;
       public            felixengelmann    false    234            �           2606    1682648    areas areas_created_by_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.areas
    ADD CONSTRAINT areas_created_by_id_fkey FOREIGN KEY (created_by_id) REFERENCES public.users(id) ON DELETE SET NULL;
 H   ALTER TABLE ONLY public.areas DROP CONSTRAINT areas_created_by_id_fkey;
       public          felixengelmann    false    234    217    3713            �           2606    1682653 "   areas areas_portrait_image_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.areas
    ADD CONSTRAINT areas_portrait_image_id_fkey FOREIGN KEY (portrait_image_id) REFERENCES public.files(id);
 L   ALTER TABLE ONLY public.areas DROP CONSTRAINT areas_portrait_image_id_fkey;
       public          felixengelmann    false    217    220    3657            �           2606    1682658    areas areas_sector_id_fkey    FK CONSTRAINT     }   ALTER TABLE ONLY public.areas
    ADD CONSTRAINT areas_sector_id_fkey FOREIGN KEY (sector_id) REFERENCES public.sectors(id);
 D   ALTER TABLE ONLY public.areas DROP CONSTRAINT areas_sector_id_fkey;
       public          felixengelmann    false    217    232    3701            �           2606    1682663    ascents ascents_area_id_fkey    FK CONSTRAINT     {   ALTER TABLE ONLY public.ascents
    ADD CONSTRAINT ascents_area_id_fkey FOREIGN KEY (area_id) REFERENCES public.areas(id);
 F   ALTER TABLE ONLY public.ascents DROP CONSTRAINT ascents_area_id_fkey;
       public          felixengelmann    false    3641    217    218            �           2606    1682668    ascents ascents_crag_id_fkey    FK CONSTRAINT     {   ALTER TABLE ONLY public.ascents
    ADD CONSTRAINT ascents_crag_id_fkey FOREIGN KEY (crag_id) REFERENCES public.crags(id);
 F   ALTER TABLE ONLY public.ascents DROP CONSTRAINT ascents_crag_id_fkey;
       public          felixengelmann    false    219    3651    218            �           2606    1682673 "   ascents ascents_created_by_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.ascents
    ADD CONSTRAINT ascents_created_by_id_fkey FOREIGN KEY (created_by_id) REFERENCES public.users(id);
 L   ALTER TABLE ONLY public.ascents DROP CONSTRAINT ascents_created_by_id_fkey;
       public          felixengelmann    false    218    3713    234            �           2606    1682678    ascents ascents_line_id_fkey    FK CONSTRAINT     {   ALTER TABLE ONLY public.ascents
    ADD CONSTRAINT ascents_line_id_fkey FOREIGN KEY (line_id) REFERENCES public.lines(id);
 F   ALTER TABLE ONLY public.ascents DROP CONSTRAINT ascents_line_id_fkey;
       public          felixengelmann    false    3669    218    223            �           2606    1682683    ascents ascents_sector_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.ascents
    ADD CONSTRAINT ascents_sector_id_fkey FOREIGN KEY (sector_id) REFERENCES public.sectors(id);
 H   ALTER TABLE ONLY public.ascents DROP CONSTRAINT ascents_sector_id_fkey;
       public          felixengelmann    false    218    3701    232            �           2606    1682688    crags crags_created_by_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.crags
    ADD CONSTRAINT crags_created_by_id_fkey FOREIGN KEY (created_by_id) REFERENCES public.users(id) ON DELETE SET NULL;
 H   ALTER TABLE ONLY public.crags DROP CONSTRAINT crags_created_by_id_fkey;
       public          felixengelmann    false    234    3713    219            �           2606    1682693 "   crags crags_portrait_image_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.crags
    ADD CONSTRAINT crags_portrait_image_id_fkey FOREIGN KEY (portrait_image_id) REFERENCES public.files(id);
 L   ALTER TABLE ONLY public.crags DROP CONSTRAINT crags_portrait_image_id_fkey;
       public          felixengelmann    false    3657    220    219            �           2606    1682698    files files_created_by_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.files
    ADD CONSTRAINT files_created_by_id_fkey FOREIGN KEY (created_by_id) REFERENCES public.users(id) ON DELETE SET NULL;
 H   ALTER TABLE ONLY public.files DROP CONSTRAINT files_created_by_id_fkey;
       public          felixengelmann    false    3713    234    220            �           2606    1682703 9   instance_settings instance_settings_auth_bg_image_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.instance_settings
    ADD CONSTRAINT instance_settings_auth_bg_image_id_fkey FOREIGN KEY (auth_bg_image_id) REFERENCES public.files(id);
 c   ALTER TABLE ONLY public.instance_settings DROP CONSTRAINT instance_settings_auth_bg_image_id_fkey;
       public          felixengelmann    false    221    3657    220            �           2606    1682708 9   instance_settings instance_settings_favicon_image_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.instance_settings
    ADD CONSTRAINT instance_settings_favicon_image_id_fkey FOREIGN KEY (favicon_image_id) REFERENCES public.files(id);
 c   ALTER TABLE ONLY public.instance_settings DROP CONSTRAINT instance_settings_favicon_image_id_fkey;
       public          felixengelmann    false    220    221    3657            �           2606    1682713 6   instance_settings instance_settings_logo_image_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.instance_settings
    ADD CONSTRAINT instance_settings_logo_image_id_fkey FOREIGN KEY (logo_image_id) REFERENCES public.files(id);
 `   ALTER TABLE ONLY public.instance_settings DROP CONSTRAINT instance_settings_logo_image_id_fkey;
       public          felixengelmann    false    220    3657    221            �           2606    1682718 9   instance_settings instance_settings_main_bg_image_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.instance_settings
    ADD CONSTRAINT instance_settings_main_bg_image_id_fkey FOREIGN KEY (main_bg_image_id) REFERENCES public.files(id);
 c   ALTER TABLE ONLY public.instance_settings DROP CONSTRAINT instance_settings_main_bg_image_id_fkey;
       public          felixengelmann    false    3657    221    220            �           2606    1682723 (   line_paths line_paths_created_by_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.line_paths
    ADD CONSTRAINT line_paths_created_by_id_fkey FOREIGN KEY (created_by_id) REFERENCES public.users(id) ON DELETE SET NULL;
 R   ALTER TABLE ONLY public.line_paths DROP CONSTRAINT line_paths_created_by_id_fkey;
       public          felixengelmann    false    3713    234    222            �           2606    1682728 "   line_paths line_paths_line_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.line_paths
    ADD CONSTRAINT line_paths_line_id_fkey FOREIGN KEY (line_id) REFERENCES public.lines(id);
 L   ALTER TABLE ONLY public.line_paths DROP CONSTRAINT line_paths_line_id_fkey;
       public          felixengelmann    false    222    3669    223            �           2606    1682733 (   line_paths line_paths_topo_image_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.line_paths
    ADD CONSTRAINT line_paths_topo_image_id_fkey FOREIGN KEY (topo_image_id) REFERENCES public.topo_images(id);
 R   ALTER TABLE ONLY public.line_paths DROP CONSTRAINT line_paths_topo_image_id_fkey;
       public          felixengelmann    false    3707    222    233            �           2606    1682738    lines lines_area_id_fkey    FK CONSTRAINT     w   ALTER TABLE ONLY public.lines
    ADD CONSTRAINT lines_area_id_fkey FOREIGN KEY (area_id) REFERENCES public.areas(id);
 B   ALTER TABLE ONLY public.lines DROP CONSTRAINT lines_area_id_fkey;
       public          felixengelmann    false    217    223    3641            �           2606    1682743    lines lines_created_by_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.lines
    ADD CONSTRAINT lines_created_by_id_fkey FOREIGN KEY (created_by_id) REFERENCES public.users(id) ON DELETE SET NULL;
 H   ALTER TABLE ONLY public.lines DROP CONSTRAINT lines_created_by_id_fkey;
       public          felixengelmann    false    223    3713    234            �           2606    1682748 (   menu_items menu_items_created_by_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.menu_items
    ADD CONSTRAINT menu_items_created_by_id_fkey FOREIGN KEY (created_by_id) REFERENCES public.users(id) ON DELETE SET NULL;
 R   ALTER TABLE ONLY public.menu_items DROP CONSTRAINT menu_items_created_by_id_fkey;
       public          felixengelmann    false    234    3713    224            �           2606    1682753 '   menu_items menu_items_menu_page_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.menu_items
    ADD CONSTRAINT menu_items_menu_page_id_fkey FOREIGN KEY (menu_page_id) REFERENCES public.menu_pages(id);
 Q   ALTER TABLE ONLY public.menu_items DROP CONSTRAINT menu_items_menu_page_id_fkey;
       public          felixengelmann    false    3677    224    225            �           2606    1682758 (   menu_pages menu_pages_created_by_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.menu_pages
    ADD CONSTRAINT menu_pages_created_by_id_fkey FOREIGN KEY (created_by_id) REFERENCES public.users(id) ON DELETE SET NULL;
 R   ALTER TABLE ONLY public.menu_pages DROP CONSTRAINT menu_pages_created_by_id_fkey;
       public          felixengelmann    false    225    234    3713            �           2606    1682763    posts posts_created_by_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.posts
    ADD CONSTRAINT posts_created_by_id_fkey FOREIGN KEY (created_by_id) REFERENCES public.users(id) ON DELETE SET NULL;
 H   ALTER TABLE ONLY public.posts DROP CONSTRAINT posts_created_by_id_fkey;
       public          felixengelmann    false    226    3713    234            �           2606    1682768    rankings rankings_crag_id_fkey    FK CONSTRAINT     }   ALTER TABLE ONLY public.rankings
    ADD CONSTRAINT rankings_crag_id_fkey FOREIGN KEY (crag_id) REFERENCES public.crags(id);
 H   ALTER TABLE ONLY public.rankings DROP CONSTRAINT rankings_crag_id_fkey;
       public          felixengelmann    false    219    227    3651            �           2606    1682773     rankings rankings_sector_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.rankings
    ADD CONSTRAINT rankings_sector_id_fkey FOREIGN KEY (sector_id) REFERENCES public.sectors(id);
 J   ALTER TABLE ONLY public.rankings DROP CONSTRAINT rankings_sector_id_fkey;
       public          felixengelmann    false    3701    227    232            �           2606    1682778    rankings rankings_user_id_fkey    FK CONSTRAINT     }   ALTER TABLE ONLY public.rankings
    ADD CONSTRAINT rankings_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);
 H   ALTER TABLE ONLY public.rankings DROP CONSTRAINT rankings_user_id_fkey;
       public          felixengelmann    false    3713    227    234            �           2606    1682783 "   regions regions_created_by_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.regions
    ADD CONSTRAINT regions_created_by_id_fkey FOREIGN KEY (created_by_id) REFERENCES public.users(id) ON DELETE SET NULL;
 L   ALTER TABLE ONLY public.regions DROP CONSTRAINT regions_created_by_id_fkey;
       public          felixengelmann    false    3713    228    234            �           2606    1682788    sectors sectors_crag_id_fkey    FK CONSTRAINT     {   ALTER TABLE ONLY public.sectors
    ADD CONSTRAINT sectors_crag_id_fkey FOREIGN KEY (crag_id) REFERENCES public.crags(id);
 F   ALTER TABLE ONLY public.sectors DROP CONSTRAINT sectors_crag_id_fkey;
       public          felixengelmann    false    3651    232    219            �           2606    1682793 "   sectors sectors_created_by_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.sectors
    ADD CONSTRAINT sectors_created_by_id_fkey FOREIGN KEY (created_by_id) REFERENCES public.users(id) ON DELETE SET NULL;
 L   ALTER TABLE ONLY public.sectors DROP CONSTRAINT sectors_created_by_id_fkey;
       public          felixengelmann    false    234    232    3713            �           2606    1682798 &   sectors sectors_portrait_image_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.sectors
    ADD CONSTRAINT sectors_portrait_image_id_fkey FOREIGN KEY (portrait_image_id) REFERENCES public.files(id);
 P   ALTER TABLE ONLY public.sectors DROP CONSTRAINT sectors_portrait_image_id_fkey;
       public          felixengelmann    false    220    232    3657            �           2606    1682803 $   topo_images topo_images_area_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.topo_images
    ADD CONSTRAINT topo_images_area_id_fkey FOREIGN KEY (area_id) REFERENCES public.areas(id);
 N   ALTER TABLE ONLY public.topo_images DROP CONSTRAINT topo_images_area_id_fkey;
       public          felixengelmann    false    233    3641    217            �           2606    1682808 *   topo_images topo_images_created_by_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.topo_images
    ADD CONSTRAINT topo_images_created_by_id_fkey FOREIGN KEY (created_by_id) REFERENCES public.users(id) ON DELETE SET NULL;
 T   ALTER TABLE ONLY public.topo_images DROP CONSTRAINT topo_images_created_by_id_fkey;
       public          felixengelmann    false    234    233    3713            �           2606    1682813 $   topo_images topo_images_file_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.topo_images
    ADD CONSTRAINT topo_images_file_id_fkey FOREIGN KEY (file_id) REFERENCES public.files(id);
 N   ALTER TABLE ONLY public.topo_images DROP CONSTRAINT topo_images_file_id_fkey;
       public          felixengelmann    false    3657    233    220            �           2606    1682818    users users_avatar_id_fkey    FK CONSTRAINT     {   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_avatar_id_fkey FOREIGN KEY (avatar_id) REFERENCES public.files(id);
 D   ALTER TABLE ONLY public.users DROP CONSTRAINT users_avatar_id_fkey;
       public          felixengelmann    false    220    3657    234            �           2606    1682823    users users_created_by_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_created_by_id_fkey FOREIGN KEY (created_by_id) REFERENCES public.users(id) ON DELETE SET NULL;
 H   ALTER TABLE ONLY public.users DROP CONSTRAINT users_created_by_id_fkey;
       public          felixengelmann    false    3713    234    234            ;      x�31L5H2HNLI2������ .;6      <   '  x���=n�0Fg�� ]�P"t�d��1�؁�v��+7�2$4}�����t�G�+s���a�,�2҂�(�p��8A��`\�6�]X;lư|`z��AI�d	��!
'�2:4i��H|,�ɀ6{hs!d;
,�SVcm	�%俖v9�Vos��Y�I��k�Џ��\����Q.������n��󢏿��9�l^�[��r�qiUB��c��\[)J�p"�)wB�,��Y�[#6�B��o�
�B6Yh� G[�QB����3�*"<����C�Z�~ C��      =   �   x�M�;N�1�����xe'~e;((鑶�G���@��T�7c���E�1�oRV�v��^v���������W��x-��R�2 iIg��[�j����3���Br'����X��H��ˡ���>OD�
:������#&K�0�����A�)ݝ���J��8��}D��6�Iޣ���Ѐau``��ŞF�O������_��I8      >     x����n1Eי��0�$����e�.�f�`�j@����:-��V�"Yr,瞓���C��juZ�Ȱ/����a,}���zi��#����6���P��[ٗ���"��M�B!U,�98H&��E8GT���u��R�um��V�^UgɄ`+.($b؁K�C��	Y�{���x�#���s[ǎPGB�eq�D!�Yu���S���w	��ⱂ�-YÐPO �B�� w�X�~:薖=j���8G},����n���P�	��"��O5(���M�| �	��      ?   ?  x���Mj1���S�2Y�)IU���@L!0�ҟq09�{B��V�������$��	b@�Dڒ����!AJ4�t����f�D����x:/�o��T�zh-����=�F�P4�]� �y�1�	��0t̀���7Q��^�ld�Z�91`--�� x��W6��쬸&X1.�J���^�Ώ���}^n��(4 E[,�cmcHf4��"�i����o��̒7����#q���\��Kڴ.�aŸ�>��>�}���� ~J�?� ��7�RgRA�]r��e
�azQ�HɷB��ao�0�դ�c�vD�WE/��' Z�������Q�h.��f��E�}R�l�GRGlEBԘ��ۂp��������3-#o�cZH$%|[��1���'�-C�L1&����g���s�,<q�4�teS�u� ���Hk��E�e����g��������}�|����E�/	�����l��^�B���g$> û�S��&��}��H�WҤz߽L������_��?��<
�&H�s�
S͋�H�������;�;�o�����ޖ=�      @   �   x�]�1�0��_�`ڗ���U��K��vHLI[�o#��q�qppRkC[eŃ��RM(�ue���(������`��G��%̑?�'�yO���OY�P֐������V�T�pq��~��qW�L�A/�G�K�v�ͭ�$�挱72�      A   �  x����q1�ϫ*T�����"Ҁ���쿄@�����s��	~��;�:p5c�&h�F�j�'�0�%69c�m3�B���tj��<e`no�nW��$`h�"z���PG��U��=�1+z�r�/�j�u3%��D��?��)Ǻ���Ըu����o.���ltx6�C[ m8�E���o$��\��wɎ�	�����J]�E#��$vm�Ӛ푱�P��`�K&���(��m�Q������M�!���oW�N
����`�OH��hw�``�zA�,�Xݮ�	db#���o4�;��6fK9����G�D�gR~���mLX��;�-1ұ�6a�Z��佭A��ոۛ���4;��G-/*��T�S>A�G��~�E��~��O_b��K�.��y����a�
w��&G�9��R����bb���pE�����p  ���?��r���>      B   �  x���͎�0���S��q��W�hY��v�AÉE�vƴ�4�҄�oƍ�-ET�Vh,{<����s5`�#��/��������:���yI�^�{u�|KB4��+���Th��2�)/\��+@�@L����Q#}M0�@�s
_���L�(S	���2�gBIC�n	H��������؇E��F'���q���+����qs^7[M=t�hkP���!y��Ǻ���`�{�MM�>�?6�	5���D@�1NQ֘���/��d2�`4秔���%@	23F��a�vG��?
��>r���K�l?a��m��'&��;���zqD�����o�44i���q�w�|��ﳯ�4N3�m�{;����O���O���E�8I����.����/��l���      C   o  x����nAE��W��r����H!��0`���?!�-c5j���sp���v�z?�]��m߷�-^�H�[.X!!#p�[F�T����������JHQ���1��?0� ���ɍl��-(S��� NU GWК<�������C\&-hЙҡ�	JW�(��9�Ѣ��#�5�q@
& ��h!}7��2�N�'��}[�3�f�-I��Ђ�j�U(����v"�A5�W'�Q�������r�c"C�|�`��!Y����j9��gc\mV�3쟷�����|=�GT�\@�Ͻ�\���HK��W�Gt[��>C�]~��/5O�M�϶݀��4��J��Ց�A庪	�<�\O��_Ƥ��      D   �   x���;N�0Ekg��~�{4���i�(���g&���ؑ�a'l������=^�j]/l?nFZxmtn�Ɖ?���������Ư�M!S�Tpt�5���!�3>3)��@j�~��S�wh���t��h�)@�
h�D,��/IK-BwM5���L����˲N�?p�������齢�$��۰-v�F	���Ф7�A�>`L�Et�>p껮{8�it      E   �   x��ϽN�0��9y
�s�����ʎDK�󗜁4��۱�b8AL,����~�����i^��^��Ҝ���Z�G6���i����xi>j?5�[m"r�!�ѤA�0:�U�����R� 4���	��(�۵Z��:Cr)��A�΀	���Tܵ�{(l���if�QV�J։��io�VZ�P�v�P7ac��d�5��(�(F��k̝�����V�{o��m�}@a�      F   �   x���1ND1�z�]�l�N�A�@B�b)�Ĺ��`5�є�6��rhh�5!���&_������VRif���6�M�hޡOs�),��?}|�xyz~�|2����Cg~�>bL��᳁�tT�^kk%�I�D�m��6��*Щ����Ml$�t
�1�0%X��QC�P�aM��-L:��5@��6�<�#�>��r+o�      G   h   x��=
�0�:9�^`�L�	_.��bi������^�f���p����ۺ���!Ij����:HX#3b�.n��Xet�e{�R�r�Ԑ1�D	�y~�z�o��      H   �   x���!ߚ[����}D0���Tw5�ȵI�f0��Bx
,��2Y�>��>������6c�D��rB��lrGe�tc!�� խ�a.��NʱZ�����+^������.m�p*f@�l��/L&́��O�v%r���o�hC`�G[$�xJ�}��?�:t      J   {  x���M�A�u�}��/�2	BB3R2�ؔ]�Ik��	��SQ�	�|����&׫�ϟ�F�k�d����7�A�Հ'2-qJT�j��lp�nR�lj��VM��|&(�H��F�;}Z�2ȴ�d�ڟƽBv�4��� XC��ǔ��}���v�m8�+�?�e�����c��H��$[���~;3�D�%ӯ�3�Iu�/�'���3BJƂ/�I�g�Ft�X2��|)}�r+��5��U ����:"IR�) ����2m�2񪎧�G)&G {�M��Q���\�^�a��E�b\ֶ���}��M����|�y�5�˫��ʲ�/��L�1�d���s9Bd���[��߬����~}���~�Ů�      K     x��P=oB1��~���N�$6B][�CW�$������ԅ.�ɲ�����Egcr.����PF<�Ql� �dB�ER���8@��C�E�1�b��>�΍6,1-��ě͛��<sh����.�%B�,�
9B1����ƾ�_�������9��a��筎�z�����eގ���x�Z=֏CdJ<)�d�>M�m)p�,�O0Z�ر�H����^.������W����(�n��!�Z|C�<��?�,�a��{e      L   �   x��λmC1��Zw�,������)����H ��S����9bR��VZxf���W+�"Q�Aƹ;s߆���M��)��sB?M��P����I 	P��|�>�ߣ�i{=[Wa3-ؾ�Xֱ���*�N����w���O9h����:�P�� 0~�e�l�V2Hc%$��5 �T�������4�������_�u]߂u_,      M     x��һN�0��~�Y|9ǵ;!BJ	��.N����ޞVT		DE�Jg��_>ç#�1�Yf3���Ȝ����X���-�\J�-��#l��U�5(�m��#6����h� �:YN�d��Iԁ����*J�'�P����-��AzXi�0o��׫dt7���n��q]7�`����"�*uy�즧>+�Y^��'���yC����8��M�{��iM����Be[�}��LP���~������俁(�G���?� ���w`@y�     