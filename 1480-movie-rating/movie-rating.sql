# Write your MySQL query statement below
(
    select name as results
    from movierating as mr
        inner join users as u
            on mr.user_id = u.user_id
    group by name
    order by
        count(rating) desc,
        name asc
    limit 1
)
union all
(
    select title as results
    from movierating as mr
        inner join movies as m
            on mr.movie_id = m.movie_id
    where created_at like '2020-02%'
    group by title
    order by
        avg(rating) desc,
        title asc
    limit 1
)