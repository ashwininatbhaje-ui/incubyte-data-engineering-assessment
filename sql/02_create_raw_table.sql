-- ============================================================
-- 02_create_raw_table.sql
-- SkyPoints - RAW member profile table
-- ============================================================

USE DATABASE SKYPOINTS_DB;
USE SCHEMA RAW;

CREATE OR REPLACE TABLE MEMBER_PROFILE_RAW
(
    LOAD_ID                  VARCHAR,
    SOURCE_FILE_NAME         VARCHAR,
    LOAD_TIMESTAMP           TIMESTAMP_NTZ,

    RECORD_TYPE              VARCHAR(1),

    MEMBER_NAME              VARCHAR(255),
    MEMBER_ID                VARCHAR(18),

    ENROLLMENT_DATE_RAW      VARCHAR(20),
    LAST_FLIGHT_DATE_RAW     VARCHAR(20),

    TIER_CODE                VARCHAR(5),
    AGENT_NAME               VARCHAR(255),
    STATE                    VARCHAR(100),
    COUNTRY                  VARCHAR(100),

    POST_CODE_RAW            VARCHAR(50),
    DOB_RAW                  VARCHAR(20),

    IS_ACTIVE                VARCHAR(10),

    RAW_RECORD               VARCHAR(5000)
);

-- Verify the table
DESC TABLE MEMBER_PROFILE_RAW;