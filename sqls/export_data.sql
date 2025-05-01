EXPORT DATABASE 'export_adsn';

COPY Species TO 'species_test.csv' (HEADER, DELIMITER ',');

-- One table
COPY Species TO 'species_test.csv' (HEADER, DELIMITER ',');

-- specific query
-- COPY(SELECT COUNT (*))