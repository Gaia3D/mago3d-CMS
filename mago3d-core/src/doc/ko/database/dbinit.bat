@echo off
echo .................. ddl init start .................
echo ...................................................
SET CUR_PATH=%~dp0

cd C:\PostgreSQL\9.6\bin\

for /f %%f in ('dir /b %CUR_PATH%ddl\*.sql') do psql -U postgres -d mago3d -a -f %CUR_PATH%ddl\%%f

for /f %%f in ('dir /b %CUR_PATH%ddl\sequence\*.sql') do psql -U postgres -d mago3d -a -f %CUR_PATH%ddl\sequence\%%f

for /f %%f in ('dir /b %CUR_PATH%index\*.sql') do psql -U postgres -d mago3d -a -f %CUR_PATH%index\%%f

for /f %%f in ('dir /b %CUR_PATH%trigger\*.sql') do psql -U postgres -d mago3d -a -f %CUR_PATH%trigger\%%f

for /f %%f in ('dir /b %CUR_PATH%dml\*.sql') do psql -U postgres -d mago3d -a -f %CUR_PATH%dml\%%f

echo .................. ddl init end ...................
echo ...................................................