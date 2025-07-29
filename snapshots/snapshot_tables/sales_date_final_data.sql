
{% snapshot sales_date_final_data %}
{{ config(
    target_database='MASTER_SALES',
    target_schema='MASTER_SCHEMA',
    strategy='check',
    unique_key='C_CUSTOMER_SK',
    check_cols=['C_CUSTOMER_SK', 'C_FIRST_NAME', 'C_LAST_NAME'],
    invalidate_hard_deletes=True
) }}

SELECT * FROM {{source('source_model','CHECK_TABLE')}}

{% endsnapshot %}