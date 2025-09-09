-- Test that no orders exist before customer registration
select 
    o.order_id,
    o.customer_id,
    o.order_date,
    c.registration_date
from {{ ref('stg_orders') }} o
join {{ ref('stg_customers') }} c on o.customer_id = c.customer_id
where o.order_date < c.registration_date