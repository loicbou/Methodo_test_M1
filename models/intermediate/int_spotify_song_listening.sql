select
    l.listen_date,
    l.minutes_listened,
    s.song_id,
    s.artist_name,
    s.title,
    s.album,
    s.release_year,
    s.genre
from {{ ref('stg_spotify__listening_data') }} l
left join {{ ref('stg_spotify_songs') }} s on l.song_id = s.song_id
where l.listen_date >= DATE_SUB(CURRENT_DATE(), INTERVAL 2 YEAR)