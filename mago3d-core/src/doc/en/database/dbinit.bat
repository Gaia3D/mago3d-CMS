:: psql -U postgres -d mago3d -a -f script.sql

@echo off
echo .................. ddl init start .................
echo ...................................................

cd C:\PostgreSQL\9.6\bin\

psql -U postgres -d mago3d -a -f C:\git\repository\mago3d\mago3d-core\src\doc\en\database\ddl\access_log.sql
psql -U postgres -d mago3d -a -f C:\git\repository\mago3d\mago3d-core\src\doc\en\database\ddl\api.sql
psql -U postgres -d mago3d -a -f C:\git\repository\mago3d\mago3d-core\src\doc\en\database\ddl\common_code.sql
psql -U postgres -d mago3d -a -f C:\git\repository\mago3d\mago3d-core\src\doc\en\database\ddl\datainfo.sql
psql -U postgres -d mago3d -a -f C:\git\repository\mago3d\mago3d-core\src\doc\en\database\ddl\datainfo_log.sql
psql -U postgres -d mago3d -a -f C:\git\repository\mago3d\mago3d-core\src\doc\en\database\ddl\file_info.sql
psql -U postgres -d mago3d -a -f C:\git\repository\mago3d\mago3d-core\src\doc\en\database\ddl\issue.sql
psql -U postgres -d mago3d -a -f C:\git\repository\mago3d\mago3d-core\src\doc\en\database\ddl\menu.sql
psql -U postgres -d mago3d -a -f C:\git\repository\mago3d\mago3d-core\src\doc\en\database\ddl\policy.sql
psql -U postgres -d mago3d -a -f C:\git\repository\mago3d\mago3d-core\src\doc\en\database\ddl\role.sql
psql -U postgres -d mago3d -a -f C:\git\repository\mago3d\mago3d-core\src\doc\en\database\ddl\schedule.sql
:: psql -U postgres -d mago3d -a -f C:\git\repository\mago3d\mago3d-core\src\doc\en\database\ddl\sso_log.sql
psql -U postgres -d mago3d -a -f C:\git\repository\mago3d\mago3d-core\src\doc\en\database\ddl\user_info.sql
psql -U postgres -d mago3d -a -f C:\git\repository\mago3d\mago3d-core\src\doc\en\database\ddl\widget.sql

psql -U postgres -d mago3d -a -f C:\git\repository\mago3d\mago3d-core\src\doc\en\database\ddl\sequence\sequence.sql

psql -U postgres -d mago3d -a -f C:\git\repository\mago3d\mago3d-core\src\doc\en\database\index\access_log.sql
psql -U postgres -d mago3d -a -f C:\git\repository\mago3d\mago3d-core\src\doc\en\database\index\api_log.sql
psql -U postgres -d mago3d -a -f C:\git\repository\mago3d\mago3d-core\src\doc\en\database\index\data_info_log.sql
:: psql -U postgres -d mago3d -a -f C:\git\repository\mago3d\mago3d-core\src\doc\en\database\index\sso_log.sql

psql -U postgres -d mago3d -a -f C:\git\repository\mago3d\mago3d-core\src\doc\en\database\trigger\access_log_trigger.sql
psql -U postgres -d mago3d -a -f C:\git\repository\mago3d\mago3d-core\src\doc\en\database\trigger\api_log_trigger.sql
psql -U postgres -d mago3d -a -f C:\git\repository\mago3d\mago3d-core\src\doc\en\database\trigger\data_info_log_trigger.sql
:: psql -U postgres -d mago3d -a -f C:\git\repository\mago3d\mago3d-core\src\doc\en\database\trigger\sso_log_trigger.sql

psql -U postgres -d mago3d -a -f C:\git\repository\mago3d\mago3d-core\src\doc\en\database\dml\insert.sql

echo .................. ddl init end ...................
echo ...................................................
pause
