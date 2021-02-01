# Users table size
SELECT table_schema AS DB_NAME, TABLE_NAME, (DATA_LENGTH+INDEX_LENGTH)/1024/1024/1024 AS TABLE_SIZE_in_GB 
FROM information_schema.TABLES
WHERE TABLE_NAME = 'Users';

# Delete 1/2 of data
START TRANSACTION;
DELETE 
FROM Users
WHERE Id > 20000000;
COMMIT;

SELECT COUNT(*) FROM Users

# Users table size
# the same value
SELECT table_schema AS DB_NAME, TABLE_NAME, (DATA_LENGTH+INDEX_LENGTH)/1024/1024/1024 AS TABLE_SIZE_in_GB
FROM information_schema.TABLES
WHERE TABLE_NAME = 'Users';


OPTIMIZE TABLE Users;


# Users table size

SELECT table_schema AS DB_NAME, TABLE_NAME, (DATA_LENGTH+INDEX_LENGTH)/1024/1024/1024 AS TABLE_SIZE_in_GB
FROM information_schema.TABLES
WHERE TABLE_NAME = 'Users';