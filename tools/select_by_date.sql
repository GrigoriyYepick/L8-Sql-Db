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
# ~1.5 min
CREATE INDEX Dates_idx USING BTREE
  ON Users (DATE);

# Select 1/2 of data
# ~53 sec
# slower then full scan
SELECT * FROM Users FORCE INDEX (Dates_idx)
WHERE Date > '2010-10-01';

# Select 1/10 of datta 
# ~ 10 sec
# faster then full scan
SELECT * FROM Users FORCE INDEX (Dates_idx) 
WHERE DATE < '2001-08-01';

# Plan without forcing Index - full scan
EXPLAIN EXTENDED SELECT * FROM Users 
WHERE Date > '2010-10-01';

# Plan with forcing Index
EXPLAIN EXTENDED SELECT * FROM Users FORCE INDEX (Dates_idx) 
WHERE Date > '2010-10-01';

# Plan without forcing Index - full scan
EXPLAIN EXTENDED SELECT * FROM Users
WHERE DATE < '2001-08-01';

# Plan without forcing Index
EXPLAIN EXTENDED SELECT * FROM Users FORCE INDEX (Dates_idx) 
WHERE DATE < '2001-08-01';