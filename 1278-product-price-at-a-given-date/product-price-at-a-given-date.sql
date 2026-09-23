# Write your MySQL query statement below
select
    product_id,
    new_price as price -- uses price attached to filtered dates
from products
where (product_id, change_date) in -- filters to products before 8-16
(
    -- subquery needed to get the correct (product_id, date) pairs to connect to price
    select
        product_id,
        max(change_date)
    from products
    where change_date <= '2019-08-16'
    group by product_id
)

union

select
    product_id,
    10 as price
from products
group by product_id -- subquery not needed b/c price fixed
having min(change_date) > '2019-08-16' -- happens after group by
;

-- Previous solution
-- with prices_before as
-- (
--     select
--         product_id,
--         new_price as price,
--         rank() over (partition by product_id order by change_date desc) as date_rank
--     from products
--     where change_date <= '2019-08-16'
-- ),
-- prices_after as
-- (
--     select
--         product_id,
--         10 as price,
--         rank() over (partition by product_id order by change_date asc) as date_rank
--     from products
--     where change_date > '2019-08-16'
-- )
-- select * -- takes the first price
-- from
-- (
--     select
--         product_id,
--         price
--     from prices_before
--     where date_rank = 1
--     union
--     select
--         product_id,
--         price
--     from prices_after
--     where date_rank = 1
-- ) as all_products
-- group by product_id
-- ;