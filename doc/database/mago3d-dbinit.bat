:::::::::::::::::::::::::::: :::::::::::
:: 실행 화면의 인코딩이 깨져 보이더라도 값은 제대로 들어감 ::
::::::::::::::::::::::::::::::::::::::::

@echo off
echo .................. ddl mago3d init start .................
echo ...................................................

set PGCLIENTENCODING=UTF-8

set CUR_PATH=%~dp0

cd C:\Program Files\PostgreSQL\12.2\bin\

psql -U postgres -d mago3d -a -f D:\GIT\mago3d-cms\doc\database\ddl\access_log.sql
psql -U postgres -d mago3d -a -f D:\GIT\mago3d-cms\doc\database\ddl\civil_voice.sql
psql -U postgres -d mago3d -a -f D:\GIT\mago3d-cms\doc\database\ddl\constraint
psql -U postgres -d mago3d -a -f D:\GIT\mago3d-cms\doc\database\ddl\converter.sql
psql -U postgres -d mago3d -a -f D:\GIT\mago3d-cms\doc\database\ddl\dataInfo.sql
psql -U postgres -d mago3d -a -f D:\GIT\mago3d-cms\doc\database\ddl\dataInfo_log.sql
psql -U postgres -d mago3d -a -f D:\GIT\mago3d-cms\doc\database\ddl\dataInfo_origin.sql
psql -U postgres -d mago3d -a -f D:\GIT\mago3d-cms\doc\database\ddl\data_adjust_log.sql
psql -U postgres -d mago3d -a -f D:\GIT\mago3d-cms\doc\database\ddl\data_attribute.sql
psql -U postgres -d mago3d -a -f D:\GIT\mago3d-cms\doc\database\ddl\data_attribute_file_info.sql
psql -U postgres -d mago3d -a -f D:\GIT\mago3d-cms\doc\database\ddl\data_file_info.sql
psql -U postgres -d mago3d -a -f D:\GIT\mago3d-cms\doc\database\ddl\data_smart_tiling_file_info.sql
psql -U postgres -d mago3d -a -f D:\GIT\mago3d-cms\doc\database\ddl\geopolicy.sql
psql -U postgres -d mago3d -a -f D:\GIT\mago3d-cms\doc\database\ddl\issue.sql
psql -U postgres -d mago3d -a -f D:\GIT\mago3d-cms\doc\database\ddl\layer.sql
psql -U postgres -d mago3d -a -f D:\GIT\mago3d-cms\doc\database\ddl\menu.sql
psql -U postgres -d mago3d -a -f D:\GIT\mago3d-cms\doc\database\ddl\policy.sql
psql -U postgres -d mago3d -a -f D:\GIT\mago3d-cms\doc\database\ddl\role.sql
psql -U postgres -d mago3d -a -f D:\GIT\mago3d-cms\doc\database\ddl\sequence
psql -U postgres -d mago3d -a -f D:\GIT\mago3d-cms\doc\database\ddl\upload_data.sql
psql -U postgres -d mago3d -a -f D:\GIT\mago3d-cms\doc\database\ddl\user_info.sql
psql -U postgres -d mago3d -a -f D:\GIT\mago3d-cms\doc\database\ddl\user_policy.sql
psql -U postgres -d mago3d -a -f D:\GIT\mago3d-cms\doc\database\ddl\widget.sql
											  
psql -U postgres -d mago3d -a -f D:\GIT\mago3d-cms\doc\database\ddl\sequence\sequence.sql
											  
psql -U postgres -d mago3d -a -f D:\GIT\mago3d-cms\doc\database\dml\insert.sql

echo .................. ddl mago3d init end ...................
echo ...................................................
pause
