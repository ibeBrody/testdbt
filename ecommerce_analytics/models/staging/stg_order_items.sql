{{ config(materialized='view') }}

select
    order_item_id,
    order_id,
    product_id,
    quantity,
    cast(unit_price as decimal(10,2)) as unit_price,
    cast(discount_amount as decimal(10,2)) as discount_amount,
    cast(unit_price as decimal(10,2)) * quantity as line_total_before_discount,
    (cast(unit_price as decimal(10,2)) * quantity) - cast(discount_amount as decimal(10,2)) as line_total_after_discount,
    current_timestamp as loaded_at
from {{ ref('raw_order_items') }}