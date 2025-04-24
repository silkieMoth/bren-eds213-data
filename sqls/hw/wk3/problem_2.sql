-- for duckdb to perform an aggregate function, it has to know what to do with the other columns in the query
-- it's fine if these further instructions are not there when there's only one column present, because then it only has to deal with the column it was given instructions for
-- but when there's more than one, it needs to be told this information because there are multiple ways to approach it
-- some methods include group by, first, giving it its own agg function, etc
SELECT Site_name, MAX(Area) FROM Site
    GROUP BY Site_name;

-- Part 2
SELECT Site_name, Area FROM Site
    ORDER BY Area DESC -- order areas descending
    LIMIT 1; -- return only first row



-- Part 3
SELECT Site_name, Area FROM Site 
    WHERE Area = ( -- return area vals only if
        SELECT MAX(Area) AS Area FROM Site --- it is the max in dataset
        );