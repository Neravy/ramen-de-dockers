--
-- PostgreSQL database dump
--

\restrict g3IUAMOJR8JBUOuR54ruKNoHoIhDvdbMBoa6TGSoC5qNyc32EsmbixFXg15aUzb

-- Dumped from database version 18.1 (Ubuntu 18.1-1.pgdg24.04+2)
-- Dumped by pg_dump version 18.1 (Ubuntu 18.1-1.pgdg24.04+2)

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

ALTER TABLE IF EXISTS ONLY public.s01role_permission DROP CONSTRAINT IF EXISTS s01role_permission_nidrole_fkey;
ALTER TABLE IF EXISTS ONLY public.s01role_permission DROP CONSTRAINT IF EXISTS s01role_permission_nidpermission_fkey;
ALTER TABLE IF EXISTS ONLY public.s01product DROP CONSTRAINT IF EXISTS s01product_nidcompany_fkey;
ALTER TABLE IF EXISTS ONLY public.s01product DROP CONSTRAINT IF EXISTS s01product_nidcategory_fkey;
ALTER TABLE IF EXISTS ONLY public.s01phone DROP CONSTRAINT IF EXISTS s01phone_nidphonetype_fkey;
ALTER TABLE IF EXISTS ONLY public.s01payment DROP CONSTRAINT IF EXISTS s01payment_nidpaymentmethod_fkey;
ALTER TABLE IF EXISTS ONLY public.s01payment DROP CONSTRAINT IF EXISTS s01payment_nidemployeereceivedby_fkey;
ALTER TABLE IF EXISTS ONLY public.s01payment DROP CONSTRAINT IF EXISTS s01payment_nidcontract_fkey;
ALTER TABLE IF EXISTS ONLY public.s01payment DROP CONSTRAINT IF EXISTS s01payment_nidclient_fkey;
ALTER TABLE IF EXISTS ONLY public.s01employee_role DROP CONSTRAINT IF EXISTS s01employee_role_nidrole_fkey;
ALTER TABLE IF EXISTS ONLY public.s01employee_role DROP CONSTRAINT IF EXISTS s01employee_role_nidemployee_fkey;
ALTER TABLE IF EXISTS ONLY public.s01employee DROP CONSTRAINT IF EXISTS s01employee_nidrole_fkey;
ALTER TABLE IF EXISTS ONLY public.s01employee DROP CONSTRAINT IF EXISTS s01employee_nididentificationtype_fkey;
ALTER TABLE IF EXISTS ONLY public.s01employee DROP CONSTRAINT IF EXISTS s01employee_nidcompany_fkey;
ALTER TABLE IF EXISTS ONLY public.s01credit_note DROP CONSTRAINT IF EXISTS s01credit_note_nidoriginalcontract_fkey;
ALTER TABLE IF EXISTS ONLY public.s01credit_note DROP CONSTRAINT IF EXISTS s01credit_note_nidemployeecreatedby_fkey;
ALTER TABLE IF EXISTS ONLY public.s01credit_note DROP CONSTRAINT IF EXISTS s01credit_note_niddocumenttype_fkey;
ALTER TABLE IF EXISTS ONLY public.s01credit_note DROP CONSTRAINT IF EXISTS s01credit_note_nidcompany_fkey;
ALTER TABLE IF EXISTS ONLY public.s01credit_note DROP CONSTRAINT IF EXISTS s01credit_note_nidclient_fkey;
ALTER TABLE IF EXISTS ONLY public.s01contract DROP CONSTRAINT IF EXISTS s01contract_nidemployeecreatedby_fkey;
ALTER TABLE IF EXISTS ONLY public.s01contract DROP CONSTRAINT IF EXISTS s01contract_niddocumenttype_fkey;
ALTER TABLE IF EXISTS ONLY public.s01contract DROP CONSTRAINT IF EXISTS s01contract_nidcompany_fkey;
ALTER TABLE IF EXISTS ONLY public.s01contract DROP CONSTRAINT IF EXISTS s01contract_nidclient_fkey;
ALTER TABLE IF EXISTS ONLY public.s01contract_detail DROP CONSTRAINT IF EXISTS s01contract_detail_nidproduct_fkey;
ALTER TABLE IF EXISTS ONLY public.s01contract_detail DROP CONSTRAINT IF EXISTS s01contract_detail_nidcontract_fkey;
ALTER TABLE IF EXISTS ONLY public.s01client DROP CONSTRAINT IF EXISTS s01client_nididentificationtype_fkey;
DROP TRIGGER IF EXISTS phone_format_before_insert_update ON public.s01phone;
DROP INDEX IF EXISTS public.idx_phone_type;
DROP INDEX IF EXISTS public.idx_phone_primary;
DROP INDEX IF EXISTS public.idx_phone_number;
DROP INDEX IF EXISTS public.idx_phone_entity;
ALTER TABLE IF EXISTS ONLY public.s01role DROP CONSTRAINT IF EXISTS s01role_pkey;
ALTER TABLE IF EXISTS ONLY public.s01role_permission DROP CONSTRAINT IF EXISTS s01role_permission_pkey;
ALTER TABLE IF EXISTS ONLY public.s01role DROP CONSTRAINT IF EXISTS s01role_cname_key;
ALTER TABLE IF EXISTS ONLY public.s01product DROP CONSTRAINT IF EXISTS s01product_pkey;
ALTER TABLE IF EXISTS ONLY public.s01product DROP CONSTRAINT IF EXISTS s01product_nidcompany_ccode_key;
ALTER TABLE IF EXISTS ONLY public.s01phone_type DROP CONSTRAINT IF EXISTS s01phone_type_pkey;
ALTER TABLE IF EXISTS ONLY public.s01phone_type DROP CONSTRAINT IF EXISTS s01phone_type_cname_key;
ALTER TABLE IF EXISTS ONLY public.s01phone_type DROP CONSTRAINT IF EXISTS s01phone_type_ccode_key;
ALTER TABLE IF EXISTS ONLY public.s01phone DROP CONSTRAINT IF EXISTS s01phone_pkey;
ALTER TABLE IF EXISTS ONLY public.s01phone DROP CONSTRAINT IF EXISTS s01phone_centitytype_nentityid_cphonenumber_key;
ALTER TABLE IF EXISTS ONLY public.s01permission DROP CONSTRAINT IF EXISTS s01permission_pkey;
ALTER TABLE IF EXISTS ONLY public.s01permission DROP CONSTRAINT IF EXISTS s01permission_cname_key;
ALTER TABLE IF EXISTS ONLY public.s01permission DROP CONSTRAINT IF EXISTS s01permission_ccode_key;
ALTER TABLE IF EXISTS ONLY public.s01payment DROP CONSTRAINT IF EXISTS s01payment_pkey;
ALTER TABLE IF EXISTS ONLY public.s01payment_method DROP CONSTRAINT IF EXISTS s01payment_method_pkey;
ALTER TABLE IF EXISTS ONLY public.s01payment_method DROP CONSTRAINT IF EXISTS s01payment_method_ctype_key;
ALTER TABLE IF EXISTS ONLY public.s01payment_method DROP CONSTRAINT IF EXISTS s01payment_method_cname_key;
ALTER TABLE IF EXISTS ONLY public.s01payment_method DROP CONSTRAINT IF EXISTS s01payment_method_ccode_key;
ALTER TABLE IF EXISTS ONLY public.s01payment DROP CONSTRAINT IF EXISTS s01payment_cpaymentnumber_key;
ALTER TABLE IF EXISTS ONLY public.s01payment DROP CONSTRAINT IF EXISTS s01payment_cidempotencykey_key;
ALTER TABLE IF EXISTS ONLY public.s01identification_type DROP CONSTRAINT IF EXISTS s01identification_type_pkey;
ALTER TABLE IF EXISTS ONLY public.s01identification_type DROP CONSTRAINT IF EXISTS s01identification_type_cname_key;
ALTER TABLE IF EXISTS ONLY public.s01identification_type DROP CONSTRAINT IF EXISTS s01identification_type_ccode_key;
ALTER TABLE IF EXISTS ONLY public.s01employee_role DROP CONSTRAINT IF EXISTS s01employee_role_pkey;
ALTER TABLE IF EXISTS ONLY public.s01employee DROP CONSTRAINT IF EXISTS s01employee_pkey;
ALTER TABLE IF EXISTS ONLY public.s01employee DROP CONSTRAINT IF EXISTS s01employee_nidcompany_nididentificationtype_cidentificatio_key;
ALTER TABLE IF EXISTS ONLY public.s01employee DROP CONSTRAINT IF EXISTS s01employee_cemail_key;
ALTER TABLE IF EXISTS ONLY public.s01document_type DROP CONSTRAINT IF EXISTS s01document_type_pkey;
ALTER TABLE IF EXISTS ONLY public.s01document_type DROP CONSTRAINT IF EXISTS s01document_type_cname_key;
ALTER TABLE IF EXISTS ONLY public.s01document_type DROP CONSTRAINT IF EXISTS s01document_type_ccode_key;
ALTER TABLE IF EXISTS ONLY public.s01credit_note DROP CONSTRAINT IF EXISTS s01credit_note_pkey;
ALTER TABLE IF EXISTS ONLY public.s01credit_note DROP CONSTRAINT IF EXISTS s01credit_note_ccreditnotenumber_key;
ALTER TABLE IF EXISTS ONLY public.s01contract DROP CONSTRAINT IF EXISTS s01contract_pkey;
ALTER TABLE IF EXISTS ONLY public.s01contract_detail DROP CONSTRAINT IF EXISTS s01contract_detail_pkey;
ALTER TABLE IF EXISTS ONLY public.s01contract_detail DROP CONSTRAINT IF EXISTS s01contract_detail_nidcontract_nlinenumber_key;
ALTER TABLE IF EXISTS ONLY public.s01contract DROP CONSTRAINT IF EXISTS s01contract_ccontractnumber_key;
ALTER TABLE IF EXISTS ONLY public.s01company DROP CONSTRAINT IF EXISTS s01company_pkey;
ALTER TABLE IF EXISTS ONLY public.s01company DROP CONSTRAINT IF EXISTS s01company_cruc_key;
ALTER TABLE IF EXISTS ONLY public.s01client DROP CONSTRAINT IF EXISTS s01client_pkey;
ALTER TABLE IF EXISTS ONLY public.s01client DROP CONSTRAINT IF EXISTS s01client_nididentificationtype_cidentificationnumber_key;
ALTER TABLE IF EXISTS ONLY public.s01category DROP CONSTRAINT IF EXISTS s01category_pkey;
ALTER TABLE IF EXISTS ONLY public.s01category DROP CONSTRAINT IF EXISTS s01category_cname_key;
ALTER TABLE IF EXISTS ONLY public.s01category DROP CONSTRAINT IF EXISTS s01category_ccode_key;
ALTER TABLE IF EXISTS ONLY public.s01audit_log DROP CONSTRAINT IF EXISTS s01audit_log_pkey;
ALTER TABLE IF EXISTS ONLY public.s01audit_log DROP CONSTRAINT IF EXISTS s01audit_log_ctransactionid_key;
ALTER TABLE IF EXISTS public.s01role ALTER COLUMN nidrole DROP DEFAULT;
ALTER TABLE IF EXISTS public.s01product ALTER COLUMN nidproduct DROP DEFAULT;
ALTER TABLE IF EXISTS public.s01phone_type ALTER COLUMN nidphonetype DROP DEFAULT;
ALTER TABLE IF EXISTS public.s01phone ALTER COLUMN nidphone DROP DEFAULT;
ALTER TABLE IF EXISTS public.s01permission ALTER COLUMN nidpermission DROP DEFAULT;
ALTER TABLE IF EXISTS public.s01payment_method ALTER COLUMN nidpaymentmethod DROP DEFAULT;
ALTER TABLE IF EXISTS public.s01payment ALTER COLUMN nidpayment DROP DEFAULT;
ALTER TABLE IF EXISTS public.s01identification_type ALTER COLUMN nididentificationtype DROP DEFAULT;
ALTER TABLE IF EXISTS public.s01employee ALTER COLUMN nidemployee DROP DEFAULT;
ALTER TABLE IF EXISTS public.s01document_type ALTER COLUMN niddocumenttype DROP DEFAULT;
ALTER TABLE IF EXISTS public.s01credit_note ALTER COLUMN nidcreditnote DROP DEFAULT;
ALTER TABLE IF EXISTS public.s01contract_detail ALTER COLUMN nidcontractdetail DROP DEFAULT;
ALTER TABLE IF EXISTS public.s01contract ALTER COLUMN nidcontract DROP DEFAULT;
ALTER TABLE IF EXISTS public.s01company ALTER COLUMN nidcompany DROP DEFAULT;
ALTER TABLE IF EXISTS public.s01client ALTER COLUMN nidclient DROP DEFAULT;
ALTER TABLE IF EXISTS public.s01category ALTER COLUMN nidcategory DROP DEFAULT;
ALTER TABLE IF EXISTS public.s01audit_log ALTER COLUMN nidauditlog DROP DEFAULT;
DROP VIEW IF EXISTS public.v_product_stock;
DROP VIEW IF EXISTS public.v_payment_summary;
DROP VIEW IF EXISTS public.v_employee_with_phones;
DROP VIEW IF EXISTS public.v_employee_permissions;
DROP VIEW IF EXISTS public.v_directory;
DROP VIEW IF EXISTS public.v_contract_complete;
DROP VIEW IF EXISTS public.v_client_with_phones;
DROP SEQUENCE IF EXISTS public.seq_payment_number;
DROP SEQUENCE IF EXISTS public.seq_credit_note_number;
DROP SEQUENCE IF EXISTS public.seq_contract_number;
DROP TABLE IF EXISTS public.s01role_permission;
DROP SEQUENCE IF EXISTS public.s01role_nidrole_seq;
DROP TABLE IF EXISTS public.s01role;
DROP SEQUENCE IF EXISTS public.s01product_nidproduct_seq;
DROP TABLE IF EXISTS public.s01product;
DROP SEQUENCE IF EXISTS public.s01phone_type_nidphonetype_seq;
DROP TABLE IF EXISTS public.s01phone_type;
DROP SEQUENCE IF EXISTS public.s01phone_nidphone_seq;
DROP TABLE IF EXISTS public.s01phone;
DROP SEQUENCE IF EXISTS public.s01permission_nidpermission_seq;
DROP TABLE IF EXISTS public.s01permission;
DROP SEQUENCE IF EXISTS public.s01payment_nidpayment_seq;
DROP SEQUENCE IF EXISTS public.s01payment_method_nidpaymentmethod_seq;
DROP TABLE IF EXISTS public.s01payment_method;
DROP TABLE IF EXISTS public.s01payment;
DROP SEQUENCE IF EXISTS public.s01identification_type_nididentificationtype_seq;
DROP TABLE IF EXISTS public.s01identification_type;
DROP TABLE IF EXISTS public.s01employee_role;
DROP SEQUENCE IF EXISTS public.s01employee_nidemployee_seq;
DROP TABLE IF EXISTS public.s01employee;
DROP SEQUENCE IF EXISTS public.s01document_type_niddocumenttype_seq;
DROP TABLE IF EXISTS public.s01document_type;
DROP SEQUENCE IF EXISTS public.s01credit_note_nidcreditnote_seq;
DROP TABLE IF EXISTS public.s01credit_note;
DROP SEQUENCE IF EXISTS public.s01contract_nidcontract_seq;
DROP SEQUENCE IF EXISTS public.s01contract_detail_nidcontractdetail_seq;
DROP TABLE IF EXISTS public.s01contract_detail;
DROP TABLE IF EXISTS public.s01contract;
DROP SEQUENCE IF EXISTS public.s01company_nidcompany_seq;
DROP TABLE IF EXISTS public.s01company;
DROP SEQUENCE IF EXISTS public.s01client_nidclient_seq;
DROP TABLE IF EXISTS public.s01client;
DROP SEQUENCE IF EXISTS public.s01category_nidcategory_seq;
DROP TABLE IF EXISTS public.s01category;
DROP SEQUENCE IF EXISTS public.s01audit_log_nidauditlog_seq;
DROP TABLE IF EXISTS public.s01audit_log;
DROP FUNCTION IF EXISTS public.validate_and_format_phone();
DROP FUNCTION IF EXISTS public.get_primary_phone(p_centitytype character varying, p_nentityid integer);
DROP FUNCTION IF EXISTS public.get_client_balance(p_nidclient integer);
DROP FUNCTION IF EXISTS public.get_all_phones(p_centitytype character varying, p_nentityid integer);
DROP FUNCTION IF EXISTS public.generate_contract_number(p_nidcompany integer, p_niddocumenttype integer);
--
-- Name: generate_contract_number(integer, integer); Type: FUNCTION; Schema: public; Owner: arelyxl
--

