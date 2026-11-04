# Write your MySQL query statement below
with first_half as
(
    select 
        driver_id,
        avg(distance_km / fuel_consumed) as first_half_avg
    from trips
    where month(trip_date) <= 6
    group by driver_id
),
second_half as
(
    select 
        driver_id,
        avg(distance_km / fuel_consumed) as second_half_avg
    from trips
    where month(trip_date) between 7 and 12
    group by driver_id
)
select 
    f.driver_id,
    driver_name,
    round(first_half_avg, 2) as first_half_avg,
    round(second_half_avg, 2) as second_half_avg,
    round(second_half_avg - first_half_avg, 2) as efficiency_improvement
from first_half as f
    inner join second_half as s
        on 
            f.driver_id = s.driver_id and 
            first_half_avg is not null and 
            second_half_avg is not null
    inner join drivers as d
        on f.driver_id = d.driver_id
having efficiency_improvement > 0
order by
    efficiency_improvement desc,
    driver_name asc
;