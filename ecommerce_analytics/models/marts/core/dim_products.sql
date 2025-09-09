{{ config(materialized='table') }}

with product_metrics as (
    select
        p.product_id,
        p.product_name,
        p.category,
        p.subcategory,
        p.brand,
        p.price,
        p.cost,
        p.profit_margin,
        p.sku,
        p.created_date,
        coalesce(sum(oi.quantity), 0) as total_quantity_sold,
        coalesce(count(distinct o.order_id), 0) as total_orders,
        coalesce(sum(oi.line_total_after_discount), 0) as total_revenue,
        coalesce(sum(oi.quantity * p.cost), 0) as total_cost,
        coalesce(sum(oi.line_total_after_discount) - sum(oi.quantity * p.cost), 0) as total_profit
    from {{ ref('stg_products') }} p
    left join {{ ref('stg_order_items') }} oi on p.product_id = oi.product_id
    left join {{ ref('stg_orders') }} o on oi.order_id = o.order_id and o.status = 'completed'
    group by 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
)

select
    *,
    case
        when total_quantity_sold = 0 then 'No Sales'
        when total_quantity_sold between 1 and 5 then 'Low Seller'
        when total_quantity_sold between 6 and 20 then 'Medium Seller'
        when total_quantity_sold > 20 then 'High Seller'
    end as sales_performance,
    case
        when total_revenue > 0 then round(total_profit / total_revenue * 100, 2)
        else 0
    end as profit_margin_percent
from product_metrics