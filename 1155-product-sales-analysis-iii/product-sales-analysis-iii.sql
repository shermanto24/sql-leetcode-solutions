# Write your MySQL query statement below
with product_first_years as
(
    select
        product_id,
        min(year) as first_year
    from sales
    group by product_id
)
select
    s.product_id,
    first_year,
    quantity,
    price
from sales as s
    inner join product_first_years as p
        on s.product_id = p.product_id
where year = first_year
;