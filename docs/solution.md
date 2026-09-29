# SkyPoints Data Engineering Assessment

## 1. Architecture

Source files are loaded into the Snowflake RAW layer.
RAW data is transformed into STAGING.
STAGING derives Age and Stale_Member.
Latest member records are selected using MEMBER_ID.
Country-specific target tables are created from the latest records.

JSON redemption data is stored as VARIANT and flattened using
LATERAL FLATTEN.

Flow:

Source -> RAW -> STAGING -> LATEST MEMBERS -> COUNTRY TARGETS
                         \
                          -> REDEMPTION FLAT

## 2. Age

Age is derived from DOB using the current date.

## 3. Stale Member

A member is marked stale when:

DATEDIFF(DAY, LAST_FLIGHT_DATE, CURRENT_DATE()) > 90

## 4. Latest Record Wins

ROW_NUMBER is used:

PARTITION BY MEMBER_ID
ORDER BY LAST_FLIGHT_DATE DESC NULLS LAST

The record with ROW_NUMBER = 1 is retained.

This ensures that when a member moves to another country,
the latest member record is used.

## 5. Country Targets

Latest member records are separated into country-specific
target tables such as Australia, India and USA.

## 6. JSON Redemption

The JSON structure contains:

member_id
feed_date
redemptions[]

The redemptions array is flattened using:

LATERAL FLATTEN(INPUT => JSON_DATA:redemptions)

The flattened table contains:

MEMBER_ID
FEED_DATE
TXN_ID
TXN_DATE
PARTNER
MILES_REDEEMED
STATUS

## 7. Member / Redemption Join

Redemption data is joined to member data using:

MEMBER_ID

Example:

SELECT *
FROM TARGET.LATEST_MEMBERS M
LEFT JOIN REDEMPTION.REDEMPTION_FLAT R
ON M.MEMBER_ID = R.MEMBER_ID;

The supplied sample data contains different member IDs
between the profile feed and redemption JSON, so the sample
join returns NULL member details. This is a data-quality
mismatch, not a join failure.

## 8. Validations

The solution validates:

- Mandatory member fields
- Duplicate MEMBER_ID
- Record counts
- Latest-member record counts
- Redemption records
- Data-quality mismatches

## 9. Production Approach

For production, files can arrive through cloud storage.
Snowflake COPY INTO can load RAW tables.

Incremental processing can use:

- ingestion timestamp
- file name
- load ID
- MERGE
- ROW_NUMBER for latest records

RAW preserves source data, while STAGING and TARGET contain
business transformations.