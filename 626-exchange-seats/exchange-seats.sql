# Write your MySQL query statement below
# if odd looking 1 forward, if even looking 1 back
# if id number same as length, no swap

select
    id,
    case
        when id = ( select max(id) from seat ) and id % 2 = 1 then student
        when id % 2 = 1 then lead(student, 1) over (order by id)
        else lag(student, 1) over (order by id)
    end as student
from seat
;