-- Test: feedback score should never be 0 (scale is 1-5)
select
    feedback_id,
    feedback_score
from {{ ref('stg_sales_database_feedback') }}
where feedback_score = 0