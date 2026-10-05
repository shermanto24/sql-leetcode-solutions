# Write your MySQL query statement below
with email_counts as
(
    select
        email,
        count(email) as cnt
    from person
    group by email
)
select email
from email_counts
where cnt >= 2
;