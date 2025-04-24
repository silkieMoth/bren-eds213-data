-- Start the DB at the terminal: duckdb

CREATE TABLE ducks AS SELECT 3 As age, 'mandarin' AS breed;

SHOW TABLES;

FROM ducks SELECT *;