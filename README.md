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

###  Install
- [java](http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html)
  - java jdk-8u161-windows-x64.exe를 설치합니다.


- [eclipse Oxygen](https://www.eclipse.org/downloads/download.php?file=/oomph/epp/oxygen/R/eclipse-inst-win64.exe)
  - eclipse neon버전 이상을 설치합니다.
  - eclipse를 실행 후 Project Import <br>
    File -> import -> Gradle -> Existing Gradle Project


- [PostgreSQL 9.6.3-1](https://github.com/Gaia3D/mago3d/wiki/PostgreSQL-%EC%84%A4%EC%B9%98-%EA%B0%80%EC%9D%B4%EB%93%9C)
  - 설치경로 C:/PostgreSQL
  	-다른 경로로 지정하고 싶다면, mago3d-core/src/doc/database/dbinit.bat 에서 PostgreSQL 경로를 설치한 경로와 일치하게 지정해 줍니다. 
  	
  - DB Table 생성 및 초기 데이터 등록
	- windows 자동 실행 script는 개발 중입니다.
	- 데이터베이스를 생성합니다.<br>
	  (Name:mago3d, Encoding:UTF-8, Template:template0, Collation:C, Character type:C, Connection Limit:-1)
	- download 한 소스의 /mago3d-core/src/doc/database 폴더로 이동합니다.
	- PostgreSQL에서 database 폴더에 있는 쿼리를 실행해 줍니다.<br>
	  ddl 폴더의 sql 파일을 실행하여 table을 생성합니다.<br>
	  (table, table column comment 다국어 버전은 개발 중입니다.)<br>
	  ddl 폴더의 sequence sql 실행하여 sequence 생성합니다.<br>
	  index, trigger 폴더의 sql을 실행하여 index 및 partition 생성합니다.<br>
	  dml 폴더의 sql을 실행하여 초기 데이터 등록합니다.
	- dbinit.bat 파일을 실행하여 데이터를 초기화 합니다.
	  (파일 경로 예시: C:\git\repository\mago3d\mago3d-core\src\doc\database)
	i
  - 데이터 링크
	- root folder인 data 폴더 아래 프로젝트 별로 디렉토리를 생성하여 관리합니다.<br>
	  <code>C:\data\프로젝트명 </code>
	- mago3d-user에서 변환된 데이터를 저장하기 위해  D드라이브에 mago3d\data 폴더 생성한 후 링크를 걸어줍니다.
	- C:\git\repository\mago3d\mago3d-user\src\main\webapp으로 이동
	  <code>mklink /d "C:\git\repository\mago3d\mago3d-user\src\main\webapp\data" "C:\data"</code>
	
	
- [PostGIS 2.3.2](https://github.com/Gaia3D/mago3d/wiki/PostGIS-%EC%84%A4%EC%B9%98)
  - 설치경로 C:/PostGIS<br>
  - PostgreSQL에서 Extensions를 실시 <br>
    <code>CREATE EXTENSION postgis</code>
  - PosGIS Extensions이 성공적으로 끝나면 spatial_ref_sys라는 테이블이 자동 생성됩니다



- [gradle 4.1](https://gradle.org/docs/
  - 설치경로 C:/gradl
  - 시스템 변수 추가 -path -> C:\gradle\gradle-4.1 추
  - eclipse BuildShip Gradle Plugin을 사용하여 build합니다.

- [lombok](https://projectlombok.org/
  - 설치한 뒤에 다운로드 폴더 이동 후 실
  - eclipse 설치 위치 [Specify location..]를 검색해서 'eclipse.exe' 파일을 선택합니다
  - install/update 클릭합니다.

### Execution
- mago3D-admin project spring boot 실행
<pre><code>/mago3D-admin/src/main/java/com/gaia3d/mago3DAdminApplication.java</code></pre>
- mago3D-user project spring boot 실행 <br>
<pre><code>/mago3D-user/src/main/java/com/gaia3d/mago3DUserApplication.java</code></pre>>

## github
- [mago3DJs](https://github.com/Gaia3D/mago3djs) 깃허브 사이트 입니다
- [F4DConverter](https://github.com/Gaia3D/F4DConverter) 깃허브 사이트 입니다.

## License
[Apache License Version 2.0](http://www.apache.org/licenses/LICENSE-2.0.html).







<br><br>>
[한국어](#korean))

# <a name="english"></a>mago3D
mago3D is a next-generation three-dimensional platform that integrates and visualizes AEC (Architecture, Engineering, Construction) and traditional 3D spatial information (3D GIS). Unlike conventional solutions, mago3D seamlessly integrates AEC and 3D GIS in a web browser without distinction between indoor and outdoor. As a result, mago3D users can quickly view and collaborate on large-scale building information modeling (BIM), JT (Jupiter Tessellation) and 3D GIS files without installing any additional programs.

## Mission
mago3DJs Integrate visualization data using open source JavaScript library for 3D multi-block visualization.

## Features
- Issue status You can see new issue, ongoing issue, and finished issue.
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

###  Install
- [java](http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html )
  - Install java jdk-8u144-windows-x64.exe.

- [eclipse Oxygen](https://www.eclipse.org/downloads/download.php?file=/oomph/epp/oxygen/R/eclipse-inst-win64.exe)
    - Install the eclipse neon version or later.
    - After running eclipse, Project Import <br>
      File -> import -> Gradle -> Existing Gradle Project

- [PostgreSQL 9.6.3-1](https://github.com/Gaia3D/mago3d/wiki/PostgreSQL-%EC%84%A4%EC%B9%98-%EA%B0%80%EC%9D%B4%EB%93%9C)
    - Installation path C: / PostgreSQL
    - DB table and initial data registration
      - windows autorun script is under development.
      - Go to the downloaded source / mago3D-core / src / doc folder.
      - Creates a SQL file in the ddl folder as a table. <br>
      Tables, table columns Comments Multilingual versions are under development.
      - Order of folders in ddl in SQL work order.
      - Runs index, index, and partition of the folder by running SQL.
      - Initial data registration in SQL in the dml folder

- [PostGIS 2.3.2](https://github.com/Gaia3D/mago3d/wiki/PostGIS-%EC%84%A4%EC%B9%98)
  - Installation path C:/PostGIS
  - PostgreSQL Extensions PostGIS <br>
  <code>CREATE EXTENSION postgis</code>
  - When PosGIS Extensions finishes successfully, a table called spatial_ref_sys is automatically created.

- [gradle 4.1](https://gradle.org/docs/)
  - Installation path C:/gradle
  - Adding System Variables -path -> C:\gradle\gradle-4.1 Add
  - Build using eclipse BuildShip Gradle Plugin.

- [lombok](https://projectlombok.org/)
  - After installing, move the download folder and execute it.
  - Locate the eclipse installation location [Specify location ..] and select the file 'eclipse.exe'.
  - Click install / update.

### Execution
- run mago3D-admin project spring boot <br>
<pre><code>/mago3D-admin/src/main/java/com/gaia3d/mago3DAdminApplication.java</code></pre>
- run mago3D-user project spring boot <br>
<pre><code>/mago3D-user/src/main/java/com/gaia3d/mago3DUserApplication.java</code></pre>

## github
- [mago3DJs](https://github.com/Gaia3D/mago3djs) It is a feather hub site.
- [F4DConverter](https://github.com/Gaia3D/F4DConverter) It is a feather hub site.
## License
[Apache License Version 2.0](http://www.apache.org/licenses/LICENSE-2.0.html).

<br><br>
[english](#english)


<a name="japan"></a>

準備中です。
# mago3D
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

###  Install
- [java](http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html )
  - java jdk-8u144-windows-x64.exeをインストールします。

- [eclipse Oxygen](https://www.eclipse.org/downloads/download.php?file=/oomph/epp/oxygen/R/eclipse-inst-win64.exe)

 - eclipse neon以降のバージョンをインストールします。
 - eclipseを実行した後Project Import <br>
    File  - > import  - > Gradle  - > Existing Gradle Project

- [PostgreSQL 9.6.3-1](https://github.com/Gaia3D/mago3d/wiki/PostgreSQL-%EC%84%A4%EC%B9%98-%EA%B0%80%EC%9D%B4%EB%93%9C)
 - インストールパスはC：/ PostgreSQL
 -  DB Tableの作成と初期データの登録
    -  windows自動実行scriptは開発中です。
    -  downloadしたソースの/ mago3D-core / src / docフォルダに移動します。
    -  ddlフォルダのsqlファイルを実行してtableを生成します。<br>
    table、table column comment多言語バージョンは開発中です。
    -  ddlフォルダのsequence sql実行してsequence生成します。
    -  index、triggerフォルダのsqlを実行して、indexとpartition生成します。
    -  dmlフォルダのsqlを実行して、初期データの登録

- [PostGIS 2.3.2](https://github.com/Gaia3D/mago3d/wiki/PostGIS-%EC%84%A4%EC%B9%98)
  - インストールパスはC：/ PostGIS
  - PostgreSQL Extensions PostGIS 必須 <br>
   <code>CREATE EXTENSION postgis</code>
  -  PosGIS Extensionsが正常に終了したら、spatial_ref_sysというテーブルが自動的に作成されます。

- [gradle 4.1](https://gradle.org/docs/)
  - インストールパスC：/ gradle
  - システム変数の追加-path  - > C：\ gradle \ gradle-4.1を追加
  - eclipse BuildShip Gradle Pluginを使用してbuildします。

- [lombok](https://projectlombok.org/)
  - インストールした後にダウンロードフォルダの移動後に実行。
  - eclipseのインストール場所[Specify location ..]を検索して「eclipse.exe」ファイルを選択します。
  - install / updateクリックします。

### Execution

 - mago3d-admin project spring boot 実行 <br>
 <pre><code>/mago3D-admin/src/main/java/com/gaia3d/mago3DAdminApplication.java</code></pre>
 - mago3d-user project spring boot 実行 <br>
 <pre><code>/mago3D-user/src/main/java/com/gaia3d/mago3DUserApplication.java</code></pre>

## github
- [mago3DJs](https://github.com/Gaia3D/mago3djs) github サイトです。
- [F4DConverter](https://github.com/Gaia3D/F4DConverter) github サイトです。

## License
[Apache License Version 2.0](http://www.apache.org/licenses/LICENSE-2.0.html).
