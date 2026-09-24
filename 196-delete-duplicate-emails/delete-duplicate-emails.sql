# Write your MySQL query statement below
delete from person
where id not in -- deleting ids that are not the minimum
(
    select id
    from
    (   -- gets 1 id per email, id is the min one associated
        select min(id) as id
        from person
        group by email
    ) as t
)
;

-- Previous solution
-- delete p1 -- looks at result table from rest of code, deletes that from person
-- from person as p1
--     inner join person as p2
--         on
--             p1.email = p2.email and
--             p2.id < p1.id
-- ;