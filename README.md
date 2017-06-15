[![Englsh](https://img.shields.io/badge/language-English-orange.svg)](README.md)
[![Korean](https://img.shields.io/badge/language-Korean-blue.svg)](README.md)

# Mago3D
MAGO3D는 AEC(Architecture, Engineering, Construction) 영역과 전통적인 3차원 공간정보(3D GIS)를 통합적으로 관리, 가시화해 주는 차세대 3차원 플랫폼입니다. MAGO3D는 기존의 솔루션과 달리 실내외 구별 없이 끊김 없이 AEC와 3D GIS를 웹 브라우저에서 통합해 줍니다. 이에 따라, MAGO3D 사용자는 초대용량 BIM(Building Information Modelling), JT(Jupiter Tessellation), 3D GIS 파일 등을 별도의 프로그램 설치 없이 웹 브라우저 상에서 바로 살펴보고 협업작업을 진행할 수 있습니다.

## Mission
Mago3DJS 3차원 다중 블록 가시화를 위한 오픈소스 자바스크립트 라이브러리를 사용한 가시화 데이터를 통합 과제 & 이슈 관리를 할 수 있습니다.

## Features
 - 이슈 현황 신규 이슈, 진행 중인 이슈, 완료된 이슈를 볼 수 있습니다.
 - 사용자 상태별 현황을 그래프로 되어 있어 보기 편합니다.
 - DB Connection Pool 현황이나 DV세션 현황을 테이블로 볼 수 있습니다.

## Development Environment
<code>Spring, gradle, PostgreSQL, PostGIS, mybatis Docker </code>

## Getting Started

###  Install

- [PostgreSQL](https://github.com/Gaia3D/mago3d/wiki/PostgreSQL-%EC%84%A4%EC%B9%98-%EA%B0%80%EC%9D%B4%EB%93%9C)
  - PostgreSQL 버전 설정 (PostgreSQL v9.6.3-1)
  - 설치경로 C:/PostgreSQL
  - 비밀번호 설정 Password: postgres Retype Password : postgres

- [PostGIS](https://github.com/Gaia3D/mago3d/wiki/PostGIS-%EC%84%A4%EC%B9%98)
  - PostgreSQL 설치가 끝난 뒤에 Stack Builder를 실행하여 설치
  - PostGIS 버전 설정 (PostGIS v2.3.2)
  - PostgreSQL Extensions PostGIS 필수
- [gradle](https://github.com/Gaia3D/mago3d/wiki/gradle-%EC%84%A4%EC%B9%98-%EA%B0%80%EC%9D%B4%EB%93%9C)
  - gradle 버전 설치 (gradle v3.5)
  - 설치경로 C:/gradle
  - 시스템 변수 추가 -path -> C:\gradle\gradle-3.5 추가
- [lombok](https://projectlombok.org/)
  - 설치한 뒤에 다운로드 폴더 이동 후 실행
  - eclipse 설치 위치 [Specify location..]를 검색해서 'eclipse.exe' 파일을 선택합니다.
  - install/update 클릭합니다.

- Buildship Gradle Integration
  - eclipse Help -> Eclipse Marketplace 이동 후 Buildship Gradle Integration 2.0을 설치합니다.

### Setting

  - eclipse에서 mago3d Project를 git clone으로 불러옵니다.
  - File -> Import -> Gradle -> Existing Gradle Project를 클릭하여 mago3d를 받아줍니다.
  - mago3d를 실행하기전에 PostgreSQL을 사용하여 데이터베이스를 만들어 줍니다.<br>
  PostgreSQL - > new DataBase
  <pre>
    Name: mago3d
    Encoding: UTF8
    Template: template0
    Collation: C
    Character type: C
    Connection Limit: -1
  </pre>
  - 생선한 database에 쿼리를 실행시켜줍니다. 쿼리는 mago3d-core -> src -> doc -> database 안에 있습니다.

### Execution

 - mao3d를 실행하려면 mago3d-admin -> src/main/java -> com.gaia3d -> Mago3dAdminApplication.java를 Spring Boot app으로 실행시켜줍니다.

## github
 [Mago3DJS](https://github.com/Gaia3D/mago3djs) 깃허브 사이트 입니다.
## License
...
