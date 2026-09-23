# Write your MySQL query statement below

-- Prices set before or on 8-16
with prices_before as
(
    select
        product_id,
        new_price as price,
        rank() over (partition by product_id order by change_date desc) as date_rank
    from products
    where change_date <= '2019-08-16'
),-- what if a product has change_date before and after 8-16
prices_after as
(
    select
        product_id,
        10 as price,
        change_date, -- remove after testing
        rank() over (partition by product_id order by change_date asc) as date_rank
    from products
    where change_date > '2019-08-16'
)
select *
from
(
    select
        product_id,
        price
    from prices_before
    where date_rank = 1
    union
    select
        product_id,
        price
    from prices_after
    where date_rank = 1
) as all_products
group by product_id
;