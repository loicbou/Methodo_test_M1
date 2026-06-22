with source as (
    select * from {{ source('spotify', 'songs') }}
),

renamed as (
    select
        song_id,
        UPPER(artist_name)          as artist_name,
        UPPER(title)                as title,
        COALESCE(genre, 'Unknown')  as genre
    from source
)

select * from renamed