CREATE FUNCTION public.generate_contract_number(p_nidcompany integer, p_niddocumenttype integer) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_date_prefix VARCHAR(10);
    v_sequence INTEGER;
    v_doc_code VARCHAR(2);
BEGIN
    SELECT cCode INTO v_doc_code
    FROM S01DOCUMENT_TYPE
    WHERE nIdDocumentType = p_nIdDocumentType;
    
    v_date_prefix := TO_CHAR(NOW(), 'YYYY-MM-DD');
    v_sequence := NEXTVAL('seq_contract_number');
    
    RETURN v_date_prefix || '-' || LPAD(v_doc_code, 2, '0') || '-' || LPAD(v_sequence::TEXT, 6, '0');
END;
$$;


ALTER FUNCTION public.generate_contract_number(p_nidcompany integer, p_niddocumenttype integer) OWNER TO arelyxl;

--
-- Name: get_all_phones(character varying, integer); Type: FUNCTION; Schema: public; Owner: arelyxl
--

CREATE FUNCTION public.get_all_phones(p_centitytype character varying, p_nentityid integer) RETURNS TABLE(cphonenumber character varying, cphoneformatted character varying, cphonetype character varying, bisprimary boolean, breceivesms boolean, breceivewhatsapp boolean)
    LANGUAGE plpgsql STABLE
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
        p.cPhoneNumber,
        p.cPhoneFormatted,
        pt.cName,
        p.bIsPrimary,
        p.bReceiveSMS,
        p.bReceiveWhatsapp
    FROM S01PHONE p
    LEFT JOIN S01PHONE_TYPE pt ON p.nIdPhoneType = pt.nIdPhoneType
    WHERE p.cEntityType = p_cEntityType
        AND p.nEntityId = p_nEntityId
        AND p.bIsActive = TRUE
    ORDER BY p.bIsPrimary DESC, p.tCreatedAt DESC;
END;
$$;


ALTER FUNCTION public.get_all_phones(p_centitytype character varying, p_nentityid integer) OWNER TO arelyxl;

--
-- Name: get_client_balance(integer); Type: FUNCTION; Schema: public; Owner: arelyxl
--

CREATE FUNCTION public.get_client_balance(p_nidclient integer) RETURNS numeric
    LANGUAGE plpgsql STABLE
    AS $$
DECLARE
    v_total_invoices NUMERIC;
    v_total_paid NUMERIC;
BEGIN
    SELECT COALESCE(SUM(c.nTotal), 0) INTO v_total_invoices
    FROM S01CONTRACT c
    WHERE c.nIdClient = p_nIdClient 
        AND c.cStatus NOT IN ('VOIDED', 'CANCELLED');
    
    SELECT COALESCE(SUM(p.nAmount), 0) INTO v_total_paid
    FROM S01PAYMENT p
    WHERE p.nIdClient = p_nIdClient 
        AND p.cStatus = 'COMPLETED';
    
    RETURN v_total_invoices - v_total_paid;
END;
$$;


ALTER FUNCTION public.get_client_balance(p_nidclient integer) OWNER TO arelyxl;

--
-- Name: get_primary_phone(character varying, integer); Type: FUNCTION; Schema: public; Owner: arelyxl
--

CREATE FUNCTION public.get_primary_phone(p_centitytype character varying, p_nentityid integer) RETURNS character varying
    LANGUAGE plpgsql STABLE
    AS $$
DECLARE
    v_phone_formatted VARCHAR;
BEGIN
    SELECT cPhoneFormatted INTO v_phone_formatted
    FROM S01PHONE
    WHERE cEntityType = p_cEntityType
        AND nEntityId = p_nEntityId
        AND bIsPrimary = TRUE
        AND bIsActive = TRUE
    LIMIT 1;
    
    RETURN COALESCE(v_phone_formatted, '');
END;
$$;


ALTER FUNCTION public.get_primary_phone(p_centitytype character varying, p_nentityid integer) OWNER TO arelyxl;

--
-- Name: validate_and_format_phone(); Type: FUNCTION; Schema: public; Owner: arelyxl
--

CREATE FUNCTION public.validate_and_format_phone() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Limpiar número (solo dígitos)
    NEW.cPhoneNumber := regexp_replace(NEW.cPhoneNumber, '[^0-9]', '', 'g');
    
    -- Validar longitud (7-15 dígitos típicos)
    IF LENGTH(NEW.cPhoneNumber) < 7 OR LENGTH(NEW.cPhoneNumber) > 15 THEN
        RAISE EXCEPTION 'Teléfono debe tener entre 7 y 15 dígitos';
    END IF;
    
    -- Generar formato (ejemplo: +51 1 2345 6789)
    IF NEW.cCountryCode IS NOT NULL AND NEW.cAreaCode IS NOT NULL THEN
        NEW.cPhoneFormatted := NEW.cCountryCode || ' ' || NEW.cAreaCode || ' ' || NEW.cPhoneNumber;
    ELSIF NEW.cCountryCode IS NOT NULL THEN
        NEW.cPhoneFormatted := NEW.cCountryCode || ' ' || NEW.cPhoneNumber;
    ELSE
        NEW.cPhoneFormatted := NEW.cPhoneNumber;
    END IF;
    
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.validate_and_format_phone() OWNER TO arelyxl;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: s01audit_log; Type: TABLE; Schema: public; Owner: arelyxl
--

CREATE TABLE public.s01audit_log (
    nidauditlog bigint NOT NULL,
    ctablename character varying(50) NOT NULL,
    nrecordid bigint NOT NULL,
    coperation character varying(10) NOT NULL,
    joldvalue jsonb,
    jnewvalue jsonb,
    jchangedfields jsonb,
    cusername character varying(100),
    cipaddress inet,
    ctransactionid character varying(64),
    cchangetype character varying(50),
    ttimestamp timestamp without time zone DEFAULT now(),
    CONSTRAINT s01audit_log_coperation_check CHECK (((coperation)::text = ANY ((ARRAY['INSERT'::character varying, 'UPDATE'::character varying, 'DELETE'::character varying])::text[])))
);


ALTER TABLE public.s01audit_log OWNER TO arelyxl;

--
-- Name: s01audit_log_nidauditlog_seq; Type: SEQUENCE; Schema: public; Owner: arelyxl
--

CREATE SEQUENCE public.s01audit_log_nidauditlog_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.s01audit_log_nidauditlog_seq OWNER TO arelyxl;

--
-- Name: s01audit_log_nidauditlog_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: arelyxl
--

ALTER SEQUENCE public.s01audit_log_nidauditlog_seq OWNED BY public.s01audit_log.nidauditlog;


--
-- Name: s01category; Type: TABLE; Schema: public; Owner: arelyxl
--

CREATE TABLE public.s01category (
    nidcategory integer NOT NULL,
    ccode character varying(20) NOT NULL,
    cname character varying(100) NOT NULL,
    cdescription text,
    bisactive boolean DEFAULT true,
    tcreatedat timestamp without time zone DEFAULT now(),
    tmodifiedat timestamp without time zone
);


ALTER TABLE public.s01category OWNER TO arelyxl;

--
-- Name: s01category_nidcategory_seq; Type: SEQUENCE; Schema: public; Owner: arelyxl
--

CREATE SEQUENCE public.s01category_nidcategory_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.s01category_nidcategory_seq OWNER TO arelyxl;

--
-- Name: s01category_nidcategory_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: arelyxl
--

ALTER SEQUENCE public.s01category_nidcategory_seq OWNED BY public.s01category.nidcategory;


--
-- Name: s01client; Type: TABLE; Schema: public; Owner: arelyxl
--

CREATE TABLE public.s01client (
    nidclient integer NOT NULL,
    cname character varying(50) NOT NULL,
    clastname character varying(50) NOT NULL,
    nididentificationtype integer NOT NULL,
    cidentificationnumber character varying(20) NOT NULL,
    cemail character varying(100),
    cphoneprimary character varying(20),
    cphonealternative character varying(20),
    caddress character varying(200),
    ccity character varying(50) DEFAULT 'Arequipa'::character varying,
    ccountry character varying(50) DEFAULT 'Perú'::character varying,
    bidentificationvalidated boolean DEFAULT false,
    tidentificationvalidationdate timestamp without time zone,
    cidentificationvalidationstatus character varying(50),
    jclientmetadata jsonb DEFAULT '{}'::jsonb,
    bisactive boolean DEFAULT true,
    tcreatedat timestamp without time zone DEFAULT now(),
    tmodifiedat timestamp without time zone,
    CONSTRAINT chk_metadata_valid CHECK (
CASE
    WHEN (jclientmetadata ? 'nCreditLimit'::text) THEN (((jclientmetadata ->> 'nCreditLimit'::text))::numeric > (0)::numeric)
    ELSE true
END)
);


ALTER TABLE public.s01client OWNER TO arelyxl;

--
-- Name: s01client_nidclient_seq; Type: SEQUENCE; Schema: public; Owner: arelyxl
--

