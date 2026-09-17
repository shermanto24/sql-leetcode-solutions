# Write your MySQL query statement below
-- select 
--     product_id,
--     round(sum(total_price) / sum(units), 2) as average_price
-- from
-- (
--     select
--         u.*,
--         units * p.price as total_price
--     from unitsSold as u
--         right join prices as p
--             on -- these two conditions don't work anymore
--                 u.product_id = p.product_id and 
--                 purchase_date between start_date and end_date
-- ) as merged_table
-- group by product_id
-- ;
-- 15/18 passed, what if unitssold is empty?
-- for one or all products

select 
    product_id,
    round(coalesce(sum(total_price) / sum(units), 0), 2) as average_price
from
(
    select
        coalesce(u.product_id, p.product_id) as product_id,
        coalesce(purchase_date) as purchase_date,
        coalesce(units, 0) as units,
        coalesce(units, 0) * p.price as total_price
    from prices as p
        left join unitsSold as u
            on
                coalesce(u.product_id, p.product_id) = p.product_id and 
                purchase_date between start_date and end_date
) as merged_table
group by product_id
;
