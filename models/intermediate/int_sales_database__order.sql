with orders as (
    select * from {{ ref('stg_sales_database__order') }}
),

order_items as (
    select
        order_id,
        SUM(price + shipping_cost)  as total_order_amount,
        COUNT(*)                    as total_items,
        COUNT(DISTINCT product_id)  as total_distinct_items
    from {{ ref('g_sales_database__order_item') }}
    group by order_id
),

feedbacks as (
    select
        order_id,
        AVG(feedback_score) as average_feedback_score
    from {{ ref('stg_sales_database_feedback') }}
    group by order_id
),

users as (
    select * from {{ ref('stg_sales_database_user') }}
),

final as (
    select
        o.order_id,
        o.user_name                         as user_id,
        o.order_status,
        o.order_date                        as order_created_at,
        o.order_approved_date               as order_approved_at,
        u.customer_city                     as user_city,
        u.customer_state                    as user_state,
        f.average_feedback_score,
        oi.total_order_amount,
        oi.total_items,
        oi.total_distinct_items
    from orders o
    left join users u       on o.user_name = u.user_name
    left join feedbacks f   on o.order_id = f.order_id
    left join order_items oi on o.order_id = oi.order_id
)

select * from final