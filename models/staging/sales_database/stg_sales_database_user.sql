with source as (
    select * from {{ source('sales_database', 'user') }}
),

renamed as (
    select
        user_name,
        CAST(customer_zip_code AS STRING) as customer_zip_code,
        customer_city,
        customer_state
    from source
)

select * from renamed