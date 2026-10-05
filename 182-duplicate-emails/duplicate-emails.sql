# Write your MySQL query statement below
select email
from person
group by email
having count(email) > 1
;

-- Previous solution
-- with email_counts as
-- (
--     select
--         email,
--         count(email) as cnt
--     from person
--     group by email
-- )
-- select email
-- from email_counts
-- where cnt >= 2
-- ;