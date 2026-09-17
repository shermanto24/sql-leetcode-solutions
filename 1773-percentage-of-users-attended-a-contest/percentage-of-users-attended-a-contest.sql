# Write your MySQL query statement below
select 
    contest_id,
    round(count(u.user_id) / ( select count(*) from users ) * 100, 2) as percentage
from register as r
    left join users as u
        on r.user_id = u.user_id
group by contest_id
order by
    percentage desc,
    contest_id asc
;