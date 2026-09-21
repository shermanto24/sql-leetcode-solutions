# Write your MySQL query statement below
with num_appearances as
(
    select 
        num,
        count(num) as appearances
    from mynumbers
    group by num
)
select max(num) as num
from num_appearances
where appearances = 1
;