# Write your MySQL query statement below
with salaries_ranked as
(
    select
        departmentId,
        name,
        salary,
        rank() over (partition by departmentId order by salary desc) as rnk
    from employee
)
select 
    d.name as department,
    s.name as employee,
    salary
from salaries_ranked as s
    inner join department as d
        on s.departmentId = d.id
where rnk = 1
;