{{ config(materialized='table') }}

WITH sample_table AS (
    SELECT 
        C_CUSTOMER_SK,
        INITCAP(C_FIRST_NAME) || ' ' || INITCAP(C_LAST_NAME) AS full_name,
        UPPER(C_FIRST_NAME) || ' ' || UPPER(C_LAST_NAME) AS upper_full_name,
        CASE 
            WHEN C_SALUTATION IN ('Mrs.', 'Dr.') THEN C_SALUTATION
            ELSE 'other'
        END AS salutation
    FROM {{ source('source_model', 'CUSTOMER') }}
    WHERE C_SALUTATION = 'Mrs.'
      AND C_BIRTH_DAY = 21
)
SELECT * FROM SAMPLE_TABLE 