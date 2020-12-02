# mago3D
<strong>mago3D 는 Digital Twin Platform 입니다.</strong>

[설치 및 교육 상세 자료](https://gaia3d.atlassian.net/wiki/spaces/education/pages/71892997/mago3D)

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
- Spring Boot 2.3.0
- PostgreSQL 12
- PostGIS 3.0
- Gradle 6.5.0
- Mybatis
- Lombok
- Thymeleaf
- F4d Converter
- Geoserver 2.17.x
- RabbitMQ 3.8.x
- Gdal 3.x

## Project Composition
- mago3d-admin : 플랫폼(mago3D) 관리자     
- mago3d-converter : 3차원 공간정보 자동화 관리
- mago3d-user : 2차원/3차원  공간데이터 조회, 시뮬레이션 연동 등
- common : 암호화(보안), 통계모듈 등 공통 기능 관리
- doc : database schema, 개발 문서
- html : html 디자인 파일 (npm init으로 생성)

## Getting Started

## 1. Install
### 1.1 공통
#### [java](https://jdk.java.net/archive/)
- OpenJDK 11.0.2 (build 11.0.2+9) : 11버전 설치

#### [GDAL](https://trac.osgeo.org/osgeo4w/)
- GDAL을 설치하기 위해서 OSGeo4W(FOSSGIS for Windows)를 설치
- 시스템 변수 추가 <br>
  Path) C:\OSGeo4W64\bin 
  
#### [F4D Converter](https://github.com/Gaia3D/F4DConverter/blob/master/install/SetupF4DConverter.msi)
- 설치경로 : C:\F4DConverterConsole
- 내려 받은 파일을 실행하여, Converter 를 설치합니다.
 
### 1.2 docker 환경
- docker-compose 를 사용하기 위해서는 사전에 docker 가 설치되어 있어야 합니다.
- checkout 받은 프로젝트의 root 경로에서 아래의 명령어를 실행합니다. 
~~~ cmd
    docker-compose up -d
~~~
- docker-compose 파일에 정의된 내용에 따라 database, geoserver, rabbitmq 가 container 로 생성됩니다. 

### 1.3 일반 환경 
- 1.2 의 docker 환경에서 docker-compose 로 개발환경을 구성하였다면 1.3 과정은 생략해도 됩니다. 

#### [PostgreSQL](https://www.enterprisedb.com/downloads/postgres-postgresql-downloads)
- PostgreSQL12 버전으로 설정
- 설치경로 C:/PostgreSQL/12 <br>
  doc/database/doc/database/ 참조 
