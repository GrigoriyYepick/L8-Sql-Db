CREATE TEMPORARY TABLE test_names (Name VARCHAR(255) NOT NULL);

LOAD DATA INFILE '/var/lib/mysql/csv/Names.csv'
INTO TABLE test_names
LINES TERMINATED BY '\n';

##SELECT * FROM test_names

CREATE TEMPORARY TABLE test_sirnames (Sirname VARCHAR(255) NOT NULL);

LOAD DATA INFILE '/var/lib/mysql/csv/Sirnames.csv'
INTO TABLE test_sirnames
LINES TERMINATED BY '\n';

CREATE TEMPORARY TABLE test_dates (Date VARCHAR(255) NOT NULL);
LOAD DATA INFILE '/var/lib/mysql/csv/Dates.csv'
INTO TABLE test_dates
LINES TERMINATED BY '\n';

START TRANSACTION;
INSERT INTO Users
(FirstName, SecondName, Date)
SELECT n.Name, s.Sirname, STR_TO_DATE(d.Date,'%Y-%m-%d') FROM test_names AS n CROSS JOIN test_sirnames AS s  CROSS JOIN test_dates AS d LIMIT 40000000;
COMMIT;