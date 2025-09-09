{{ config(materialized='table') }}

select
    date_trunc('month', order_date) as month_year,
    count(distinct order_id) as total_orders,
    count(distinct case when status = 'completed' then order_id end) as completed_orders,
    count(distinct case when status = 'cancelled' then order_id end) as cancelled_orders,
    sum(case when status = 'completed' then total_amount else 0 end) as total_revenue,
    avg(case when status = 'completed' then total_amount else null end) as avg_order_value,
    count(distinct customer_id) as unique_customers,
    sum(case when status = 'completed' then discount_amount else 0 end) as total_discounts,
    sum(case when status = 'completed' then shipping_cost else 0 end) as total_shipping_revenue
from {{ ref('stg_orders') }}
group by 1
order by 1