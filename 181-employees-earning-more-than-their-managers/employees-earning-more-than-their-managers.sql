# Write your MySQL query statement below
with employee_manager_salaries as
(
    select
        e.name as employee,
        e.salary as employee_salary,
        m.salary as manager_salary
    from employee as e
        inner join employee as m
            on e.managerId = m.id
)
select employee
from employee_manager_salaries
where employee_salary > manager_salary
;