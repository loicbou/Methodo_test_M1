with source as (
    select * from {{ source('sales_database', 'seller') }}
),

renamed as (
    select
        seller_id,
        CAST(seller_zip_code AS STRING) as seller_zip_code,
        seller_city,
        seller_state
    from source
)

select * from renamed