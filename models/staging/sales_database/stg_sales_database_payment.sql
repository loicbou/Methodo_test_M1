with source as (
    select * from {{ source('sales_database', 'payment') }}
),

renamed as (
    select
        order_id,
        payment_sequential,
        payment_type,
        payment_installments,
        payment_value,
        -- pas de clé primaire unique : clé composite
        CONCAT(order_id, '_', CAST(payment_sequential AS STRING)) as payment_id
    from source
)

select * from deduplicated