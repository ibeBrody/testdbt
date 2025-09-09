{{ config(materialized='view') }}

-- Staging model for order items data with basic calculations
select 
    order_item_id,
    order_id,
    product_id,
    quantity,
    unit_price,
    total_price,
    -- Validate that total_price equals quantity * unit_price
    case 
        when abs(total_price - (quantity * unit_price)) < 0.01 then true
        else false
    end as price_calculation_valid
from {{ ref('order_items') }}