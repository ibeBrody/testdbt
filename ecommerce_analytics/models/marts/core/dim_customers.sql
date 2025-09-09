{{ config(materialized='table') }}

with customer_orders as (
    select
        c.customer_id,
        c.first_name,
        c.last_name,
        c.email,
        c.city,
        c.state,
        c.country,
        c.registration_date,
        count(o.order_id) as total_orders,
        sum(case when o.status = 'completed' then 1 else 0 end) as completed_orders,
        sum(case when o.status = 'cancelled' then 1 else 0 end) as cancelled_orders,
        sum(case when o.status = 'completed' then o.total_amount else 0 end) as total_revenue,
        avg(case when o.status = 'completed' then o.total_amount else null end) as avg_order_value,
        min(o.order_date) as first_order_date,
        max(o.order_date) as last_order_date
    from {{ ref('stg_customers') }} c
    left join {{ ref('stg_orders') }} o on c.customer_id = o.customer_id
    group by 1, 2, 3, 4, 5, 6, 7, 8
)

select
    *,
    case 
        when total_orders = 0 then 'No Orders'
        when total_orders = 1 then 'One-time Customer'
        when total_orders between 2 and 5 then 'Regular Customer'
        when total_orders > 5 then 'VIP Customer'
    end as customer_segment,
    case
        when last_order_date >= current_date - interval '30 days' then 'Active'
        when last_order_date >= current_date - interval '90 days' then 'At Risk'
        when last_order_date is not null then 'Inactive'
        else 'Never Purchased'
    end as customer_status
from customer_orders