{{
    config(
        materialized='table',
        transient=false
    )
}}

WITH MERGE_DATA AS (
    SELECT 
        P_NAME || '-' || P_MFGR AS part_label
    FROM {{ source('source_model', 'PART_INFO') }}
)

SELECT * FROM MERGE_DATA