CREATE SEQUENCE public.s01client_nidclient_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.s01client_nidclient_seq OWNER TO arelyxl;

--
-- Name: s01client_nidclient_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: arelyxl
--

ALTER SEQUENCE public.s01client_nidclient_seq OWNED BY public.s01client.nidclient;


--
-- Name: s01company; Type: TABLE; Schema: public; Owner: arelyxl
--

CREATE TABLE public.s01company (
    nidcompany integer NOT NULL,
    cruc character(11) NOT NULL,
    cbusinessname character varying(150) NOT NULL,
    ctradename character varying(150),
    cdescription text,
    clogourl character varying(500),
    cemail character varying(100),
    cphoneprimary character varying(20),
    cphonealternative character varying(20),
    caddress character varying(200) NOT NULL,
    ccity character varying(50) NOT NULL,
    ccountry character varying(50) DEFAULT 'Perú'::character varying,
    bisrucvalidated boolean DEFAULT false,
    trucvalidationdate timestamp without time zone,
    crucvalidationstatus character varying(50),
    bisactive boolean DEFAULT true,
    tcreatedat timestamp without time zone DEFAULT now(),
    tmodifiedat timestamp without time zone
);


ALTER TABLE public.s01company OWNER TO arelyxl;

--
-- Name: s01company_nidcompany_seq; Type: SEQUENCE; Schema: public; Owner: arelyxl
--

CREATE SEQUENCE public.s01company_nidcompany_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.s01company_nidcompany_seq OWNER TO arelyxl;

--
-- Name: s01company_nidcompany_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: arelyxl
--

ALTER SEQUENCE public.s01company_nidcompany_seq OWNED BY public.s01company.nidcompany;


--
-- Name: s01contract; Type: TABLE; Schema: public; Owner: arelyxl
--

CREATE TABLE public.s01contract (
    nidcontract bigint NOT NULL,
    ccontractnumber character varying(20) NOT NULL,
    niddocumenttype integer NOT NULL,
    nidclient integer NOT NULL,
    nidcompany integer NOT NULL,
    nidemployeecreatedby integer,
    cstatus character varying(50) DEFAULT 'DRAFT'::character varying NOT NULL,
    nsubtotal numeric(14,2) NOT NULL,
    ntotaldiscount numeric(14,2) DEFAULT 0,
    nigvpercent numeric(5,2) DEFAULT 18.0,
    ndownpayment numeric(14,2) DEFAULT 0,
    ntaxablebase numeric(14,2) GENERATED ALWAYS AS ((nsubtotal - COALESCE(ntotaldiscount, (0)::numeric))) STORED NOT NULL,
    nigvamount numeric(14,2) GENERATED ALWAYS AS (((nsubtotal - COALESCE(ntotaldiscount, (0)::numeric)) * (nigvpercent / (100)::numeric))) STORED NOT NULL,
    ntotal numeric(14,2) GENERATED ALWAYS AS (((nsubtotal - COALESCE(ntotaldiscount, (0)::numeric)) + ((nsubtotal - COALESCE(ntotaldiscount, (0)::numeric)) * (nigvpercent / (100)::numeric)))) STORED NOT NULL,
    nbalancedue numeric(14,2) GENERATED ALWAYS AS ((((nsubtotal - COALESCE(ntotaldiscount, (0)::numeric)) + ((nsubtotal - COALESCE(ntotaldiscount, (0)::numeric)) * (nigvpercent / (100)::numeric))) - COALESCE(ndownpayment, (0)::numeric))) STORED NOT NULL,
    jcontractmetadata jsonb DEFAULT '{}'::jsonb,
    tdate timestamp without time zone DEFAULT now(),
    tduedate timestamp without time zone,
    tcreatedat timestamp without time zone DEFAULT now(),
    tmodifiedat timestamp without time zone,
    CONSTRAINT s01contract_cstatus_check CHECK (((cstatus)::text = ANY ((ARRAY['DRAFT'::character varying, 'EMITTED'::character varying, 'ACCEPTED'::character varying, 'REJECTED'::character varying, 'VOIDED'::character varying, 'CANCELLED'::character varying])::text[]))),
    CONSTRAINT s01contract_ndownpayment_check CHECK ((ndownpayment >= (0)::numeric)),
    CONSTRAINT s01contract_nigvpercent_check CHECK (((nigvpercent >= (0)::numeric) AND (nigvpercent <= (100)::numeric)))
);


ALTER TABLE public.s01contract OWNER TO arelyxl;

--
-- Name: s01contract_detail; Type: TABLE; Schema: public; Owner: arelyxl
--

CREATE TABLE public.s01contract_detail (
    nidcontractdetail bigint NOT NULL,
    nidcontract bigint NOT NULL,
    nlinenumber integer NOT NULL,
    nidproduct integer NOT NULL,
    cproductname character varying(200) NOT NULL,
    cproductcode character varying(50) NOT NULL,
    cunit character varying(3) NOT NULL,
    nquantity numeric(12,2) NOT NULL,
    nunitprice numeric(12,2) NOT NULL,
    ndiscountpercent numeric(5,2) DEFAULT 0,
    nigvpercent numeric(5,2) DEFAULT 18.0,
    nsubtotal numeric(14,2) GENERATED ALWAYS AS ((nquantity * nunitprice)) STORED NOT NULL,
    ndiscountamount numeric(14,2) GENERATED ALWAYS AS (((nquantity * nunitprice) * (ndiscountpercent / (100)::numeric))) STORED NOT NULL,
    ntaxablebase numeric(14,2) GENERATED ALWAYS AS (((nquantity * nunitprice) - ((nquantity * nunitprice) * (ndiscountpercent / (100)::numeric)))) STORED NOT NULL,
    nigvamount numeric(14,2) GENERATED ALWAYS AS ((((nquantity * nunitprice) - ((nquantity * nunitprice) * (ndiscountpercent / (100)::numeric))) * (nigvpercent / (100)::numeric))) STORED NOT NULL,
    nlinetotal numeric(14,2) GENERATED ALWAYS AS ((((nquantity * nunitprice) - ((nquantity * nunitprice) * (ndiscountpercent / (100)::numeric))) + (((nquantity * nunitprice) - ((nquantity * nunitprice) * (ndiscountpercent / (100)::numeric))) * (nigvpercent / (100)::numeric)))) STORED NOT NULL,
    cdescription text,
    tcreatedat timestamp without time zone DEFAULT now(),
    CONSTRAINT s01contract_detail_ndiscountpercent_check CHECK (((ndiscountpercent >= (0)::numeric) AND (ndiscountpercent <= (100)::numeric))),
    CONSTRAINT s01contract_detail_nigvpercent_check CHECK (((nigvpercent >= (0)::numeric) AND (nigvpercent <= (100)::numeric))),
    CONSTRAINT s01contract_detail_nquantity_check CHECK ((nquantity > (0)::numeric)),
    CONSTRAINT s01contract_detail_nunitprice_check CHECK ((nunitprice >= (0)::numeric))
);


ALTER TABLE public.s01contract_detail OWNER TO arelyxl;

--
-- Name: s01contract_detail_nidcontractdetail_seq; Type: SEQUENCE; Schema: public; Owner: arelyxl
--

CREATE SEQUENCE public.s01contract_detail_nidcontractdetail_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.s01contract_detail_nidcontractdetail_seq OWNER TO arelyxl;

--
-- Name: s01contract_detail_nidcontractdetail_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: arelyxl
--

ALTER SEQUENCE public.s01contract_detail_nidcontractdetail_seq OWNED BY public.s01contract_detail.nidcontractdetail;


--
-- Name: s01contract_nidcontract_seq; Type: SEQUENCE; Schema: public; Owner: arelyxl
--

CREATE SEQUENCE public.s01contract_nidcontract_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.s01contract_nidcontract_seq OWNER TO arelyxl;

--
-- Name: s01contract_nidcontract_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: arelyxl
--

ALTER SEQUENCE public.s01contract_nidcontract_seq OWNED BY public.s01contract.nidcontract;


--
-- Name: s01credit_note; Type: TABLE; Schema: public; Owner: arelyxl
--

CREATE TABLE public.s01credit_note (
    nidcreditnote bigint NOT NULL,
    ccreditnotenumber character varying(20) NOT NULL,
    niddocumenttype integer NOT NULL,
    nidoriginalcontract bigint NOT NULL,
    nidcompany integer NOT NULL,
    nidclient integer NOT NULL,
    nidemployeecreatedby integer,
    creason character varying(50) NOT NULL,
    cdescription text,
    namount numeric(14,2) NOT NULL,
    cstatus character varying(50) DEFAULT 'EMITTED'::character varying,
    tcreatedat timestamp without time zone DEFAULT now(),
    tmodifiedat timestamp without time zone,
    CONSTRAINT s01credit_note_creason_check CHECK (((creason)::text = ANY ((ARRAY['RETURN'::character varying, 'DISCOUNT'::character varying, 'ERROR'::character varying, 'BONUS'::character varying, 'VOID'::character varying])::text[]))),
    CONSTRAINT s01credit_note_namount_check CHECK ((namount > (0)::numeric))
);


ALTER TABLE public.s01credit_note OWNER TO arelyxl;

--
-- Name: s01credit_note_nidcreditnote_seq; Type: SEQUENCE; Schema: public; Owner: arelyxl
--

CREATE SEQUENCE public.s01credit_note_nidcreditnote_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.s01credit_note_nidcreditnote_seq OWNER TO arelyxl;

--
-- Name: s01credit_note_nidcreditnote_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: arelyxl
--

ALTER SEQUENCE public.s01credit_note_nidcreditnote_seq OWNED BY public.s01credit_note.nidcreditnote;


--
-- Name: s01document_type; Type: TABLE; Schema: public; Owner: arelyxl
--

CREATE TABLE public.s01document_type (
    niddocumenttype integer NOT NULL,
    ccode character varying(2) NOT NULL,
    cname character varying(50) NOT NULL,
    cdescription text,
    bisactive boolean DEFAULT true,
    tcreatedat timestamp without time zone DEFAULT now()
);


ALTER TABLE public.s01document_type OWNER TO arelyxl;

--
-- Name: s01document_type_niddocumenttype_seq; Type: SEQUENCE; Schema: public; Owner: arelyxl
--

CREATE SEQUENCE public.s01document_type_niddocumenttype_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.s01document_type_niddocumenttype_seq OWNER TO arelyxl;

--
-- Name: s01document_type_niddocumenttype_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: arelyxl
--

ALTER SEQUENCE public.s01document_type_niddocumenttype_seq OWNED BY public.s01document_type.niddocumenttype;


--
-- Name: s01employee; Type: TABLE; Schema: public; Owner: arelyxl
--

CREATE TABLE public.s01employee (
    nidemployee integer NOT NULL,
    nidcompany integer NOT NULL,
    cname character varying(50) NOT NULL,
    clastname character varying(50) NOT NULL,
    nididentificationtype integer NOT NULL,
    cidentificationnumber character varying(20) NOT NULL,
    cemail character varying(100) NOT NULL,
    cphoneprimary character varying(20),
    cphonealternative character varying(20),
    nidrole integer NOT NULL,
    bisactive boolean DEFAULT true,
    tcreatedat timestamp without time zone DEFAULT now(),
    tmodifiedat timestamp without time zone
);


ALTER TABLE public.s01employee OWNER TO arelyxl;

--
-- Name: s01employee_nidemployee_seq; Type: SEQUENCE; Schema: public; Owner: arelyxl
--

CREATE SEQUENCE public.s01employee_nidemployee_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.s01employee_nidemployee_seq OWNER TO arelyxl;

--
-- Name: s01employee_nidemployee_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: arelyxl
--

ALTER SEQUENCE public.s01employee_nidemployee_seq OWNED BY public.s01employee.nidemployee;


--
-- Name: s01employee_role; Type: TABLE; Schema: public; Owner: arelyxl
--

CREATE TABLE public.s01employee_role (
    nidemployee integer NOT NULL,
    nidrole integer NOT NULL,
    tassignedat timestamp without time zone DEFAULT now()
);


ALTER TABLE public.s01employee_role OWNER TO arelyxl;

--
-- Name: s01identification_type; Type: TABLE; Schema: public; Owner: arelyxl
--

CREATE TABLE public.s01identification_type (
    nididentificationtype integer NOT NULL,
    ccode character varying(2) NOT NULL,
    cname character varying(50) NOT NULL,
    nmaxlength integer NOT NULL,
    bisactive boolean DEFAULT true,
    tcreatedat timestamp without time zone DEFAULT now()
);


ALTER TABLE public.s01identification_type OWNER TO arelyxl;

--
-- Name: s01identification_type_nididentificationtype_seq; Type: SEQUENCE; Schema: public; Owner: arelyxl
--

CREATE SEQUENCE public.s01identification_type_nididentificationtype_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.s01identification_type_nididentificationtype_seq OWNER TO arelyxl;

