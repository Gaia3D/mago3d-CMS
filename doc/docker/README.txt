docker image 다운로드
    - docker image pull gaia3d/mago-cms
docker container 실행
    - docker container run --privileged --restart=always -d -p 15432:5432  --name "mago-cms" gaia3d/mago-cms /sbin/init

