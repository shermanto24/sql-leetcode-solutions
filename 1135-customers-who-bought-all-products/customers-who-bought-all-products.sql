# Write your MySQL query statement below
with customer_purchases as
(
    select
        customer_id,
        count(distinct product_key) as num_products_bought
    from customer
    group by customer_id
)
select customer_id
from customer_purchases
where num_products_bought = (select count(*) from product)
;