--
-- Name: s01identification_type_nididentificationtype_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: arelyxl
--

ALTER SEQUENCE public.s01identification_type_nididentificationtype_seq OWNED BY public.s01identification_type.nididentificationtype;


--
-- Name: s01payment; Type: TABLE; Schema: public; Owner: arelyxl
--

CREATE TABLE public.s01payment (
    nidpayment bigint NOT NULL,
    nidcontract bigint NOT NULL,
    nidpaymentmethod integer NOT NULL,
    nidclient integer NOT NULL,
    nidemployeereceivedby integer,
    cidempotencykey character varying(64) NOT NULL,
    cpaymentnumber character varying(20) NOT NULL,
    namount numeric(14,2) NOT NULL,
    ccurrency character varying(3) DEFAULT 'PEN'::character varying,
    cstatus character varying(50) DEFAULT 'PENDING'::character varying NOT NULL,
    jgatewaydata jsonb DEFAULT '{}'::jsonb,
    tdate timestamp without time zone DEFAULT now(),
    tprocessedat timestamp without time zone,
    tcreatedat timestamp without time zone DEFAULT now(),
    tmodifiedat timestamp without time zone,
    CONSTRAINT s01payment_cstatus_check CHECK (((cstatus)::text = ANY ((ARRAY['PENDING'::character varying, 'PROCESSING'::character varying, 'COMPLETED'::character varying, 'FAILED'::character varying, 'CANCELLED'::character varying, 'REFUNDED'::character varying])::text[]))),
    CONSTRAINT s01payment_namount_check CHECK ((namount > (0)::numeric))
);


ALTER TABLE public.s01payment OWNER TO arelyxl;

--
-- Name: s01payment_method; Type: TABLE; Schema: public; Owner: arelyxl
--

CREATE TABLE public.s01payment_method (
    nidpaymentmethod integer NOT NULL,
    ctype character varying(50) NOT NULL,
    ccode character varying(20) NOT NULL,
    cname character varying(100) NOT NULL,
    bisgateway boolean DEFAULT false,
    cgatewayprovider character varying(100),
    cgatewayurl character varying(500),
    bisactive boolean DEFAULT true,
    tcreatedat timestamp without time zone DEFAULT now()
);


ALTER TABLE public.s01payment_method OWNER TO arelyxl;

--
-- Name: s01payment_method_nidpaymentmethod_seq; Type: SEQUENCE; Schema: public; Owner: arelyxl
--

CREATE SEQUENCE public.s01payment_method_nidpaymentmethod_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.s01payment_method_nidpaymentmethod_seq OWNER TO arelyxl;

--
-- Name: s01payment_method_nidpaymentmethod_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: arelyxl
--

ALTER SEQUENCE public.s01payment_method_nidpaymentmethod_seq OWNED BY public.s01payment_method.nidpaymentmethod;


--
-- Name: s01payment_nidpayment_seq; Type: SEQUENCE; Schema: public; Owner: arelyxl
--

CREATE SEQUENCE public.s01payment_nidpayment_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.s01payment_nidpayment_seq OWNER TO arelyxl;

--
-- Name: s01payment_nidpayment_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: arelyxl
--

ALTER SEQUENCE public.s01payment_nidpayment_seq OWNED BY public.s01payment.nidpayment;


--
-- Name: s01permission; Type: TABLE; Schema: public; Owner: arelyxl
--

CREATE TABLE public.s01permission (
    nidpermission integer NOT NULL,
    ccode character varying(50) NOT NULL,
    cname character varying(100) NOT NULL,
    cdescription text,
    cmodule character varying(50),
    bisactive boolean DEFAULT true,
    tcreatedat timestamp without time zone DEFAULT now()
);


ALTER TABLE public.s01permission OWNER TO arelyxl;

--
-- Name: s01permission_nidpermission_seq; Type: SEQUENCE; Schema: public; Owner: arelyxl
--

CREATE SEQUENCE public.s01permission_nidpermission_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.s01permission_nidpermission_seq OWNER TO arelyxl;

--
-- Name: s01permission_nidpermission_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: arelyxl
--

ALTER SEQUENCE public.s01permission_nidpermission_seq OWNED BY public.s01permission.nidpermission;


--
-- Name: s01phone; Type: TABLE; Schema: public; Owner: arelyxl
--

CREATE TABLE public.s01phone (
    nidphone bigint NOT NULL,
    centitytype character varying(50) NOT NULL,
    nentityid integer NOT NULL,
    nidphonetype integer NOT NULL,
    ccountrycode character varying(3) DEFAULT '+51'::character varying,
    careacode character varying(5),
    cphonenumber character varying(20) NOT NULL,
    cphoneformatted character varying(30),
    bisverified boolean DEFAULT false,
    tverificationdate timestamp without time zone,
    bisprimary boolean DEFAULT false,
    breceivesms boolean DEFAULT true,
    breceivewhatsapp boolean DEFAULT false,
    bisactive boolean DEFAULT true,
    tcreatedat timestamp without time zone DEFAULT now(),
    tmodifiedat timestamp without time zone,
    CONSTRAINT s01phone_centitytype_check CHECK (((centitytype)::text = ANY ((ARRAY['CLIENT'::character varying, 'EMPLOYEE'::character varying, 'COMPANY'::character varying])::text[])))
);


ALTER TABLE public.s01phone OWNER TO arelyxl;

--
-- Name: s01phone_nidphone_seq; Type: SEQUENCE; Schema: public; Owner: arelyxl
--

CREATE SEQUENCE public.s01phone_nidphone_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.s01phone_nidphone_seq OWNER TO arelyxl;

--
-- Name: s01phone_nidphone_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: arelyxl
--

ALTER SEQUENCE public.s01phone_nidphone_seq OWNED BY public.s01phone.nidphone;


--
-- Name: s01phone_type; Type: TABLE; Schema: public; Owner: arelyxl
--

CREATE TABLE public.s01phone_type (
    nidphonetype integer NOT NULL,
    ccode character varying(20) NOT NULL,
    cname character varying(50) NOT NULL,
    cdescription text,
    bisactive boolean DEFAULT true,
    tcreatedat timestamp without time zone DEFAULT now()
);


ALTER TABLE public.s01phone_type OWNER TO arelyxl;

--
-- Name: s01phone_type_nidphonetype_seq; Type: SEQUENCE; Schema: public; Owner: arelyxl
--

CREATE SEQUENCE public.s01phone_type_nidphonetype_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.s01phone_type_nidphonetype_seq OWNER TO arelyxl;

--
-- Name: s01phone_type_nidphonetype_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: arelyxl
--

ALTER SEQUENCE public.s01phone_type_nidphonetype_seq OWNED BY public.s01phone_type.nidphonetype;


--
-- Name: s01product; Type: TABLE; Schema: public; Owner: arelyxl
--

CREATE TABLE public.s01product (
    nidproduct integer NOT NULL,
    nidcompany integer NOT NULL,
    nidcategory integer NOT NULL,
    ccode character varying(50) NOT NULL,
    cname character varying(150) NOT NULL,
    cdescription text,
    cunit character varying(3) DEFAULT 'H87'::character varying NOT NULL,
    ncostprice numeric(12,2),
    nsaleprice numeric(12,2) NOT NULL,
    nigvpercent numeric(5,2) DEFAULT 18.0,
    nstock integer DEFAULT 0 NOT NULL,
    nminstock integer DEFAULT 0,
    nreorderquantity integer,
    cimgurl character varying(500),
    jproductmetadata jsonb DEFAULT '{}'::jsonb,
    bisactive boolean DEFAULT true,
    tcreatedat timestamp without time zone DEFAULT now(),
    tmodifiedat timestamp without time zone,
    CONSTRAINT s01product_nigvpercent_check CHECK (((nigvpercent >= (0)::numeric) AND (nigvpercent <= (100)::numeric))),
    CONSTRAINT s01product_nminstock_check CHECK ((nminstock >= 0)),
    CONSTRAINT s01product_nsaleprice_check CHECK ((nsaleprice > (0)::numeric)),
    CONSTRAINT s01product_nstock_check CHECK ((nstock >= 0))
);


ALTER TABLE public.s01product OWNER TO arelyxl;

--
-- Name: s01product_nidproduct_seq; Type: SEQUENCE; Schema: public; Owner: arelyxl
--

CREATE SEQUENCE public.s01product_nidproduct_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.s01product_nidproduct_seq OWNER TO arelyxl;

--
-- Name: s01product_nidproduct_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: arelyxl
--

ALTER SEQUENCE public.s01product_nidproduct_seq OWNED BY public.s01product.nidproduct;


--
-- Name: s01role; Type: TABLE; Schema: public; Owner: arelyxl
--

CREATE TABLE public.s01role (
    nidrole integer NOT NULL,
    cname character varying(50) NOT NULL,
    cdescription text,
    bisactive boolean DEFAULT true,
    tcreatedat timestamp without time zone DEFAULT now()
);


ALTER TABLE public.s01role OWNER TO arelyxl;

--
-- Name: s01role_nidrole_seq; Type: SEQUENCE; Schema: public; Owner: arelyxl
--

CREATE SEQUENCE public.s01role_nidrole_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.s01role_nidrole_seq OWNER TO arelyxl;

--
-- Name: s01role_nidrole_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: arelyxl
--

ALTER SEQUENCE public.s01role_nidrole_seq OWNED BY public.s01role.nidrole;


--
-- Name: s01role_permission; Type: TABLE; Schema: public; Owner: arelyxl
--

CREATE TABLE public.s01role_permission (
    nidrole integer NOT NULL,
    nidpermission integer NOT NULL,
    tassignedat timestamp without time zone DEFAULT now()
);


ALTER TABLE public.s01role_permission OWNER TO arelyxl;

--
-- Name: seq_contract_number; Type: SEQUENCE; Schema: public; Owner: arelyxl
--

CREATE SEQUENCE public.seq_contract_number
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_contract_number OWNER TO arelyxl;

--
-- Name: seq_credit_note_number; Type: SEQUENCE; Schema: public; Owner: arelyxl
--

CREATE SEQUENCE public.seq_credit_note_number
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_credit_note_number OWNER TO arelyxl;

--
-- Name: seq_payment_number; Type: SEQUENCE; Schema: public; Owner: arelyxl
--

CREATE SEQUENCE public.seq_payment_number
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_payment_number OWNER TO arelyxl;

--
-- Name: v_client_with_phones; Type: VIEW; Schema: public; Owner: arelyxl
--

CREATE VIEW public.v_client_with_phones AS
 SELECT cl.nidclient,
    (((cl.cname)::text || ' '::text) || (cl.clastname)::text) AS cclientname,
    cl.cidentificationnumber,
    cl.cemail,
    pt.cname AS cprimaryphonetype,
    p.cphoneformatted AS cprimaryphone,
    count(p2.nidphone) AS ntotalphones
   FROM (((public.s01client cl
     LEFT JOIN public.s01phone p ON (((cl.nidclient = p.nentityid) AND ((p.centitytype)::text = 'CLIENT'::text) AND (p.bisprimary = true) AND (p.bisactive = true))))
     LEFT JOIN public.s01phone_type pt ON ((p.nidphonetype = pt.nidphonetype)))
     LEFT JOIN public.s01phone p2 ON (((cl.nidclient = p2.nentityid) AND ((p2.centitytype)::text = 'CLIENT'::text) AND (p2.bisactive = true))))
  GROUP BY cl.nidclient, (((cl.cname)::text || ' '::text) || (cl.clastname)::text), cl.cidentificationnumber, cl.cemail, pt.cname, p.cphoneformatted;


ALTER VIEW public.v_client_with_phones OWNER TO arelyxl;

--
-- Name: v_contract_complete; Type: VIEW; Schema: public; Owner: arelyxl
--

CREATE VIEW public.v_contract_complete AS
 SELECT c.nidcontract,
    c.ccontractnumber,
    dt.cname AS cdocumenttype,
    co.cbusinessname AS ccompanyname,
    (((cl.cname)::text || ' '::text) || (cl.clastname)::text) AS cclientname,
    (((emp.cname)::text || ' '::text) || (emp.clastname)::text) AS cemployeecreatedby,
    c.cstatus,
    c.nsubtotal,
    c.ntotaldiscount,
    c.ntaxablebase,
    c.nigvpercent,
    c.nigvamount,
    c.ntotal,
    c.ndownpayment,
    c.nbalancedue,
    c.tdate,
    c.tduedate,
    c.tcreatedat,
    c.tmodifiedat
   FROM ((((public.s01contract c
     LEFT JOIN public.s01document_type dt ON ((c.niddocumenttype = dt.niddocumenttype)))
     LEFT JOIN public.s01company co ON ((c.nidcompany = co.nidcompany)))
     LEFT JOIN public.s01client cl ON ((c.nidclient = cl.nidclient)))
     LEFT JOIN public.s01employee emp ON ((c.nidemployeecreatedby = emp.nidemployee)));


