{% docs mrt_order_daily_report %}

## mrt_order_daily_report

Final mart model for Account Managers to monitor daily regional performance.

### Sources
- `int_sales_database__order` — enriched order data
- `stg_google_sheets__account_manager_region_mapping` — maps user states to account managers

### Metrics (aggregated by day)
- `total_orders` — number of orders placed
- `avg_items_per_order` — average number of items per order
- `avg_feedback_score` — average customer satisfaction score
- `avg_order_amount` — average spend per order

### Dimensions
- `order_date` — day of the order
- `account_manager` — responsible account manager
- `user_state` — geographical state of the customer

{% enddocs %}