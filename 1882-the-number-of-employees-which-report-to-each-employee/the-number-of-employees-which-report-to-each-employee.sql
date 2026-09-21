# Write your MySQL query statement below
with managers as
(
    select
        reports_to as manager_id,
        count(reports_to) as reports_count,
        round(avg(age)) as average_age
    from employees
    group by manager_id
)
select
    employee_id,
    name,
    reports_count,
    average_age
from managers as m
    inner join employees as e
        on m.manager_id = e.employee_id
order by employee_id asc
;