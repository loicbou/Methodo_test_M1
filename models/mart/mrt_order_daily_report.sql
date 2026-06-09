with orders as (
    select * from {{ ref('int_sales_database__order') }}
),

mapping as (
    select * from {{ ref('stg_google_sheets__account_manager_region_mapping') }}
),

final as (
    select
        DATE(o.order_created_at)            as order_date,
        m.account_manager,
        o.user_state,
        o.order_status,
        COUNT(o.order_id)                   as total_orders,
        AVG(o.total_items)                  as avg_items_per_order,
        AVG(o.average_feedback_score)       as avg_feedback_score,
        AVG(o.total_order_amount)           as avg_order_amount
    from orders o
    left join mapping m on o.user_state = m.region
    group by
        DATE(o.order_created_at),
        m.account_manager,
        o.user_state,
        o.order_status
)

select * from final