# Write your MySQL query statement below
with all_students_subjects as 
(
    select *
    from students
        cross join subjects
)
select
    a.student_id,
    a.student_name,
    a.subject_name,
    (
        select count(student_id)
        from examinations as e
        where
            a.student_id = e.student_id and
            a.subject_name = e.subject_name
    ) as attended_exams
from all_students_subjects as a
order by
    a.student_id,
    a.subject_name
;
    