ALTER VIEW public.v_contract_complete OWNER TO arelyxl;

--
-- Name: v_directory; Type: VIEW; Schema: public; Owner: arelyxl
--

CREATE VIEW public.v_directory AS
 SELECT 'CLIENT'::text AS centitytype,
    cl.nidclient AS nentityid,
    (((cl.cname)::text || ' '::text) || (cl.clastname)::text) AS centityname,
    p.cphoneformatted,
    pt.cname AS cphonetype,
    p.breceivesms,
    p.breceivewhatsapp,
    p.bisprimary
   FROM ((public.s01client cl
     LEFT JOIN public.s01phone p ON (((cl.nidclient = p.nentityid) AND ((p.centitytype)::text = 'CLIENT'::text) AND (p.bisactive = true))))
     LEFT JOIN public.s01phone_type pt ON ((p.nidphonetype = pt.nidphonetype)))
  WHERE (cl.bisactive = true)
UNION ALL
 SELECT 'EMPLOYEE'::text AS centitytype,
    e.nidemployee AS nentityid,
    (((e.cname)::text || ' '::text) || (e.clastname)::text) AS centityname,
    p.cphoneformatted,
    pt.cname AS cphonetype,
    p.breceivesms,
    p.breceivewhatsapp,
    p.bisprimary
   FROM ((public.s01employee e
     LEFT JOIN public.s01phone p ON (((e.nidemployee = p.nentityid) AND ((p.centitytype)::text = 'EMPLOYEE'::text) AND (p.bisactive = true))))
     LEFT JOIN public.s01phone_type pt ON ((p.nidphonetype = pt.nidphonetype)))
  WHERE (e.bisactive = true);


ALTER VIEW public.v_directory OWNER TO arelyxl;

--
-- Name: v_employee_permissions; Type: VIEW; Schema: public; Owner: arelyxl
--

CREATE VIEW public.v_employee_permissions AS
 SELECT DISTINCT e.nidemployee,
    (((e.cname)::text || ' '::text) || (e.clastname)::text) AS cemployeename,
    c.cbusinessname AS ccompanyname,
    r.nidrole,
    r.cname AS crolename,
    p.nidpermission,
    p.ccode AS cpermissioncode,
    p.cname AS cpermissionname,
    p.cmodule,
    e.bisactive AS bemployeeactive,
    r.bisactive AS broleactive,
    p.bisactive AS bpermissionactive
   FROM (((((public.s01employee e
     JOIN public.s01company c ON ((e.nidcompany = c.nidcompany)))
     LEFT JOIN public.s01employee_role er ON ((e.nidemployee = er.nidemployee)))
     LEFT JOIN public.s01role r ON ((er.nidrole = r.nidrole)))
     LEFT JOIN public.s01role_permission rp ON ((r.nidrole = rp.nidrole)))
     LEFT JOIN public.s01permission p ON ((rp.nidpermission = p.nidpermission)))
  WHERE (e.bisactive = true);


ALTER VIEW public.v_employee_permissions OWNER TO arelyxl;

--
-- Name: v_employee_with_phones; Type: VIEW; Schema: public; Owner: arelyxl
--

CREATE VIEW public.v_employee_with_phones AS
 SELECT e.nidemployee,
    (((e.cname)::text || ' '::text) || (e.clastname)::text) AS cempname,
    e.cemail,
    co.cbusinessname AS ccompanyname,
    pt.cname AS cprimaryphonetype,
    p.cphoneformatted AS cprimaryphone,
    count(p2.nidphone) AS ntotalphones
   FROM ((((public.s01employee e
     LEFT JOIN public.s01company co ON ((e.nidcompany = co.nidcompany)))
     LEFT JOIN public.s01phone p ON (((e.nidemployee = p.nentityid) AND ((p.centitytype)::text = 'EMPLOYEE'::text) AND (p.bisprimary = true) AND (p.bisactive = true))))
     LEFT JOIN public.s01phone_type pt ON ((p.nidphonetype = pt.nidphonetype)))
     LEFT JOIN public.s01phone p2 ON (((e.nidemployee = p2.nentityid) AND ((p2.centitytype)::text = 'EMPLOYEE'::text) AND (p2.bisactive = true))))
  GROUP BY e.nidemployee, (((e.cname)::text || ' '::text) || (e.clastname)::text), e.cemail, co.cbusinessname, pt.cname, p.cphoneformatted;


ALTER VIEW public.v_employee_with_phones OWNER TO arelyxl;

--
-- Name: v_payment_summary; Type: VIEW; Schema: public; Owner: arelyxl
--

CREATE VIEW public.v_payment_summary AS
 SELECT p.nidpayment,
    p.cpaymentnumber,
    c.ccontractnumber,
    co.cbusinessname AS ccompanyname,
    (((cl.cname)::text || ' '::text) || (cl.clastname)::text) AS cclientname,
    (((emp.cname)::text || ' '::text) || (emp.clastname)::text) AS cemployeereceivedby,
    p.namount,
    c.ntotal AS ccontracttotal,
    (c.ntotal - COALESCE(sum(p2.namount) OVER (PARTITION BY p.nidcontract ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW), (0)::numeric)) AS cbalanceremaining,
    p.cstatus,
    pm.cname AS cpaymentmethodname,
    (p.jgatewaydata ->> 'cGatewayTransactionId'::text) AS cgatewaytrxid,
    p.tdate,
    p.tprocessedat
   FROM ((((((public.s01payment p
     LEFT JOIN public.s01contract c ON ((p.nidcontract = c.nidcontract)))
     LEFT JOIN public.s01company co ON ((c.nidcompany = co.nidcompany)))
     LEFT JOIN public.s01client cl ON ((p.nidclient = cl.nidclient)))
     LEFT JOIN public.s01employee emp ON ((p.nidemployeereceivedby = emp.nidemployee)))
     LEFT JOIN public.s01payment_method pm ON ((p.nidpaymentmethod = pm.nidpaymentmethod)))
     LEFT JOIN public.s01payment p2 ON (((p.nidcontract = p2.nidcontract) AND ((p2.cstatus)::text = 'COMPLETED'::text) AND (p2.tdate <= p.tdate))));


ALTER VIEW public.v_payment_summary OWNER TO arelyxl;

--
-- Name: v_product_stock; Type: VIEW; Schema: public; Owner: arelyxl
--

CREATE VIEW public.v_product_stock AS
 SELECT p.nidproduct,
    p.ccode,
    p.cname,
    co.cbusinessname AS ccompanyname,
    cat.cname AS ccategoryname,
    p.nstock,
    p.nminstock,
    p.nreorderquantity,
    p.nsaleprice,
    p.ncostprice,
    p.nigvpercent,
        CASE
            WHEN (p.nstock <= p.nminstock) THEN 'LOW_STOCK'::text
            WHEN (p.nstock = 0) THEN 'OUT_OF_STOCK'::text
            ELSE 'IN_STOCK'::text
        END AS cstockstatus
   FROM ((public.s01product p
     LEFT JOIN public.s01company co ON ((p.nidcompany = co.nidcompany)))
     LEFT JOIN public.s01category cat ON ((p.nidcategory = cat.nidcategory)))
  WHERE (p.bisactive = true);


ALTER VIEW public.v_product_stock OWNER TO arelyxl;

--
-- Name: s01audit_log nidauditlog; Type: DEFAULT; Schema: public; Owner: arelyxl
--

ALTER TABLE ONLY public.s01audit_log ALTER COLUMN nidauditlog SET DEFAULT nextval('public.s01audit_log_nidauditlog_seq'::regclass);


--
-- Name: s01category nidcategory; Type: DEFAULT; Schema: public; Owner: arelyxl
--

ALTER TABLE ONLY public.s01category ALTER COLUMN nidcategory SET DEFAULT nextval('public.s01category_nidcategory_seq'::regclass);


--
-- Name: s01client nidclient; Type: DEFAULT; Schema: public; Owner: arelyxl
--

ALTER TABLE ONLY public.s01client ALTER COLUMN nidclient SET DEFAULT nextval('public.s01client_nidclient_seq'::regclass);


--
-- Name: s01company nidcompany; Type: DEFAULT; Schema: public; Owner: arelyxl
--

ALTER TABLE ONLY public.s01company ALTER COLUMN nidcompany SET DEFAULT nextval('public.s01company_nidcompany_seq'::regclass);


--
-- Name: s01contract nidcontract; Type: DEFAULT; Schema: public; Owner: arelyxl
--

ALTER TABLE ONLY public.s01contract ALTER COLUMN nidcontract SET DEFAULT nextval('public.s01contract_nidcontract_seq'::regclass);


--
-- Name: s01contract_detail nidcontractdetail; Type: DEFAULT; Schema: public; Owner: arelyxl
--

ALTER TABLE ONLY public.s01contract_detail ALTER COLUMN nidcontractdetail SET DEFAULT nextval('public.s01contract_detail_nidcontractdetail_seq'::regclass);


--
-- Name: s01credit_note nidcreditnote; Type: DEFAULT; Schema: public; Owner: arelyxl
--

ALTER TABLE ONLY public.s01credit_note ALTER COLUMN nidcreditnote SET DEFAULT nextval('public.s01credit_note_nidcreditnote_seq'::regclass);


--
-- Name: s01document_type niddocumenttype; Type: DEFAULT; Schema: public; Owner: arelyxl
--

ALTER TABLE ONLY public.s01document_type ALTER COLUMN niddocumenttype SET DEFAULT nextval('public.s01document_type_niddocumenttype_seq'::regclass);


--
-- Name: s01employee nidemployee; Type: DEFAULT; Schema: public; Owner: arelyxl
--

ALTER TABLE ONLY public.s01employee ALTER COLUMN nidemployee SET DEFAULT nextval('public.s01employee_nidemployee_seq'::regclass);


--
-- Name: s01identification_type nididentificationtype; Type: DEFAULT; Schema: public; Owner: arelyxl
--

ALTER TABLE ONLY public.s01identification_type ALTER COLUMN nididentificationtype SET DEFAULT nextval('public.s01identification_type_nididentificationtype_seq'::regclass);


--
-- Name: s01payment nidpayment; Type: DEFAULT; Schema: public; Owner: arelyxl
--

ALTER TABLE ONLY public.s01payment ALTER COLUMN nidpayment SET DEFAULT nextval('public.s01payment_nidpayment_seq'::regclass);


--
-- Name: s01payment_method nidpaymentmethod; Type: DEFAULT; Schema: public; Owner: arelyxl
--

ALTER TABLE ONLY public.s01payment_method ALTER COLUMN nidpaymentmethod SET DEFAULT nextval('public.s01payment_method_nidpaymentmethod_seq'::regclass);


--
-- Name: s01permission nidpermission; Type: DEFAULT; Schema: public; Owner: arelyxl
--

ALTER TABLE ONLY public.s01permission ALTER COLUMN nidpermission SET DEFAULT nextval('public.s01permission_nidpermission_seq'::regclass);


--
-- Name: s01phone nidphone; Type: DEFAULT; Schema: public; Owner: arelyxl
--

ALTER TABLE ONLY public.s01phone ALTER COLUMN nidphone SET DEFAULT nextval('public.s01phone_nidphone_seq'::regclass);


--
-- Name: s01phone_type nidphonetype; Type: DEFAULT; Schema: public; Owner: arelyxl
--

ALTER TABLE ONLY public.s01phone_type ALTER COLUMN nidphonetype SET DEFAULT nextval('public.s01phone_type_nidphonetype_seq'::regclass);


--
-- Name: s01product nidproduct; Type: DEFAULT; Schema: public; Owner: arelyxl
--

ALTER TABLE ONLY public.s01product ALTER COLUMN nidproduct SET DEFAULT nextval('public.s01product_nidproduct_seq'::regclass);


--
-- Name: s01role nidrole; Type: DEFAULT; Schema: public; Owner: arelyxl
--

ALTER TABLE ONLY public.s01role ALTER COLUMN nidrole SET DEFAULT nextval('public.s01role_nidrole_seq'::regclass);


--
-- Data for Name: s01audit_log; Type: TABLE DATA; Schema: public; Owner: arelyxl
--

COPY public.s01audit_log (nidauditlog, ctablename, nrecordid, coperation, joldvalue, jnewvalue, jchangedfields, cusername, cipaddress, ctransactionid, cchangetype, ttimestamp) FROM stdin;
\.


--
-- Data for Name: s01category; Type: TABLE DATA; Schema: public; Owner: arelyxl
--

COPY public.s01category (nidcategory, ccode, cname, cdescription, bisactive, tcreatedat, tmodifiedat) FROM stdin;
\.


--
-- Data for Name: s01client; Type: TABLE DATA; Schema: public; Owner: arelyxl
--

