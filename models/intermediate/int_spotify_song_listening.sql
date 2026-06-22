with listening as (
    select * from {{ ref('stg_spotify__listening_data') }}
),

songs as (
    select * from {{ ref('stg_spotify_songs') }}
),

final as (
    select
        l.user_id,
        l.listen_date,
        l.minutes_listened,
        s.song_id,
        s.artist_name,
        s.title,
        s.genre
    from listening l
    left join songs s on l.song_id = s.song_id
    where l.listen_date >= DATE_SUB(CURRENT_DATE(), INTERVAL 2 YEAR)
)

select * from final