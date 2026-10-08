# Write your MySQL query statement below
select
    user_id as buyer_id,
    join_date,
    coalesce(num_orders, 0) as orders_in_2019
from users as u
    left join
    (
        select
            buyer_id,
            count(order_id) as num_orders
        from orders
        where order_date like '2019%'
        group by buyer_id
    ) as o
        on u.user_id = o.buyer_id
group by user_id
order by user_id