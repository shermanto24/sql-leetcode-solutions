# Write your MySQL query statement below
with children as 
(
    select
        p_id as id,
        count(id) as num_children
    from tree
    group by p_id
)
select
    t.id,
    case
        when p_id is null then 'Root'
        when num_children > 0 then 'Inner'
        else 'Leaf'
    end as type
from tree as t
    left join children as c
        on t.id = c.id
;