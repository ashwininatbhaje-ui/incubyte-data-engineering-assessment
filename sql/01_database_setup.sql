-- ============================================================
-- SkyPoints Data Engineering Assessment
-- 01 - Database and Table Setup
-- ============================================================

-- Database
CREATE DATABASE IF NOT EXISTS SKYPOINTS_DB;

USE DATABASE SKYPOINTS_DB;

-- Schemas
CREATE SCHEMA IF NOT EXISTS RAW;
CREATE SCHEMA IF NOT EXISTS STAGING;
CREATE SCHEMA IF NOT EXISTS CORE;

USE SCHEMA RAW;


-- ============================================================
-- 1. RAW MEMBER FILE
-- Stores the source file as received.
-- We intentionally keep raw data close to the source format.
-- ============================================================

CREATE OR REPLACE TABLE RAW.MEMBER_PROFILE_RAW (
    LOAD_ID             VARCHAR(100),
    SOURCE_FILE_NAME    VARCHAR(500),
    LOAD_TIMESTAMP      TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP(),

    RECORD_TYPE         VARCHAR(1),
    MEMBER_NAME         VARCHAR(255),
    MEMBER_ID           VARCHAR(18),
    ENROLLMENT_DATE_RAW VARCHAR(8),
    LAST_FLIGHT_DATE_RAW VARCHAR(8),
    TIER_CODE            VARCHAR(5),
    AGENT_NAME           VARCHAR(255),
    STATE                VARCHAR(5),
    COUNTRY             VARCHAR(5),
    POST_CODE_RAW       VARCHAR(20),
    DOB_RAW             VARCHAR(8),
    IS_ACTIVE            VARCHAR(1),

    RAW_RECORD          VARCHAR
);


-- ============================================================
-- 2. STAGING MEMBER TABLE
-- Cleans and converts the raw data.
-- Additional derived columns:
--   AGE
--   STALE_MEMBER
-- ============================================================

CREATE OR REPLACE TABLE STAGING.MEMBER_PROFILE (
    MEMBER_NAME         VARCHAR(255),
    MEMBER_ID           VARCHAR(18),
    ENROLLMENT_DATE     DATE,
    LAST_FLIGHT_DATE    DATE,
    TIER_CODE           VARCHAR(5),
    AGENT_NAME          VARCHAR(255),
    STATE               VARCHAR(5),
    COUNTRY             VARCHAR(5),
    POST_CODE           INTEGER,
    DOB                 DATE,
    IS_ACTIVE            VARCHAR(1),

    AGE                 INTEGER,
    STALE_MEMBER        BOOLEAN,

    SOURCE_FILE_NAME    VARCHAR(500),
    LOAD_TIMESTAMP      TIMESTAMP_NTZ,
    RECORD_HASH         VARCHAR(64)
);


-- ============================================================
-- 3. COUNTRY-SPECIFIC TARGET TABLES
-- ============================================================

CREATE OR REPLACE TABLE CORE.TABLE_INDIA (
    MEMBER_NAME         VARCHAR(255),
    MEMBER_ID           VARCHAR(18),
    ENROLLMENT_DATE     DATE,
    LAST_FLIGHT_DATE    DATE,
    TIER_CODE           VARCHAR(5),
    AGENT_NAME          VARCHAR(255),
    STATE                VARCHAR(5),
    COUNTRY             VARCHAR(5),
    POST_CODE           INTEGER,
    DOB                 DATE,
    IS_ACTIVE            VARCHAR(1),
    AGE                 INTEGER,
    STALE_MEMBER        BOOLEAN,

    SOURCE_FILE_NAME    VARCHAR(500),
    LOAD_TIMESTAMP      TIMESTAMP_NTZ,
    RECORD_HASH         VARCHAR(64),

    UPDATED_TIMESTAMP   TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP()
);


CREATE OR REPLACE TABLE CORE.TABLE_USA (
    MEMBER_NAME         VARCHAR(255),
    MEMBER_ID           VARCHAR(18),
    ENROLLMENT_DATE     DATE,
    LAST_FLIGHT_DATE    DATE,
    TIER_CODE            VARCHAR(5),
    AGENT_NAME           VARCHAR(255),
    STATE                VARCHAR(5),
    COUNTRY             VARCHAR(5),
    POST_CODE           INTEGER,
    DOB                 DATE,
    IS_ACTIVE            VARCHAR(1),
    AGE                 INTEGER,
    STALE_MEMBER        BOOLEAN,

    SOURCE_FILE_NAME    VARCHAR(500),
    LOAD_TIMESTAMP      TIMESTAMP_NTZ,
    RECORD_HASH         VARCHAR(64),

    UPDATED_TIMESTAMP   TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP()
);


CREATE OR REPLACE TABLE CORE.TABLE_AUSTRALIA (
    MEMBER_NAME         VARCHAR(255),
    MEMBER_ID           VARCHAR(18),
    ENROLLMENT_DATE     DATE,
    LAST_FLIGHT_DATE    DATE,
    TIER_CODE            VARCHAR(5),
    AGENT_NAME           VARCHAR(255),
    STATE                VARCHAR(5),
    COUNTRY             VARCHAR(5),
    POST_CODE           INTEGER,
    DOB                 DATE,
    IS_ACTIVE            VARCHAR(1),
    AGE                 INTEGER,
    STALE_MEMBER        BOOLEAN,

    SOURCE_FILE_NAME    VARCHAR(500),
    LOAD_TIMESTAMP      TIMESTAMP_NTZ,
    RECORD_HASH         VARCHAR(64),

    UPDATED_TIMESTAMP   TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP()
);


-- ============================================================
-- 4. RAW JSON REDEMPTION FEED
-- ============================================================

CREATE OR REPLACE TABLE RAW.REDEMPTION_JSON_RAW (
    LOAD_ID             VARCHAR(100),
    SOURCE_FILE_NAME    VARCHAR(500),
    LOAD_TIMESTAMP      TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP(),

    MEMBER_ID           VARCHAR(18),
    FEED_DATE            VARCHAR(8),
    RAW_JSON             VARIANT
);


-- ============================================================
-- 5. FLATTENED REDEMPTION TRANSACTIONS
-- ============================================================

CREATE OR REPLACE TABLE CORE.REDEMPTION_TRANSACTION (
    MEMBER_ID            VARCHAR(18),
    FEED_DATE             DATE,
    TXN_ID                VARCHAR(100),
    TXN_DATE              DATE,
    PARTNER               VARCHAR(255),
    MILES_REDEEMED       NUMBER(18,0),
    STATUS                VARCHAR(50),

    SOURCE_FILE_NAME     VARCHAR(500),
    LOAD_TIMESTAMP       TIMESTAMP_NTZ
);