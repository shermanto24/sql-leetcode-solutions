# Write your MySQL query statement below
with unbanned_requests as
(
    select
        status,
        request_at
    from trips as t
        inner join users as c
            on t.client_id = c.users_id
        inner join users as d
            on t.driver_id = d.users_id
    where 
        c.banned != 'Yes' and
        d.banned != 'Yes'
)
select
    request_at as "Day",
    round(sum(if(status like 'cancelled%', 1, 0)) / count(*), 2) as "Cancellation Rate"
from unbanned_requests
where request_at between '2013-10-01' and '2013-10-03'
group by request_at
;
