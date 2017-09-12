[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](http://www.apache.org/licenses/LICENSE-2.0.html)
[![Englsh](https://img.shields.io/badge/language-English-orange.svg)](#english)
[![Korean](https://img.shields.io/badge/language-Korean-blue.svg)](#korean)

<a name="korean"></a>

# mago3D
MAGO3D는 AEC(Architecture, Engineering, Construction) 영역과 전통적인 3차원 공간정보(3D GIS)를 통합적으로 관리, 가시화해 주는 차세대 3차원 플랫폼입니다. MAGO3D는 기존의 솔루션과 달리 실내외 구별 없이 끊김 없이 AEC와 3D GIS를 웹 브라우저에서 통합해 줍니다. 이에 따라, MAGO3D 사용자는 초대용량 BIM(Building Information Modelling), JT(Jupiter Tessellation), 3D GIS 파일 등을 별도의 프로그램 설치 없이 웹 브라우저 상에서 바로 살펴보고 협업작업을 진행할 수 있습니다.

## Mission
Mago3DJS 3차원 다중 블록 가시화를 위한 오픈소스 자바스크립트 라이브러리를 사용한 가시화 데이터를 통합 과제 & 이슈 관리를 할 수 있습니다.

## Features
 - 이슈 현황 신규 이슈, 진행 중인 이슈, 완료된 이슈를 볼 수 있습니다.
 - 사용자 상태별 현황을 그래프로 되어 있어 보기 편합니다.
 - DB Connection Pool 현황이나 DV세션 현황을 테이블로 볼 수 있습니다.

## Development Environment
  - Spring
  - Gradle
  - PostgreSQL
  - PostGIS
  - mybatis
  - Docker

## Getting Started

###  Install
- [java](http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html )
  - java jdk-8u144-windows-x64.exe를 설치합니다.

- [eclipse Oxygen](https://www.eclipse.org/downloads/download.php?file=/oomph/epp/oxygen/R/eclipse-inst-win64.exe)
  - eclipse neon버전 이상을 설치합니다.
  - eclipse를 실행 후 Project Import <br>
    File -> import -> Gradle -> Existing Gradle Project

- [PostgreSQL 9.6.3-1](https://github.com/Gaia3D/mago3d/wiki/PostgreSQL-%EC%84%A4%EC%B9%98-%EA%B0%80%EC%9D%B4%EB%93%9C)

  - 설치경로 C:/PostgreSQL
  - DB Table 생성 및 초기 데이터 등록
    - windows 자동 실행 script는 개발 중입니다.
    - download 한 소스의 /mago3d-core/src/doc 폴더로 이동합니다.
    - ddl 폴더의 sql 파일을 실행하여 table을 생성합니다.<br>
    table, table column comment 다국어 버전은 개발 중입니다.
    - ddl 폴더의 sequence sql 실행하여 sequence 생성합니다.
    - index, trigger 폴더의 sql을 실행하여 index 및 partition 생성합니다.
    - dml 폴더의 sql을 실행하여 초기 데이터 등록

- [PostGIS 2.3.2](https://github.com/Gaia3D/mago3d/wiki/PostGIS-%EC%84%A4%EC%B9%98)
  - 설치경로 C:/PostGIS
  - PostgreSQL Extensions PostGIS 필수 <br>
   <code>CREATE EXTENSION postgis</code>

- [gradle 4.1](https://gradle.org/docs/)
  - 설치경로 C:/gradle
  - 시스템 변수 추가 -path -> C:\gradle\gradle-4.1 추가
  - Eclipse BuildShip Gradle Plugin 또는 Gradle command line을 이용하여 build합니다.

- [lombok](https://projectlombok.org/)
  - 설치한 뒤에 다운로드 폴더 이동 후 실행
  - eclipse 설치 위치 [Specify location..]를 검색해서 'eclipse.exe' 파일을 선택합니다.
  - install/update 클릭합니다.

### Execution

 - mago3d-admin project spring boot 실행 <br> /mago3d-admin/src/main/java/com/gaia3d/Mago3dAdminApplication.java

## github
 [Mago3DJS](https://github.com/Gaia3D/mago3djs) 깃허브 사이트 입니다.
## License
[Apache License Version 2.0](http://www.apache.org/licenses/LICENSE-2.0.html).







<br><br>
[한국어](#korean)

# <a name="english"></a>mago3D
MAGO3D is a next-generation three-dimensional platform that integrates and visualizes AEC (Architecture, Engineering, Construction) and traditional 3D spatial information (3D GIS). Unlike conventional solutions, MAGO3D seamlessly integrates AEC and 3D GIS in a web browser without distinction between indoor and outdoor. As a result, MAGO3D users can quickly view and collaborate on large-scale building information modeling (BIM), JT (Jupiter Tessellation) and 3D GIS files without installing any additional programs.

## Mission
Mago3DJS Integrate visualization data using open source JavaScript library for 3D multi-block visualization.

## Features
- Issue status You can see new issue, ongoing issue, and finished issue.
- It is easy to view the status by user status graph.
- DB Connection Pool status or DV session status can be viewed as a table.

## Development Environment
- Spring
- Gradle
- PostgreSQL
- PostGIS
- mybatis
- Docker

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
    - Go to the downloaded source / mago3d-core / src / doc folder.
    - Creates a SQL file in the ddl folder as a table. <br>
    Tables, table columns Comments Multilingual versions are under development.
    - Order of folders in ddl in SQL work order.
    - Runs index, index, and partition of the folder by running SQL.
    - Initial data registration in SQL in the dml folder

- [PostGIS 2.3.2](https://github.com/Gaia3D/mago3d/wiki/PostGIS-%EC%84%A4%EC%B9%98)
  - Installation path C:/PostGIS
  - PostgreSQL Extensions PostGIS <br>
  <code>CREATE EXTENSION postgis</code>

- [gradle 4.1](https://gradle.org/docs/)
  - Installation path C:/gradle
  - Adding System Variables -path -> C:\gradle\gradle-4.1 Add
  - Build with Eclipse BuildShip Gradle Plugin or Gradle command line.

- [lombok](https://projectlombok.org/)
  - After installing, move the download folder and execute it.
  - Locate the eclipse installation location [Specify location ..] and select the file 'eclipse.exe'.
  - Click install / update.

### Execution
- run mago3d-admin project spring boot <br> /mago3d-admin/src/main/java/com/gaia3d/Mago3dAdminApplication.java

## github
 [Mago3DJS](https://github.com/Gaia3D/mago3djs) It is a feather hub site.
## License
[Apache License Version 2.0](http://www.apache.org/licenses/LICENSE-2.0.html).
