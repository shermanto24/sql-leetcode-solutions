# Write your MySQL query statement below
with customer_first_orders as
(
    select
            customer_id,
            min(order_date) as first_order_date,
            if(min(order_date) = min(customer_pref_delivery_date), 1, 0) as is_immediate
    from delivery
    group by customer_id
)
select
    round(sum(is_immediate) / count(customer_id) * 100, 2) as immediate_percentage
from customer_first_orders
;