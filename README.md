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

EXPLAIN EXTENDED still show full scan as the best option

But with FORCE INDEX it takes index into account.

Select 50% of rows with FORCE INDEX is slower and takes ~53 seconds.

Plan:
```
+----+-------------+-------+-------+---------------+-----------+---------+-----+----------+-----------------------+
| id | select_type | table | type  | possible_keys | key       | key_len | ref | rows     | extra                 |
+----+-------------+-------+-------+---------------+-----------+---------+-----+----------+-----------------------+
|  1 | SIMPLE      | Users | range | Dates_idx     | Dates_idx | 3       |     | 20000000 | Using index condition |
+----+-------------+-------+-------+---------------+-----------+---------+-----+----------+-----------------------+
```
<br>

Select 10% of rows with FORCE INDEX is faster and takes ~10 seconds.

Plan:
```
+----+-------------+-------+-------+---------------+-----------+---------+-----+---------+-----------------------+
| id | select_type | table | type  | possible_keys | key       | key_len | ref | rows    | extra                 |
+----+-------------+-------+-------+---------------+-----------+---------+-----+---------+-----------------------+
|  1 | SIMPLE      | Users | range | Dates_idx     | Dates_idx | 3       |     | 8777968 | Using index condition |
+----+-------------+-------+-------+---------------+-----------+---------+-----+---------+-----------------------+
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
 db1	   Users	       2.22
```
With 20 million of users, table size remains the same.

After 
```
OPTIMIZE TABLE Users;
```
```
DB_NAME	TABLE_NAME	TABLE_SIZE_in_GB
 db1	   Users	       1.23
```
