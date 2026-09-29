-- ============================================================
-- 03_create_stage.sql
-- SkyPoints - CSV File Format and Stage
-- ============================================================

USE DATABASE SKYPOINTS_DB;
USE SCHEMA RAW;

-- Create CSV file format
CREATE OR REPLACE FILE FORMAT FF_MEMBER_CSV
    TYPE = CSV
    FIELD_DELIMITER = ','
    SKIP_HEADER = 1
    FIELD_OPTIONALLY_ENCLOSED_BY = '"'
    EMPTY_FIELD_AS_NULL = TRUE
    TRIM_SPACE = TRUE;

-- Create internal Snowflake stage
CREATE OR REPLACE STAGE MEMBER_FILE_STAGE
    FILE_FORMAT = FF_MEMBER_CSV;

-- Check the file format
SHOW FILE FORMATS;

-- Check the stage
SHOW STAGES;