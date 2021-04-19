#!/bin/bash

psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -a -f /database/ddl/sequence/sequence.sql

for file in /database/ddl/*.sql
do
  psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -a -f ${file}
done

for file in /database/dml/*.sql
do
  psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -a -f ${file}
done

#for file in /database/function/*.sql
#do
#  psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -a -f ${file}
#done

for file in /database/index/*.sql
do
  psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -a -f ${file}
done
