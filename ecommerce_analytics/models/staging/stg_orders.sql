{{ config(materialized='view') }}

select
    order_id,
    customer_id,
    cast(order_date as date) as order_date,
    status,
    cast(total_amount as decimal(10,2)) as total_amount,
    cast(shipping_cost as decimal(10,2)) as shipping_cost,
    cast(discount_amount as decimal(10,2)) as discount_amount,
    payment_method,
    shipping_address,
    billing_address,
    current_timestamp as loaded_at
from {{ ref('raw_orders') }}