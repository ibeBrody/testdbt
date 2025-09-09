{{ config(materialized='table') }}

-- Financial performance mart with revenue and profitability analysis
with order_financials as (
    select 
        o.order_id,
        o.customer_id,
        o.order_date,
        o.order_status,
        o.payment_method,
        oi.product_id,
        p.product_name,
        p.category,
        oi.quantity,
        oi.unit_price,
        oi.total_price as revenue,
        p.cost * oi.quantity as total_cost,
        oi.total_price - (p.cost * oi.quantity) as profit
    from {{ ref('stg_orders') }} o
    join {{ ref('stg_order_items') }} oi on o.order_id = oi.order_id
    join {{ ref('stg_products') }} p on oi.product_id = p.product_id
    where o.order_status = 'delivered'  -- Only count delivered orders
)

select 
    order_id,
    customer_id,
    order_date,
    payment_method,
    sum(revenue) as total_revenue,
    sum(total_cost) as total_cost,
    sum(profit) as total_profit,
    round(sum(profit) / sum(revenue) * 100, 2) as profit_margin_pct,
    count(distinct product_id) as unique_products
from order_financials
group by 1, 2, 3, 4