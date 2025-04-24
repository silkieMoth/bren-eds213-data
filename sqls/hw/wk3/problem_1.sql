-- init sequential id
CREATE OR REPLACE SEQUENCE id;

-- create test table
CREATE OR REPLACE TEMP TABLE test(
    id INT DEFAULT nextval('id') PRIMARY KEY,
    test_col REAL
);

-- insert values into it
INSERT OR REPLACE INTO test (test_col) VALUES 
    (5), (25), (12), (35), (41), (1), (24), (NULL), (52), (7), (15);
SELECT * FROM test;


-- average function with null question

-- both omitting and not omitting the nulls returns the same answer, because duckdb does that automatically for most functions
-- if all values funneled in are null, the func returns null
SELECT AVG(test_col) AS avg_result_with_null FROM test;
SELECT AVG(test_col) AS avg_result_without_null FROM test WHERE test_col IS NOT NULL;

-- incorrect, is not excluding the null values
SELECT SUM(test_col)/COUNT(*) FROM test;


-- average calc question

-- correct, excludes nulls
SELECT SUM(test_col)/COUNT(test_col) FROM test;
-- does same thing
SELECT SUM(test_col)/COUNT(*) FROM test WHERE test_col IS NOT NULL;


-- drop table 
DROP TABLE test;