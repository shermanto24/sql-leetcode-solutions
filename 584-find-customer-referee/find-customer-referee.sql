# Write your MySQL query statement below
select name
from customer
where !isnull(referee_id) and referee_id != 2 or isnull(referee_id)
;