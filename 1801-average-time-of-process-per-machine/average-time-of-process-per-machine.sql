# Write your MySQL query statement below
with processing_times as
(
    select
        machine_id,
        process_id,
        activity_type,
        timestamp - lag(timestamp, 1, 0) over (order by machine_id asc, process_id asc, activity_type asc) as processing_time
    from activity
)
select
    machine_id,
    round(avg(processing_time), 3) as processing_time
from processing_times
where activity_type = 'end'
group by machine_id
;