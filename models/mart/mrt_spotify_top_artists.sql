{{ config(materialized='table') }}

select
    artist_name,
    SUM(minutes_listened)   as total_minutes_listened,
    COUNT(*)                as total_listens
from {{ ref('int_spotify_song_listening') }}
group by artist_name
order by total_minutes_listened DESC
limit 20