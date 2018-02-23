:: psql -U postgres -d mago3d -a -f script.sql

@echo off
echo .................. ddl init start .................
echo ...................................................

cd C:\PostgreSQL\9.6\bin\

psql -U postgres -d mago3d -a -f C:\git\repository\mago3d\mago3d-core\src\doc\database\ddl\access_log.sql
psql -U postgres -d mago3d -a -f C:\git\repository\mago3d\mago3d-core\src\doc\database\ddl\api.sql
psql -U postgres -d mago3d -a -f C:\git\repository\mago3d\mago3d-core\src\doc\database\ddl\common_code.sql
psql -U postgres -d mago3d -a -f C:\git\repository\mago3d\mago3d-core\src\doc\database\ddl\datainfo.sql
psql -U postgres -d mago3d -a -f C:\git\repository\mago3d\mago3d-core\src\doc\database\ddl\datainfo_log.sql
psql -U postgres -d mago3d -a -f C:\git\repository\mago3d\mago3d-core\src\doc\database\ddl\file_info.sql
psql -U postgres -d mago3d -a -f C:\git\repository\mago3d\mago3d-core\src\doc\database\ddl\issue.sql
psql -U postgres -d mago3d -a -f C:\git\repository\mago3d\mago3d-core\src\doc\database\ddl\menu.sql
psql -U postgres -d mago3d -a -f C:\git\repository\mago3d\mago3d-core\src\doc\database\ddl\policy.sql
psql -U postgres -d mago3d -a -f C:\git\repository\mago3d\mago3d-core\src\doc\database\ddl\role.sql
psql -U postgres -d mago3d -a -f C:\git\repository\mago3d\mago3d-core\src\doc\database\ddl\schedule.sql
:: psql -U postgres -d mago3d -a -f C:\git\repository\mago3d\mago3d-core\src\doc\database\ddl\sso_log.sql
psql -U postgres -d mago3d -a -f C:\git\repository\mago3d\mago3d-core\src\doc\database\ddl\user_info.sql
psql -U postgres -d mago3d -a -f C:\git\repository\mago3d\mago3d-core\src\doc\database\ddl\widget.sql

psql -U postgres -d mago3d -a -f C:\git\repository\mago3d\mago3d-core\src\doc\database\ddl\sequence\sequence.sql

psql -U postgres -d mago3d -a -f C:\git\repository\mago3d\mago3d-core\src\doc\database\index\access_log.sql
psql -U postgres -d mago3d -a -f C:\git\repository\mago3d\mago3d-core\src\doc\database\index\api_log.sql
psql -U postgres -d mago3d -a -f C:\git\repository\mago3d\mago3d-core\src\doc\database\index\data_info_log.sql
:: psql -U postgres -d mago3d -a -f C:\git\repository\mago3d\mago3d-core\src\doc\database\index\sso_log.sql

psql -U postgres -d mago3d -a -f C:\git\repository\mago3d\mago3d-core\src\doc\database\trigger\access_log_trigger.sql
psql -U postgres -d mago3d -a -f C:\git\repository\mago3d\mago3d-core\src\doc\database\trigger\api_log_trigger.sql
psql -U postgres -d mago3d -a -f C:\git\repository\mago3d\mago3d-core\src\doc\database\trigger\data_info_log_trigger.sql
:: psql -U postgres -d mago3d -a -f C:\git\repository\mago3d\mago3d-core\src\doc\database\trigger\sso_log_trigger.sql

psql -U postgres -d mago3d -a -f C:\git\repository\mago3d\mago3d-core\src\doc\database\dml\insert.sql

echo .................. ddl init end ...................
echo ...................................................
pause
