# Write your MySQL query statement below
with consecutive_nums as
(
    select
        *,
        lead(num, 1) over (order by id asc) as one_after,
        lead(num, 2) over (order by id asc) as two_after
    from logs
)
select num as ConsecutiveNums
from consecutive_nums
where
    one_after = num and 
    two_after = num
group by num
;