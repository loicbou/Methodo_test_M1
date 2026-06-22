{{ config(materialized='table') }}

with song_listening as (
    select * from {{ ref('int_spotify_song_listening') }}
),

final as (
    select
        artist_name,
        SUM(minutes_listened)   as total_minutes_listened,
        COUNT(*)                as total_listens
    from song_listening
    group by artist_name
    order by total_minutes_listened DESC
    limit 20
)

select * from final