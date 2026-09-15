# Write your MySQL query statement below
with report_counts as 
(
    select
        managerId,
        count(id) as num_reports
    from employee
    group by managerId
)
select e.name
from report_counts as r
    inner join employee as e
        on e.id = r.managerId
where num_reports >= 5
;