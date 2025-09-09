{{ config(materialized='view') }}

-- Staging model for orders data with enhanced status tracking
select 
    order_id,
    customer_id,
    order_date,
    order_status,
    total_amount,
    shipping_address,
    shipping_city,
    shipping_state,
    shipping_zip,
    payment_method,
    case 
        when order_status = 'delivered' then 'Complete'
        when order_status = 'shipped' then 'In Transit'
        when order_status = 'processing' then 'Being Processed'
        when order_status = 'cancelled' then 'Cancelled'
        else 'Unknown'
    end as order_status_description
from {{ ref('orders') }}