{% docs int_sales_database__order %}

## int_sales_database__order

This model enriches raw order data by joining it with user, feedback, and order item information.

### Sources
- `stg_sales_database__order` — base order data
- `stg_sales_database__user` — adds city and state dimensions
- `stg_sales_database__feedback` — adds average feedback score per order
- `stg_sales_database__order_item` — adds total amount, item count, distinct item count

### Transformations
- Average feedback score aggregated per order
- Total order amount computed as SUM(price + shipping_cost)
- Total items and distinct items counted per order

{% enddocs %}