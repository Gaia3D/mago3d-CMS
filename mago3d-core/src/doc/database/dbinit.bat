:: psql -U postgres -d mago3d -a -f script.sql

@echo off
echo .................. ddl init start .................
echo ...................................................

cd C:\PostgreSQL\9.6\bin\

psql -U postgres -d mago3d -a -f C:\git\repository\mago3d\mago3d-core\src\doc\database\ddl\access_log.sql
psql -U postgres -d mago3d -a -f C:\git\repository\mago3d\mago3d-core\src\doc\database\ddl\api.sql
psql -U postgres -d mago3d -a -f C:\git\repository\mago3d\mago3d-core\src\doc\database\ddl\common_code.sql
psql -U postgres -d mago3d -a -f C:\git\repository\mago3d\mago3d-core\src\doc\database\ddl\datainfo.sql
psql -U postgres -d mago3d -a -f C:\git\repository\mago3d\mago3d-core\src\doc\database\ddl\file_info.sql
psql -U postgres -d mago3d -a -f C:\git\repository\mago3d\mago3d-core\src\doc\database\ddl\issue.sql
psql -U postgres -d mago3d -a -f C:\git\repository\mago3d\mago3d-core\src\doc\database\ddl\menu.sql
psql -U postgres -d mago3d -a -f C:\git\repository\mago3d\mago3d-core\src\doc\database\ddl\policy.sql
psql -U postgres -d mago3d -a -f C:\git\repository\mago3d\mago3d-core\src\doc\database\ddl\role.sql
psql -U postgres -d mago3d -a -f C:\git\repository\mago3d\mago3d-core\src\doc\database\ddl\schedule.sql
psql -U postgres -d mago3d -a -f C:\git\repository\mago3d\mago3d-core\src\doc\database\ddl\sso_log.sql
psql -U postgres -d mago3d -a -f C:\git\repository\mago3d\mago3d-core\src\doc\database\ddl\user_info.sql
psql -U postgres -d mago3d -a -f C:\git\repository\mago3d\mago3d-core\src\doc\database\ddl\widget.sql


echo .................. ddl init end ...................
echo ...................................................
pause
