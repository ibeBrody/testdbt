{{ config(materialized='view') }}

select
    product_id,
    product_name,
    category,
    subcategory,
    brand,
    cast(price as decimal(10,2)) as price,
    cast(cost as decimal(10,2)) as cost,
    cast(price as decimal(10,2)) - cast(cost as decimal(10,2)) as profit_margin,
    description,
    sku,
    cast(created_date as date) as created_date,
    current_timestamp as loaded_at
from {{ ref('raw_products') }}