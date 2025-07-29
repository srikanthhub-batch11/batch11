{% snapshot order_data_table %}
{{
  config(
    target_database='SNAP_DB',
    target_schema='SNAP_SCHEMA',
    unique_key='O_ORDERKEY',
    strategy='timestamp',
    updated_at='UPDATE_DT',
    invalidate_hard_deletes=True
  )
}}

SELECT * FROM {{ source('source_model', 'ORDER_TABLE') }}

{% endsnapshot %}


