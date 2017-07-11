1 database 생성

CREATE DATABASE mago3d
  WITH ENCODING='UTF8'
       OWNER=postgres
       TEMPLATE=template0
       LC_COLLATE='C'
       LC_CTYPE='C'
       CONNECTION LIMIT=-1;

2 extendsion 이 안 생긴다.



#!/bin/bash
TABLE_PATH='/gt100/database/ddl'
SEQUENCE_PATH='/gt100/database/ddl/sequence/bdr'
INDEX_PATH='/gt100/database/index'
TRIGGER_PATH='/gt100/database/trigger'
REPLICATION_PATH='/gt100/database/replication'
INSERT_PATH='/gt100/database/dml/bdr'

for file in $TABLE_PATH/*
do
   filename=${file}
    echo "$TABLE_PATH/${filename##/*/}"
    psql -U postgres mago3d < "$TABLE_PATH/${filename##/*/}"
done

psql -U postgres mago3d < /gt1000/database/ddl/sequence/bdr/bdr_global_sequences.sql

for file in $INDEX_PATH/*
do
   filename=${file}
    echo "$INDEX_PATH/${filename##/*/}"
    psql -U postgres mago3d < "$INDEX_PATH/${filename##/*/}"
done

for file in $TRIGGER_PATH/*
do
   filename=${file}
    echo "$TRIGGER_PATH/${filename##/*/}"
    psql -U postgres mago3d < "$TRIGGER_PATH/${filename##/*/}"
done

psql -U postgres mago3d < /gt1000/database/replication/replication_exception_table.sql

for file in $INSERT_PATH/*
do
   filename=${file}
    echo "$INSERT_PATH/${filename##/*/}"
    psql -U postgres mago3d < "$INSERT_PATH/${filename##/*/}"
done




# psql -U postgres mago3d < bdr_global_sequences.sql
# psql -U postgres mago3d < index/access_log.sql
# psql -U postgres mago3d < index/user_otp_log.sql
# psql -U postgres mago3d < access_log_trigger.sql
# psql -U postgres mago3d < user_log_trigger.sql
# psql -U postgres mago3d < replication_exception_table.sql
# psql -U postgres mago3d < insert.sql