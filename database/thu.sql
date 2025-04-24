SELECT * FROM Site WHERE Area < 200;

-- SELECT * FROM Site WHERE Location

-- Not equal, classical operator is <>, but nowadays most support !=
SELECT * FROM Site WHERE Location <> 'Alaska, USA';

-- other operators
-- like for string matching, uses % as the wildcard character (not *)
SELECT * FROM Site WHERE Location LIKE '%Canada';

-- regular expressions, use regex
SELECT * FROM Site WHERE regexp_matches(Location, '.*west.*');

-- select expressions; i.e., you can do computation
SELECT Site_name, Area FROM Site;
SELECT Site_name, Area*2.47 FROM Site;
SELECT Site_name, Area*2.47 AS Area_acres FROM Site;

-- You can use ou database as a calculator
SELECT 2*3+4/5-6*7+8/9*10 AS result;

-- String concationation operator: classic one is ||, others via functions
SELECT Site_name || ' in ' || Location FROM Site;

-- Aggregation and grouping
SELECT COUNT(*) FROM Species;
-- ^^ * means number of rows
SELECT COUNT(Scientific_name) FROM Species;

-- can also cound distinct values
SELECT DISTINCT Relevance FROM Speciesl
SELECT COUNT(DISTINCT Relevance) FROM Species;

-- arithmetic operations
SELECT AVG(Area) FROM Site;
SELECTAVG(AREA) FROM Site WHERE Location LIKE '%Alaska%';
-- min, max

-- a quiz: what happens when you do this
SELECT Site_name, MAX(Area) 
    FROM Site
    GROUP BY Site_name; --without a group by, it will return an error because it doesn't know what the output is supposed to be

SELECT Location, COUNT(*), MAX(Area)
    FROM Site
    WHERE Location LIKE '%Canada'
    GROUP BY Location;

SELECT Location, COUNT(*) AS Count, MAX(Area) AS Max_area
    FROM Site
    WHERE Location LIKE '%Canada'
    GROUP BY Location
    HAVING COUNT > 1;


-- NULL processing
-- null indicates the absence of data in a table
-- but in an expression, it means unknown
SELECT COUNT(*) FROM Bird_nests;
SELECT COUNT(*) FROM Bird_nests WHERE floatAge > 5;
SELECT COUNT(*) FROM Bird_nests WHERE floatAge <= 5;

-- how can I find out which rows are null
-- this doesn't work for this, just returns 0 
SELECT COUNT(*) FROM Bird_nests WHERE floatAge == NULL;
-- this does
SELECT COUNT(*) FROM Bird_nests WHERE floatAge IS NULL;
SELECT COUNT(*) FROM Bird_nests WHERE floatAge IS NOT NULL;

-- joins
SELECT * FROM Camp_assignment LIMIT 10;
SELECT * FROM Personnel;

SELECT * FROM Camp_assignment JOIN Personnel ON Observer = Abbreviation LIMIT 10;

-- what happens
SELECT * FROM Camp_assignment CROSS JOIN Personnel;
-- cross join matches every row in x with every row in y
-- basically it finds to common cols for you

SELECT * FROM Camp_assignment JOIN Personnel
    ON Camp_assignment.Observer = Personnel.Abbreviation
    LIMIT 10;

SELECT * FROM Camp_assignment AS CA JOIN Personnel AS P
    ON CA.Observer = P.Abbreviation
    LIMIT 10;

SELECT COUNT(*) FROM Bird_nests;
SELECT COUNT(*) FROM (SELECT COUNT(*) FROM Bird_nests);

-- Create temp tables
CREATE TEMP TABLE nest_count AS SELECT COUNT(*) FROM Bird_nests;
.table
SELECT * FROM nest_count;
DROP TABLE nest_count;
-- another place to nest queries, in IN clauses
SELECT Observer FROM Bird_nests;

SELECT * FROM Personnel ORDER BY Abbreviation;
SELECT * FROM Bird_nests
    WHERE Observer IN (
        SELECT Abbreviation FROM Personnel
            WHERE Abbreviation LIKE 'a%'
    );