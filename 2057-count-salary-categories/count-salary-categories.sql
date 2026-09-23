# Write your MySQL query statement below
with accounts_categorized as
(
    select
        account_id,
        case
            when income < 20000 then 'Low Salary'
            when income <= 50000 then 'Average Salary'
            else 'High Salary'
        end as category
    from accounts
)
select 
    c.category,
    count(account_id) as accounts_count
from accounts_categorized as a
    right join
    (
        select 'Low Salary' as category union
        select 'Average Salary' union
        select 'High Salary'
    ) as c
        on c.category = a.category
group by c.category
;