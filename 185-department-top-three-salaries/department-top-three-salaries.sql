# Write your MySQL query statement below
with salary_ranks as
(
    select
        d.name as department,
        e.name as employee,
        salary,
        dense_rank() over (partition by departmentid order by salary desc) as rnk
    from employee as e
        inner join department as d
            on e.departmentid = d.id
    order by 
        departmentid asc,
        salary desc
)
select
    department,
    employee,
    salary
from salary_ranks
where rnk <= 3
;