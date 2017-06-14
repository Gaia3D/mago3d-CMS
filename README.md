[![Englsh](https://img.shields.io/badge/language-English-orange.svg)](README.md)
[![Korean](https://img.shields.io/badge/language-Korean-blue.svg)](README.md)

# Mago3D
통합 과제 & 이슈 관리 시스템

## Mission
Mago3DJS 3차원 다중 블록 가시화를 위한 오픈소스 자바스크립트 라이브러리를 사용한 가시화 데이터를 통합 과제 & 이슈 관리를 할 수 있습니다.

## Features
 - 이슈 현황 신규 이슈, 진행 중인 이슈, 완료된 이슈를 볼 수 있습니다.
 - 사용자 상태별 현황을 그래프로 되어 있어 보기 편합니다.
 - DB Connection Pool 현황이나 DV세션 현황을 테이블로 볼 수 있습니다.

## Development Environment
<code>Spring, gradle, PostgreSQL, PostGIS, mybatis ... </code>

## Getting Started

###  Install <br>

- [PostgreSQL](https://github.com/Gaia3D/mago3d/wiki/PostgreSQL-%EC%84%A4%EC%B9%98-%EA%B0%80%EC%9D%B4%EB%93%9C)
  - PostgreSQL 버전 설정 (PostgreSQL v9.6.3-1)
  - 설치경로 C:/PostgreSQL
  - 비밀번호 설정 Password: postgres Retype Password : postgres

- [PostGIS](https://github.com/Gaia3D/mago3d/wiki/PostGIS-%EC%84%A4%EC%B9%98)
  - PostgreSQL 설치가 끝난 뒤에 Stack Builder를 실행하여 설치
  - PostGIS 버전 설정 (PostGIS v2.3.2)

- [gradle](https://github.com/Gaia3D/mago3d/wiki/gradle-%EC%84%A4%EC%B9%98-%EA%B0%80%EC%9D%B4%EB%93%9C)
  - gradle 버전 설치 (gradle v3.5)
  - 설치경로 C:/gradle
  - 시스템 변수 추가 -path -> C:\gradle\gradle-3.5 추가

### Setting
 - eclipse 설정
    - [lombok](https://projectlombok.org/)
      - 설치한 뒤에 다운로드 폴더 이동 후 실행
      - IDE 설치 위치 [Specify location..]를 검색해서 'eclipse.exe' 파일을 선택합니다.

    - eclipse에서 Help -> Eclipse Marketplace 이동 후 Buildship Gradle Integration 2.0을 설치합니다.

## github
 [Mago3DJS](https://github.com/Gaia3D/mago3djs) 깃허브 사이트 입니다.
## License
...
