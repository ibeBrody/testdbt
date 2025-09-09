{{ config(materialized='table') }}

-- Customer analytics mart with lifetime value and order statistics
with customer_orders as (
    select 
        c.customer_id,
        c.full_name,
        c.email,
        c.customer_status,
        c.registration_date,
        count(o.order_id) as total_orders,
        sum(case when o.order_status = 'delivered' then o.total_amount else 0 end) as total_spent,
        avg(case when o.order_status = 'delivered' then o.total_amount else null end) as avg_order_value,
        min(o.order_date) as first_order_date,
        max(o.order_date) as last_order_date
    from {{ ref('stg_customers') }} c
    left join {{ ref('stg_orders') }} o on c.customer_id = o.customer_id
    group by 1, 2, 3, 4, 5
)

select 
    *,
    case 
        when total_orders = 0 then 'No Orders'
        when total_orders = 1 then 'Single Purchase'
        when total_orders between 2 and 5 then 'Regular Customer'
        when total_orders > 5 then 'Loyal Customer'
    end as customer_segment,
    case 
        when total_spent >= 500 then 'High Value'
        when total_spent >= 200 then 'Medium Value'
        when total_spent > 0 then 'Low Value'
        else 'No Value'
    end as value_segment
from customer_orders