COPY public.s01client (nidclient, cname, clastname, nididentificationtype, cidentificationnumber, cemail, cphoneprimary, cphonealternative, caddress, ccity, ccountry, bidentificationvalidated, tidentificationvalidationdate, cidentificationvalidationstatus, jclientmetadata, bisactive, tcreatedat, tmodifiedat) FROM stdin;
\.


--
-- Data for Name: s01company; Type: TABLE DATA; Schema: public; Owner: arelyxl
--

COPY public.s01company (nidcompany, cruc, cbusinessname, ctradename, cdescription, clogourl, cemail, cphoneprimary, cphonealternative, caddress, ccity, ccountry, bisrucvalidated, trucvalidationdate, crucvalidationstatus, bisactive, tcreatedat, tmodifiedat) FROM stdin;
\.


--
-- Data for Name: s01contract; Type: TABLE DATA; Schema: public; Owner: arelyxl
--

COPY public.s01contract (nidcontract, ccontractnumber, niddocumenttype, nidclient, nidcompany, nidemployeecreatedby, cstatus, nsubtotal, ntotaldiscount, nigvpercent, ndownpayment, jcontractmetadata, tdate, tduedate, tcreatedat, tmodifiedat) FROM stdin;
\.


--
-- Data for Name: s01contract_detail; Type: TABLE DATA; Schema: public; Owner: arelyxl
--

COPY public.s01contract_detail (nidcontractdetail, nidcontract, nlinenumber, nidproduct, cproductname, cproductcode, cunit, nquantity, nunitprice, ndiscountpercent, nigvpercent, cdescription, tcreatedat) FROM stdin;
\.


--
-- Data for Name: s01credit_note; Type: TABLE DATA; Schema: public; Owner: arelyxl
--

COPY public.s01credit_note (nidcreditnote, ccreditnotenumber, niddocumenttype, nidoriginalcontract, nidcompany, nidclient, nidemployeecreatedby, creason, cdescription, namount, cstatus, tcreatedat, tmodifiedat) FROM stdin;
\.


--
-- Data for Name: s01document_type; Type: TABLE DATA; Schema: public; Owner: arelyxl
--

COPY public.s01document_type (niddocumenttype, ccode, cname, cdescription, bisactive, tcreatedat) FROM stdin;
1	01	Factura	Factura Electrónica	t	2025-11-23 19:03:03.796334
2	03	Boleta	Boleta de Venta Electrónica	t	2025-11-23 19:03:03.796334
3	07	Nota Crédito	Nota de Crédito Electrónica	t	2025-11-23 19:03:03.796334
4	08	Nota Débito	Nota de Débito Electrónica	t	2025-11-23 19:03:03.796334
\.


--
-- Data for Name: s01employee; Type: TABLE DATA; Schema: public; Owner: arelyxl
--

COPY public.s01employee (nidemployee, nidcompany, cname, clastname, nididentificationtype, cidentificationnumber, cemail, cphoneprimary, cphonealternative, nidrole, bisactive, tcreatedat, tmodifiedat) FROM stdin;
\.


--
-- Data for Name: s01employee_role; Type: TABLE DATA; Schema: public; Owner: arelyxl
--

COPY public.s01employee_role (nidemployee, nidrole, tassignedat) FROM stdin;
\.


--
-- Data for Name: s01identification_type; Type: TABLE DATA; Schema: public; Owner: arelyxl
--

COPY public.s01identification_type (nididentificationtype, ccode, cname, nmaxlength, bisactive, tcreatedat) FROM stdin;
1	1	DNI	8	t	2025-11-23 19:02:47.767373
2	6	RUC	11	t	2025-11-23 19:02:47.767373
3	7	Pasaporte	20	t	2025-11-23 19:02:47.767373
\.


--
-- Data for Name: s01payment; Type: TABLE DATA; Schema: public; Owner: arelyxl
--

COPY public.s01payment (nidpayment, nidcontract, nidpaymentmethod, nidclient, nidemployeereceivedby, cidempotencykey, cpaymentnumber, namount, ccurrency, cstatus, jgatewaydata, tdate, tprocessedat, tcreatedat, tmodifiedat) FROM stdin;
\.


--
-- Data for Name: s01payment_method; Type: TABLE DATA; Schema: public; Owner: arelyxl
--

COPY public.s01payment_method (nidpaymentmethod, ctype, ccode, cname, bisgateway, cgatewayprovider, cgatewayurl, bisactive, tcreatedat) FROM stdin;
1	CASH	01	Efectivo	f	\N	\N	t	2025-11-23 19:03:25.001839
2	TRANSFER	02	Transferencia Bancaria	f	\N	\N	t	2025-11-23 19:03:25.001839
3	CREDIT_CARD	03	Tarjeta de Crédito	t	\N	\N	t	2025-11-23 19:03:25.001839
4	CHECK	04	Cheque	f	\N	\N	t	2025-11-23 19:03:25.001839
\.


--
-- Data for Name: s01permission; Type: TABLE DATA; Schema: public; Owner: arelyxl
--

COPY public.s01permission (nidpermission, ccode, cname, cdescription, cmodule, bisactive, tcreatedat) FROM stdin;
1	CREATE_CONTRACT	Crear Comprobante	Permite crear nuevos comprobantes (facturas, boletas)	CONTRACTS	t	2025-11-23 19:09:53.224077
2	VIEW_CONTRACT	Ver Comprobante	Permite ver detalles de comprobantes	CONTRACTS	t	2025-11-23 19:09:53.224077
3	EDIT_CONTRACT	Editar Comprobante	Permite editar comprobantes en estado DRAFT	CONTRACTS	t	2025-11-23 19:09:53.224077
4	EMIT_CONTRACT	Emitir Comprobante	Permite emitir comprobantes (cambiar estado a EMITTED)	CONTRACTS	t	2025-11-23 19:09:53.224077
5	DELETE_CONTRACT	Eliminar Comprobante	Permite eliminar/anular comprobantes	CONTRACTS	t	2025-11-23 19:09:53.224077
6	CREATE_CLIENT	Crear Cliente	Permite crear nuevos clientes	CLIENTS	t	2025-11-23 19:09:53.224077
7	VIEW_CLIENT	Ver Cliente	Permite ver detalles de clientes	CLIENTS	t	2025-11-23 19:09:53.224077
8	EDIT_CLIENT	Editar Cliente	Permite editar datos de clientes	CLIENTS	t	2025-11-23 19:09:53.224077
9	DELETE_CLIENT	Eliminar Cliente	Permite eliminar clientes	CLIENTS	t	2025-11-23 19:09:53.224077
10	CREATE_PAYMENT	Crear Pago	Permite registrar nuevos pagos	PAYMENTS	t	2025-11-23 19:09:53.224077
11	VIEW_PAYMENT	Ver Pago	Permite ver detalles de pagos	PAYMENTS	t	2025-11-23 19:09:53.224077
12	REFUND_PAYMENT	Revertir Pago	Permite revertir pagos (REFUND)	PAYMENTS	t	2025-11-23 19:09:53.224077
13	DELETE_PAYMENT	Eliminar Pago	Permite eliminar pagos	PAYMENTS	t	2025-11-23 19:09:53.224077
14	CREATE_PRODUCT	Crear Producto	Permite crear nuevos productos	PRODUCTS	t	2025-11-23 19:09:53.224077
15	VIEW_PRODUCT	Ver Producto	Permite ver productos	PRODUCTS	t	2025-11-23 19:09:53.224077
16	EDIT_PRODUCT	Editar Producto	Permite editar datos de productos	PRODUCTS	t	2025-11-23 19:09:53.224077
17	DELETE_PRODUCT	Eliminar Producto	Permite eliminar productos	PRODUCTS	t	2025-11-23 19:09:53.224077
18	VIEW_AUDIT_LOG	Ver Auditoría	Permite acceder a logs de auditoría	AUDIT	t	2025-11-23 19:09:53.224077
19	VIEW_REPORTS	Ver Reportes	Permite acceder a reportes del sistema	REPORTS	t	2025-11-23 19:09:53.224077
20	MANAGE_USERS	Gestionar Usuarios	Permite crear/editar/eliminar usuarios	ADMIN	t	2025-11-23 19:09:53.224077
21	MANAGE_ROLES	Gestionar Roles	Permite crear/editar permisos y roles	ADMIN	t	2025-11-23 19:09:53.224077
22	SYSTEM_CONFIG	Configuración del Sistema	Permite acceso a configuración global	ADMIN	t	2025-11-23 19:09:53.224077
\.


--
-- Data for Name: s01phone; Type: TABLE DATA; Schema: public; Owner: arelyxl
--

COPY public.s01phone (nidphone, centitytype, nentityid, nidphonetype, ccountrycode, careacode, cphonenumber, cphoneformatted, bisverified, tverificationdate, bisprimary, breceivesms, breceivewhatsapp, bisactive, tcreatedat, tmodifiedat) FROM stdin;
\.


--
-- Data for Name: s01phone_type; Type: TABLE DATA; Schema: public; Owner: arelyxl
--

COPY public.s01phone_type (nidphonetype, ccode, cname, cdescription, bisactive, tcreatedat) FROM stdin;
1	MOBILE	Teléfono Móvil	Celular personal o empresarial	t	2025-11-23 19:02:57.091146
2	LANDLINE	Teléfono Fijo	Línea telefónica fija	t	2025-11-23 19:02:57.091146
3	WHATSAPP	WhatsApp	Número con WhatsApp activo	t	2025-11-23 19:02:57.091146
4	OFFICE	Teléfono Oficina	Extensión de oficina	t	2025-11-23 19:02:57.091146
5	FAX	Fax	Línea de fax	t	2025-11-23 19:02:57.091146
\.


--
-- Data for Name: s01product; Type: TABLE DATA; Schema: public; Owner: arelyxl
--

COPY public.s01product (nidproduct, nidcompany, nidcategory, ccode, cname, cdescription, cunit, ncostprice, nsaleprice, nigvpercent, nstock, nminstock, nreorderquantity, cimgurl, jproductmetadata, bisactive, tcreatedat, tmodifiedat) FROM stdin;
\.


--
-- Data for Name: s01role; Type: TABLE DATA; Schema: public; Owner: arelyxl
--

COPY public.s01role (nidrole, cname, cdescription, bisactive, tcreatedat) FROM stdin;
\.


--
-- Data for Name: s01role_permission; Type: TABLE DATA; Schema: public; Owner: arelyxl
--

COPY public.s01role_permission (nidrole, nidpermission, tassignedat) FROM stdin;
\.


--
-- Name: s01audit_log_nidauditlog_seq; Type: SEQUENCE SET; Schema: public; Owner: arelyxl
--

SELECT pg_catalog.setval('public.s01audit_log_nidauditlog_seq', 1, false);


--
-- Name: s01category_nidcategory_seq; Type: SEQUENCE SET; Schema: public; Owner: arelyxl
--

SELECT pg_catalog.setval('public.s01category_nidcategory_seq', 1, false);


--
-- Name: s01client_nidclient_seq; Type: SEQUENCE SET; Schema: public; Owner: arelyxl
--

SELECT pg_catalog.setval('public.s01client_nidclient_seq', 1, false);


--
-- Name: s01company_nidcompany_seq; Type: SEQUENCE SET; Schema: public; Owner: arelyxl
--

SELECT pg_catalog.setval('public.s01company_nidcompany_seq', 1, false);


--
-- Name: s01contract_detail_nidcontractdetail_seq; Type: SEQUENCE SET; Schema: public; Owner: arelyxl
--

SELECT pg_catalog.setval('public.s01contract_detail_nidcontractdetail_seq', 1, false);


--
-- Name: s01contract_nidcontract_seq; Type: SEQUENCE SET; Schema: public; Owner: arelyxl
--

SELECT pg_catalog.setval('public.s01contract_nidcontract_seq', 1, false);


--
-- Name: s01credit_note_nidcreditnote_seq; Type: SEQUENCE SET; Schema: public; Owner: arelyxl
--

SELECT pg_catalog.setval('public.s01credit_note_nidcreditnote_seq', 1, false);


--
-- Name: s01document_type_niddocumenttype_seq; Type: SEQUENCE SET; Schema: public; Owner: arelyxl
--

SELECT pg_catalog.setval('public.s01document_type_niddocumenttype_seq', 4, true);


--
-- Name: s01employee_nidemployee_seq; Type: SEQUENCE SET; Schema: public; Owner: arelyxl
--

SELECT pg_catalog.setval('public.s01employee_nidemployee_seq', 1, false);


--
-- Name: s01identification_type_nididentificationtype_seq; Type: SEQUENCE SET; Schema: public; Owner: arelyxl
--

SELECT pg_catalog.setval('public.s01identification_type_nididentificationtype_seq', 3, true);


--
-- Name: s01payment_method_nidpaymentmethod_seq; Type: SEQUENCE SET; Schema: public; Owner: arelyxl
--

SELECT pg_catalog.setval('public.s01payment_method_nidpaymentmethod_seq', 4, true);


