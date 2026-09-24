# Write your MySQL query statement below
with feb_products as
(
    select
        product_id,
        sum(unit) as unit
    from orders
    where order_date like '2020-02%'
    group by product_id
)
select 
    product_name,
    unit
from products as p
    inner join feb_products as f
        on p.product_id = f.product_id
where unit >= 100
;
