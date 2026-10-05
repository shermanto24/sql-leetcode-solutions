CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
  RETURN 
  (
    # Write your MySQL query statement below.
    with salaries_ordered as
    (
        select
            distinct salary,
            row_number() over (order by salary desc) as rn
        from employee
        group by salary
    )
    select salary
    from salaries_ordered
    where if(n > rn, null, rn = n)
  );
END