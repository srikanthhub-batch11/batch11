{{ config(
    materialized='table'
) }}
select * from {{source('source_model','CUSTOMER')}}