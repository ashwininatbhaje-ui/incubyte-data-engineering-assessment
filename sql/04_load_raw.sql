-- ============================================================
-- 04_load_raw.sql
-- SkyPoints - Load CSV files into RAW table
-- ============================================================

USE DATABASE SKYPOINTS_DB;
USE SCHEMA RAW;


-- ============================================================
-- 1. Load Australia file
-- ============================================================

INSERT INTO MEMBER_PROFILE_RAW
(
    LOAD_ID,
    SOURCE_FILE_NAME,
    LOAD_TIMESTAMP,
    RECORD_TYPE,
    MEMBER_NAME,
    MEMBER_ID,
    ENROLLMENT_DATE_RAW,
    LAST_FLIGHT_DATE_RAW,
    TIER_CODE,
    AGENT_NAME,
    STATE,
    COUNTRY,
    POST_CODE_RAW,
    DOB_RAW,
    IS_ACTIVE,
    RAW_RECORD
)
SELECT
    UUID_STRING(),
    METADATA$FILENAME,
    CURRENT_TIMESTAMP(),
    'D',
    $2,
    $1,
    $5,
    $6,
    $3,
    NULL,
    NULL,
    'AUS',
    NULL,
    $4,
    NULL,
    CONCAT_WS('|',
        $1, $2, $3, $4, $5, $6
    )
FROM @MEMBER_FILE_STAGE
(FILE_FORMAT => FF_MEMBER_CSV)
WHERE METADATA$FILENAME = 'AUS(Sheet1).csv';


-- ============================================================
-- 2. Load India file
-- ============================================================

INSERT INTO MEMBER_PROFILE_RAW
(
    LOAD_ID,
    SOURCE_FILE_NAME,
    LOAD_TIMESTAMP,
    RECORD_TYPE,
    MEMBER_NAME,
    MEMBER_ID,
    ENROLLMENT_DATE_RAW,
    LAST_FLIGHT_DATE_RAW,
    TIER_CODE,
    AGENT_NAME,
    STATE,
    COUNTRY,
    POST_CODE_RAW,
    DOB_RAW,
    IS_ACTIVE,
    RAW_RECORD
)
SELECT
    UUID_STRING(),
    METADATA$FILENAME,
    CURRENT_TIMESTAMP(),
    'D',
    $2,
    $1,
    $5,
    $7,
    $4,
    NULL,
    NULL,
    'IND',
    NULL,
    $3,
    $6,
    CONCAT_WS('|',
        $1, $2, $3, $4, $5, $6, $7
    )
FROM @MEMBER_FILE_STAGE
(FILE_FORMAT => FF_MEMBER_CSV)
WHERE METADATA$FILENAME = 'IND(in).csv';


-- ============================================================
-- 3. Load USA file
-- ============================================================

INSERT INTO MEMBER_PROFILE_RAW
(
    LOAD_ID,
    SOURCE_FILE_NAME,
    LOAD_TIMESTAMP,
    RECORD_TYPE,
    MEMBER_NAME,
    MEMBER_ID,
    ENROLLMENT_DATE_RAW,
    LAST_FLIGHT_DATE_RAW,
    TIER_CODE,
    AGENT_NAME,
    STATE,
    COUNTRY,
    POST_CODE_RAW,
    DOB_RAW,
    IS_ACTIVE,
    RAW_RECORD
)
SELECT
    UUID_STRING(),
    METADATA$FILENAME,
    CURRENT_TIMESTAMP(),
    'D',
    $2,
    $1,
    $4,
    $5,
    $3,
    NULL,
    NULL,
    'USA',
    NULL,
    NULL,
    NULL,
    CONCAT_WS('|',
        $1, $2, $3, $4, $5
    )
FROM @MEMBER_FILE_STAGE
(FILE_FORMAT => FF_MEMBER_CSV)
WHERE METADATA$FILENAME = 'USA(in).csv';


-- ============================================================
-- 4. Verify loaded data
-- ============================================================

SELECT
    SOURCE_FILE_NAME,
    COUNT(*) AS RECORD_COUNT
FROM MEMBER_PROFILE_RAW
GROUP BY SOURCE_FILE_NAME
ORDER BY SOURCE_FILE_NAME;


-- ============================================================
-- 5. View all RAW records
-- ============================================================

SELECT *
FROM MEMBER_PROFILE_RAW
ORDER BY SOURCE_FILE_NAME, MEMBER_ID;