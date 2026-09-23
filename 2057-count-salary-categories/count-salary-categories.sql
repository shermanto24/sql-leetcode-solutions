# Write your MySQL query statement below
select 'High Salary' as category, count(account_id) as accounts_count
from accounts where income > 50000

union 

select 'Low Salary' as category, count(account_id) as accounts_count
from accounts where income < 20000

union

select 'Average Salary' as category, count(account_id) as accounts_count
from accounts where income >= 20000 and income <= 50000

-- Previous solution
-- with accounts_categorized as
-- (
--     select
--         account_id,
--         case
--             when income < 20000 then 'Low Salary'
--             when income <= 50000 then 'Average Salary'
--             else 'High Salary'
--         end as category
--     from accounts
-- )
-- select 
--     c.category,
--     count(account_id) as accounts_count
-- from accounts_categorized as a
--     right join
--     (
--         select 'Low Salary' as category union
--         select 'Average Salary' union
--         select 'High Salary'
--     ) as c
--         on c.category = a.category
-- group by c.category
-- ;