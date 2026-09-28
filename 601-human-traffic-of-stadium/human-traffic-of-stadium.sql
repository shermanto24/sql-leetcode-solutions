# Write your MySQL query statement below
select
    id,
    visit_date,
    people
from 
(
    select
        id,
        visit_date,
        people,
        lag(people, 1) over (order by id asc) as people_before,
        lead(people, 1) over (order by id asc) as people_after
    from stadium
) as btwn
where
    people >= 100 and
    people_before >= 100 and
    people_after >= 100

union

select 
    id,
    visit_date,
    people 
from
(
    -- lead: everything except last 2
    select
        id,
        visit_date,
        people,
        lead(people, 1) over (order by id asc) as people_2,
        lead(people, 2) over (order by id asc) as people_3
    from stadium
) as ld
where
    people >= 100 and 
    people_2 >= 100 and 
    people_3 >= 100

union

select 
    id,
    visit_date,
    people 
from
(
    -- lag: everything except first 2
    select
        id,
        visit_date,
        people,
        lag(people, 1) over (order by id asc) as people_2,
        lag(people, 2) over (order by id asc) as people_3
    from stadium
) as lg
where
    people >= 100 and 
    people_2 >= 100 and 
    people_3 >= 100

order by visit_date asc
;