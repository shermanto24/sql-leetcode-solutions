# Write your MySQL query statement below
select round(sum(tiv_2016), 2) as tiv_2016
from insurance as outer_table
where 
    tiv_2015 in 
    (
        select tiv_2015 
        from insurance as inner_table 
        where outer_table.pid != inner_table.pid
    )
    and (lat, lon) in ( select lat, lon from insurance group by lat, lon having count(*) = 1 )
;
