# Write your MySQL query statement below
with consecutive_nums as
(
    select
        *,
        lead(num, 1) over (order by id asc) as one_down,
        lead(num, 2) over (order by id asc) as two_down
    from logs
)
select num as ConsecutiveNums
from consecutive_nums
where
    one_down = num and 
    two_down = num
group by num
;