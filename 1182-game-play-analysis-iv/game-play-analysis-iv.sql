# Write your MySQL query statement below
with first_next_logins as
(
    select
        player_id,
        min(event_date) over (partition by player_id order by event_date asc) as first_login_date,
        lead(event_date, 1) over (partition by player_id order by event_date asc) as next_login_date,
        row_number() over (partition by player_id order by event_date asc) as pair_index
    from activity
)
select
    round(sum(if(datediff(next_login_date, first_login_date) = 1, 1, 0)) / count(distinct player_id), 2) as fraction
from first_next_logins
where pair_index = 1
;