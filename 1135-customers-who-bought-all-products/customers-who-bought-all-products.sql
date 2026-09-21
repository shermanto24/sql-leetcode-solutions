# Write your MySQL query statement below
-- with all_combos as
-- (
--     select distinct
--         c.customer_id,
--         p.product_key
--     from customer as c
--     cross join product as p
-- -- )
-- -- select
-- --     c.customer_id,
-- --     count(c.product_key) as num_products_purchased
-- -- from all_combos as a
-- --     inner join customer as c
-- --         on a.customer_id = c.customer_id
-- -- group by c.customer_id
-- -- ;

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