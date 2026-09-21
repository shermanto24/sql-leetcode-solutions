# Write your MySQL query statement below
select class
from
(
    select
        class,
        count(distinct student) as num_students
    from courses
    group by class
) as num_students_by_class
where num_students >= 5
;