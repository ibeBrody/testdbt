{{ config(materialized='table') }}

with order_details as (
    select
        o.order_id,
        o.customer_id,
        o.order_date,
        o.status,
        o.total_amount,
        o.shipping_cost,
        o.discount_amount,
        o.payment_method,
        sum(oi.quantity) as total_items,
        sum(oi.line_total_after_discount) as calculated_total,
        count(distinct oi.product_id) as unique_products
    from {{ ref('stg_orders') }} o
    left join {{ ref('stg_order_items') }} oi on o.order_id = oi.order_id
    group by 1, 2, 3, 4, 5, 6, 7, 8
),

customer_order_sequence as (
    select
        order_id,
        customer_id,
        order_date,
        status,
        row_number() over (partition by customer_id order by order_date) as customer_order_number
    from {{ ref('stg_orders') }}
)

select
    od.*,
    cos.customer_order_number,
    case
        when cos.customer_order_number = 1 then 'First Order'
        when od.status = 'cancelled' then 'Cancelled Order'
        else 'Repeat Order'
    end as order_type,
    extract(year from od.order_date) as order_year,
    extract(month from od.order_date) as order_month,
    extract(dow from od.order_date) as order_day_of_week,
    case
        when extract(dow from od.order_date) in (0, 6) then 'Weekend'
        else 'Weekday'
    end as order_day_type
from order_details od
left join customer_order_sequence cos on od.order_id = cos.order_id