{{ config(materialized='view') }}

select
    customer_id,
    first_name,
    last_name,
    email,
    phone,
    address,
    city,
    state,
    zip_code,
    country,
    cast(registration_date as date) as registration_date,
    current_timestamp as loaded_at
from {{ ref('raw_customers') }}