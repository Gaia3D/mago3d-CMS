[![License](https://img.shields.io/badge/License-Apache%202.0-brightgreen.svg)](http://www.apache.org/licenses/LICENSE-2.0.html)
[![Korean](https://img.shields.io/badge/language-Korean-blue.svg)](#korean)
[![English](https://img.shields.io/badge/language-English-orange.svg)](#english)
[![Japan](https://img.shields.io/badge/language-Japan-red.svg)](#japan)
<a name="korean"></a>

# mago3D
mago3D는 AEC(Architecture, Engineering, Construction) 영역과 전통적인 3차원 공간정보(3D GIS)를 통합적으로 관리, 가시화해 주는 차세대 3차원 플랫폼입니다. mago3D는 기존의 솔루션과 달리 실내외 구별 없이 끊김 없이 AEC와 3D GIS를 웹 브라우저에서 통합해 줍니다. 이에 따라, mago3D 사용자는 초대용량 BIM(Building Information Modelling), JT(Jupiter Tessellation), 3D GIS 파일 등을 별도의 프로그램 설치 없이 웹 브라우저 상에서 바로 살펴보고 협업작업을 진행할 수 있습니다.

## Mission
mago3DJS 3차원 다중 블록 가시화를 위한 오픈소스 자바스크립트 라이브러리를 사용한 가시화 데이터를 통합 과제 & 이슈 관리를 할 수 있습니다.

## Features
- 이슈 현황 신규 이슈, 진행 중인 이슈, 완료된 이슈를 볼 수 있습니다.
- 사용자 상태별 현황을 그래프로 되어 있어 보기 편합니다.
- DB Connection Pool 현황이나 DV세션 현황을 테이블로 볼 수 있습니다.

## Development Environment
- Spring
- mybatis
- lombok
- PostgreSQL
- PostGIS
- Gradle


## Getting Started

### 1. Install
#### [java](http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html)
- java jdk-8u161 (8버전 설치)


#### [eclipse](https://www.eclipse.org/downloads/download.php?file=/oomph/epp/oxygen/R/eclipse-inst-win64.exe)
- eclipse Oxygen(neon버전 이상 설치)
- eclipse를 실행 후 Project Import <br>
  File → import → Gradle → Existing Gradle Project


#### [PostgreSQL](https://github.com/Gaia3D/mago3d/wiki/PostgreSQL-%EC%84%A4%EC%B9%98-%EA%B0%80%EC%9D%B4%EB%93%9C)
- PostgreSQL9.6.3 최신버전으로 설정
- 설치경로 C:/PostgreSQL <br>
  mago3d-core/src/doc/database/dbinit.bat 에서 설치 경로와 일치
  
  
#### [PostGIS](https://github.com/Gaia3D/mago3d/wiki/PostGIS-%EC%84%A4%EC%B9%98)
- PostGIS 최신 SQL 버전으로 설정
- 설치경로 C:/PostGIS


#### [gradle](https://gradle.org/docs/)
- 설치경로 C:/gradle
- 시스템 변수 추가 <br> 
  Path) C:\gradle\gradle-4.1 
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
	- download 한 소스의 /mago3d-core/src/doc/database 폴더로 이동합니다.
	- PostgreSQL에서 database 폴더에 있는 쿼리를 실행해 줍니다. (windows 자동 실행 script는 개발 중입니다.) <br>
	   - ddl 폴더의 sql 파일을 실행하여 table을 생성합니다. <br>
	     (table, table column comment 다국어 버전은 개발 중입니다.)
	   - ddl 폴더의 sequence sql 실행하여 sequence 생성합니다.<br>
	   - index, trigger 폴더의 sql을 실행하여 index 및 partition 생성합니다.<br>
	   - dml 폴더의 sql을 실행하여 초기 데이터 등록합니다.
	- dbinit.bat 파일을 실행하여 데이터를 초기화 합니다.<br>
	  ex) C:\git\repository\mago3d\mago3d-core\src\doc\database\dbinit.bat 실행


### 3. symbolic link

- 데이터 링크
	- F4D 파일을 서비스하기 위한 폴더를 지정합니다. <br>
	  ex) data 폴더 하위에 프로젝트 별로 디렉토리를 생성하여 관리 → <code>  C:\data\프로젝트명    </code>
	- mago3d-user 데이터를 저장하기 위한 심볼릭 링크(symbolic link)를 걸어줍니다.
	- 관리자 권한으로 Command Line Prompt(cmd.exe)를 실행
	- mago3d-user\src\main\webapp 디렉토리로 이동
	  <pre><code>C:\git\repository\mago3d\mago3d-user\src\main\webapp > mklink /d "C:\git\repository\mago3d\mago3d-user\src\main\webapp\data" "C:\data"</code></pre>


### 4. Execution
- mago3D-admin project spring boot 실행 <br>
  url : http://localhost(:port)/login/login.do
<pre><code>/mago3D-admin/src/main/java/com/gaia3d/mago3DAdminApplication.java</code></pre>

- mago3D-user project spring boot 실행 <br>
  url : http://localhost/homepage/demo.do
<pre><code>/mago3D-user/src/main/java/com/gaia3d/mago3DUserApplication.java</code></pre>


## github
- [mago3DJs](https://github.com/Gaia3D/mago3djs) 깃허브 사이트 입니다
- [F4DConverter](https://github.com/Gaia3D/F4DConverter) 깃허브 사이트 입니다.


## License
[Apache License Version 2.0](http://www.apache.org/licenses/LICENSE-2.0.html).


<br><br>
-----
<br><br>


###### Using Google Translator
# <a name="english"></a>mago3D
mago3D is a next-generation 3D platform that integrates and visualizes AEC (Architecture, Engineering, Construction) areas and traditional 3D spatial information (3D GIS). mago3D seamlessly integrates AEC and 3D GIS in a web browser, indistinguishable from existing solutions. As a result, mago3D users can quickly view and collaborate on large capacity building information modeling (BIM), JT (Jupiter Tessellation) and 3D GIS files without installing any additional programs.


## Mission
mago3DJS Integrate visualization data with open source JavaScript library for 3-D multi-block visualization.


## Features
- Issue Status You can see new issue, ongoing issue, and finished issue.
- It is easy to view the status by user status graph.
- DB Connection Pool status or DV session status can be viewed as a table.


## Development Environment
- Spring
- mybatis
- lombok
- PostgreSQL
- PostGIS
- Gradle


## Getting Started

### 1. Install
#### [java](http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html)
- java jdk-8u161 (8 version installed)


#### [eclipse](https://www.eclipse.org/downloads/download.php?file=/oomph/epp/oxygen/R/eclipse-inst-win64.exe)
- eclipse Oxygen (neon version or higher installed)
- After running eclipse Project Import <br>
  File → import → Gradle → Existing Gradle Project


#### [PostgreSQL](https://github.com/Gaia3D/mago3d/wiki/PostgreSQL-%EC%84%A4%EC%B9%98-%EA%B0%80%EC%9D%B4%%EB93%9C)
- Set PostgreSQL9.6.3 to the latest version
- Installation path C:/PostgreSQL <br>
  mago3d-core/src/doc/database/dbinit.bat 에서 설치 경로와 일치

#### [PostGIS](https://github.com/Gaia3D/mago3d/wiki/PostGIS-%EC%84%A4%EC%B9%98)
- Set to latest SQL version of PostGIS
- Installation path C:/PostGIS


#### [gradle](https://gradle.org/docs/)
- Installation path C:/gradle
- Add System Variable <br>
  Path) C:\grade\grade-4.1
- You can use gradle with eclipse BuildShip Gradle Plugin.


#### [lombok](https://projectlombok.org/)
- After installation, move the download folder and execute it.
- Locate the eclipse installation location [Specify location ..] and select the file 'eclipse.exe'.
- Click on install/update.

  
### 2. DB creation & initial data registration

- Database & Extensions
	- Create the mago3d database.
	  Set the database as follows for sorting.
	  <pre><code>Name:mago3d, Encoding:UTF-8, Template:template0, Collation:C, Character type:C, Connection Limit:-1</code></pre
	- Run Extensions from psql(SQL Shell) or pgAdmin.
	  <pre><code> CREATE EXTENSION postgis </code></pre>
	  When PosGIS Extensions is successfully completed, a table called spatial_ref_sys is automatically created after creating the database and registering the initial data.


- Data registration
	- Go to the /mago3d-core/src/doc/database folder of the downloaded source.
	- PostgreSQL will execute the query in the database folder. (Windows autorun script is under development.) <br>
	- Run the sql file in the ddl folder to create the table. <br>
	  (A multilanguage version of table, table column comment is under development.)
	- Generate sequence by executing sequence sql in ddl folder <br>
	- Execute sql of index, trigger folder to create index and partition. <br>
	- Register the initial data by running sql in the dml folder.
	- Run the dbinit.bat file to initialize the data. <br>
	  ex) C:\git\repository\mago3d\mago3d-core\src\doc\database\dbinit.bat


### 3. symbolic link

- Data link
	- F4D Specify the folder to serve the file. <br>
	  ex) Create and manage a project-specific directory under the data folder → <code>C:\data\project name</code>
	- mago3d-user Makes a symbolic link for storing data.
	- Execute Command Line Prompt (cmd.exe) with administrative privileges
	- Go to mago3d-user\src\main\webapp directory
	  <pre><code>C:\git\repository\mago3d\mago3d-user\src\main\webapp > mklink /d "C:\git\repository\mago3d\mago3d-user\src\main\webapp\data" "C:\data"</code></pre>


### 4. Execution
- run mago3D-admin project spring boot <br>
  url: http://localhost(:port)/login/login.do
<pre><code>/mago3D-admin/src/main/java/com/gaia3d/mago3DAdminApplication.java</code></pre>

- run mago3D-user project spring boot <br>
  url: http://localhost/homepage/demo.do
<pre><code>/mago3D-user/src/main/java/com/gaia3d/mago3DUserApplication.java</code></pre>


## github
- [mago3DJs](https://github.com/Gaia3D/mago3djs) is a feather hub site
- [F4DConverter](https://github.com/Gaia3D/F4DConverter) This is the hub site.


## License
[Apache License Version 2.0](http://www.apache.org/licenses/LICENSE-2.0.html).



<br><br>
-----
<br><br>



###### Googleの翻訳を使用して
# <a name="japan"></a>mago3D
mago3DはAEC（Architecture、Engineering、Construction）領域と、伝統的な3次元空間情報（3D GIS）を統合的に管理、可視化してくれる次世代3次元のプラットフォームです。 mago3Dは、従来のソリューションとは異なり、室内外の区別なくシームレスにAECと3D GISをWebブラウザに統合されています。これにより、mago3Dユーザーは超大容量BIM（Building Information Modelling）、JT（Jupiter Tessellation）、3D GISファイルなどを、別のプログラムをインストールすることなく、Webブラウザ上ですぐに見てコラボレーションを行うことができます。

## Mission
mago3DJS 3次元マルチブロック可視化のためのオープンソースのJavaScriptライブラリを使用した可視化データを統合課題及び問題管理をすることができます。

## Features
- 問題の現状新規問題、進行中の問題、終了した問題を見ることができます。
- ユーザーの状態別状況をグラフになっており表示楽です。
- DB Connection Pool現況やDVセッションのステータスをテーブルに見ることができます。

## Development Environment
- Spring
- mybatis
- lombok
- PostgreSQL
- PostGIS
- Gradle


## Getting Started

### 1. Install
#### [java](http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html)
- java jdk-8u161（8バージョンのインストール）


#### [eclipse](https://www.eclipse.org/downloads/download.php?file=/oomph/epp/oxygen/R/eclipse-inst-win64.exe)
- eclipse Oxygen（neon以降のインストール）
- eclipseを実行した後Project Import <br>
  File → import → Gradle → Existing Gradle Project


#### [PostgreSQL](https://github.com/Gaia3D/mago3d/wiki/PostgreSQL-%EC%84%A4%EC%B9%98-%EA%B0%80%EC%9D%B4%EB％93％9C)
- PostgreSQL9.6.3最新のバージョンに設定
- インストールパスは C:/PostgreSQL <br>
  mago3d-core/src/doc/database/dbinit.bat でインストールパスと一致

#### [PostGIS](https://github.com/Gaia3D/mago3d/wiki/PostGIS-%EC%84%A4%EC%B9%98) 
- PostGIS最新のSQLバージョンに設定
- インストールパスは C:/PostGIS


#### [gradle](https://gradle.org/docs)
- インストールパスはC：/ gradle
- システム変数の追加 <br>
  Path) C:\gradle\gradle-4.1
- eclipse BuildShip Gradle Pluginを利用して、gradleを使用することができます。


#### [lombok](https://projectlombok.org/)
- インストールした後にダウンロードフォルダの移動後に実行
- eclipse設置位置[Specify location ..]を検索して「eclipse.exe」ファイルを選択します。
- install/update クリックします。

  
### 2. DBの作成と初期データの登録

- Database＆Extensions
	- mago3dデータベースを作成します。
	    ハングルのソートのためにデータベースを次のように設定します。
	  <pre><code>Name：mago3d、Encoding：UTF-8、Template：template0、Collat​​ion：C、Character type：C、Connection Limit：-1</code></pre>
	- psql(SQL Shell)でのpgAdminの拡張機能の実行。
	  <pre><code> CREATE EXTENSION postgis </code></pre>
	  PosGIS Extensionsが正常に完了したら、データベースの作成と初期データより登録後spatial_ref_sysというテーブルが自動的に作成されます。


- データの登録
	- downloadしたソースの/mago3d-core/src/doc/databaseフォルダに移動します。
	- PostgreSQLでdatabaseフォルダにあるクエリを実行してくれます。 (windows自動実行scriptは開発中です。) <br>
	- ddlフォルダのsqlファイルを実行してtableを生成します。 <br>
	  （table、table column comment多言語バージョンは開発中です。）
	- ddlフォルダのsequence sql実行してsequence生成します。<br>
	- index、triggerフォルダのsqlを実行して、indexとpartition生成します。<br>
	- dmlフォルダのsqlを実行して、初期データ登録します。
	- dbinit.batファイルを実行して、データを初期化します。<br>
	  ex) C:\git\repository\mago3d\mago3d-core\src\doc\database\dbinit.bat 実行


### 3. symbolic link

- データリンク
	- F4D ファイルをサービスするためのフォルダを指定します。 <br>
	  ex）dataフォルダサブプロジェクトごとにディレクトリを作成して管理  → <code>C:\data\プロジェクト名</code>
	- mago3d-userデータを格納するためのシンボリックリンク（symbolic link）をかけます。
	- 管理者権限でCommand Line Prompt(cmd.exe)を実行
	- mago3d-user\src\main\webapp ディレクトリに移動
	  <pre><code>C:\git\repository\mago3d\mago3d-user\src\main\webapp> mklink /d "C:\git\repository\mago3d\mago3d-user\src\main\webapp\data" "C:\data"</code></pre>


### 4. Execution
- mago3D-admin project spring boot 実行 <br>
  url: http://localhost(:port)/login/login.do
<pre><code>/mago3D-admin/src/main/java/com/gaia3d/mago3DAdminApplication.java</code></pre>

- mago3D-user project spring boot 実行 <br>
  url: http://localhost/homepage/demo.do
<pre><code>/mago3D-user/src/main/java/com/gaia3d/mago3DUserApplication.java</code></pre>



## github
- [mago3DJs](https://github.com/Gaia3D/mago3djs)襟ハブサイトです
- [F4DConverter](https://github.com/Gaia3D/F4DConverter)襟ハブサイトです。


## License
[Apache License Version 2.0](http://www.apache.org/licenses/LICENSE-2.0.html)。



<br><br>
