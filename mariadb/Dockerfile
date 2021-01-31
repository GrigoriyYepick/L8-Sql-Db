FROM mariadb:10.5

COPY schema.sql /docker-entrypoint-initdb.d/
COPY ./Csv/ /var/lib/mysql/csv

EXPOSE 3306
