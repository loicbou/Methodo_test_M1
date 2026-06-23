with users as (
    select * from {{ ref('stg_sales_database_user') }}
),

orders as (
    select * from {{ ref('int_sales_database__order') }}
),

final as (
    select
        u.user_name                     as user_id,
        u.customer_city,
        SUM(o.total_order_amount)       as total_amount_order,
        COUNT(o.order_id)               as total_order
    from users u
    left join orders o on u.user_name = o.user_id
    group by u.user_name, u.customer_city
)

select * from final