:: psql -U postgres -d mago3d -a -f script.sql

@echo off
echo .................. ddl init start .................
echo ...................................................

cd C:\PostgreSQL\9.6\bin\

psql -U postgres -d mago3d -a -f C:\git\repository\mago3d\mago3d-core\src\doc\ko\database\ddl\access_log.sql
psql -U postgres -d mago3d -a -f C:\git\repository\mago3d\mago3d-core\src\doc\ko\database\ddl\api.sql
psql -U postgres -d mago3d -a -f C:\git\repository\mago3d\mago3d-core\src\doc\ko\database\ddl\common_code.sql
psql -U postgres -d mago3d -a -f C:\git\repository\mago3d\mago3d-core\src\doc\ko\database\ddl\datainfo.sql
psql -U postgres -d mago3d -a -f C:\git\repository\mago3d\mago3d-core\src\doc\ko\database\ddl\datainfo_log.sql
psql -U postgres -d mago3d -a -f C:\git\repository\mago3d\mago3d-core\src\doc\ko\database\ddl\file_info.sql
psql -U postgres -d mago3d -a -f C:\git\repository\mago3d\mago3d-core\src\doc\ko\database\ddl\issue.sql
psql -U postgres -d mago3d -a -f C:\git\repository\mago3d\mago3d-core\src\doc\ko\database\ddl\menu.sql
psql -U postgres -d mago3d -a -f C:\git\repository\mago3d\mago3d-core\src\doc\ko\database\ddl\policy.sql
psql -U postgres -d mago3d -a -f C:\git\repository\mago3d\mago3d-core\src\doc\ko\database\ddl\role.sql
psql -U postgres -d mago3d -a -f C:\git\repository\mago3d\mago3d-core\src\doc\ko\database\ddl\schedule.sql
:: psql -U postgres -d mago3d -a -f C:\git\repository\mago3d\mago3d-core\src\doc\ko\database\ddl\sso_log.sql
psql -U postgres -d mago3d -a -f C:\git\repository\mago3d\mago3d-core\src\doc\ko\database\ddl\user_info.sql
psql -U postgres -d mago3d -a -f C:\git\repository\mago3d\mago3d-core\src\doc\ko\database\ddl\widget.sql

psql -U postgres -d mago3d -a -f C:\git\repository\mago3d\mago3d-core\src\doc\ko\database\ddl\sequence\sequence.sql

psql -U postgres -d mago3d -a -f C:\git\repository\mago3d\mago3d-core\src\doc\ko\database\index\access_log.sql
psql -U postgres -d mago3d -a -f C:\git\repository\mago3d\mago3d-core\src\doc\ko\database\index\api_log.sql
psql -U postgres -d mago3d -a -f C:\git\repository\mago3d\mago3d-core\src\doc\ko\database\index\data_info_log.sql
:: psql -U postgres -d mago3d -a -f C:\git\repository\mago3d\mago3d-core\src\doc\ko\database\index\sso_log.sql

psql -U postgres -d mago3d -a -f C:\git\repository\mago3d\mago3d-core\src\doc\ko\database\trigger\access_log_trigger.sql
psql -U postgres -d mago3d -a -f C:\git\repository\mago3d\mago3d-core\src\doc\ko\database\trigger\api_log_trigger.sql
psql -U postgres -d mago3d -a -f C:\git\repository\mago3d\mago3d-core\src\doc\ko\database\trigger\data_info_log_trigger.sql
:: psql -U postgres -d mago3d -a -f C:\git\repository\mago3d\mago3d-core\src\doc\ko\database\trigger\sso_log_trigger.sql

psql -U postgres -d mago3d -a -f C:\git\repository\mago3d\mago3d-core\src\doc\ko\database\dml\insert.sql

echo .................. ddl init end ...................
echo ...................................................
pause
