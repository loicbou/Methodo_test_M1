with source as (
    select * from {{ source('spotify', 'listening_data') }}
),

renamed as (
    select
        song_id,
        CAST(listen_date AS DATE)       as listen_date,
        COALESCE(minutes_listened, 0)   as minutes_listened
    from source
)

select * from renamed