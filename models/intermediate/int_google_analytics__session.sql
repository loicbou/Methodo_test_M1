with events as (
    select * from {{ ref('stg_google_analytics__event') }}
),

final as (
    select
        CONCAT(user_pseudo_id, '_', CAST(ga_session_id AS STRING))  as unique_session_id,
        user_pseudo_id,
        MIN(event_timestamp)                                         as session_start_time,
        MAX(event_timestamp)                                         as session_end_time,
        TIMESTAMP_DIFF(
            MAX(event_timestamp),
            MIN(event_timestamp),
            SECOND
        )                                                            as session_duration_seconds,
        MAX(browser)                                                 as browser_used,
        MAX(traffic_medium)                                          as traffic_medium,
        MAX(traffic_source)                                          as traffic_source,
        MAX(traffic_name)                                            as traffic_name,
        COUNT(*)                                                     as event_count,
        COUNT(DISTINCT page_location)                                as pages_viewed
    from events
    group by user_pseudo_id, ga_session_id
)

select * from final