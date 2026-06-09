with source as (
    select * from {{ source('sales_database', 'order') }}
),

renamed as (
    select
        order_id,
        user_name,
        order_status,
        DATETIME(order_date, 'Europe/Paris') as order_date,
        DATETIME(order_approved_date, 'Europe/Paris') as order_approved_date,
        DATETIME(pickup_date, 'Europe/Paris') as pickup_date,
        DATETIME(delivered_date, 'Europe/Paris') as delivered_date,
        DATETIME(estimated_time_delivery, 'Europe/Paris') as estimated_time_delivery
    from source
)

select * from renamed