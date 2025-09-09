-- Test that order total matches sum of line items
select 
    o.order_id,
    o.total_amount as order_total,
    sum(oi.line_total_after_discount) as calculated_total,
    abs(o.total_amount - sum(oi.line_total_after_discount)) as difference
from {{ ref('stg_orders') }} o
left join {{ ref('stg_order_items') }} oi on o.order_id = oi.order_id
where o.status != 'cancelled'
group by o.order_id, o.total_amount
having abs(o.total_amount - sum(oi.line_total_after_discount)) > 0.01