- [PostGIS](https://postgis.net/) 최신 SQL 버전으로 설정

#### [Erlang](https://www.erlang.org/downloads)
- rabbit mq 를 설치하기 위해서는 erlang 이 필요하기 때문에 먼저 erlang를 설치하도록 합니다.
- Download OTP 23.1 항목에서 ‘OTP 23.1 Windows 64-bit Binary File’을 클릭하여 파일을 내려 받고 실행합니다.
- 구성요소 설정은 기본값으로 할 것이므로 next를 클릭하여 설치 합니다.
- **Visual C++ 구성요소 설치 창이 뜰 경우 체크박스를 체크하고 설치합니다.**

#### [RabbitMQ](https://www.rabbitmq.com/download.html)
- 최신 버전을 확인하고 운영체제 환경에 맞춰 설치 파일을 내려 받고 설치 합니다.
    - 환경변수 설정
        - [제어판] → [시스템 및 보안] → [시스템] 또는 [내 PC]의 [속성]을 클릭 한 후, [고급 시스템 설정]을 클릭합니다.
        - [시스템 속성]의 [고급]탭 화면에서 [환경 변수]를 클릭합니다.
        - [환경변수] 화면에서 [새로 만들기]를 클릭하여, 변수 이름과 변수 값 입력란에 RABBITMQ_HOME과 RabbitMQ 설치 경로를 설정합니다.
        - RabbitMQ 설치 경로를 설정 한 후, 시스템 변수의 [Path] 변수를 선택하고 [편집] 버튼을 클릭합니다.
        - [새로 만들기] 버튼을 클릭하여, %RABBITMQ_HOME%\sbin 을 입력합니다.
    - 관리자 플러그인 활성화
        - 관리자 페이지에 접속하기 위해서는 management plugin 이 활성화 되어야 합니다. (비활성화 시 접속 불가)
        - RabbitMQ의 management plugin 을 활성화하기 위해 명령 프롬프트 창에 ‘rabbitmq-plugins enable rabbitmq_management’라고 입력하여 활성화 합니다.
        - 명령 프롬프트를 재시작하고, ‘rabbitmq-plugins list’로 플러그인의 활성화 여부를 확인합니다.
    - 관리자 설정
        - RabbitMQ 관리자 페이지(http://localhost:15672)에 접속합니다.
        - 아이디와 비밀번호는 모두 guest 로 로그인 합니다.
        - 상단에 Exchange 탭을 클릭하고, 하단에 Add a new exchanges 를 클릭하여 아래와 같이 입력한 뒤, Add exchange 버튼을 클릭합니다. 
            - Name : f4d.converter
            - Type : topic
            - Durability : Durable
        - 상단에 Queues 탭을 글릭하고, 하단에 Add a new queue 를 클릭하여 아래와 같이 입력한 뒤, Add queue 버튼을 클릭합니다.
            - Type : Classic
            - Name : f4d.converter.queue
            - Durability : Durable
        - 다른 관리자 계정을 생성하기 위해 Admin 메뉴 하단의 Add a user를 클릭하고 아래와 같이 입력하여 관리자 계정을 생성합니다.
            - Username : mago3d
            - Password : mago3d
            - Tags : administrator
        - guest 아래에 새로 생성된 mago3d 계정을 클릭하고, 아래와 같이 Current permissions, Current topic permissions 을 생성하고 Update this user 에 비밀번호(mago3d)를 입력한 뒤, 하단의 Update user 버튼을 클릭합니다.
            - Current permission
                - Virtual Host : /
                - Configure regexp : .*
                - Write regexp : .*
                - Read regexp : .*
            - Topic permission
                - Virtual Host : /
                - Exchange : f4d.converter
                - Write regexp : .*
                - Read regexp : .*
                
#### IDE 설정 
#### [eclipse](https://www.eclipse.org/downloads/download.php?file=/oomph/epp/2019-12/R/eclipse-inst-win64.exe)
- Eclipse IDE 2019-12 (2019-12(4.14.0) 버전 이상 설치)<br>
- Eclipse 설정 - STS(Spring Tools) 설정 <br>
  Help → Eclipse Marketplace → 'STS' 검색후, Spring Tools 4 설치
- Eclipse를 실행 후 Project Import <br>
  File → import → Gradle → Existing Gradle Project
  
#### intellij
- 로컬 개발환경에서 static resource 들을 build 없이 갱신하기 위하여 resource 경로를 file path 로 잡아 주는데, mago3d 의 실행을 bootRun 으로 실행하거나
configuration 에 Working directory 를 **$MODULE_WORKING_DIR$** 로 설정해 주어야 합니다.


#### [lombok](https://projectlombok.org/)
- eclipse 를 사용한다면 아래의 과정을 통해 lombok 을 설치해 주어야 합니다.
- 다운로드 폴더 이동 후 실행
- eclipse 설치 위치 [Specify location..]를 검색해서 'eclipse.exe' 파일을 선택합니다.
- install/update 클릭합니다.



## 2. DB 생성 및 초기 데이터 등록
- 1.2 의 docker 환경에서 docker-compose 로 개발환경을 구성하였다면 해당 과정은 생략해도 됩니다.
- Database & Extensions
	- mago3d 데이터베이스를 생성합니다. 한글 정렬을 위해 데이터베이스를 다음과 같이 설정합니다.
	~~~ sql
        CREATE DATABASE mago3d
        WITH OWNER = postgres
        	ENCODING = 'UTF8'
        	TEMPLATE = template0
        	TABLESPACE = pg_default
        	LC_COLLATE = 'C'
        	LC_CTYPE = 'C'
        	CONNECTION LIMIT = -1; 
    ~~~
	- psql(SQL Shell) 혹은 pgAdmin에서 Extensions 를 실행합니다.
	~~~ sql
        CREATE EXTENSION postgis
    ~~~
- sql 실행
    - doc/database 경로에 있는 ddl/dml/index 폴더의 sql 들을 실행해 줍니다.

	   
## 3. Execution
- mago3d-admin project spring boot 실행 <br>
  url : http://localhost(:port)/
<pre><code>/mago3d-admin/src/main/java/gaia3d/Mago3DAdminApplication.java</code></pre>

## License
[Apache License Version 2.0](http://www.apache.org/licenses/LICENSE-2.0.html).