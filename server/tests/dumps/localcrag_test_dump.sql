PGDMP         '                |            localcrag_dev    14.8 (Homebrew)    14.11 (Homebrew) W    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    68766542    localcrag_dev    DATABASE     X   CREATE DATABASE localcrag_dev WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'C';
    DROP DATABASE localcrag_dev;
                felixengelmann    false                        3079    68766544 	   uuid-ossp 	   EXTENSION     ?   CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;
    DROP EXTENSION "uuid-ossp";
                   false            �           0    0    EXTENSION "uuid-ossp"    COMMENT     W   COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';
                        false    2            M           1247 	   134033401    linetypeenum    TYPE     T   CREATE TYPE public.linetypeenum AS ENUM (
    'BOULDER',
    'SPORT',
    'TRAD'
);
    DROP TYPE public.linetypeenum;
       public          felixengelmann    false            P           1247 	   134033408    startingpositionenum    TYPE     v   CREATE TYPE public.startingpositionenum AS ENUM (
    'SIT',
    'STAND',
    'CROUCH',
    'FRENCH',
    'CANDLE'
);
 '   DROP TYPE public.startingpositionenum;
       public          felixengelmann    false            �            1259 	   134033419    alembic_version    TABLE     X   CREATE TABLE public.alembic_version (
    version_num character varying(32) NOT NULL
);
 #   DROP TABLE public.alembic_version;
       public         heap    felixengelmann    false            �            1259 	   134033422    areas    TABLE     �  CREATE TABLE public.areas (
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
    short_description text
);
    DROP TABLE public.areas;
       public         heap    felixengelmann    false            �            1259 	   134033428    crags    TABLE     �  CREATE TABLE public.crags (
    name character varying(120) NOT NULL,
    description text,
    rules text,
    region_id uuid NOT NULL,
    id uuid NOT NULL,
    time_created timestamp without time zone,
    time_updated timestamp without time zone,
    created_by_id uuid,
    slug character varying(120) NOT NULL,
    short_description text,
    portrait_image_id uuid,
    order_index integer DEFAULT 0 NOT NULL,
    lat double precision,
    lng double precision
);
    DROP TABLE public.crags;
       public         heap    felixengelmann    false            �            1259 	   134033434    files    TABLE     �  CREATE TABLE public.files (
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
       public         heap    felixengelmann    false            �            1259 	   134033437 
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
       public         heap    felixengelmann    false            �            1259 	   134033444    lines    TABLE     d  CREATE TABLE public.lines (
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
    bad_dropzone boolean DEFAULT false NOT NULL
);
    DROP TABLE public.lines;
       public         heap    felixengelmann    false    848    845            �            1259 	   134033450    posts    TABLE       CREATE TABLE public.posts (
    title character varying(120) NOT NULL,
    text text,
    slug character varying NOT NULL,
    id uuid NOT NULL,
    time_created timestamp without time zone,
    time_updated timestamp without time zone,
    created_by_id uuid
);
    DROP TABLE public.posts;
       public         heap    felixengelmann    false            �            1259 	   134033455    regions    TABLE       CREATE TABLE public.regions (
    name character varying(120) NOT NULL,
    description text,
    id uuid NOT NULL,
    time_created timestamp without time zone,
    time_updated timestamp without time zone,
    created_by_id uuid,
    slug character varying NOT NULL
);
    DROP TABLE public.regions;
       public         heap    felixengelmann    false            �            1259 	   134033460    revoked_tokens    TABLE     `   CREATE TABLE public.revoked_tokens (
    id integer NOT NULL,
    jti character varying(120)
);
 "   DROP TABLE public.revoked_tokens;
       public         heap    felixengelmann    false            �            1259 	   134033463    revoked_tokens_id_seq    SEQUENCE     �   CREATE SEQUENCE public.revoked_tokens_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.revoked_tokens_id_seq;
       public          felixengelmann    false    218            �           0    0    revoked_tokens_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.revoked_tokens_id_seq OWNED BY public.revoked_tokens.id;
          public          felixengelmann    false    219            �            1259 	   134033464    sectors    TABLE     �  CREATE TABLE public.sectors (
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
    lng double precision
);
    DROP TABLE public.sectors;
       public         heap    felixengelmann    false            �            1259 	   134033470    topo_images    TABLE       CREATE TABLE public.topo_images (
    area_id uuid NOT NULL,
    file_id uuid NOT NULL,
    id uuid NOT NULL,
    time_created timestamp without time zone,
    time_updated timestamp without time zone,
    created_by_id uuid,
    order_index integer DEFAULT 0 NOT NULL
);
    DROP TABLE public.topo_images;
       public         heap    felixengelmann    false            �            1259 	   134033474    users    TABLE     �  CREATE TABLE public.users (
    id uuid NOT NULL,
    time_created timestamp without time zone,
    time_updated timestamp without time zone,
    password character varying(120) NOT NULL,
    email character varying(120) NOT NULL,
    firstname character varying(120),
    lastname character varying(120),
    locked boolean,
    activated boolean,
    activated_at timestamp without time zone,
    reset_password_hash character varying(120),
    reset_password_hash_created timestamp with time zone,
    language character varying DEFAULT 'de'::character varying NOT NULL,
    color_scheme character varying NOT NULL,
    created_by_id uuid,
    avatar_id uuid,
    deleted boolean,
    deleted_at timestamp without time zone
);
    DROP TABLE public.users;
       public         heap    felixengelmann    false            �           2604 	   134033480    revoked_tokens id    DEFAULT     v   ALTER TABLE ONLY public.revoked_tokens ALTER COLUMN id SET DEFAULT nextval('public.revoked_tokens_id_seq'::regclass);
 @   ALTER TABLE public.revoked_tokens ALTER COLUMN id DROP DEFAULT;
       public          felixengelmann    false    219    218            �          0 	   134033419    alembic_version 
   TABLE DATA                 public          felixengelmann    false    210   �u       �          0 	   134033422    areas 
   TABLE DATA                 public          felixengelmann    false    211   v       �          0 	   134033428    crags 
   TABLE DATA                 public          felixengelmann    false    212   sw       �          0 	   134033434    files 
   TABLE DATA                 public          felixengelmann    false    213   �x       �          0 	   134033437 
   line_paths 
   TABLE DATA                 public          felixengelmann    false    214   }{       �          0 	   134033444    lines 
   TABLE DATA                 public          felixengelmann    false    215   �}       �          0 	   134033450    posts 
   TABLE DATA                 public          felixengelmann    false    216   Z       �          0 	   134033455    regions 
   TABLE DATA                 public          felixengelmann    false    217   ��       �          0 	   134033460    revoked_tokens 
   TABLE DATA                 public          felixengelmann    false    218   '�       �          0 	   134033464    sectors 
   TABLE DATA                 public          felixengelmann    false    220   ��       �          0 	   134033470    topo_images 
   TABLE DATA                 public          felixengelmann    false    221   �       �          0 	   134033474    users 
   TABLE DATA                 public          felixengelmann    false    222   �       �           0    0    revoked_tokens_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.revoked_tokens_id_seq', 2, true);
          public          felixengelmann    false    219            �           2606 	   134033482 #   alembic_version alembic_version_pkc 
   CONSTRAINT     j   ALTER TABLE ONLY public.alembic_version
    ADD CONSTRAINT alembic_version_pkc PRIMARY KEY (version_num);
 M   ALTER TABLE ONLY public.alembic_version DROP CONSTRAINT alembic_version_pkc;
       public            felixengelmann    false    210            �           2606 	   134033484    areas areas_id_key 
   CONSTRAINT     K   ALTER TABLE ONLY public.areas
    ADD CONSTRAINT areas_id_key UNIQUE (id);
 <   ALTER TABLE ONLY public.areas DROP CONSTRAINT areas_id_key;
       public            felixengelmann    false    211            �           2606 	   134033486    areas areas_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.areas
    ADD CONSTRAINT areas_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.areas DROP CONSTRAINT areas_pkey;
       public            felixengelmann    false    211            �           2606 	   134033488    areas areas_slug_key 
   CONSTRAINT     O   ALTER TABLE ONLY public.areas
    ADD CONSTRAINT areas_slug_key UNIQUE (slug);
 >   ALTER TABLE ONLY public.areas DROP CONSTRAINT areas_slug_key;
       public            felixengelmann    false    211            �           2606 	   134033490    crags crags_id_key 
   CONSTRAINT     K   ALTER TABLE ONLY public.crags
    ADD CONSTRAINT crags_id_key UNIQUE (id);
 <   ALTER TABLE ONLY public.crags DROP CONSTRAINT crags_id_key;
       public            felixengelmann    false    212            �           2606 	   134033492    crags crags_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.crags
    ADD CONSTRAINT crags_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.crags DROP CONSTRAINT crags_pkey;
       public            felixengelmann    false    212            �           2606 	   134033494    crags crags_slug_key 
   CONSTRAINT     O   ALTER TABLE ONLY public.crags
    ADD CONSTRAINT crags_slug_key UNIQUE (slug);
 >   ALTER TABLE ONLY public.crags DROP CONSTRAINT crags_slug_key;
       public            felixengelmann    false    212            �           2606 	   134033496    files files_id_key 
   CONSTRAINT     K   ALTER TABLE ONLY public.files
    ADD CONSTRAINT files_id_key UNIQUE (id);
 <   ALTER TABLE ONLY public.files DROP CONSTRAINT files_id_key;
       public            felixengelmann    false    213            �           2606 	   134033498    files files_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.files
    ADD CONSTRAINT files_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.files DROP CONSTRAINT files_pkey;
       public            felixengelmann    false    213            �           2606 	   134033500    line_paths line_paths_id_key 
   CONSTRAINT     U   ALTER TABLE ONLY public.line_paths
    ADD CONSTRAINT line_paths_id_key UNIQUE (id);
 F   ALTER TABLE ONLY public.line_paths DROP CONSTRAINT line_paths_id_key;
       public            felixengelmann    false    214            �           2606 	   134033502    line_paths line_paths_pkey 
   CONSTRAINT     p   ALTER TABLE ONLY public.line_paths
    ADD CONSTRAINT line_paths_pkey PRIMARY KEY (line_id, topo_image_id, id);
 D   ALTER TABLE ONLY public.line_paths DROP CONSTRAINT line_paths_pkey;
       public            felixengelmann    false    214    214    214            �           2606 	   134033504    lines lines_id_key 
   CONSTRAINT     K   ALTER TABLE ONLY public.lines
    ADD CONSTRAINT lines_id_key UNIQUE (id);
 <   ALTER TABLE ONLY public.lines DROP CONSTRAINT lines_id_key;
       public            felixengelmann    false    215            �           2606 	   134033506    lines lines_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.lines
    ADD CONSTRAINT lines_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.lines DROP CONSTRAINT lines_pkey;
       public            felixengelmann    false    215            �           2606 	   134033508    lines lines_slug_key 
   CONSTRAINT     O   ALTER TABLE ONLY public.lines
    ADD CONSTRAINT lines_slug_key UNIQUE (slug);
 >   ALTER TABLE ONLY public.lines DROP CONSTRAINT lines_slug_key;
       public            felixengelmann    false    215            �           2606 	   134033510    posts posts_id_key 
   CONSTRAINT     K   ALTER TABLE ONLY public.posts
    ADD CONSTRAINT posts_id_key UNIQUE (id);
 <   ALTER TABLE ONLY public.posts DROP CONSTRAINT posts_id_key;
       public            felixengelmann    false    216            �           2606 	   134033512    posts posts_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.posts
    ADD CONSTRAINT posts_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.posts DROP CONSTRAINT posts_pkey;
       public            felixengelmann    false    216            �           2606 	   134033514    posts posts_slug_key 
   CONSTRAINT     O   ALTER TABLE ONLY public.posts
    ADD CONSTRAINT posts_slug_key UNIQUE (slug);
 >   ALTER TABLE ONLY public.posts DROP CONSTRAINT posts_slug_key;
       public            felixengelmann    false    216            �           2606 	   134033516    regions regions_id_key 
   CONSTRAINT     O   ALTER TABLE ONLY public.regions
    ADD CONSTRAINT regions_id_key UNIQUE (id);
 @   ALTER TABLE ONLY public.regions DROP CONSTRAINT regions_id_key;
       public            felixengelmann    false    217            �           2606 	   134033518    regions regions_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.regions
    ADD CONSTRAINT regions_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.regions DROP CONSTRAINT regions_pkey;
       public            felixengelmann    false    217            �           2606 	   134033520    regions regions_slug_key 
   CONSTRAINT     S   ALTER TABLE ONLY public.regions
    ADD CONSTRAINT regions_slug_key UNIQUE (slug);
 B   ALTER TABLE ONLY public.regions DROP CONSTRAINT regions_slug_key;
       public            felixengelmann    false    217            �           2606 	   134033522 "   revoked_tokens revoked_tokens_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.revoked_tokens
    ADD CONSTRAINT revoked_tokens_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.revoked_tokens DROP CONSTRAINT revoked_tokens_pkey;
       public            felixengelmann    false    218            �           2606 	   134033524    sectors sectors_id_key 
   CONSTRAINT     O   ALTER TABLE ONLY public.sectors
    ADD CONSTRAINT sectors_id_key UNIQUE (id);
 @   ALTER TABLE ONLY public.sectors DROP CONSTRAINT sectors_id_key;
       public            felixengelmann    false    220            �           2606 	   134033526    sectors sectors_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.sectors
    ADD CONSTRAINT sectors_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.sectors DROP CONSTRAINT sectors_pkey;
       public            felixengelmann    false    220            �           2606 	   134033528    sectors sectors_slug_key 
   CONSTRAINT     S   ALTER TABLE ONLY public.sectors
    ADD CONSTRAINT sectors_slug_key UNIQUE (slug);
 B   ALTER TABLE ONLY public.sectors DROP CONSTRAINT sectors_slug_key;
       public            felixengelmann    false    220            �           2606 	   134033530    topo_images topo_images_id_key 
   CONSTRAINT     W   ALTER TABLE ONLY public.topo_images
    ADD CONSTRAINT topo_images_id_key UNIQUE (id);
 H   ALTER TABLE ONLY public.topo_images DROP CONSTRAINT topo_images_id_key;
       public            felixengelmann    false    221            �           2606 	   134033532    topo_images topo_images_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY public.topo_images
    ADD CONSTRAINT topo_images_pkey PRIMARY KEY (area_id, file_id, id);
 F   ALTER TABLE ONLY public.topo_images DROP CONSTRAINT topo_images_pkey;
       public            felixengelmann    false    221    221    221            �           2606 	   134033534    users users_email_key 
   CONSTRAINT     Q   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);
 ?   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key;
       public            felixengelmann    false    222            �           2606 	   134033536    users users_id_key 
   CONSTRAINT     K   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_id_key UNIQUE (id);
 <   ALTER TABLE ONLY public.users DROP CONSTRAINT users_id_key;
       public            felixengelmann    false    222            �           2606 	   134033538    users users_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            felixengelmann    false    222            �           2606 	   134033539    areas areas_created_by_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.areas
    ADD CONSTRAINT areas_created_by_id_fkey FOREIGN KEY (created_by_id) REFERENCES public.users(id);
 H   ALTER TABLE ONLY public.areas DROP CONSTRAINT areas_created_by_id_fkey;
       public          felixengelmann    false    222    211    3558            �           2606 	   134033544 "   areas areas_portrait_image_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.areas
    ADD CONSTRAINT areas_portrait_image_id_fkey FOREIGN KEY (portrait_image_id) REFERENCES public.files(id);
 L   ALTER TABLE ONLY public.areas DROP CONSTRAINT areas_portrait_image_id_fkey;
       public          felixengelmann    false    211    213    3518            �           2606 	   134033549    areas areas_sector_id_fkey    FK CONSTRAINT     }   ALTER TABLE ONLY public.areas
    ADD CONSTRAINT areas_sector_id_fkey FOREIGN KEY (sector_id) REFERENCES public.sectors(id);
 D   ALTER TABLE ONLY public.areas DROP CONSTRAINT areas_sector_id_fkey;
       public          felixengelmann    false    211    220    3546            �           2606 	   134033554    crags crags_created_by_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.crags
    ADD CONSTRAINT crags_created_by_id_fkey FOREIGN KEY (created_by_id) REFERENCES public.users(id);
 H   ALTER TABLE ONLY public.crags DROP CONSTRAINT crags_created_by_id_fkey;
       public          felixengelmann    false    212    222    3558            �           2606 	   134033559 "   crags crags_portrait_image_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.crags
    ADD CONSTRAINT crags_portrait_image_id_fkey FOREIGN KEY (portrait_image_id) REFERENCES public.files(id);
 L   ALTER TABLE ONLY public.crags DROP CONSTRAINT crags_portrait_image_id_fkey;
       public          felixengelmann    false    213    3518    212            �           2606 	   134033564    crags crags_region_id_fkey    FK CONSTRAINT     }   ALTER TABLE ONLY public.crags
    ADD CONSTRAINT crags_region_id_fkey FOREIGN KEY (region_id) REFERENCES public.regions(id);
 D   ALTER TABLE ONLY public.crags DROP CONSTRAINT crags_region_id_fkey;
       public          felixengelmann    false    212    3538    217            �           2606 	   134033569    files files_created_by_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.files
    ADD CONSTRAINT files_created_by_id_fkey FOREIGN KEY (created_by_id) REFERENCES public.users(id);
 H   ALTER TABLE ONLY public.files DROP CONSTRAINT files_created_by_id_fkey;
       public          felixengelmann    false    3558    222    213            �           2606 	   134033574 (   line_paths line_paths_created_by_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.line_paths
    ADD CONSTRAINT line_paths_created_by_id_fkey FOREIGN KEY (created_by_id) REFERENCES public.users(id);
 R   ALTER TABLE ONLY public.line_paths DROP CONSTRAINT line_paths_created_by_id_fkey;
       public          felixengelmann    false    222    3558    214            �           2606 	   134033579 "   line_paths line_paths_line_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.line_paths
    ADD CONSTRAINT line_paths_line_id_fkey FOREIGN KEY (line_id) REFERENCES public.lines(id);
 L   ALTER TABLE ONLY public.line_paths DROP CONSTRAINT line_paths_line_id_fkey;
       public          felixengelmann    false    214    3526    215            �           2606 	   134033584 (   line_paths line_paths_topo_image_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.line_paths
    ADD CONSTRAINT line_paths_topo_image_id_fkey FOREIGN KEY (topo_image_id) REFERENCES public.topo_images(id);
 R   ALTER TABLE ONLY public.line_paths DROP CONSTRAINT line_paths_topo_image_id_fkey;
       public          felixengelmann    false    3552    221    214            �           2606 	   134033589    lines lines_area_id_fkey    FK CONSTRAINT     w   ALTER TABLE ONLY public.lines
    ADD CONSTRAINT lines_area_id_fkey FOREIGN KEY (area_id) REFERENCES public.areas(id);
 B   ALTER TABLE ONLY public.lines DROP CONSTRAINT lines_area_id_fkey;
       public          felixengelmann    false    215    211    3506            �           2606 	   134033594    lines lines_created_by_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.lines
    ADD CONSTRAINT lines_created_by_id_fkey FOREIGN KEY (created_by_id) REFERENCES public.users(id);
 H   ALTER TABLE ONLY public.lines DROP CONSTRAINT lines_created_by_id_fkey;
       public          felixengelmann    false    215    3558    222            �           2606 	   134033599    posts posts_created_by_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.posts
    ADD CONSTRAINT posts_created_by_id_fkey FOREIGN KEY (created_by_id) REFERENCES public.users(id);
 H   ALTER TABLE ONLY public.posts DROP CONSTRAINT posts_created_by_id_fkey;
       public          felixengelmann    false    222    216    3558            �           2606 	   134033604 "   regions regions_created_by_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.regions
    ADD CONSTRAINT regions_created_by_id_fkey FOREIGN KEY (created_by_id) REFERENCES public.users(id);
 L   ALTER TABLE ONLY public.regions DROP CONSTRAINT regions_created_by_id_fkey;
       public          felixengelmann    false    222    217    3558            �           2606 	   134033609    sectors sectors_crag_id_fkey    FK CONSTRAINT     {   ALTER TABLE ONLY public.sectors
    ADD CONSTRAINT sectors_crag_id_fkey FOREIGN KEY (crag_id) REFERENCES public.crags(id);
 F   ALTER TABLE ONLY public.sectors DROP CONSTRAINT sectors_crag_id_fkey;
       public          felixengelmann    false    212    3512    220            �           2606 	   134033614 "   sectors sectors_created_by_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.sectors
    ADD CONSTRAINT sectors_created_by_id_fkey FOREIGN KEY (created_by_id) REFERENCES public.users(id);
 L   ALTER TABLE ONLY public.sectors DROP CONSTRAINT sectors_created_by_id_fkey;
       public          felixengelmann    false    220    3558    222            �           2606 	   134033619 &   sectors sectors_portrait_image_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.sectors
    ADD CONSTRAINT sectors_portrait_image_id_fkey FOREIGN KEY (portrait_image_id) REFERENCES public.files(id);
 P   ALTER TABLE ONLY public.sectors DROP CONSTRAINT sectors_portrait_image_id_fkey;
       public          felixengelmann    false    3518    213    220            �           2606 	   134033624 $   topo_images topo_images_area_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.topo_images
    ADD CONSTRAINT topo_images_area_id_fkey FOREIGN KEY (area_id) REFERENCES public.areas(id);
 N   ALTER TABLE ONLY public.topo_images DROP CONSTRAINT topo_images_area_id_fkey;
       public          felixengelmann    false    221    3506    211            �           2606 	   134033629 *   topo_images topo_images_created_by_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.topo_images
    ADD CONSTRAINT topo_images_created_by_id_fkey FOREIGN KEY (created_by_id) REFERENCES public.users(id);
 T   ALTER TABLE ONLY public.topo_images DROP CONSTRAINT topo_images_created_by_id_fkey;
       public          felixengelmann    false    3558    221    222            �           2606 	   134033634 $   topo_images topo_images_file_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.topo_images
    ADD CONSTRAINT topo_images_file_id_fkey FOREIGN KEY (file_id) REFERENCES public.files(id);
 N   ALTER TABLE ONLY public.topo_images DROP CONSTRAINT topo_images_file_id_fkey;
       public          felixengelmann    false    213    3518    221            �           2606 	   134033639    users users_avatar_id_fkey    FK CONSTRAINT     {   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_avatar_id_fkey FOREIGN KEY (avatar_id) REFERENCES public.files(id);
 D   ALTER TABLE ONLY public.users DROP CONSTRAINT users_avatar_id_fkey;
       public          felixengelmann    false    222    3518    213            �           2606 	   134033644    users users_created_by_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_created_by_id_fkey FOREIGN KEY (created_by_id) REFERENCES public.users(id);
 H   ALTER TABLE ONLY public.users DROP CONSTRAINT users_created_by_id_fkey;
       public          felixengelmann    false    222    3558    222            �   F   x���v
Q���W((M��L�K�I�M�L�/K-*���Ss�	uV�P7�4I10KJ42IIR״��� |��      �   b  x���MO1�����J��c�l��@�)
��דYX�l���__/��JP���y��Y�o�n��r}wm�/��jFm���jsukN�����YGs����������������}�O�j�C�;�_/Of��2��R�}ݟ���U�iN��+_OS�4fI9eh�7��/�r+��qh�W��,��ƥ���*RL���z�Z����cZk[��t�:A������S�rV'��j�m����%MȑO9k��
Qmt9@�� �k)�8��{#!O�P��,���/�f���w�`�Ss��v�05��	Y���$%T��Q,��b"*\���+�)�����gM�
�#�;*��~�ݨn      �   ^  x����JC1��}����\&ɤ���X*x�O.���rJ7>�9^���$��c���lqsq}+f��+����6MR�ˍ�?��]܈��Y߮�2>���ɜ�ege����m�O[�L��'o���F\�ey�vI։F��$�T�@e�R���8p�1�5��5ei�r4PX�D/��ڀ���P8�jj��I/��.����(���6PB��(Y`�D���ef�]��m��S�!��-cJ�M���'`�30K������/���h����_umZ�j{G�����]���P�rm%�L��.{搣�F��Z7�F[o��;}����O:�sd���S C݁���5&2J�+��H��T��*      �   �  x�ŕ�kA���W��Up��L2��O>�VJm}�̯R9zŞ���ګ�x(B��d6;��O���||��t::9}7]}+��:��U��>�<>{�q:\$� R�x��űTr�K����ϧE��a�$ZB�S�HdwOΎ�-gӯ7��m~o!d��jGu(û":\"�d	q� va��[��CW׿-O�i�.}8d�R��\�,<
Y<{qp�W�9*)��ptXruJ�9U�4Pl��� ��e�%��C��Yo�֛鐞�W�7�G.���V���R{�P����#v��} QyI���$Iz�������"Pۣ<,	�d���^�������m�]��|�`[�~�(U�\FF��c��x(r]�.�{
[' ���0>"�.P�q�5��3��z���q�<�`��>@�,1M���h�j+�C���K�5��⃳�W��[`;/#����4������C��A���򰗢տi��MJ�}�O�aJ�YU�)'1z'��)�@);h����ia�<�|O�x��O�i�uZu���o߿�>�2���KT��j�ab�������O��2%�:Rw҆���648kX�b���e?�4۟ =d�F7?�A�se�`^�CԚ.W�A�|��V�-�GBpp�L�*      �   �  x���OkA���s��vS���ד�!�I��H��4���o�a��!�R���t�ｺ����x;]^�~����9?�_�>���~L��_�]�Lo�q�:I�11*��4�*�
�g���tΫh.�WԞZ���AШsú�}Vʰ�T2fEub��Ē]���=�T��`H7��L��YU
�CEU�?�C�a���рc�����}ٍd܍��T��{�� KjFm�YA�v���<�mY�\3J�P�����UhP8Ɛ�Sב�gI��&����\�L�� �}wv�2��1^�2/�A����{�a�Yo�*��!��d����׊}GڎѠ*�Ԝ�����S?"����H��Ph�d�yǲ4�DF����*�k���N�b�p�-`v�������Ҡ�"m��XC74�Ns����k�!��p���M�>��d���э,C�����8Is��؊]��DƘ��⁒�J{�0��ZZ5�W��*��B�����2�	q[t�K� ���qv�6�m      �   �  x�Œ�n�0��{&'�N�8NC����Ēr���Fs�(?��3θ1�(hC	���������r���9X��Ў�T�3U�{�2Ym��w�N��v��=iOS����v�hpP��E{:�g��yzi��0��1�:��I&����� 
�$�,U(C�I9�
F%�1�U@�0��A*%*C�R����BA� F1Ʊ�=�)"��7�����΃�H��Ne�$�L񈗒b�Onw�N����_#���ES�OΦ1˓���o6���ly'�llu��Ӣ��w�Ouet���5��v����h���?C�����j�"����A���3�(�����|9!����?��`�?��6�{��o�ى�>���w4�m�?ݻ[ry��e~l�}��;����C�ǋ�~��>4�0J��f�؋Am�{ē7Q�l̯^$�8C5=�s>�vo����+r/      �     x��лN�0�Oq�ROq|�]�"�E%\��l;�	�(��c��p
�����G��η�����=4�}�ܬ9t}�7��j�ɝ�j�m��b�L!Y4�ۡ��UJc}}����r����6�|od��ΘA)�@�E�
�Q�ZI�v�QB9�����	�39c\�,�i��lb'�)%z�r�D��%J��
�SNtrq5Y�����Q���b:�O/{(������{{�=��\y}��q������*��P93o����QEȴ��)�L�DQ��d�	�K~�      �   �   x�5�1�0��_�--�I_�N��������i�������]Y�EcYY�+{��<���ӺDv�T]Ѳ�!�i�'��:ρ5_��Ay��!��� $��F@�����psuWU��RcF�G&l���>39��
�o�~��s�$��-=      �   �   x���9
�@ �>��.
~��φ�E��`��̟DQq;��6�|����B?n��M�SZ>��v.����>�a��w��k9�l��P3!�w�g�UUrF#jj�&���i�R�\�T� J� "'�DVq�Ȉ�[���n1�      �   :  x���Mk1�����l���d��XZ� ]���d�*�U�݋��	Rh{(�@ȓy?���m�����z؇QCw<������V�n�
;�u���a����Ӵt�6��؆�9�}�l٥�`����i�a�|@�, k���+XQDm�0s ����u�Q$��h�6�6�� �3'A*�K��e��H�1�u�)����H�<ژ4)h�-x�R�Q"�<�?_�N����5Z�K�+4"M2ޢ��W5 �J'�����i0�G�K�,qKo�TXK�!G)k�*rZȂT��{�c0c��@�n�-�������v0�"(�0      �     x���1K�A����o��)w��.W'��R����\/RPZP��Wg�9O޼O����i?������eo���<_�/�w}������M7��ֲe-�@�[�T�[�%��n�{
���k�c���v	�Ik0�r�Ń
��2�PGr-Eǒ�4�+�	B�)�%�2�E�,<���f3�ȔDء��Z�R͐�Tq#�����?ۢel�;ԣ���J� �b��k��
edm�EϠ��"�pɎ�w۲��˟u�Н;�z�      �   %  x�ՐMO�@����=4�&l��G�ŋ�V-�%���ٖ-_Tj#�{i�ă�1� �wf򾓙<Q��Dq�e��Y�ԕ�T`��A�G��(�P]@�s�r.x�QL�����c�����X��(al��)w����j�0�,,B�]�-N�CĔ^�^��a���%�<,�r�l��P��d�D�4~fq���3=It[5��:W&ߨ�y�Wm�j�rƺ����m�&���P��m�����j�J?�G2��IGi�K��h��g��G���H����J�;���/X�Z�I�-     