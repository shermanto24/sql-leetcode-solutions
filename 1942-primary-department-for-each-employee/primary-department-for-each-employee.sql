# Write your MySQL query statement below
select
    e.employee_id,
    department_id
from employee as e
    inner join
    (
        select
            employee_id,
            count(department_id) as num_depts
        from employee
        group by employee_id

    ) as d
        on e.employee_id = d.employee_id
where primary_flag = 'Y' or num_depts = 1
group by employee_id
;