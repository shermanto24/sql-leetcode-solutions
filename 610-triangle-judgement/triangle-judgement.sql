-- # Write your MySQL query statement below
with sides_and_index as 
(
    select
        *,
        case
            when x > y and x > z then 1
            when y > x and y > z then 2
            else 3
        end as longest_idx
    from triangle
)
select
    x, y, z,
    if(
        x <= 0 or y <= 0 or z <= 0,
        'No',
        case longest_idx
            when 1 then if(y + z > x, 'Yes', 'No')
            when 2 then if(x + z > y, 'Yes', 'No')
            else if(x + y > z, 'Yes', 'No')
        end
    ) as triangle
from sides_and_index
;