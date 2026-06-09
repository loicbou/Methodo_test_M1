with source as (
    select * from {{ source('google_analytic_4','event_flattened') }}
),

renamed as (
    select
        PARSE_DATE('%Y%m%d', CAST(event_date AS STRING)) as event_date,
        event_name,
        TIMESTAMP_MICROS(event_timestamp) as event_timestamp,
        user_pseudo_id,
        TIMESTAMP_MICROS(user_first_touch_timestamp) as user_first_touch_timestamp,
        device.web_info.browser as browser,
        traffic_source.medium as traffic_medium,
        traffic_source.source as traffic_source,
        traffic_source.name as traffic_name,
        (SELECT value.int_value FROM UNNEST(event_params)
            WHERE key = 'ga_session_id') AS ga_session_id,
        (SELECT value.string_value FROM UNNEST(event_params)
            WHERE key = 'page_title') AS page_title,
        (SELECT value.string_value FROM UNNEST(event_params)
            WHERE key = 'page_location') AS page_location
    from source
)

select * from renamed