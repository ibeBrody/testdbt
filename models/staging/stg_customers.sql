{{ config(materialized='view') }}

-- Staging model for customers data with basic cleaning
select 
    customer_id,
    first_name,
    last_name,
    first_name || ' ' || last_name as full_name,
    email,
    phone,
    address,
    city,
    state,
    zip_code,
    country,
    registration_date,
    is_active,
    case 
        when is_active then 'Active'
        else 'Inactive'
    end as customer_status
from {{ ref('customers') }}