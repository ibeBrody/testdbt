{{ config(materialized='view') }}

-- Staging model for products data with profit margin calculation
select 
    product_id,
    product_name,
    category,
    price,
    cost,
    price - cost as profit_margin,
    round((price - cost) / price * 100, 2) as profit_margin_pct,
    supplier_id,
    description,
    is_active,
    case 
        when is_active then 'Available'
        else 'Discontinued'
    end as product_status
from {{ ref('products') }}