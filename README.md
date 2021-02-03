# L8-Sql-Db
 
### Build:
```
docker-compose build

docker-compose up -d
```

### Init Users table
Open and execute
```
Tools\init_users.sql
```

## Select data with filtering by date

All queries are placed here
```
 Tools\select_by_date.sql
```

### Without Index

Select 50% of rows with filter by date takes ~23 seconds.

Select 10% of rows with filter by date takes ~16 seconds.

EXPLAIN EXTENDED shows the full scan plan:

```
+----+-------------+-------+------+---------------+-----+---------+-----+----------+-------------+
| id | select_type | table | type | possible_keys | key | key_len | ref | rows     | extra       |
+----+-------------+-------+------+---------------+-----+---------+-----+----------+-------------+
|  1 | SIMPLE      | Users | ALL  |               |     |         |     | 40000000 | Using where |
+----+-------------+-------+------+---------------+-----+---------+-----+----------+-------------+
```
<br>

### With INDEX
```
CREATE INDEX Dates_idx USING BTREE
ON Users (DATE, FirstName, SecondName);
```

Select 50% of rows takes ~13 seconds.

***I think speed up only on 50% from original value is explained with my table specifics.***

***I used cvs files with ~340: names, sirnames and dates to make cross join to init a table.***

***So event SELECT with filter by one date gives 116 360 rows.***

***So bassically speed explained with a lot of data.***

Plan:
```
+----+-------------+-------+-------+---------------+-----------+---------+-----+----------+--------------------------+
| id | select_type | table | type  | possible_keys | key       | key_len | ref | rows     | extra                    |
+----+-------------+-------+-------+---------------+-----------+---------+-----+----------+--------------------------+
|  1 | SIMPLE      | Users | range | Dates_idx     | Dates_idx | 3       |     | 20000000 | Using where; Using index |
+----+-------------+-------+-------+---------------+-----------+---------+-----+----------+--------------------------+
```
<br>

Select 10% of rows takes ~3 seconds.

Plan:
```
+----+-------------+-------+-------+---------------+-----------+---------+-----+---------+--------------------------+
| id | select_type | table | type  | possible_keys | key       | key_len | ref | rows    | extra                    |
+----+-------------+-------+-------+---------------+-----------+---------+-----+---------+--------------------------+
|  1 | SIMPLE      | Users | range | Dates_idx     | Dates_idx | 3       |     | 7853414 | Using where; Using index |
+----+-------------+-------+-------+---------------+-----------+---------+-----+---------+--------------------------+
```
<br>

## Table size

All queries are placed here
```
 Tools\check_size.sql
```

With 40 million of users:
```
DB_NAME	TABLE_NAME	TABLE_SIZE_in_GB
 db1	   Users	       3.71
```

After deletion 50% of rows.
```
DB_NAME	TABLE_NAME	TABLE_SIZE_in_GB
 db1	   Users	       3.17
```

After 
```
OPTIMIZE TABLE Users;
```
```
DB_NAME	TABLE_NAME	TABLE_SIZE_in_GB
 db1	   Users	       1.59
```
