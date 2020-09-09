# mago3D
<strong>mago3D 는 Digital Twin Platform 입니다.</strong>
설치 및 교육에 대한 최신 내용은 아래 링크에서 확인 하실 수 있습니다.<br>
https://gaia3d.atlassian.net/wiki/spaces/education/pages/71892997/mago3D

## Features
- 2차원 공간정보 관리 기능
- 3차원 데이터 포맷 지원 기능
- 3차원 데이터 관리기능
- 자동화된 2차원/3차원 공간정보 관리 기능
- 3차원 가시화 기능
- 3차원 데이터 운영 기능
- 시뮬레이션 서비스 연동

## Development Environment
- JAVA(OpenJDK) 11.0.2
- Spring Boot 2.2.1
- PostgreSQL 11.6
- PostGIS 3.0
- Gradle 5.6.3
- mybatis
- lombok

## Project Composition
- mago3d-admin : 플랫폼(mago3D) 관리자     
- mago3d-converter : 3차원 공간정보 자동화 관리
- mago3d-user : 2차원/3차원  공간데이터 조회, 시뮬레이션 연동 등
- common : 암호화(보안), 통계모듈 등 공통 기능 관리
- doc : database schema, 개발 문서
- html : html 디자인 파일 (npm init으로 생성)

## Getting Started

### 1. Install
#### [java](https://jdk.java.net/archive/)
- OpenJDK 11.0.2 (build 11.0.2+9) : 11버전 설치

#### [eclipse](https://www.eclipse.org/downloads/download.php?file=/oomph/epp/2019-12/R/eclipse-inst-win64.exe)
- Eclipse IDE 2019-12 (2019-12(4.14.0) 버전 이상 설치)<br>
- Eclipse 설정 - STS(Spring Tools) 설정 <br>
  Help → Eclipse Marketplace → 'STS' 검색후, Spring Tools 4 설치
- Eclipse를 실행 후 Project Import <br>
  File → import → Gradle → Existing Gradle Project

#### [PostgreSQL](https://www.enterprisedb.com/downloads/postgres-postgresql-downloads)
- PostgreSQL11.6 버전으로 설정
- 설치경로 C:/PostgreSQL/11 <br>
  doc/database/doc/database/ 참조 
- [PostGIS](https://postgis.net/) 최신 SQL 버전으로 설정
- 설치경로 C:/PostGIS

#### [GDAL](https://trac.osgeo.org/osgeo4w/)
- GDAL을 설치하기 위해서 OSGeo4W(FOSSGIS for Windows)를 설치
- 시스템 변수 추가 <br>
  Path) C:\OSGeo4W64\bin 

#### [gradle](https://gradle.org/docs/)
- 설치경로 C:/gradle
- 시스템 변수 추가 <br> 
  Path) C:\gradle\gradle-5.6.3 
- eclipse BuildShip Gradle Plugin을 이용하여 gradle을 사용할 수 있습니다.

#### [lombok](https://projectlombok.org/)
- 설치한 뒤에 다운로드 폴더 이동 후 실행
- eclipse 설치 위치 [Specify location..]를 검색해서 'eclipse.exe' 파일을 선택합니다.
- install/update 클릭합니다.

  
### 2. DB 생성 및 초기 데이터 등록
- Database & Extensions
	- mago3d 데이터베이스를 생성합니다.
	    한글 정렬을 위해 데이터베이스를 다음과 같이 설정합니다.
	  <pre><code>Name:mago3d, Encoding:UTF-8, Template:template0, Collation:C, Character type:C, Connection Limit:-1</code></pre>
	- psql(SQL Shell) 혹은 pgAdmin에서 Extensions를 실행합니다.
	  <pre><code>CREATE EXTENSION postgis</code></pre>
	  PosGIS Extensions이 성공적으로 끝나면 데이터베이스 생성 및 초기 데이더 등록 후 spatial_ref_sys라는 테이블이 자동 생성됩니다.

- 데이터 등록
	   
### 3. Execution
- mago3d-admin project spring boot 실행 <br>
  url : http://localhost(:port)/
<pre><code>/mago3d-admin/src/main/java/gaia3d/Mago3DAdminApplication.java</code></pre>

## License

<br><br>