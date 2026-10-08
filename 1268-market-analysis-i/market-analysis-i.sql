# Write your MySQL query statement below
select
    user_id as buyer_id,
    join_date,
    count(order_id) as orders_in_2019
from users as u
    left join orders as o
        on u.user_id = o.buyer_id
        and order_date like '2019%'
group by user_id
order by user_id