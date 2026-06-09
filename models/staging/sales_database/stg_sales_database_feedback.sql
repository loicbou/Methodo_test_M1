with source as (
    select * from {{ source('sales_database', 'feedback') }}
),

renamed as (
    select
        feedback_id,
        order_id,
        feedback_score,
        DATETIME(feedback_form_sent_date, 'Europe/Paris') as feedback_form_sent_date,
        DATETIME(feedback_answer_date, 'Europe/Paris') as feedback_answer_date
    from source
)

select * from renamed