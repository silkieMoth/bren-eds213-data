-- create egg volumn calculation macro
CREATE OR REPLACE MACRO egg_volume(width,length) AS (
    (3.14 / 6)*((width^2)*length)
);

-- create table with average egg vols per nest
CREATE OR REPLACE TEMP TABLE nest_egg_vols AS
    SELECT Nest_ID, 
            AVG(Width) AS avg_width, 
            AVG(Length) AS avg_length, 
            egg_volume(avg_width, avg_length) AS egg_volume -- funnel egg vol macro
        FROM Bird_eggs
        GROUP BY Nest_ID; -- for every nest

SELECT * FROM nest_egg_vols LIMIT 5; -- view table

-- view summaries of tables to be included in final
DESCRIBE SELECT * FROM Bird_nests;
DESCRIBE SELECT * FROM nest_egg_vols;
DESCRIBE SELECT * FROM Species;


-- make final table
SELECT 
        Species.Scientific_name, 
        MAX(nest_egg_vols.egg_volume) AS Max_avg_volume -- max of the avg egg vols for each species
    FROM Bird_nests -- give Species tbl something to join on
        JOIN nest_egg_vols 
            USING (Nest_ID)
        JOIN Species -- attach tbl with latin names
            ON Species.Code = Bird_nests.Species
    GROUP BY Scientific_name
    ORDER BY Max_avg_volume DESC; -- smallest to largest vol