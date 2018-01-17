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




# psql -U postgres mago3d < ./ddl/access_log.sql
# psql -U postgres mago3d < ./ddl/api.sql
# psql -U postgres mago3d < ./ddl/common_code.sql
# psql -U postgres mago3d < ./ddl/dataInfo.sql
# psql -U postgres mago3d < ./ddl/file_info.sql
# psql -U postgres mago3d < ./ddl/issue.sql
# psql -U postgres mago3d < ./ddl/menu.sql
# psql -U postgres mago3d < ./ddl/policy.sql
# psql -U postgres mago3d < ./ddl/role.sql
# psql -U postgres mago3d < ./ddl/schedule.sql
# psql -U postgres mago3d < ./ddl/sso_log.sql
# psql -U postgres mago3d < ./ddl/user_info.sql
# psql -U postgres mago3d < ./ddl/widget.sql

# psql -U postgres mago3d < ./ddl/sequence/sequence.sql

# psql -U postgres mago3d < ./index/access_log.sql
# psql -U postgres mago3d < ./index/api_log.sql
# psql -U postgres mago3d < ./index/sso_log.sql

# psql -U postgres mago3d < ./trigger/access_log_trigger.sql
# psql -U postgres mago3d < ./trigger/api_log_trigger.sql
# psql -U postgres mago3d < ./trigger/sso_log_trigger.sql

# psql -U postgres mago3d < ./dml/insert.sql
