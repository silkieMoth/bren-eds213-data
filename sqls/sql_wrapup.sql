CREATE TEMP TABle t AS(

);

SELECT * FROM t;
SELECT * FROM Species s JOIN t
    ON s.Scientific_name = t.Scientific_name
    OR (s.Scientific_name IS NULL AND t.Scientific_name IS NULL);

INSERT INTO Species
    ('think 3', 'ijkl');
SELECT * FROM Species;

-- UPDATEs and DELETEs will demolish the entire table unless limited by WHERE
DELETE FROM Bird_eggs;

-- Strategies to save yourself?
-- Doing a SELECT first
SELECT * FROM Bird_eggs WHERE Nest_ID LIKE 'z%';
SELECT * FROM Bird_nests;

-- try the
CREATE TABLE nest_temp AS (SELECT * FROM Bird_nests);
DELETE FROM nest_temp WHERE Site = 'chur';

-- other ideas
xDELETE FROM ... WHERE ...;