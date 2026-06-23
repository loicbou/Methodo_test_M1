-- Test: no order item should have a negative total amount
select
    order_item_id,
    price + shipping_cost as total_amount
from {{ ref('g_sales_database__order_item') }}
where price + shipping_cost < 0