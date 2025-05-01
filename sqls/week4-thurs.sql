CREATE OR REPLACE TABLE Snow_cover (
    Site VARCHAR NOT NULL,
    Year INTEGER NOT NULL CHECK (Year BETWEEN 1990 AND 2018), 
    Date DATE NOT NULL,
    Plot VARCHAR NOT NULL,
    Location VARCHAR NOT NULL,
    Snow_cover REAL, 
    Water_cover REAL,
    Land_cover REAL,
    Total_cover REAL,
    Observer VARCHAR, 
    Notes VARCHAR, 
    PRIMARY KEY (Site, Plot, Location, Date), 
    FOREIGN KEY (Site) REFERENCES Site (Code)
);

COPY Snow_cover FROM "ASDN_csv/snow_survey_fixed.csv" (header TRUE, nullstr "NA");

SELECT * FROM Snow_cover LIMIT 10;

--- 1. what is the average snow cover at each site
SELECT Site, AVG(Snow_cover) AS avg_snow_cover FROM Snow_cover
    GROUP BY Site;

--- 2. Top 5 most snowy sites
SELECT Site, AVG(Snow_cover) AS avg_snow_cover FROM Snow_cover
    GROUP BY Site
    ORDER BY avg_snow_cover DESC
    LIMIT 5;

--- 3. save this as a view
CREATE OR REPLACE VIEW Site_avg_snowcover AS (
    SELECT Site, AVG(Snow_cover) AS avg_snow_cover FROM Snow_cover
    GROUP BY Site
    ORDER BY avg_snow_cover DESC
    LIMIT 5
);

SELECT * FROM Site_avg_snowcover;

CREATE OR REPLACE TEMP TABLE Site_avg_snowcover_table AS (
    SELECT Site, AVG(Snow_cover) AS avg_snow_cover FROM Snow_cover
    GROUP BY Site
    ORDER BY avg_snow_cover DESC
    LIMIT 5
);

SELECT * FROM Site_avg_snowcover_table;

--- DANGER ZONE AKA updating data
--- we found that 0s at plot = `brw0` with snow_cover == 0 are actually no data (NULL)

CREATE OR REPLACE TEMP TABLE Snow_cover_backup AS (SELECT * FROM Snow_cover);
UPDATE Snow_cover_backup SET Snow_cover = NULL WHERE Plot = 'brw0' AND Snow_cover = 0;

SELECT Snow_cover FROM Snow_cover_backup
    WHERE Snow_cover IS NULL;