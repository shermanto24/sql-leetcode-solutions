# Write your MySQL query statement below
-- select
--     s.user_id,
--     (
--         select round(count(action = 'confirmed') / count(c.user_id), 2)
--         from confirmations as c
--     ) as confirmation_rate
--     #round(count(action = 'confirmed') over (partition by c.user_id) / count(c.user_id) over (partition by c.user_id), 2) as confirmation_rate
-- from signups as s
-- ;

-- with confirmations_per_user as 
-- (
--     select
--         user_id,
--         count(action = 'confirmed') as num_confirmations,
--         count(action) as num_actions
--     from confirmations
-- )
-- select
--     s.user_id,
--     round(num_confirmations / num_actions, 2) as confirmation_rate
-- from signups as s
--     left join confirmations_per_user as cpu
--         on s.user_id = cpu.user_id
-- ;

select
    s.user_id,
    coalesce(round(count(case when action = 'confirmed' then 1 end) / count(action), 2), 0) as confirmation_rate
from confirmations as c
    right join signups as s
        on c.user_id = s.user_id
group by user_id
;