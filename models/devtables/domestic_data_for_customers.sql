{{ config(
    incremental_strategy='delete+insert',
    unique_key='C_CUSTOMER_SK'
) }}


WITH data_fetch AS (
    SELECT 
        C_CUSTOMER_SK,
        C_CURRENT_CDEMO_SK,
        C_CURRENT_HDEMO_SK,
        C_CURRENT_ADDR_SK,
        INITCAP(COALESCE(C_SALUTATION, '') || ' ' ||
                COALESCE(C_FIRST_NAME, '') || ' ' ||
                COALESCE(C_LAST_NAME, '')) AS FULL_NAME,
        COALESCE(C_BIRTH_DAY, 1) || '-' ||
        COALESCE(C_BIRTH_MONTH, 1) || '-' ||
        COALESCE(C_BIRTH_YEAR, 1) AS DATE_OF_BIRTH,
        COALESCE(C_BIRTH_COUNTRY, 'INDIA') AS C_BIRTH_COUNTRY,
        COALESCE(C_EMAIL_ADDRESS, 'No mail provided') AS C_EMAIL_ADDRESS
    FROM {{ source('source_model', 'CUSTOMER') }}
    LIMIT 100
),

matching_as AS (
    SELECT C_CUSTOMER_SK
    FROM data_fetch
    WHERE C_BIRTH_COUNTRY = 'INDIA'
)

SELECT 
    df.C_CUSTOMER_SK,
    df.C_CURRENT_CDEMO_SK,
    df.C_CURRENT_HDEMO_SK,
    df.C_CURRENT_ADDR_SK,
    df.FULL_NAME,
    df.DATE_OF_BIRTH,
    df.C_BIRTH_COUNTRY,
    df.C_EMAIL_ADDRESS,
    CASE 
        WHEN ma.C_CUSTOMER_SK IS NOT NULL THEN 'Y'
        ELSE 'N'
    END AS IS_DOMESTIC
FROM data_fetch df
LEFT JOIN matching_as ma
    ON df.C_CUSTOMER_SK = ma.C_CUSTOMER_SK