--
-- Name: s01payment_nidpayment_seq; Type: SEQUENCE SET; Schema: public; Owner: arelyxl
--

SELECT pg_catalog.setval('public.s01payment_nidpayment_seq', 1, false);


--
-- Name: s01permission_nidpermission_seq; Type: SEQUENCE SET; Schema: public; Owner: arelyxl
--

SELECT pg_catalog.setval('public.s01permission_nidpermission_seq', 22, true);


--
-- Name: s01phone_nidphone_seq; Type: SEQUENCE SET; Schema: public; Owner: arelyxl
--

SELECT pg_catalog.setval('public.s01phone_nidphone_seq', 1, false);


--
-- Name: s01phone_type_nidphonetype_seq; Type: SEQUENCE SET; Schema: public; Owner: arelyxl
--

SELECT pg_catalog.setval('public.s01phone_type_nidphonetype_seq', 5, true);


--
-- Name: s01product_nidproduct_seq; Type: SEQUENCE SET; Schema: public; Owner: arelyxl
--

SELECT pg_catalog.setval('public.s01product_nidproduct_seq', 1, false);


--
-- Name: s01role_nidrole_seq; Type: SEQUENCE SET; Schema: public; Owner: arelyxl
--

SELECT pg_catalog.setval('public.s01role_nidrole_seq', 1, false);


--
-- Name: seq_contract_number; Type: SEQUENCE SET; Schema: public; Owner: arelyxl
--

SELECT pg_catalog.setval('public.seq_contract_number', 1, false);


--
-- Name: seq_credit_note_number; Type: SEQUENCE SET; Schema: public; Owner: arelyxl
--

SELECT pg_catalog.setval('public.seq_credit_note_number', 1, false);


--
-- Name: seq_payment_number; Type: SEQUENCE SET; Schema: public; Owner: arelyxl
--

SELECT pg_catalog.setval('public.seq_payment_number', 1, false);


--
-- Name: s01audit_log s01audit_log_ctransactionid_key; Type: CONSTRAINT; Schema: public; Owner: arelyxl
--

ALTER TABLE ONLY public.s01audit_log
    ADD CONSTRAINT s01audit_log_ctransactionid_key UNIQUE (ctransactionid);


--
-- Name: s01audit_log s01audit_log_pkey; Type: CONSTRAINT; Schema: public; Owner: arelyxl
--

ALTER TABLE ONLY public.s01audit_log
    ADD CONSTRAINT s01audit_log_pkey PRIMARY KEY (nidauditlog);


--
-- Name: s01category s01category_ccode_key; Type: CONSTRAINT; Schema: public; Owner: arelyxl
--

ALTER TABLE ONLY public.s01category
    ADD CONSTRAINT s01category_ccode_key UNIQUE (ccode);


--
-- Name: s01category s01category_cname_key; Type: CONSTRAINT; Schema: public; Owner: arelyxl
--

ALTER TABLE ONLY public.s01category
    ADD CONSTRAINT s01category_cname_key UNIQUE (cname);


--
-- Name: s01category s01category_pkey; Type: CONSTRAINT; Schema: public; Owner: arelyxl
--

ALTER TABLE ONLY public.s01category
    ADD CONSTRAINT s01category_pkey PRIMARY KEY (nidcategory);


--
-- Name: s01client s01client_nididentificationtype_cidentificationnumber_key; Type: CONSTRAINT; Schema: public; Owner: arelyxl
--

ALTER TABLE ONLY public.s01client
    ADD CONSTRAINT s01client_nididentificationtype_cidentificationnumber_key UNIQUE (nididentificationtype, cidentificationnumber);


--
-- Name: s01client s01client_pkey; Type: CONSTRAINT; Schema: public; Owner: arelyxl
--

ALTER TABLE ONLY public.s01client
    ADD CONSTRAINT s01client_pkey PRIMARY KEY (nidclient);


--
-- Name: s01company s01company_cruc_key; Type: CONSTRAINT; Schema: public; Owner: arelyxl
--

ALTER TABLE ONLY public.s01company
    ADD CONSTRAINT s01company_cruc_key UNIQUE (cruc);


--
-- Name: s01company s01company_pkey; Type: CONSTRAINT; Schema: public; Owner: arelyxl
--

ALTER TABLE ONLY public.s01company
    ADD CONSTRAINT s01company_pkey PRIMARY KEY (nidcompany);


--
-- Name: s01contract s01contract_ccontractnumber_key; Type: CONSTRAINT; Schema: public; Owner: arelyxl
--

ALTER TABLE ONLY public.s01contract
    ADD CONSTRAINT s01contract_ccontractnumber_key UNIQUE (ccontractnumber);


--
-- Name: s01contract_detail s01contract_detail_nidcontract_nlinenumber_key; Type: CONSTRAINT; Schema: public; Owner: arelyxl
--

ALTER TABLE ONLY public.s01contract_detail
    ADD CONSTRAINT s01contract_detail_nidcontract_nlinenumber_key UNIQUE (nidcontract, nlinenumber);


--
-- Name: s01contract_detail s01contract_detail_pkey; Type: CONSTRAINT; Schema: public; Owner: arelyxl
--

ALTER TABLE ONLY public.s01contract_detail
    ADD CONSTRAINT s01contract_detail_pkey PRIMARY KEY (nidcontractdetail);


--
-- Name: s01contract s01contract_pkey; Type: CONSTRAINT; Schema: public; Owner: arelyxl
--

ALTER TABLE ONLY public.s01contract
    ADD CONSTRAINT s01contract_pkey PRIMARY KEY (nidcontract);


--
-- Name: s01credit_note s01credit_note_ccreditnotenumber_key; Type: CONSTRAINT; Schema: public; Owner: arelyxl
--

ALTER TABLE ONLY public.s01credit_note
    ADD CONSTRAINT s01credit_note_ccreditnotenumber_key UNIQUE (ccreditnotenumber);


--
-- Name: s01credit_note s01credit_note_pkey; Type: CONSTRAINT; Schema: public; Owner: arelyxl
--

ALTER TABLE ONLY public.s01credit_note
    ADD CONSTRAINT s01credit_note_pkey PRIMARY KEY (nidcreditnote);


--
-- Name: s01document_type s01document_type_ccode_key; Type: CONSTRAINT; Schema: public; Owner: arelyxl
--

ALTER TABLE ONLY public.s01document_type
    ADD CONSTRAINT s01document_type_ccode_key UNIQUE (ccode);


--
-- Name: s01document_type s01document_type_cname_key; Type: CONSTRAINT; Schema: public; Owner: arelyxl
--

ALTER TABLE ONLY public.s01document_type
    ADD CONSTRAINT s01document_type_cname_key UNIQUE (cname);


--
-- Name: s01document_type s01document_type_pkey; Type: CONSTRAINT; Schema: public; Owner: arelyxl
--

ALTER TABLE ONLY public.s01document_type
    ADD CONSTRAINT s01document_type_pkey PRIMARY KEY (niddocumenttype);


--
-- Name: s01employee s01employee_cemail_key; Type: CONSTRAINT; Schema: public; Owner: arelyxl
--

ALTER TABLE ONLY public.s01employee
    ADD CONSTRAINT s01employee_cemail_key UNIQUE (cemail);


--
-- Name: s01employee s01employee_nidcompany_nididentificationtype_cidentificatio_key; Type: CONSTRAINT; Schema: public; Owner: arelyxl
--

ALTER TABLE ONLY public.s01employee
    ADD CONSTRAINT s01employee_nidcompany_nididentificationtype_cidentificatio_key UNIQUE (nidcompany, nididentificationtype, cidentificationnumber);


--
-- Name: s01employee s01employee_pkey; Type: CONSTRAINT; Schema: public; Owner: arelyxl
--

ALTER TABLE ONLY public.s01employee
    ADD CONSTRAINT s01employee_pkey PRIMARY KEY (nidemployee);


--
-- Name: s01employee_role s01employee_role_pkey; Type: CONSTRAINT; Schema: public; Owner: arelyxl
--

ALTER TABLE ONLY public.s01employee_role
    ADD CONSTRAINT s01employee_role_pkey PRIMARY KEY (nidemployee, nidrole);


--
-- Name: s01identification_type s01identification_type_ccode_key; Type: CONSTRAINT; Schema: public; Owner: arelyxl
--

ALTER TABLE ONLY public.s01identification_type
    ADD CONSTRAINT s01identification_type_ccode_key UNIQUE (ccode);


--
-- Name: s01identification_type s01identification_type_cname_key; Type: CONSTRAINT; Schema: public; Owner: arelyxl
--

ALTER TABLE ONLY public.s01identification_type
    ADD CONSTRAINT s01identification_type_cname_key UNIQUE (cname);


--
-- Name: s01identification_type s01identification_type_pkey; Type: CONSTRAINT; Schema: public; Owner: arelyxl
--

ALTER TABLE ONLY public.s01identification_type
    ADD CONSTRAINT s01identification_type_pkey PRIMARY KEY (nididentificationtype);


--
-- Name: s01payment s01payment_cidempotencykey_key; Type: CONSTRAINT; Schema: public; Owner: arelyxl
--

ALTER TABLE ONLY public.s01payment
    ADD CONSTRAINT s01payment_cidempotencykey_key UNIQUE (cidempotencykey);


--
-- Name: s01payment s01payment_cpaymentnumber_key; Type: CONSTRAINT; Schema: public; Owner: arelyxl
--

ALTER TABLE ONLY public.s01payment
    ADD CONSTRAINT s01payment_cpaymentnumber_key UNIQUE (cpaymentnumber);


--
-- Name: s01payment_method s01payment_method_ccode_key; Type: CONSTRAINT; Schema: public; Owner: arelyxl
--

ALTER TABLE ONLY public.s01payment_method
    ADD CONSTRAINT s01payment_method_ccode_key UNIQUE (ccode);


--
-- Name: s01payment_method s01payment_method_cname_key; Type: CONSTRAINT; Schema: public; Owner: arelyxl
--

ALTER TABLE ONLY public.s01payment_method
    ADD CONSTRAINT s01payment_method_cname_key UNIQUE (cname);


--
-- Name: s01payment_method s01payment_method_ctype_key; Type: CONSTRAINT; Schema: public; Owner: arelyxl
--

ALTER TABLE ONLY public.s01payment_method
    ADD CONSTRAINT s01payment_method_ctype_key UNIQUE (ctype);


--
-- Name: s01payment_method s01payment_method_pkey; Type: CONSTRAINT; Schema: public; Owner: arelyxl
--

ALTER TABLE ONLY public.s01payment_method
    ADD CONSTRAINT s01payment_method_pkey PRIMARY KEY (nidpaymentmethod);


--
-- Name: s01payment s01payment_pkey; Type: CONSTRAINT; Schema: public; Owner: arelyxl
--

ALTER TABLE ONLY public.s01payment
    ADD CONSTRAINT s01payment_pkey PRIMARY KEY (nidpayment);


--
-- Name: s01permission s01permission_ccode_key; Type: CONSTRAINT; Schema: public; Owner: arelyxl
--

ALTER TABLE ONLY public.s01permission
    ADD CONSTRAINT s01permission_ccode_key UNIQUE (ccode);


--
-- Name: s01permission s01permission_cname_key; Type: CONSTRAINT; Schema: public; Owner: arelyxl
--

ALTER TABLE ONLY public.s01permission
    ADD CONSTRAINT s01permission_cname_key UNIQUE (cname);


--
-- Name: s01permission s01permission_pkey; Type: CONSTRAINT; Schema: public; Owner: arelyxl
--

ALTER TABLE ONLY public.s01permission
    ADD CONSTRAINT s01permission_pkey PRIMARY KEY (nidpermission);


--
-- Name: s01phone s01phone_centitytype_nentityid_cphonenumber_key; Type: CONSTRAINT; Schema: public; Owner: arelyxl
--

ALTER TABLE ONLY public.s01phone
    ADD CONSTRAINT s01phone_centitytype_nentityid_cphonenumber_key UNIQUE (centitytype, nentityid, cphonenumber);


--
-- Name: s01phone s01phone_pkey; Type: CONSTRAINT; Schema: public; Owner: arelyxl
--

ALTER TABLE ONLY public.s01phone
    ADD CONSTRAINT s01phone_pkey PRIMARY KEY (nidphone);


--
-- Name: s01phone_type s01phone_type_ccode_key; Type: CONSTRAINT; Schema: public; Owner: arelyxl
--

ALTER TABLE ONLY public.s01phone_type
    ADD CONSTRAINT s01phone_type_ccode_key UNIQUE (ccode);


--
-- Name: s01phone_type s01phone_type_cname_key; Type: CONSTRAINT; Schema: public; Owner: arelyxl
--

ALTER TABLE ONLY public.s01phone_type
    ADD CONSTRAINT s01phone_type_cname_key UNIQUE (cname);


