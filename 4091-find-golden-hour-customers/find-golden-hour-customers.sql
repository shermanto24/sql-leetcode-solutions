# Write your MySQL query statement below
with peak_orders as
(
    select
        customer_id,
        count(order_id) as num_peak_orders
    from restaurant_orders
    where
        time(order_timestamp) between cast('11:00:00' as time) and cast('14:00:00' as time) or
        time(order_timestamp) between cast('18:00:00' as time) and cast('21:00:00' as time)
    group by customer_id
),
order_ratings as 
(
    select
        customer_id,
        count(order_id) as total_orders,
        sum(if(order_rating is not null, 1, 0)) as num_rated_orders,
        round(avg(order_rating), 2) as average_rating
    from restaurant_orders
    group by customer_id
)
select
    p.customer_id,
    total_orders,
    round(num_peak_orders / total_orders * 100, 0) as peak_hour_percentage,
    average_rating
from peak_orders as p
    inner join order_ratings as o
        on p.customer_id = o.customer_id
where num_rated_orders / total_orders >= 0.5
having
    total_orders >= 3 and
    peak_hour_percentage >= 60 and
    average_rating >= 4.0
order by
    average_rating desc,
    customer_id desc
;