# Select 1/2 of data
# ~23 sec
SELECT * FROM Users 
WHERE Date > '2010-10-01';

# Select 1/10 of data 
# ~ 16 sec
SELECT * FROM Users 
WHERE DATE < '2001-08-01';

# Plan - it's the same for any query
EXPLAIN EXTENDED SELECT * FROM Users 
WHERE Date > '2010-10-01';

# Index
CREATE INDEX Dates_idx USING BTREE
ON Users (DATE, FirstName, SecondName);

# DROP INDEX Dates_idx ON Users

# Select 1/2 of data
# ~13 sec
SELECT Id, DATE, FirstName, SecondName FROM Users
WHERE Date > '2010-10-01';

# Plan
EXPLAIN EXTENDED SELECT Id, DATE, FirstName, SecondName FROM Users 
WHERE Date > '2010-10-01';

# Select 1/10 of datta 
# ~ 3 sec
SELECT Id, DATE, FirstName, SecondName FROM Users
WHERE DATE < '2001-08-01';

# Plan
EXPLAIN EXTENDED SELECT Id, DATE, FirstName, SecondName FROM Users
WHERE DATE < '2001-08-01';