--
-- Name: s01phone_type s01phone_type_pkey; Type: CONSTRAINT; Schema: public; Owner: arelyxl
--

ALTER TABLE ONLY public.s01phone_type
    ADD CONSTRAINT s01phone_type_pkey PRIMARY KEY (nidphonetype);


--
-- Name: s01product s01product_nidcompany_ccode_key; Type: CONSTRAINT; Schema: public; Owner: arelyxl
--

ALTER TABLE ONLY public.s01product
    ADD CONSTRAINT s01product_nidcompany_ccode_key UNIQUE (nidcompany, ccode);


--
-- Name: s01product s01product_pkey; Type: CONSTRAINT; Schema: public; Owner: arelyxl
--

ALTER TABLE ONLY public.s01product
    ADD CONSTRAINT s01product_pkey PRIMARY KEY (nidproduct);


--
-- Name: s01role s01role_cname_key; Type: CONSTRAINT; Schema: public; Owner: arelyxl
--

ALTER TABLE ONLY public.s01role
    ADD CONSTRAINT s01role_cname_key UNIQUE (cname);


--
-- Name: s01role_permission s01role_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: arelyxl
--

ALTER TABLE ONLY public.s01role_permission
    ADD CONSTRAINT s01role_permission_pkey PRIMARY KEY (nidrole, nidpermission);


--
-- Name: s01role s01role_pkey; Type: CONSTRAINT; Schema: public; Owner: arelyxl
--

ALTER TABLE ONLY public.s01role
    ADD CONSTRAINT s01role_pkey PRIMARY KEY (nidrole);


--
-- Name: idx_phone_entity; Type: INDEX; Schema: public; Owner: arelyxl
--

CREATE INDEX idx_phone_entity ON public.s01phone USING btree (centitytype, nentityid);


--
-- Name: idx_phone_number; Type: INDEX; Schema: public; Owner: arelyxl
--

CREATE INDEX idx_phone_number ON public.s01phone USING btree (cphonenumber);


--
-- Name: idx_phone_primary; Type: INDEX; Schema: public; Owner: arelyxl
--

CREATE INDEX idx_phone_primary ON public.s01phone USING btree (centitytype, nentityid, bisprimary);


--
-- Name: idx_phone_type; Type: INDEX; Schema: public; Owner: arelyxl
--

CREATE INDEX idx_phone_type ON public.s01phone USING btree (nidphonetype);


--
-- Name: s01phone phone_format_before_insert_update; Type: TRIGGER; Schema: public; Owner: arelyxl
--

CREATE TRIGGER phone_format_before_insert_update BEFORE INSERT OR UPDATE ON public.s01phone FOR EACH ROW EXECUTE FUNCTION public.validate_and_format_phone();


--
-- Name: s01client s01client_nididentificationtype_fkey; Type: FK CONSTRAINT; Schema: public; Owner: arelyxl
--

ALTER TABLE ONLY public.s01client
    ADD CONSTRAINT s01client_nididentificationtype_fkey FOREIGN KEY (nididentificationtype) REFERENCES public.s01identification_type(nididentificationtype) ON DELETE RESTRICT;


--
-- Name: s01contract_detail s01contract_detail_nidcontract_fkey; Type: FK CONSTRAINT; Schema: public; Owner: arelyxl
--

ALTER TABLE ONLY public.s01contract_detail
    ADD CONSTRAINT s01contract_detail_nidcontract_fkey FOREIGN KEY (nidcontract) REFERENCES public.s01contract(nidcontract) ON DELETE CASCADE;


--
-- Name: s01contract_detail s01contract_detail_nidproduct_fkey; Type: FK CONSTRAINT; Schema: public; Owner: arelyxl
--

ALTER TABLE ONLY public.s01contract_detail
    ADD CONSTRAINT s01contract_detail_nidproduct_fkey FOREIGN KEY (nidproduct) REFERENCES public.s01product(nidproduct) ON DELETE RESTRICT;


--
-- Name: s01contract s01contract_nidclient_fkey; Type: FK CONSTRAINT; Schema: public; Owner: arelyxl
--

ALTER TABLE ONLY public.s01contract
    ADD CONSTRAINT s01contract_nidclient_fkey FOREIGN KEY (nidclient) REFERENCES public.s01client(nidclient) ON DELETE RESTRICT;


--
-- Name: s01contract s01contract_nidcompany_fkey; Type: FK CONSTRAINT; Schema: public; Owner: arelyxl
--

ALTER TABLE ONLY public.s01contract
    ADD CONSTRAINT s01contract_nidcompany_fkey FOREIGN KEY (nidcompany) REFERENCES public.s01company(nidcompany) ON DELETE RESTRICT;


--
-- Name: s01contract s01contract_niddocumenttype_fkey; Type: FK CONSTRAINT; Schema: public; Owner: arelyxl
--

ALTER TABLE ONLY public.s01contract
    ADD CONSTRAINT s01contract_niddocumenttype_fkey FOREIGN KEY (niddocumenttype) REFERENCES public.s01document_type(niddocumenttype) ON DELETE RESTRICT;


--
-- Name: s01contract s01contract_nidemployeecreatedby_fkey; Type: FK CONSTRAINT; Schema: public; Owner: arelyxl
--

ALTER TABLE ONLY public.s01contract
    ADD CONSTRAINT s01contract_nidemployeecreatedby_fkey FOREIGN KEY (nidemployeecreatedby) REFERENCES public.s01employee(nidemployee) ON DELETE SET NULL;


--
-- Name: s01credit_note s01credit_note_nidclient_fkey; Type: FK CONSTRAINT; Schema: public; Owner: arelyxl
--

ALTER TABLE ONLY public.s01credit_note
    ADD CONSTRAINT s01credit_note_nidclient_fkey FOREIGN KEY (nidclient) REFERENCES public.s01client(nidclient) ON DELETE RESTRICT;


--
-- Name: s01credit_note s01credit_note_nidcompany_fkey; Type: FK CONSTRAINT; Schema: public; Owner: arelyxl
--

ALTER TABLE ONLY public.s01credit_note
    ADD CONSTRAINT s01credit_note_nidcompany_fkey FOREIGN KEY (nidcompany) REFERENCES public.s01company(nidcompany) ON DELETE RESTRICT;


--
-- Name: s01credit_note s01credit_note_niddocumenttype_fkey; Type: FK CONSTRAINT; Schema: public; Owner: arelyxl
--

ALTER TABLE ONLY public.s01credit_note
    ADD CONSTRAINT s01credit_note_niddocumenttype_fkey FOREIGN KEY (niddocumenttype) REFERENCES public.s01document_type(niddocumenttype) ON DELETE RESTRICT;


--
-- Name: s01credit_note s01credit_note_nidemployeecreatedby_fkey; Type: FK CONSTRAINT; Schema: public; Owner: arelyxl
--

ALTER TABLE ONLY public.s01credit_note
    ADD CONSTRAINT s01credit_note_nidemployeecreatedby_fkey FOREIGN KEY (nidemployeecreatedby) REFERENCES public.s01employee(nidemployee) ON DELETE SET NULL;


--
-- Name: s01credit_note s01credit_note_nidoriginalcontract_fkey; Type: FK CONSTRAINT; Schema: public; Owner: arelyxl
--

ALTER TABLE ONLY public.s01credit_note
    ADD CONSTRAINT s01credit_note_nidoriginalcontract_fkey FOREIGN KEY (nidoriginalcontract) REFERENCES public.s01contract(nidcontract) ON DELETE RESTRICT;


--
-- Name: s01employee s01employee_nidcompany_fkey; Type: FK CONSTRAINT; Schema: public; Owner: arelyxl
--

ALTER TABLE ONLY public.s01employee
    ADD CONSTRAINT s01employee_nidcompany_fkey FOREIGN KEY (nidcompany) REFERENCES public.s01company(nidcompany) ON DELETE RESTRICT;


--
-- Name: s01employee s01employee_nididentificationtype_fkey; Type: FK CONSTRAINT; Schema: public; Owner: arelyxl
--

ALTER TABLE ONLY public.s01employee
    ADD CONSTRAINT s01employee_nididentificationtype_fkey FOREIGN KEY (nididentificationtype) REFERENCES public.s01identification_type(nididentificationtype) ON DELETE RESTRICT;


--
-- Name: s01employee s01employee_nidrole_fkey; Type: FK CONSTRAINT; Schema: public; Owner: arelyxl
--

ALTER TABLE ONLY public.s01employee
    ADD CONSTRAINT s01employee_nidrole_fkey FOREIGN KEY (nidrole) REFERENCES public.s01role(nidrole) ON DELETE RESTRICT;


--
-- Name: s01employee_role s01employee_role_nidemployee_fkey; Type: FK CONSTRAINT; Schema: public; Owner: arelyxl
--

ALTER TABLE ONLY public.s01employee_role
    ADD CONSTRAINT s01employee_role_nidemployee_fkey FOREIGN KEY (nidemployee) REFERENCES public.s01employee(nidemployee) ON DELETE CASCADE;


--
-- Name: s01employee_role s01employee_role_nidrole_fkey; Type: FK CONSTRAINT; Schema: public; Owner: arelyxl
--

ALTER TABLE ONLY public.s01employee_role
    ADD CONSTRAINT s01employee_role_nidrole_fkey FOREIGN KEY (nidrole) REFERENCES public.s01role(nidrole) ON DELETE CASCADE;


--
-- Name: s01payment s01payment_nidclient_fkey; Type: FK CONSTRAINT; Schema: public; Owner: arelyxl
--

ALTER TABLE ONLY public.s01payment
    ADD CONSTRAINT s01payment_nidclient_fkey FOREIGN KEY (nidclient) REFERENCES public.s01client(nidclient) ON DELETE RESTRICT;


--
-- Name: s01payment s01payment_nidcontract_fkey; Type: FK CONSTRAINT; Schema: public; Owner: arelyxl
--

ALTER TABLE ONLY public.s01payment
    ADD CONSTRAINT s01payment_nidcontract_fkey FOREIGN KEY (nidcontract) REFERENCES public.s01contract(nidcontract) ON DELETE RESTRICT;


--
-- Name: s01payment s01payment_nidemployeereceivedby_fkey; Type: FK CONSTRAINT; Schema: public; Owner: arelyxl
--

ALTER TABLE ONLY public.s01payment
    ADD CONSTRAINT s01payment_nidemployeereceivedby_fkey FOREIGN KEY (nidemployeereceivedby) REFERENCES public.s01employee(nidemployee) ON DELETE SET NULL;


--
-- Name: s01payment s01payment_nidpaymentmethod_fkey; Type: FK CONSTRAINT; Schema: public; Owner: arelyxl
--

ALTER TABLE ONLY public.s01payment
    ADD CONSTRAINT s01payment_nidpaymentmethod_fkey FOREIGN KEY (nidpaymentmethod) REFERENCES public.s01payment_method(nidpaymentmethod) ON DELETE RESTRICT;


--
-- Name: s01phone s01phone_nidphonetype_fkey; Type: FK CONSTRAINT; Schema: public; Owner: arelyxl
--

ALTER TABLE ONLY public.s01phone
    ADD CONSTRAINT s01phone_nidphonetype_fkey FOREIGN KEY (nidphonetype) REFERENCES public.s01phone_type(nidphonetype) ON DELETE RESTRICT;


--
-- Name: s01product s01product_nidcategory_fkey; Type: FK CONSTRAINT; Schema: public; Owner: arelyxl
--

ALTER TABLE ONLY public.s01product
    ADD CONSTRAINT s01product_nidcategory_fkey FOREIGN KEY (nidcategory) REFERENCES public.s01category(nidcategory) ON DELETE RESTRICT;


--
-- Name: s01product s01product_nidcompany_fkey; Type: FK CONSTRAINT; Schema: public; Owner: arelyxl
--

ALTER TABLE ONLY public.s01product
    ADD CONSTRAINT s01product_nidcompany_fkey FOREIGN KEY (nidcompany) REFERENCES public.s01company(nidcompany) ON DELETE RESTRICT;


--
-- Name: s01role_permission s01role_permission_nidpermission_fkey; Type: FK CONSTRAINT; Schema: public; Owner: arelyxl
--

ALTER TABLE ONLY public.s01role_permission
    ADD CONSTRAINT s01role_permission_nidpermission_fkey FOREIGN KEY (nidpermission) REFERENCES public.s01permission(nidpermission) ON DELETE CASCADE;


--
-- Name: s01role_permission s01role_permission_nidrole_fkey; Type: FK CONSTRAINT; Schema: public; Owner: arelyxl
--

ALTER TABLE ONLY public.s01role_permission
    ADD CONSTRAINT s01role_permission_nidrole_fkey FOREIGN KEY (nidrole) REFERENCES public.s01role(nidrole) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

\unrestrict g3IUAMOJR8JBUOuR54ruKNoHoIhDvdbMBoa6TGSoC5qNyc32EsmbixFXg15aUzb

