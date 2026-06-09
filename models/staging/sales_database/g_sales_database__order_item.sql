with source as (
    select * from {{ source('sales_database', 'order_item') }}
),

renamed as (
    select
        order_id,
        product_id,
        seller_id,
        pickup_limit_date,
        price,
        shipping_cost,
        quantity,
        -- clé primaire composite
        CONCAT(order_id, '_', product_id) as order_item_id
    from source
)


select * from renamed