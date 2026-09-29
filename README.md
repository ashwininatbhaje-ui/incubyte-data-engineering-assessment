# SkyPoints Data Engineering Assessment

This project implements a Snowflake-based data engineering solution for the SkyPoints airline loyalty program.

## Project Flow

Flat Member Files
→ RAW / Landing
→ STAGING
→ Latest Member Record
→ Country Target Tables

JSON Redemption Feed
→ JSON RAW
→ Flattened Redemption Table
→ Member Join

## Technologies

- Snowflake
- SQL
- Semi-structured JSON
- CSV files

## Project Structure

```text
incubyte-data-engineering-assessment/
├── README.md
├── docs/
│   └── solution.md
├── python/
├── sample_data/
├── sql/
│   ├── 00_test_connection.sql
│   ├── 01_database_setup.sql
│   ├── 02_create_raw_table.sql
│   ├── 03_create_stage.sql
│   ├── 04_load_raw.sql
│   ├── 05_create_staging.sql
│   ├── 06_country_targets.sql
│   ├── 07_redemption.sql
│   ├── 08_validation.sql
│   └── 09_member_redemption_join.sql
└── tests/