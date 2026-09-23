# Write your MySQL query statement below
with turns_ordered as
(
    select
        turn,
        person_name,
        weight,
        sum(weight) over (order by turn) as total_weight -- running sum
    from queue
    order by turn desc
)
select person_name
from turns_ordered
where turn = (select max(turn) from turns_ordered where total_weight <= 1000)
group by person_name
;