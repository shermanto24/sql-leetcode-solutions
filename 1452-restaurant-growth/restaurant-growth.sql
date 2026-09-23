# Write your MySQL query statement below
select *
from 
(
    select
        visited_on,
        sum(amount) over (order by visited_on asc rows between 6 preceding and current row) as amount,
        round(avg(amount) over (order by visited_on asc rows between 6 preceding and current row), 2) as average_amount
    from
    (
        select
            visited_on,
            sum(amount) as amount
        from customer
        group by visited_on
    ) as t1
) as t2
where visited_on >= date_add((select min(visited_on) from customer), interval 6 day)
;