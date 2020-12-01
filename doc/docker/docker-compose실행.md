## docker 개발환경 실행하기 
    - docker-compose.yml 파일이 있는 경로에서 다음 실행
    - docker-compose up -d

## 변경된 db 반영시에는 지우고 다시 실행
    - -v 옵션을 줘야 docker 에서 사용하는 volume(geoserver-data) 이 모두 삭제됨. geoserver 의 데이터를 유지하고 싶을 경우에는 -v 옵션 생략
    - docker-compose down -v
    - docker-compose up --build -d

## geoserver docker 에서 로컬 데이터 사용하기
    - docker-compose 파일의 volume 마운트 하는 부븐 "lhdt-geoserver-data:/geoserver-data" 에서 lhdt-geoserver-data(docker 내부에서 자동으로 관리하는 volume)을
    로컬 호스트의 경로로 마운트하고 docker-compose up -d --build 으로 실행하여 사용하거나 geoserver container 에 마운트 한 geoserver-data 폴더 안으로 파일을 복사하여 사용
    (docker container cp "로컬파일" lhdt-geoserver:/geoserver-data)