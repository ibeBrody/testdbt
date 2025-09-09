{{ config(materialized='table') }}

-- Product performance mart with sales analytics
with product_sales as (
    select 
        p.product_id,
        p.product_name,
        p.category,
        p.price,
        p.cost,
        p.profit_margin,
        p.product_status,
        count(oi.order_item_id) as total_sales_count,
        sum(oi.quantity) as total_quantity_sold,
        sum(oi.total_price) as total_revenue,
        sum(p.cost * oi.quantity) as total_cost,
        sum(oi.total_price - (p.cost * oi.quantity)) as total_profit,
        avg(oi.quantity) as avg_quantity_per_order
    from {{ ref('stg_products') }} p
    left join {{ ref('stg_order_items') }} oi on p.product_id = oi.product_id
    left join {{ ref('stg_orders') }} o on oi.order_id = o.order_id
    where o.order_status = 'delivered' or o.order_status is null  -- Include products with no sales
    group by 1, 2, 3, 4, 5, 6, 7
)

select 
    *,
    case 
        when total_sales_count = 0 then 'No Sales'
        when total_sales_count between 1 and 2 then 'Low Sales'
        when total_sales_count between 3 and 5 then 'Medium Sales'
        when total_sales_count > 5 then 'High Sales'
    end as sales_performance,
    round(total_profit / nullif(total_revenue, 0) * 100, 2) as actual_profit_margin_pct
from product_sales