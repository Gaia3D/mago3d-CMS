:: If you create a sql file with UTF-8, you will be forced to use MS949 only because it is corrupted.
:: I did not know what encoding to use in foreign countries, so I decided to use UTF-8.

:: psql -U postgres -d mago3d -a -f script.sql

@echo off
echo .................. ddl init start .................
echo ...................................................
SET CUR_PATH=%~dp0

cd C:\PostgreSQL\9.6\bin\

psql -U postgres -d mago3d -a -f %CUR_PATH%ddl\access_log.sql
psql -U postgres -d mago3d -a -f %CUR_PATH%ddl\api.sql
psql -U postgres -d mago3d -a -f %CUR_PATH%ddl\board.sql
psql -U postgres -d mago3d -a -f %CUR_PATH%ddl\common_code.sql
psql -U postgres -d mago3d -a -f %CUR_PATH%ddl\dataInfo_attribute.sql
psql -U postgres -d mago3d -a -f %CUR_PATH%ddl\datainfo.sql
psql -U postgres -d mago3d -a -f %CUR_PATH%ddl\datainfo_log.sql
psql -U postgres -d mago3d -a -f %CUR_PATH%ddl\file_info.sql
psql -U postgres -d mago3d -a -f %CUR_PATH%ddl\issue.sql
psql -U postgres -d mago3d -a -f %CUR_PATH%ddl\menu.sql
psql -U postgres -d mago3d -a -f %CUR_PATH%ddl\policy.sql
psql -U postgres -d mago3d -a -f %CUR_PATH%ddl\role.sql
psql -U postgres -d mago3d -a -f %CUR_PATH%ddl\schedule.sql
:: psql -U postgres -d mago3d -a -f %CUR_PATH%ddl\sso_log.sql
psql -U postgres -d mago3d -a -f %CUR_PATH%ddl\user_info.sql
psql -U postgres -d mago3d -a -f %CUR_PATH%ddl\widget.sql

psql -U postgres -d mago3d -a -f %CUR_PATH%ddl\sequence\sequence.sql

psql -U postgres -d mago3d -a -f %CUR_PATH%index\access_log.sql
psql -U postgres -d mago3d -a -f %CUR_PATH%index\api_log.sql
psql -U postgres -d mago3d -a -f %CUR_PATH%index\data_info_log.sql
:: psql -U postgres -d mago3d -a -f %CUR_PATH%index\sso_log.sql

psql -U postgres -d mago3d -a -f %CUR_PATH%trigger\access_log_trigger.sql
psql -U postgres -d mago3d -a -f %CUR_PATH%trigger\api_log_trigger.sql
psql -U postgres -d mago3d -a -f %CUR_PATH%trigger\data_info_log_trigger.sql
:: psql -U postgres -d mago3d -a -f %CUR_PATH%trigger\sso_log_trigger.sql

psql -U postgres -d mago3d -a -f %CUR_PATH%dml\insert.sql

echo .................. ddl init end ...................
echo ...................................................
pause
