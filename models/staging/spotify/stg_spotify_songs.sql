with source as (
    select * from {{ source('spotify', 'songs') }}
),

renamed as (
    select
        song_id,
        UPPER(title)                as title,
        UPPER(artist)               as artist_name,
        album,
        release_year,
        COALESCE(genre, 'Unknown')  as genre
    from source
)

select * from renamed