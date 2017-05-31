# Mago3D

통합 관제 & 이슈 관리 시스템

2 개발환경 springboot, gradle, mybatis, docker 등
 springboot, gradle, mybatis, docker 등

1) postgresq9.6.3 설치
 - homepage 참조
2) PostGIS 2.3.2 설치
 - postgresql이 설치 되어 있어야 함
 http://www.postgis.net/windows_downloads/
 http://download.osgeo.org/postgis/windows/pg96/
 
 
 tar xvzf postgis-2.3.2.tar.gz 
 cd postgis-2.3.2 
 ./configure 
 make 
 make install
 
 
CREATE EXTENSION postgis;
CREATE EXTENSION address_standardizer;
CREATE EXTENSION fuzzystrmatch;
CREATE EXTENSION postgis_topology;
CREATE EXTENSION postgis_tiger_geocoder;

CREATE EXTENSION pgrouting;

CREATE EXTENSION postgis_sfcgal;
ALTER DATABASE your_db_here SET postgis.backend = sfcgal;
 
 
 