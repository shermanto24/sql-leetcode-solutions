# Write your MySQL query statement below
with salary_ranks as
(
    select
        salary,
        dense_rank() over (order by salary desc) as rnk
    from employee
    order by rnk asc
)
-- max handles edge cases - returns row even when rnk = 2 has nothing
select max(salary) as SecondHighestSalary 
from salary_ranks
where rnk = 2
;